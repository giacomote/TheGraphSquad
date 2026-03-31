// First steps: previous graph, indices and constraint deletion
MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({}, {});

// User nodes
CREATE
    (paolo:User {username: 'Paolo87_', name: 'Paolo Gelati', join_date: date('2019-03-24'), country: 'Italy'}),
    (giovanna:User {username: 'mi_giovi23', name: 'Giovanna Civitillo', join_date: date('2024-06-07'), country: 'Italy'}),
    (alessandro:User {username: 'voto.diesci', name: 'Alessandro Borghese', join_date: date('2026-01-30'), country: 'Italy'}),
    (benedetta:User {username: 'benny_paro', name: 'Benedetta Parodi', join_date: date('2014-09-21'), country: 'Italy'}),
    (joe:User {username: 'foodjoe42', name: 'Joe Bastianich', join_date: date('2015-02-28'), country: 'USA'}),
    (garima:User {username: 'garima_ao', name: 'Garima Aora', join_date: date('2023-05-22'), country: 'India'}),
    (ronald:User {username: 'mc', name: 'Ronald McDonald', join_date: date('2000-12-25'), country: 'USA'})

// Ingredients
CREATE
    (miso:Ingredient {name: 'Miso Paste', calories_100g: 199, type: 'Fermented'}),
    (tofu:Ingredient {name: 'Firm Tofu', calories_100g: 83, type: 'Protein'}),
    (nori:Ingredient {name: 'Nori Seaweed', calories_100g: 35, type: 'Vegetable'}),
    (bokchoy:Ingredient {name: 'Bok Choy', calories_100g: 13, type: 'Vegetable'}),
    (soysauce:Ingredient {name: 'Soy Sauce', calories_100g: 53, type: 'Condiment'}),
    (tamari:Ingredient {name: 'Tamari', calories_100g: 60, type: 'Condiment'}),
    (kimchi:Ingredient {name: 'Kimchi', calories_100g: 15, type: 'Fermented'}),
    (shrimp:Ingredient {name: 'Tiger Shrimps', calories_100g: 99, type: 'Seafood'}),
    (egg:Ingredient {name: 'Egg', calories_100g: 155, type: 'Protein'}),
    (jowls:Ingredient {name: 'Jowls', calories_100g: 655, type: 'Protein'}),
    (pasta:Ingredient {name: 'Wheat Spaghetti', calories_100g: 350, type: 'Carbohydrates'}),
    (rice_spag:Ingredient {name: 'Rice Spaghetti', calories_100g: 340, type: 'Carbohydrates'}),
    (pecorino:Ingredient {name: 'Pecorino Romano', calories_100g: 380, type: 'Dairy'}),
    (chocolate:Ingredient {name: 'Dark Chocolate', calories_100g: 540, type: 'Dessert'}),
    (soy_milk:Ingredient {name: 'Soy Milk', calories_100g: 33, type: 'Drink'}),
    (chicken:Ingredient {name: 'Chicken', calories_100g: 209, type: 'Protein'}),
    (garlic:Ingredient {name: 'Garlic', calories_100g: 12, type: 'Spices'}),
    (turmeric:Ingredient {name: 'Turmeric', calories_100g: 312, type: 'Spices'}),
    (basmati:Ingredient {name: 'Basmati Rice', calories_100g: 121, category: 'Carbohydrates'}),
    (gingergarl:Ingredient {name: 'Ginger-Garlic Paste', calories_100g: 80, category: 'Spices'}),
    (garam:Ingredient {name: 'Garam Masala', calories_100g: 300, category: 'Spices'}),
    (yogurt:Ingredient {name: 'Greek Yogurt', calories_100g: 59, category: 'Dairy'}),
    (saffron:Ingredient {name: 'Saffron Strands', calories_100g: 310, category: 'Spices'}),
    (bacon:Ingredient {name: 'Bacon', calories_100g: 655, category: 'Protein'}),
    (mascarpone:Ingredient {name: 'Mascarpone', calories_100g: 429, category: 'Dairy'}),
    (ladyfingers:Ingredient {name: 'Ladyfingers', calories_100g: 391, category: 'Dessert'}),
    (espresso:Ingredient {name: 'Espresso', calories_100g: 2, category: 'Drink'}),
    (parmesan:Ingredient {name: 'Parmesan Cheese', calories_100g: 350, category: 'Dairy'})

