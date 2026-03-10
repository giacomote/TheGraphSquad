# Shakespeare Theater Exercise

## Challenge 1

> [!NOTE] Assignment
> Find **all performances of the play "Julius Caesar"**.  
> The query should return play title, performance date and production name.

```cypher
MATCH (pf:Performance)-[]->(pr:Production)-[]->(pl:Play)
WHERE pl.title = 'Julius Caesar'
RETURN pl.title, pf.date, pr.name
```

## Challenge 2

> [!NOTE] Assignment
> Find **the city and country where the theatre company is based**.  
> The query should return company name, city and country.

```cypher
MATCH (cmp:Company)-[]->(cty:City)-[]->(ctr:Country)
RETURN cmp.name, cty.name, ctr.name
```

## Challenge 3

> [!NOTE] Assignment
> Find **a user who wrote a review**.  
> Report review text and rating of the review, name of the user and date of the performance.

```cypher
MATCH (u:User)-[]->(r:Review)-[]->(p:Performance)
RETURN r.review, r.rating, u.name, p.date
```

## Challenge 4

> [!NOTE] Assignment
> Find **all plays that have at least one performance**.  
> If you can, return play title and number of performances.

```cypher
MATCH (pf:Performance)-[]-(:Production)-[]-(pl:Play)
RETURN pl.title, count(pf) AS n_performances
ORDER BY n_performances DESC
```

## Challenge 5

> [!NOTE] Assignment
> Write a query that returns:
> - Play title
> - Production name
> - Performance date
> - Venue
> - City
> - Country
> 
> This requires combining many parts of the graph.
> 
> Explain the meaning of your query.

```cypher
MATCH
	(pf:Performance)-[:PERFORMANCE_OF]->(pr:Production)-[:PRODUCTION_OF]-(pl:Play),
	(pf)-[:VENUE]->(vn:Venue)-[]-()-[:CITY]->(cty:City)-[:COUNTY]-()-[:COUNTRY]->(ctr:Country)
RETURN pl.title, pr.name, pf.date, vn.name, cty.name, ctr.name
```

### Explanation

In the same `MATCH` statement, two different paths have been selected.  
This is done because, starting from `Performace`, there are 2 different directions to reach `Venue` and `Production`.

The same result would have been achieved by using a single path (in the `MATCH` statement) without specifying the
orientation of the relationships.