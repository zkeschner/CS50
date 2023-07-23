select ratings.rating, movies.title from movies
join ratings on movies.id = ratings.movie_id where movies.year = 2010
order by ratings.rating desc, movies.title asc;