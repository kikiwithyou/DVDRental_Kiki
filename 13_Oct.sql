-- -- returns films that haven’t been rented
-- SELECT film_id, title
-- FROM film
-- EXCEPT
-- SELECT f.film_id, f.title
-- FROM film f
-- JOIN inventory i ON f.film_id = i.film_id
-- JOIN rental r ON i.inventory_id = r.inventory_id;

-- --Use of Natural Join, it cares of data type!
-- SELECT film_id, category_id 
-- FROM film_category
-- NATURAL JOIN category;

-- -- Subquery can be everywhere! Not just in WHERE clause
-- -- In below example, it is in SELECT clause
-- SELECT customer_id, first_name, last_name,
--     (SELECT COUNT(*) FROM rental WHERE rental.customer_id = customer.customer_id) AS rental_count
-- FROM customer;

-- -- In below examples, it is in FROM clause
-- SELECT avg(rental_count)
-- FROM (
--     SELECT customer_id, COUNT(customer_id) AS rental_count
--     FROM rental
--     GROUP BY customer_id
-- ) AS avg_rental_counts;

-- -- Advanced version of GROUP BY, with null values (aka need full join)
-- SELECT ct.city, EXTRACT(MONTH FROM p.payment_date) AS month, SUM(p.amount) AS total_payment
-- FROM payment p
-- FULL JOIN customer c ON p.customer_id = c.customer_id
-- FULL JOIN address a ON c.address_id = a.address_id
-- FULL JOIN city ct ON a.city_id = ct.city_id
-- GROUP BY ct.city, EXTRACT(MONTH FROM p.payment_date)
-- --HAVING SUM(p.amount) > 31
-- ORDER BY total_payment desc;

-- -- values from one or multiple rows to return a value for each row
-- -- you can mention if there's any group by in the () after OVER
-- -- Below is an example. Overall_average is 1 value, but it is matched to each row for comparison of rental_duration
-- SELECT
--   title,
--   rental_duration,
--   AVG(rental_duration) OVER () AS overall_average
-- FROM film;

-- -- PARTITION BY = GROUP BY
-- SELECT amount, customer_id, 
-- avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
-- FROM payment
-- ORDER BY month desc;

-- --Example of CTE
-- --Average amount of each month = avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date))
-- WITH revenue_vs_month AS (

-- SELECT DISTINCT avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
-- FROM payment	
-- )

-- SELECT corr(month_average, month)
-- FROM revenue_vs_month;



-- --How to do it without CTE? Example of subquery in FROM clause
-- SELECT corr(a.month_average, a.month)
-- FROM (SELECT DISTINCT avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average ,EXTRACT(month FROM payment_date) as month
-- FROM payment) a




--Can we have 2 CTE happening at the same time? YES! This is over-complicated, not necessary. Just for your understanding of 2 CTE can execute in the same query
-- WITH revenue_vs_month AS (

-- SELECT DISTINCT avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
-- FROM payment	
-- ), revenue_vs_month_two AS
-- (SELECT avg(amount) as month_average, EXTRACT(month FROM payment_date) as month
-- FROM payment
-- GROUP BY EXTRACT (month FROM payment_date))

-- SELECT corr(month_average, month)
-- FROM revenue_vs_month_two;


-- Another example of CTE
-- WITH film_rentals AS (
--   SELECT inventory.film_id, COUNT(*) AS rental_count
--   FROM rental
--   JOIN inventory ON rental.inventory_id = inventory.inventory_id
--   GROUP BY inventory.film_id
-- )
-- SELECT f.title, fr.rental_count
-- FROM film f
-- JOIN film_rentals fr ON f.film_id = fr.film_id
-- WHERE fr.rental_count > 1;


-- -- Want to replace the null values with sth else? Try the CASE WHEN
-- WITH film_rentals AS (
--   SELECT inventory.film_id, COUNT(*) AS rental_count
--   FROM rental
--   JOIN inventory ON rental.inventory_id = inventory.inventory_id
--   GROUP BY inventory.film_id
-- )
-- SELECT f.title,
-- 	CASE WHEN fr.rental_count IS Null THEN '0'
-- 		ELSE fr.rental_count
-- 	END 
-- FROM film f
-- FULL JOIN film_rentals fr ON f.film_id = fr.film_id
-- ORDER BY fr.rental_count ASC
-- -- Why the 0 is not in the upper part?? because null is the biggest, we just need to change the fr.rental_count to rental_count 
-- -- Another way: assign alias after the END
-- WITH film_rentals AS (
--   SELECT inventory.film_id, COUNT(*) AS rental_count
--   FROM rental
--   JOIN inventory ON rental.inventory_id = inventory.inventory_id
--   GROUP BY inventory.film_id
-- )
-- SELECT f.title,
-- 	CASE WHEN fr.rental_count IS Null THEN '0'
-- 		ELSE fr.rental_count
-- 	END as transformed_rental_count
-- FROM film f
-- FULL JOIN film_rentals fr ON f.film_id = fr.film_id
-- ORDER BY transformed_rental_count ASC