// Recipe nodes
CREATE
    (carb:Recipe {title: 'Carbonara', prep_time_min: 20, category: 'Main Course'}),
    (cake:Recipe {title: 'Dark Vegan Cake', prep_time_min: 45, category: 'Dessert'}),
    (biryani:Recipe {title: 'Royal Chicken Biryani', prep_time_min: 90, category: 'Second Course'}),
    (tiramisù:Recipe {title:'Tiramisù', prep_time_min: 90, category: 'Dessert'})

// Instruction nodes
CREATE
    (b1:Instruction {step_id: 1, description: 'Marinate chicken with yogurt, spices, and ginger-garlic paste'}),
    (b2:Instruction {step_id: 2, description: 'Parboil basmati rice until 70% cooked'}),
    (b3:Instruction {step_id: 3, description: 'Layer the chicken and rice, then seal the pot for Dum cooking'}),
    (s1:Instruction {step_id: 1, description: 'Fry the cured pork jowl without oil until crispy'}),
    (s2:Instruction {step_id: 2, description: 'Cook pasta until al dente'}),
    (s3:Instruction {step_id: 3, description: 'Mix eggs and pecorino cheese off-heat'}),
    (v1:Instruction {step_id: 1, description: 'Preheat oven to 180 degrees Celsius'}),
    (v2:Instruction {step_id: 2, description: 'Melt chocolate using a double boiler method'}),
    (t1:Instruction {step_id: 1, description: 'Separate the yolks from the whites'}),
    (t2:Instruction {step_id: 2, description: 'Beat the egg yolks with the sugar until creamy'}),
    (t3:Instruction {step_id: 3, description: 'Incorporate the mascarpone into the whipped egg yolks'}),
    (t4:Instruction {step_id: 4, description: 'Soak the ladyfingers in the coffee and layer with the cream'}),
    (t5:Instruction {step_id: 5, description: 'Sprinkle with bitter cocoa and leave to rest in the fridge for 4 hours'})

// Tool nodes
CREATE
    (pan:Tool {name: 'Non-stick Pan', type: 'Cooking'}),
    (oven:Tool {name: 'Electric Oven', type: 'Cooking'}),
    (spatula:Tool {name: 'Rubber Spatula', type: 'Utensil'}),
    (handi:Tool {name: 'Heavy-bottomed Pot', type: 'Cooking'}),
    (casserole:Tool {name: 'Large casserole', type: 'Cooking'}),
    (blender:Tool {name: 'Blender', type: 'Utensil'}),
    (whisk:Tool {name: 'Kitchen whisk', type: 'Utensil'}),
    (baking_tray:Tool {name: 'Baking tray', type: 'Cooking'})

// Diet nodes
CREATE
    (vegan:Diet {name: 'Vegan', description: 'No animal-derived products'}),
    (glutenfree:Diet {name: 'Gluten-Free', description: 'Total absence of gluten'})

// Review nodes
CREATE
    (rev1:Review {rating: 5, comment: 'The best Carbonara I have ever tasted! Authentic and creamy.', date: date('2026-03-10')}),
    (rev2:Review {rating: 3, comment: 'Good, but a bit too much pecorino for my taste.', date: date('2026-03-12')}),
    (rev3:Review {rating: 5, comment: 'The spices in this Biryani are perfectly balanced. Masterpiece.', date: date('2026-03-28')}),
    (rev4:Review {rating: 2, comment: 'The rice was a bit overcooked for an expert recipe.', date: date('2026-03-29')}),
    (rev5:Review {rating: 4, comment: 'Finally, a vegan cake that is actually moist and delicious!', date: date('2026-02-20')}),
    (rev6:Review {rating: 5, comment: 'The best tiramisù I have ever tasted!', date: date('2024-03-05')}),
    (rev7:Review {rating: 5, comment: 'Absolutely phenomenal—rich, fragrant, and perfectly spiced, with tender chicken and unforgettable flavor!', date: date('2025-03-01')})

