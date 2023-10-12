-- -- Get the max. amount from payment
-- SELECT MAX(amount) from payment

-- -- Get the average amount from payment
-- SELECT AVG(amount) from payment

-- -- Total revenue from payment
-- SELECT sum(amount) FROM payment

-- -- This perform the same as count(*), it will show the number of rows 
-- SELECT count(1) From film

-- -- This shows the number of rows of rental duration in film table 
-- SELECT count(rental_duration) FROM film

-- -- This shows the distinct value of rental_duration
-- SELECT count(distinct rental_duration ) FROM film

-- SELECT stddev(length) FROM film
-- SELECT variance(length) FROM film

-- -- Use MIN on text, it will give you the alphabetic first
-- SELECT MIN(title) FROM film

-- SELECT MIN(rental_date) as first_rental, MAX(rental_date) as last_rental 
-- FROM rental

-- SELECT MAX(return_date) as last_return_date, MAX(rental_date) as last_rental_date
-- FROM rental

-- SELECT * FROM rental
-- ORDER BY rental_date DESC


-- SELECT category_id, COUNT(film_id) AS category_count
-- FROM film_category
-- GROUP BY category_id
-- ORDER BY category_count;

-- -- COUNT(*) here means count the number of film.. be careful. COUNT(*) can mean many things
-- SELECT c.category_id, fc.category_id, c.name AS category_name, COUNT(*) AS film_count
-- FROM category c
-- -- the join here means INNER join
-- JOIN film_category fc ON c.category_id = fc.category_id
-- GROUP BY c.category_id, fc.category_id
-- ORDER BY film_count DESC;

-- SELECT c.category_id, c.name AS category_name, COUNT(f.film_id) AS film_count, SUM(p.amount) AS total_amount
-- FROM category c
-- JOIN film_category fc ON c.category_id = fc.category_id
-- JOIN film f ON fc.film_id = f.film_id
-- JOIN inventory i ON f.film_id = i.film_id
-- JOIN rental r ON i.inventory_id = r.inventory_id
-- FULL JOIN payment p ON r.rental_id = p.rental_id <-- we care about how many times it is RENTED, regardless of payment condition
-- GROUP BY c.category_id
-- ORDER BY total_amount DESC;

-- SELECT c.customer_id, c.first_name, c.last_name, COUNT(*) AS rental_count
-- FROM customer c
-- JOIN rental r ON c.customer_id = r.customer_id
-- GROUP BY c.customer_id
-- HAVING COUNT(*) > 30;


-- -- How many customers from each country? (Given there are at least 1 customer in that country)
-- SELECT c.country, COUNT(cu.customer_id)
-- FROM customer cu
-- LEFT JOIN address ON address.address_id = cu.address_id
-- LEFT JOIN city ON city.city_id = address.city_id
-- LEFT JOIN country c ON c.country_id = city.country_id
-- GROUP BY c.country
-- ORDER BY COUNT(cu.customer_id) DESC

-- -- How many customers in each country? Display even if that country has 0 customer
-- SELECT count(cu.customer_id), c.country
-- FROM customer cu
-- FULL JOIN address ON address.address_id = cu.address_id
-- FULL JOIN city ON city.city_id = address.city_id
-- FULL JOIN country c ON c.country_id = city.country_id
-- GROUP BY c.country
-- ORDER BY COUNT(cu.customer_id)


SELECT cu.customer_id, cu.first_name, city.city, address.address_id
FROM customer cu
FULL JOIN address ON address.address_id = cu.address_id
FULL JOIN city ON city.city_id = address.city_id
FULL JOIN country c ON c.country_id = city.country_id
