--Challenges
--Challenge 1: Create a dummy variable for each kind of special feature in the film table
-- SELECT*, 
-- 	--Your code here
-- FROM FILM;


SELECT*, 
	CASE WHEN 'Trailers' = any(special_features) THEN 1
	ELSE 0
	END as Trailers,
	CASE WHEN 'Behind the Scenes' = any(special_features) THEN 1
	ELSE 0
	END as Behind_the_scenes,
	CASE WHEN 'Deleted Scenes' = any(special_features) THEN 1
	ELSE 0
	END as Deleted_scenes,
	CASE WHEN 'Commentaries' = any(special_features) THEN 1
	ELSE 0
	END as Commentaries
FROM FILM;


	