// User-Recipe relationships
CREATE
    (garima)-[:CREATED {year: 2024}]->(biryani),
    (benedetta)-[:CREATED {year: 2020}]->(carb)

// Recipe-Ingredient relationships
CREATE
    (carb)-[:CONTAINS {quantity: 4, unit: 'pcs'}]->(egg),
    (carb)-[:CONTAINS {quantity: 150, unit: 'g'}]->(jowls),
    (carb)-[:CONTAINS {quantity: 400, unit: 'g'}]->(pasta),
    (carb)-[:CONTAINS {quantity: 200, unit: 'g'}]->(pecorino),
    (cake)-[:CONTAINS {quantity: 200, unit: 'g'}]->(chocolate),
    (cake)-[:CONTAINS {quantity: 500, unit: 'ml'}]->(soy_milk),
    (biryani)-[:CONTAINS {quantity: 500, unit: 'g'}]->(basmati),
    (biryani)-[:CONTAINS {quantity: 600, unit: 'g'}]->(chicken),
    (biryani)-[:CONTAINS {quantity: 200, unit: 'g'}]->(yogurt),
    (biryani)-[:CONTAINS {quantity: 2, unit: 'tbsp'}]->(garam),
    (tiramisù)-[:CONTAINS {quantity: 500, unit: 'g'}]->(mascarpone),
    (tiramisù)-[:CONTAINS {quantity: 4, unit: 'pcs'}]->(egg),
    (tiramisù)-[:CONTAINS {quantity: 200, unit: 'g'}]->(ladyfingers),
    (tiramisù)-[:CONTAINS {quantity: 200, unit: 'ml'}]->(espresso)

// User ALLERGY Ingredient (relationships)
CREATE
    (ronald)-[:ALLERGY_TO]->(soy_milk),
    (ronald)-[:ALLERGY_TO]->(pecorino),
    (alessandro)-[:ALLERGY_TO]->(pecorino)

// Recipe-Instruction relationships
CREATE
    (biryani)-[:START_WITH]->(b1),
    (carb)-[:START_WITH]->(s1),
    (tiramisù)-[:START_WITH]->(t1)

// Instruction-Instruction relationships
CREATE
    (b1)-[:NEXT_STEP {wait_time_min: 60}]->(b2),
    (b2)-[:NEXT_STEP {wait_time_min: 10}]->(b3),
    (s1)-[:NEXT_STEP {wait_time_min: 5}]->(s2),
    (s2)-[:NEXT_STEP {wait_time_min: 2}]->(s3),
    (t1)-[:NEXT_STEP {wait_time_min: 2}]->(t2),
    (t2)-[:NEXT_STEP {wait_time_min: 2}]->(t3),
    (t3)-[:NEXT_STEP {wait_time_min: 2}]->(t4),
    (t4)-[:NEXT_STEP {wait_time_min: 2}]->(t5)

// Recipe-Tool relationships
CREATE
    (b3)-[:REQUIRES]->(handi),
    (t2)-[:REQUIRES]->(whisk),
    (t4)-[:REQUIRES]->(baking_tray)

