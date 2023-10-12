-- SELECT *
-- FROM film  
-- WHERE film_id IN (SELECT film_id FROM film WHERE description LIKE '%Cat%')

-- -- Get the film details from the "Action" category film
-- SELECT * FROM film
-- WHERE film_id IN
-- (SELECT film_id FROM film_category
-- WHERE category_id IN
-- (Select category_id FROM category
-- WHERE name = 'Action'))

-- --See if any actor's first name longer than any of the customer last name
-- SELECT * FROM actor
-- WHERE LENGTH(first_name) > ANY(select LENGTH(last_name) from customer)

-- -- Film with its detail with ANY of the given conditions = TRUE
-- SELECT * FROM film
-- WHERE (rental_rate > .99) OR (length > 100) OR (rental_duration > 3)

-- SELECT 1 from customer

-- --We cannot say equals to NULL, we need to use IS NULL
-- --We are doing table join here, find customer that has retenal_date = null
-- SELECT customer_id, first_name, last_name
-- FROM customer c
-- WHERE EXISTS (
--     SELECT 1
--     FROM rental r
--     WHERE r.customer_id = c.customer_id
--     AND r.return_date IS NULL
-- )


-- -- Greater than some of the result in sub query
-- SELECT film_id, title, rental_rate
-- FROM film
-- WHERE rental_rate > SOME (
--     SELECT rental_rate
--     FROM film
--     WHERE replacement_cost > 20
-- )


-- --Find the film details where the film description contains cat & dog (case in-sensitive)
-- SELECT * FROM film
-- WHERE description ILIKE '%cat%' AND description ILIKE '%dog%'

-- --This one has sequence, cat must comes first
-- SELECT * FROM film
-- WHERE description ILIKE '%cat%dog%'


-- -- List film details with film desciption contains m (a charater) d
-- SELECT * FROM film
-- WHERE description ILIKE '%m_d%'

-- Order in descending order of length, by default it is ASC (ascending order)
-- Also, order rental_rate in ascending order
-- Select * FROM film
-- ORDER BY length DESC, rental_rate ASC

-- SELECT * FROM film
-- ORDER BY length DESC, rental_rate ASC
-- LIMIT 11

-- SELECT DISTINCT rental_duration FROM film
-- WHERE rental_duration NOT IN (4)

-- -- Payment first, so keep everything from payment
-- SELECT p.amount, p.rental_id, r.inventory_id, r.return_date, p.payment_id
-- FROM payment p
-- LEFT JOIN rental r ON p.rental_id = r.rental_id
-- ORDER BY return_date ASC


-- -- Payment first, so keep everything from rental
-- SELECT p.amount, p.rental_id, r.inventory_id, r.return_date, p.payment_id
-- FROM payment p
-- RIGHT JOIN rental r ON p.rental_id = r.rental_id
-- ORDER BY return_date ASC

SELECT f.title, c.name as category_name, fc.category_id
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category c ON c.category_id = fc.category_id





