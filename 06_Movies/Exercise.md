# Movies

## Challenge 1

> [!NOTE] Assignment
> Search for **pairs of actors who worked on the same movie**.  
> Limit the query results to `50`.

```cypher
MATCH (a1:Actor)-[:ACTS_IN]->(m:Movie)<-[:ACTS_IN]-(a2:Actor)
WHERE elementId(a1) < elementId (a2)
RETURN a1.name AS actor1, a2.name AS actor2, m.title AS movie
LIMIT 50
```

## Challenge 2

> [!NOTE] Assignment
> Count, for each actor, **how many movies they acted in**.  
> Limit the query results to `50`.

```cypher
MATCH (a:Actor)-[:ACTS_IN]-(m:Movie)
RETURN a.name AS actor, count(m.movieId) AS movie_count
ORDER BY movie_count DESC
LIMIT 50
```

## Challenge 3

> [!NOTE] Assignment
> Get a movie (by movieId), and **list all the features**.

```cypher
MATCH (m:Movie {movieId: "1"})
RETURN m.movieId, m.title, m.plot
```

## Challenge 4

> [!NOTE] Assignment
> List the **movies rated by a user** (`userId = 1`) **ordered from the highest rated**.

```cypher
MATCH (a:User {userId: "1"})<-[r:RATED]->(m:Movie)
RETURN a.userId, r.rating, m.title
ORDER BY r.rating DESC
```

## Challenge 5

> [!NOTE] Assignment
> Get the **average number of films that a user has rated**.

```cypher
MATCH (u:User)-[:RATED]->(m:Movie)
WITH u.userId AS user, count(m.movieId) AS ratings_number
RETURN round(avg(ratings_number), 3) AS average_ratings_number
```