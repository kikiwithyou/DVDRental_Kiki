--how much revenue is coming from different countries to the DVD store

WITH country_revenue As (
	SELECT c.country As Country, SUM(p.amount) As Revenue
	FROM rental r 
	LEFT JOIN customer cu ON r.customer_id = cu.customer_id
	LEFT JOIN address ad ON cu.address_id = ad.address_id
	LEFT JOIN city ci ON ad.city_id = ci.city_id
	LEFT JOIN country c ON ci.country_id = c.country_id
	LEFT JOIN payment p ON r.rental_id = p.rental_id
	GROUP BY c.country
	ORDER BY revenue DESC
)

SELECT Country, Revenue FROM country_revenue

