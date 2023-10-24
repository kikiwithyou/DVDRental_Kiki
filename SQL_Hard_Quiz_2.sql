--challenge 2: Which film category is rented the most often
--your code must return all category names in the column on the left, and their rental count on the right,
--ranked from high rental count to low rental count desc.

SELECT cat.name, COUNT(r.rental_id) As rental_count
FROM category cat
FULL OUTER JOIN film_category fc ON cat.category_id = fc.category_id
FULL OUTER JOIN inventory i ON fc.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cat.name
ORDER BY rental_count DESC;

