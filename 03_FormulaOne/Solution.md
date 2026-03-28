# Formula One Races

## Challenge 1

> [!NOTE] Assignment
> For each driver, return **driver name, nationality and the team which he drives for**.

```cypher
MATCH (d:Driver)-[:DRIVES_FOR]->(t:Team)
RETURN d.name, d.nationality, t.name
```

## Challenge 2

> [!NOTE] Assignment
> For each circuit, return **its name and the country which it is located in**.

```cypher
MATCH (ci:Circuit)-[:LOCATED_IN]->(co:Country)
RETURN ci.name, co.name
```

## Challenge 3

> [!NOTE] Assignment
> For each racecar model, find **the engine which it uses**.

```cypher
MATCH (c:Car)-[:USES_ENGINE]->(e:Engine)
RETURN c.model, e.name
```

## Challenge 4

> [!NOTE] Assignment
> Count **how many races a driver participated in**.  
> What if it is required to exclude retirements (`position = "DNF"`)?

```cypher
MATCH (d:Driver)-[p:PARTICIPATED]->(r:Race)
WHERE p.position <> "DNF"  // to avoid counting retirements
RETURN d.name, count(r) AS n_races
```

## Challenge 5

> [!NOTE] Assignment
> For all the sponsors, find **the teams which it supports**.

```cypher
MATCH (s:Sponsor)-[:SPONSORS]->(t:Team)
RETURN s.name, collect(t.name) AS sponsored_teams
```

However, since we know that **a single sponsor supports only one team**, the query can be also the following one:

```cypher
MATCH (s:Sponsor)-[:SPONSORS]->(t:Team)
RETURN s.name, t.name
```

## Challenge 6

> [!NOTE] Assignment
> For each driver, count **his number of wins**.  
> Order the results in a decreasing order.

```cypher
MATCH (d:Driver)-[p:PARTICIPATED]->(r:Race)
WHERE p.position = 1
RETURN d.name, count(r) as wins
ORDER BY wins DESC
```

## Challenge 7

> [!NOTE] Assignment
> Count the **number of wins** (`position = 1`) **for each team**.  
> Return the list of teams which has more than 2 wins, as long as their number of wins.

```cypher
MATCH (t:Team)<-[:DRIVES_FOR]-(:Driver)-[p:PARTICIPATED]->(r:Race)
WHERE p.position = 1
WITH t, count(r) AS wins
WHERE wins > 2
RETURN t.name, wins
```

## Challenge 8

> [!NOTE] Assignment
> For each team, return **the two teammate drivers**.

```cypher
MATCH
  (t:Team)<-[:DRIVES_FOR]-(d1:Driver),
  (t)<-[:DRIVES_FOR]-(d2:Driver)
WHERE elementId(d1) < elementId(d2)
RETURN t.name, d1.name, d2.name
```

Since we now that each team has only two drivers, the query can be also the following one:

```cypher
MATCH (t:Team)<-[:DRIVES_FOR]-(d:Driver)
RETURN t.name, collect(d.name)
```

## Challenge 9

> [!NOTE] Assignment
> Find **the races which are held in Italy**.  
> Return the circuit name and the season.

```cypher
MATCH
  (r:Race)-[:HELD_ON]->(ci:Circuit)-[:LOCATED_IN]->(co:Country),
  (r)-[:PART_OF_SEASON]->(s:Season)
WHERE co.name = "Italy"
RETURN r.name, ci.name, s.year
```

## Challenge 10

> [!NOTE] Assignment
> For each race, find **the circuit, country, season and the list of all the results** (containing drivers and finishing
> positions).

```cypher
MATCH
  (r:Race)-[:HELD_ON]->(ci:Circuit)-[:LOCATED_IN]->(co:Country),
  (r)-[:PART_OF_SEASON]->(s:Season),
  (r)<-[p:PARTICIPATED]-(d:Driver)
RETURN r.name, ci.name, co.name, s.year, collect([d.name, p.position]) AS results
```

An alternative solution, having the result ordered by position, can be the following one:

```cypher
MATCH
  (r:Race)-[:HELD_ON]->(ci:Circuit)-[:LOCATED_IN]->(co:Country),
  (r)-[:PART_OF_SEASON]->(s:Season),
  (r)<-[p:PARTICIPATED]-(d:Driver)

// Sorting results by position
WITH r, co, s, d, p
ORDER BY p.position ASC  // unfortunately, "DNF" position will be always the first

RETURN r.name, co.name, s.year, collect({driver: d.name, position: p.position}) AS results
```

