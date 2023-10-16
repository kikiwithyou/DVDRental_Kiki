-- -- Use of wildcards
-- SELECT description 
-- FROM film
-- WHERE description ILIKE '%d__g%'
-- OR description ILIKE '%dog%'
-- OR description ILIKE '%bird%'


-- -- String aggregation function: get all the desciption and line them up in 1 role with deliminator '54639 '
-- -- String_to_array([delimited_column],'[delimiter]')
-- WITH short_film AS (
-- 	SELECT*FROM film
-- 	LIMIT 20	   	   )
-- select rating, STRING_AGG(description, '54639 ')
-- FROM short_film
-- GROUP BY rating;


-- -- Which customer paid the most? Non-hardcoded version
-- WITH customers AS(
-- 	SELECT customer_id, SUM(amount)As amount2 FROM payment
-- 	GROUP BY customer_id
-- 	ORDER BY amount2 DESC
-- )

-- SELECT * FROM customers
-- WHERE amount2 = (SELECT MAX(amount2) FROM customers)


-- -- What if we want to save this query and refer them again next time easily? Create view!
-- CREATE OR REPLACE VIEW top_customers AS
-- WITH customers AS(
-- 	SELECT customer_id, SUM(amount)As amount2 FROM payment
-- 	GROUP BY customer_id
-- 	ORDER BY amount2 DESC
-- )

-- SELECT * FROM customers
-- WHERE amount2 = (SELECT MAX(amount2) FROM customers)


-- -- Use it again
-- SELECT * FROM top_customers

-- -- Any inventory never been rented?
-- SELECT inventory_id
-- FROM inventory
-- WHERE inventory_id NOT IN (SELECT i.inventory_id FROM inventory i
-- 					  JOIN rental ON i.inventory_id = rental.inventory_id)

-- Give the bottom 30% rented film 
WITH rental_table AS(
	SELECT i.film_id, count(i.film_id) as rental_count
	FROM inventory i JOIN rental r ON r.inventory_id = i.inventory_id
	GROUP BY i.film_id
	ORDER BY rental_count
),
Percentage AS(
SELECT 
PERCENTILE_CONT(0.30) WITHIN GROUP (ORDER BY rental_count)
FROM rental_table
)

SELECT * FROM rental_table
WHERE rental_count <= (SELECT * FROM Percentage)







