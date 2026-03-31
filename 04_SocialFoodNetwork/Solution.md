# Recipes

## Challenge 1

> [!NOTE] Assignment
> Return **recipes ordered by preparation time**.

```cypher
MATCH (r:Recipe)
RETURN r.title, r.prep_time_min
ORDER BY r.prep_time_min ASC
```

## Challenge 2

> [!NOTE] Assignment
> For all the recipes, extract **the needed ingredients**.

```cypher
MATCH (r:Recipe)-[:CONTAINS]->(i:Ingredient)
RETURN r.title, collect(i.name)
```

## Challenge 3

> [!NOTE] Assignment
> List **users and the respective recipes they have created**.

```cypher
MATCH (u:User)-[:CREATED]->(r:Recipe)
RETURN u.name, collect(r.title)
```

## Challenge 4

> [!NOTE] Assignment
> Calculate **the average rating received for all the reviews**.

```cypher
MATCH (rec:Recipe)-[:HAS]->(rev:Review)
RETURN rec.title, avg(rev.rating)
```

## Challenge 5

> [!NOTE] Assignment
> List, for all the users, **the recipes that they cannot make due to an ingredient**.
> Return also the specific allergen (ingredient which the user is allergic to).

```cypher
MATCH
  (u:User)-[:ALLERGY_TO]->(i:Ingredient),
  (i)<-[:CONTAINS]-(r:Recipe)
RETURN u.name AS name, collect(DISTINCT r.title) AS recipes, collect(DISTINCT i.name) AS allergens
```

## Challenge 6

> [!NOTE]
> Count the **total number of operations (steps) planned in the pipeline of each recipe**.

```cypher
MATCH (r:Recipe)-[*]->(i:Instruction)
RETURN r.title AS title, count(i) AS steps
```

## Challenge 7

> [!NOTE] Assignment
> Extract **the unique list of tools required by a recipe**.

```cypher
MATCH (r:Recipe)-[*]->(:Instruction)-[:REQUIRES]->(t:Tool)
RETURN r.title, collect(DISTINCT t.name)
```

## Challenge 8

> [!NOTE] Assignment
> Identify **the most cross-utilized ingredients** in the dataset.

```cypher
MATCH (i:Ingredient)<-[*]-(r:Recipe)
RETURN i.name AS ingredient, count(DISTINCT r) AS utilizations
ORDER BY utilizations DESC
```

## Challenge 9

> [!NOTE] Assignment
> Calculate **the total calories derived from ingredients measured in grams for each recipe**.

```cypher
MATCH (r:Recipe)-[c:CONTAINS]->(i:Ingredient)
RETURN r.title AS recipe, sum(c.quantity * i.calories_100g / 100) AS calories
```

## Challenge 10

> [!NOTE] Assignment
> Suggest **alternative ingredients with their relative confidence index** (match ratio).

```cypher
MATCH (i1:Ingredient)-[s:SUBSTITUTE_FOR]->(i2:Ingredient)
RETURN i2.name AS ingredient, i1.name AS substitute, s.match_ratio AS confidence
```

## Challenge 11

> [!NOTE] Assignment
> Return **only the recipes that do not contain ingredients to which a specific user is allergic**.

```cypher
MATCH (r:Recipe)
WHERE NOT (r)-[:CONTAINS]->(:Ingredient)<-[:ALLERGY_TO]-(:User)
RETURN r.title
```

## Challenge 12

> [!NOTE] Assignment
> Find **pairs of users who have rated the same recipes**.

```cypher
MATCH
  (u1:User)-[:WRITES]->(:Review)<-[:HAS]-(r:Recipe),
  (u2:User)-[:WRITES]->(:Review)<-[:HAS]-(r)
WHERE elementId(u1) < elementId(u2)
RETURN u1.name, u2.name, r.title
```

## Challenge 13

> [!NOTE] Assignment
> Perform a logical integrity check: **isolate recipes where all ingredients have an explicit relationship towards a
> specific diet** (e.g., Vegan).

```cypher
MATCH (d:Diet {name: 'Vegan'})
MATCH (r:Recipe)-[:CONTAINS]->(i:Ingredient)
WITH d, r, collect(i) AS ingredients
WHERE ALL(ing IN ingredients WHERE (ing)-[:SUITABLE_FOR]->(d))
RETURN r.title, d.name
```

## Challenge 14

> [!NOTE] Assignment
> Identify potential anomalies or fraud in the rating system (e.g., **users reviewing recipes they created themselves**).

```cypher
MATCH (u:User)-[:CREATED]->(r:Recipe)-[:HAS]->(:Review)<-[:WRITES]-(u)
RETURN u.name, r.title
```

## Challenge 15

> [!NOTE] Assignment
> Find **the most voted reviews**.
> Return, writer name, recipe title, comment and number of votes.

```cypher
MATCH
  (rev:Review)<-[:VOTES]-(u:User),
  (rev)<-[:HAS]-(rec:Recipe),
  (rev)<-[:WRITES]-(w:User)
RETURN w.name AS writer, rec.title AS recipe, rev.comment AS comment, count(u) AS votes
ORDER BY votes DESC
```