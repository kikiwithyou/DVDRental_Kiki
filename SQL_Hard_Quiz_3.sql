--challenge 3: how many rentals have NOT been paid for?
--Just return the number in one cell in the result set

SELECT COUNT(*) 
FROM rental
WHERE rental_id NOT IN(
	SELECT DISTINCT(r.rental_id) FROM rental r
	INNER JOIN payment p ON r.rental_id = p.rental_id
);


