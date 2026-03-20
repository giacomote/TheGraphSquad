# Alpine Skiing Competitions

## Challenge 1

> [!NOTE] Assignment
> Find **all athletes and the races they participated in**.  
> Include also athletes who have no recorded results.

```cypher
MATCH (a:Athlete)
OPTIONAL MATCH (a)-[:FINISHED_AT]->(:Result)-[:FINISHED*]->(r:Race)
RETURN a.firstname, a.lastname, collect(r.date) AS races
```

## Challenge 2

> [!NOTE] Assignment
> Find **all the athletes and results in Downhill races**.

```Cypher
MATCH (a:Athlete)-[:FINISHED_AT]->(r:Result)-[:FINISHED]->(:Race)-[:IS_A]->(t:Type {name:"Downhill"})
RETURN a.firstname, a.lastname, r.time
```

## Challenge 3

> [!NOTE] Assignment
> Find **all pairs of races connected by between 3 and 5 steps in the season** sequence.

```cypher
MATCH (s:Season)-[:FIRST_RACE]->(r1:Race)-[:NEXT_RACE*3..5]->(r2:Race)
RETURN r1.date, r2.date, s.name
```

## Challenge 4

> [!NOTE] Assignment
> Starting from the first race of the 2013/14 season, find **all races reachable within 4 steps**.

```cypher
MATCH (s:Season {name:"2013/14"})-[:FIRST_RACE]->(:Race)-[:NEXT_RACE*..4]->(r:Race)
RETURN r.date
```

## Challenge 5

> [!NOTE] Assignment
> Find **a path that connects the athlete Shiffrin** (`lastname: "Shiffrin"`) **with the discipline type** (`Type`)
> **Slalom** (`name: "Slalom"`).

```cypher
MATCH p = (:Athlete {lastname:"Shiffrin"})-[*..20]->(:Type {name:"Slalom"})
RETURN p
```

## Challenge 6

> [!NOTE] Assignment
> Find **the shortest path between the Soelden race and the Beaver Creek race**.

```cypher
MATCH
  (r1:Race)-[:IN]->(:Location {name:"Soelden"}),
  (r2:Race)-[:IN]->(:Location {name:"Beaver Creek"})
MATCH p = shortestPath((r1)-[*..20]->(r2))
RETURN p
```

## Challenge 7

> [!NOTE] Assignment
> For each athlete, find **the number of recorded results**.

```cypher
MATCH (a:Athlete)-[:FINISHED_AT]->(r:Result)
RETURN a.firstname, a.lastname, count(r) AS n_results
```

An alternative solution is the following one, which uses the `WITH` construct:

```cypher
MATCH (a:Athlete)-[:FINISHED_AT]->(r:Result)
WITH a, count(r) as n_results
RETURN a.firstname, a.lastname, n_results
```

## Challenge 8

> [!NOTE] Assignment
> For each athlete, **count the number of distinct races which he or she has participated in**.

```cypher
MATCH (a:Athlete)-[:FINISHED_AT]->(:Result)-[:FINISHED]->(r:Race)
RETURN a.firstname, a.lastname, count(DISTINCT r) AS n_races
```

## Challenge 9

> [!NOTE] Assignment
> Find **the absolute fastest time recorded in all races**.

```cypher
MATCH (:Race)<-[:FINISHED]-(r:Result)
RETURN max(r.time)
```

Alternatively, without using the `max()` function, the query could be done in the following way:

```cypher
MATCH (re:Result)-[:FINISHED]->(ra:Race)
RETURN ra.date, re.time
ORDER BY re.time DESC
LIMIT 1
```

With this second solution it is also possible to show the race date.

## Challenge 10

> [!NOTE] Assignment
> For all races, find **the fastest time recorded**.

```cypher
MATCH (ra:Race)<-[:FINISHED]-(re:Result)
RETURN ra.date, max(re.time) AS max_time
```

## Challenge 11

> [!NOTE] Assignment
> Find **the athlete which participated in the most races this season** (2013/14).

```cypher
MATCH
  (a:Athlete)-[:FINISHED_AT]->(:Result)-[:FINISHED]->(r:Race),
  (r)<-[*..20]-(s:Season)
WHERE s.name = "2013/14"
RETURN a.firstname, a.lastname, count(r) AS n_races
ORDER BY n_races DESC
LIMIT 1
```

## Challenge 12

> [!NOTE] Assignment
> Create a **direct relationship Athlete–Race `:PARTICIPATED_IN`**.  
> Think about what advantages and disadvantages might this redundant relationship have in the graph.

```cypher
MATCH (a:Athlete)-[]->(:Result)-[:FINISHED*..10]->(r:Race)
CREATE (a)-[:PARTICIPATED_IN]->(r)
```

Note that the same result could have been achieved with a query in which the `CREATE` keyword is replaced with the
`MERGE` keyword.

```cypher
MATCH (a:Athlete)-[]->(:Result)-[:FINISHED*..10]->(r:Race)
MERGE (a)-[:PARTICIPATED_IN]->(r)
```

Using `MERGE` instead of `CREATE` will also prevent from re-creating the relationship (creating a duplicate) when it
already exists.

This relationship is redundant.
This may be a problem when trying to keep data in a consistent state.

## Challenge 13

> [!NOTE] Assignment
> Create a **uniqueness constraint** that ensures that **two athletes cannot have the same `firstname` and `lastname`**.

```cypher
CREATE CONSTRAINT FOR (a:Athlete)
REQUIRE (a.firstname, a.lastname) IS UNIQUE
```

## Challenge 14

> [!NOTE] Assignment
> Create an **index on the `lastname` property of `Athlete` nodes**.  
> Think about in which cases this index speeds up queries, and in which cases it does not help.

```cypher
CREATE INDEX FOR (a:Athlete) ON a.lastname
```

This index is helpful when a query involves (in the `MATCH` statement) the last name of the athlete.  
When it doesn't, creating the index is completely useless.