## Challenge 11

> [!NOTE] Assignment
> Find **the driver with a higher number of wins in the 2024 season**.

```cypher
MATCH (d:Driver)-[p:PARTICIPATED]->(r:Race)-[:PART_OF_SEASON]->(s:Season)
WHERE s.year = 2024 AND p.position = 1
RETURN d.name, count(r) AS wins
ORDER BY wins DESC
LIMIT 1
```

Alternative, a more advanced solution, which considers that multiple drivers can have the same number of wins, is the
following one:

```cypher
MATCH (d:Driver)-[:PARTICIPATED {position: 1}]->(r:Race)-[:PART_OF_SEASON]->(:Season {year: 2024})
WITH d.name AS driver, count(r) AS wins

// Finding the highest number of wins
WITH collect({nome: driver, n: wins}) AS results, max(wins) AS max_wins

// Finding the drivers having a number of wins which is equal to the maximum
UNWIND results AS r
WITH r WHERE r.n = max_wins
RETURN r.nome AS driver, r.n AS wins
```

## Challenge 12

> [!NOTE] Assignment
> Find **the number of wins and the average position for each driver**, excluding not finished races
> (`position = "DNF"`).

```cypher
MATCH (d:Driver)-[p:PARTICIPATED]->(:Race)
WHERE p.position <> "DNF"

WITH
    d.name AS driver,
    sum(CASE WHEN p.position = 1 THEN 1 ELSE 0 END) AS n_wins,  // counting wins
    avg(p.position) AS avg_position

RETURN driver, n_wins, avg_position
ORDER BY n_wins DESC
```

## Challenge 13

> [!NOTE] Assignment
> For each team, return (in a single line) the following information:
> - Team principal
> - Drivers
> - Racecar
> - Engine
> - Sponsor
> - Tires
> - Results

```cypher
MATCH
  (t:Team)<-[:MANAGES]-(tp:TeamPrincipal),
  (t)<-[:DRIVES_FOR]-(d:Driver),
  (t)-[:USES_TYRES]->(ts:TyreSupplier),
  (t)<-[:SPONSORS]-(sp:Sponsor),
  (d)-[:DRIVES]->(ca:Car)-[:USES_ENGINE]->(e:Engine)

WITH t, tp, ca, e, ts, sp, collect(DISTINCT d.name) AS drivers

MATCH (t)<-[:DRIVES_FOR]-(d:Driver)-[p:PARTICIPATED]->(r:Race)
WITH t, tp, ca, e, ts, sp, drivers, r.name AS gp_name, collect(p.position) AS race_positions

RETURN
  t.name AS team,
  tp.name AS team_principal,
  drivers,
  ca.model AS car,
  e.name AS engine,
  ts.name AS tyre_supplier,
  sp.name AS sponsor,
  collect({GP: gp_name, results: race_positions}) AS results
```

## Challenge 14

> [!NOTE] Assignment
> Find **the shortest path between Max Verstappen and Oscar Piastri**.

```cypher
MATCH p = shortestPath((:Driver {name: "Max Verstappen"})-[*]-(:Driver {name: "Oscar Piastri"}))
RETURN p
```

## Challenge 15

> [!NOTE] Assignment
> Find **the teams which drivers use a Mercedes AMG engine**.

```cypher
MATCH (t:Team)<-[:DRIVES_FOR]-(:Driver)-[:DRIVES]->(:Car)-[:USES_ENGINE]->(e:Engine {name: "Mercedes AMG"})
RETURN DISTINCT t.name AS team, e.name AS engine
```

## Challenge 16

> [!NOTE] Assignment
> Return **wins by driver nationality**.

```cypher
MATCH (d:Driver)-[p:PARTICIPATED {position: 1}]->(:Race)
RETURN d.nationality, count(p) AS wins
ORDER BY wins DESC
```

## Challenge 17

> [!NOTE] Assignment
> Find **the maximum shortest path length between two races**.  
> This is called diameter of the graph.

```cypher
MATCH p = allShortestPaths((r1:Race)-[*]-(r2:Race))
WHERE elementId(r1) < elementId(r2)
WITH length(p) AS length
RETURN max(length) AS diameter
```