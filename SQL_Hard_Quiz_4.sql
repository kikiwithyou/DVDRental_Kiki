--challenge 4: which city has brought in the most revenue to the dvd store 
--(both stores, assume this is a fun virtual store) thinking about where the customers are from
-- If many cities are tied for first place, this should return all of them in the result set. 
-- if it’s just one, then return that one.

WITH city_revenue As (
	SELECT c.city As city, SUM(p.amount) As revenue
	FROM rental r 
	LEFT JOIN customer cu ON r.customer_id = cu.customer_id
	LEFT JOIN address ad ON cu.address_id = ad.address_id
	LEFT JOIN city c ON ad.city_id = c.city_id
	LEFT JOIN payment p ON r.rental_id = p.rental_id
	GROUP BY c.city
	ORDER BY revenue DESC
)

SELECT city FROM city_revenue
WHERE revenue = (SELECT MAX(revenue) FROM city_revenue);