// Ingredient-Diet relationships
CREATE
    (miso)-[:SUITABLE_FOR]->(vegan),
    (tofu)-[:SUITABLE_FOR]->(vegan),
    (tofu)-[:SUITABLE_FOR]->(glutenfree),
    (nori)-[:SUITABLE_FOR]->(vegan),
    (nori)-[:SUITABLE_FOR]->(glutenfree),
    (bokchoy)-[:SUITABLE_FOR]->(vegan),
    (bokchoy)-[:SUITABLE_FOR]->(glutenfree),
    (soysauce)-[:SUITABLE_FOR]->(vegan),
    (soysauce)-[:SUITABLE_FOR]->(glutenfree),
    (tamari)-[:SUITABLE_FOR]->(vegan),
    (tamari)-[:SUITABLE_FOR]->(glutenfree),
    (kimchi)-[:SUITABLE_FOR]->(vegan),
    (shrimp)-[:SUITABLE_FOR]->(glutenfree),
    (egg)-[:SUITABLE_FOR]->(glutenfree),
    (jowls)-[:SUITABLE_FOR]->(glutenfree),
    (pasta)-[:SUITABLE_FOR]->(vegan),
    (rice_spag)-[:SUITABLE_FOR]->(vegan),
    (pecorino)-[:SUITABLE_FOR]->(glutenfree),
    (chocolate)-[:SUITABLE_FOR]->(vegan),
    (chocolate)-[:SUITABLE_FOR]->(glutenfree),
    (soy_milk)-[:SUITABLE_FOR]->(vegan),
    (soy_milk)-[:SUITABLE_FOR]->(glutenfree),
    (chicken)-[:SUITABLE_FOR]->(glutenfree),
    (gingergarl)-[:SUITABLE_FOR]->(vegan),
    (gingergarl)-[:SUITABLE_FOR]->(glutenfree),
    (turmeric)-[:SUITABLE_FOR]->(vegan),
    (turmeric)-[:SUITABLE_FOR]->(glutenfree),
    (basmati)-[:SUITABLE_FOR]->(vegan),
    (basmati)-[:SUITABLE_FOR]->(glutenfree),
    (garam)-[:SUITABLE_FOR]->(vegan),
    (garam)-[:SUITABLE_FOR]->(glutenfree),
    (yogurt)-[:SUITABLE_FOR]->(glutenfree),
    (saffron)-[:SUITABLE_FOR]->(vegan),
    (saffron)-[:SUITABLE_FOR]->(glutenfree),
    (bacon)-[:SUITABLE_FOR]->(glutenfree),
    (mascarpone)-[:SUITABLE_FOR]->(glutenfree),
    (espresso)-[:SUITABLE_FOR]->(vegan),
    (espresso)-[:SUITABLE_FOR]->(glutenfree),
    (parmesan)-[:SUITABLE_FOR]->(glutenfree)

// Ingredient-Ingredient relationships
CREATE
    (bacon)-[:SUBSTITUTE_FOR {match_ratio: 0.8}]->(jowls),
    (parmesan)-[:SUBSTITUTE_FOR {match_ratio: 0.7}]->(pecorino)

// Recipe-Review relationships
CREATE
    (carb)-[:HAS]->(rev1),
    (carb)-[:HAS]->(rev2),
    (biryani)-[:HAS]->(rev3),
    (biryani)-[:HAS]->(rev4),
    (cake)-[:HAS]->(rev5),
    (tiramisù)-[:HAS]->(rev6),
    (biryani)-[:HAS]->(rev7)

// User WRITES Review (relationships)
CREATE
    (giovanna)-[:WRITES]->(rev1),
    (joe)-[:WRITES]->(rev2),
    (alessandro)-[:WRITES]->(rev3),
    (paolo)-[:WRITES]->(rev4),
    (ronald)-[:WRITES]->(rev5),
    (paolo)-[:WRITES]->(rev6),
    (garima)-[:WRITES]->(rev7)

// User VOTES Review (relationships)
CREATE
    (joe)-[:VOTES]->(rev3),
    (alessandro)-[:VOTES]->(rev3),
    (paolo)-[:VOTES]->(rev1),
    (giovanna)-[:VOTES]->(rev2),
    (alessandro)-[:VOTES]->(rev5)