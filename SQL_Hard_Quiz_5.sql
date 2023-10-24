-- challenge 5: Considering every film in the film table, (aka full outer join)
-- return a result set that 
-- 1. gives the number of actors in one column and 2. the frequency of that number of actors in the next column. 
-- 3. Order the result by the number of actors. 

WITH film_numAc AS(
	SELECT f.film_id, COUNT(a.actor_id) AS number_of_actors
	FROM film f
	FULL OUTER JOIN film_actor fc ON fc.film_id = f.film_id
	FULL OUTER JOIN actor a ON fc.actor_id = a.actor_id
	GROUP BY f.film_id
	ORDER BY number_of_actors DESC
)

SELECT DISTINCT(fn.number_of_actors), COUNT(fn.film_id) AS frequency
FROM film_numAC fn
GROUP BY fn.number_of_actors
ORDER BY fn.number_of_actors;