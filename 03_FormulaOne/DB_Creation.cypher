// First steps: previous graph, indices and constraint deletion
MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({}, {});

// Team principal nodes
CREATE (horner:TeamPrincipal {name:'Christian Horner'})
CREATE (wolff:TeamPrincipal {name:'Toto Wolff'})
CREATE (vasseur:TeamPrincipal {name:'Frederic Vasseur'})
CREATE (stella:TeamPrincipal {name:'Andrea Stella'})

// Team nodes
CREATE (redbull:Team {name:'Red Bull Racing'})
CREATE (mercedes:Team {name:'Mercedes'})
CREATE (ferrari:Team {name:'Ferrari'})
CREATE (mclaren:Team {name:'McLaren'})

// Team principal relationships
CREATE (horner)-[:MANAGES]->(redbull)
CREATE (wolff)-[:MANAGES]->(mercedes)
CREATE (vasseur)-[:MANAGES]->(ferrari)
CREATE (stella)-[:MANAGES]->(mclaren)

// Driver nodes
CREATE (max:Driver {name:'Max Verstappen', nationality:'Dutch'})
CREATE (perez:Driver {name:'Sergio Perez', nationality:'Mexican'})
CREATE (hamilton:Driver {name:'Lewis Hamilton', nationality:'British'})
CREATE (russell:Driver {name:'George Russell', nationality:'British'})
CREATE (leclerc:Driver {name:'Charles Leclerc', nationality:'Monegasque'})
CREATE (sainz:Driver {name:'Carlos Sainz', nationality:'Spanish'})
CREATE (norris:Driver {name:'Lando Norris', nationality:'British'})
CREATE (piastri:Driver {name:'Oscar Piastri', nationality:'Australian'})

// Driver relationships
CREATE (max)-[:DRIVES_FOR]->(redbull)
CREATE (perez)-[:DRIVES_FOR]->(redbull)
CREATE (hamilton)-[:DRIVES_FOR]->(mercedes)
CREATE (russell)-[:DRIVES_FOR]->(mercedes)
CREATE (leclerc)-[:DRIVES_FOR]->(ferrari)
CREATE (sainz)-[:DRIVES_FOR]->(ferrari)
CREATE (norris)-[:DRIVES_FOR]->(mclaren)
CREATE (piastri)-[:DRIVES_FOR]->(mclaren)

// Car nodes
CREATE (rb20:Car {model:'RB20'})
CREATE (w15:Car {model:'W15'})
CREATE (sf24:Car {model:'SF24'})
CREATE (mcl38:Car {model:'MCL38'})

// Car relationships
CREATE (max)-[:DRIVES]->(rb20)
CREATE (perez)-[:DRIVES]->(rb20)
CREATE (hamilton)-[:DRIVES]->(w15)
CREATE (russell)-[:DRIVES]->(w15)
CREATE (leclerc)-[:DRIVES]->(sf24)
CREATE (sainz)-[:DRIVES]->(sf24)
CREATE (norris)-[:DRIVES]->(mcl38)
CREATE (piastri)-[:DRIVES]->(mcl38)

// Engine nodes
CREATE (honda:Engine {name:'Honda RBPT'})
CREATE (mercedesEngine:Engine {name:'Mercedes AMG'})
CREATE (ferrariEngine:Engine {name:'Ferrari'})

// Engine relationships
CREATE (rb20)-[:USES_ENGINE]->(honda)
CREATE (w15)-[:USES_ENGINE]->(mercedesEngine)
CREATE (sf24)-[:USES_ENGINE]->(ferrariEngine)
CREATE (mcl38)-[:USES_ENGINE]->(mercedesEngine)

// Tyre supplier nodes
CREATE (pirelli:TyreSupplier {name:'Pirelli'})

// Tyre supplier relationships
CREATE (redbull)-[:USES_TYRES]->(pirelli)
CREATE (mercedes)-[:USES_TYRES]->(pirelli)
CREATE (ferrari)-[:USES_TYRES]->(pirelli)
CREATE (mclaren)-[:USES_TYRES]->(pirelli)

// Sponsor nodes
CREATE (oracle:Sponsor {name:'Oracle'})
CREATE (petronas:Sponsor {name:'Petronas'})
CREATE (shell:Sponsor {name:'Shell'})
CREATE (google:Sponsor {name:'Google'})

// Sponsor relationships
CREATE (oracle)-[:SPONSORS]->(redbull)
CREATE (petronas)-[:SPONSORS]->(mercedes)
CREATE (shell)-[:SPONSORS]->(ferrari)
CREATE (google)-[:SPONSORS]->(mclaren)

// Countries nodes
CREATE (italy:Country {name:'Italy'})
CREATE (uk:Country {name:'United Kingdom'})
CREATE (monaco:Country {name:'Monaco'})
CREATE (japan:Country {name:'Japan'})
CREATE (bahrain:Country {name:'Bahrain'})
CREATE (australia:Country {name:'Australia'})
CREATE (china:Country {name:'China'})
CREATE (saudi:Country {name:'Saudi Arabia'})

// Circuit nodes
CREATE (imola:Circuit {name:'Imola'})
CREATE (silverstone:Circuit {name:'Silverstone'})
CREATE (monacoCircuit:Circuit {name:'Monaco Circuit'})
CREATE (suzuka:Circuit {name:'Suzuka'})
CREATE (bahrainCircuit:Circuit {name:'Bahrain International Circuit'})
CREATE (melbourne:Circuit {name:'Albert Park'})
CREATE (shanghai:Circuit {name:'Shanghai International Circuit'})
CREATE (jeddah:Circuit {name:'Jeddah Street Circuit'})

// Circuit relationships
CREATE (imola)-[:LOCATED_IN]->(italy)
CREATE (silverstone)-[:LOCATED_IN]->(uk)
CREATE (monacoCircuit)-[:LOCATED_IN]->(monaco)
CREATE (suzuka)-[:LOCATED_IN]->(japan)
CREATE (bahrainCircuit)-[:LOCATED_IN]->(bahrain)
CREATE (melbourne)-[:LOCATED_IN]->(australia)
CREATE (shanghai)-[:LOCATED_IN]->(china)
CREATE (jeddah)-[:LOCATED_IN]->(saudi)

// Season nodes
CREATE (s2024:Season {year:2024})
CREATE (s2025:Season {year:2025})

// Race nodes
CREATE (race1:Race {name:'Bahrain GP'})
CREATE (race2:Race {name:'Saudi Arabia GP'})
CREATE (race3:Race {name:'Australian GP'})
CREATE (race4:Race {name:'Japanese GP'})
CREATE (race5:Race {name:'Chinese GP'})
CREATE (race6:Race {name:'Monaco GP'})
CREATE (race7:Race {name:'British GP'})
CREATE (race8:Race {name:'Imola GP'})

// Race relationships
CREATE (race1)-[:HELD_ON]->(bahrainCircuit)
CREATE (race2)-[:HELD_ON]->(jeddah)
CREATE (race3)-[:HELD_ON]->(melbourne)
CREATE (race4)-[:HELD_ON]->(suzuka)
CREATE (race5)-[:HELD_ON]->(shanghai)
CREATE (race6)-[:HELD_ON]->(monacoCircuit)
CREATE (race7)-[:HELD_ON]->(silverstone)
CREATE (race8)-[:HELD_ON]->(imola)

CREATE (race1)-[:PART_OF_SEASON]->(s2024)
CREATE (race2)-[:PART_OF_SEASON]->(s2024)
CREATE (race3)-[:PART_OF_SEASON]->(s2024)
CREATE (race4)-[:PART_OF_SEASON]->(s2024)
CREATE (race5)-[:PART_OF_SEASON]->(s2024)
CREATE (race6)-[:PART_OF_SEASON]->(s2024)
CREATE (race7)-[:PART_OF_SEASON]->(s2025)
CREATE (race8)-[:PART_OF_SEASON]->(s2025);

// Bahrain GP - Race 1
MATCH
    (r:Race {name:'Bahrain GP'}),
    (max:Driver {name:'Max Verstappen'}),
    (perez:Driver {name:'Sergio Perez'}),
    (hamilton:Driver {name:'Lewis Hamilton'}),
    (leclerc:Driver {name:'Charles Leclerc'}),
    (norris:Driver {name:'Lando Norris'})

CREATE
    (max)-[:PARTICIPATED {position:1}]->(r),
    (perez)-[:PARTICIPATED {position:2}]->(r),
    (hamilton)-[:PARTICIPATED {position:3}]->(r),
    (leclerc)-[:PARTICIPATED {position:4}]->(r),
    (norris)-[:PARTICIPATED {position:5}]->(r);

// Saudi Arabia GP - Race 2
MATCH
    (r:Race {name:'Saudi Arabia GP'}),
    (max:Driver {name:'Max Verstappen'}),
    (perez:Driver {name:'Sergio Perez'}),
    (sainz:Driver {name:'Carlos Sainz'}),
    (russell:Driver {name:'George Russell'}),
    (piastri:Driver {name:'Oscar Piastri'})

CREATE
    (sainz)-[:PARTICIPATED {position:1}]->(r),
    (max)-[:PARTICIPATED {position:2}]->(r),
    (perez)-[:PARTICIPATED {position:3}]->(r),
    (russell)-[:PARTICIPATED {position:4}]->(r),
    (piastri)-[:PARTICIPATED {position:"DNF"}]->(r);

// Australian GP - Race 3
MATCH
    (r:Race {name:'Australian GP'}),
    (perez:Driver {name:'Sergio Perez'}),
    (norris:Driver {name:'Lando Norris'}),
    (piastri:Driver {name:'Oscar Piastri'}),
    (leclerc:Driver {name:'Charles Leclerc'}),
    (hamilton:Driver {name:'Lewis Hamilton'})

CREATE
    (perez)-[:PARTICIPATED {position:1}]->(r),
    (norris)-[:PARTICIPATED {position:2}]->(r),
    (piastri)-[:PARTICIPATED {position:3}]->(r),
    (hamilton)-[:PARTICIPATED {position:"DNF"}]->(r);

// Japanese GP - Race 4
MATCH
    (r:Race {name:'Japanese GP'}),
    (max:Driver {name:'Max Verstappen'}),
    (leclerc:Driver {name:'Charles Leclerc'}),
    (perez:Driver {name:'Sergio Perez'}),
    (sainz:Driver {name:'Carlos Sainz'}),
    (russell:Driver {name:'George Russell'})

CREATE
    (max)-[:PARTICIPATED {position:1}]->(r),
    (leclerc)-[:PARTICIPATED {position:2}]->(r),
    (perez)-[:PARTICIPATED {position:3}]->(r),
    (sainz)-[:PARTICIPATED {position:4}]->(r),
    (russell)-[:PARTICIPATED {position:5}]->(r);

// Chinese GP - Race 5
MATCH
    (r:Race {name:'Chinese GP'}),
    (piastri:Driver {name:'Oscar Piastri'}),
    (norris:Driver {name:'Lando Norris'}),
    (max:Driver {name:'Max Verstappen'}),
    (hamilton:Driver {name:'Lewis Hamilton'}),
    (sainz:Driver {name:'Carlos Sainz'})

CREATE
    (piastri)-[:PARTICIPATED {position:1}]->(r),
    (norris)-[:PARTICIPATED {position:2}]->(r),
    (max)-[:PARTICIPATED {position:3}]->(r),
    (hamilton)-[:PARTICIPATED {position:"DNF"}]->(r),
    (sainz)-[:PARTICIPATED {position:"DNF"}]->(r);

// Monaco GP - Race 6
MATCH
    (r:Race {name:'Monaco GP'}),
    (piastri:Driver {name:'Oscar Piastri'}),
    (norris:Driver {name:'Lando Norris'}),
    (max:Driver {name:'Max Verstappen'}),
    (hamilton:Driver {name:'Lewis Hamilton'}),
    (sainz:Driver {name:'Carlos Sainz'})

CREATE
    (piastri)-[:PARTICIPATED {position:1}]->(r),
    (norris)-[:PARTICIPATED {position:"DNF"}]->(r),
    (max)-[:PARTICIPATED {position:2}]->(r),
    (hamilton)-[:PARTICIPATED {position:"DNF"}]->(r),
    (sainz)-[:PARTICIPATED {position:"DNF"}]->(r);

// British GP - Race 7
MATCH
    (r:Race  {name:'British GP'}),
    (perez:Driver {name:'Sergio Perez'}),
    (norris:Driver {name:'Lando Norris'}),
    (piastri:Driver {name:'Oscar Piastri'}),
    (leclerc:Driver {name:'Charles Leclerc'}),
    (hamilton:Driver {name:'Lewis Hamilton'})

CREATE
    (perez)-[:PARTICIPATED {position:1}]->(r),
    (norris)-[:PARTICIPATED {position:2}]->(r),
    (piastri)-[:PARTICIPATED {position:3}]->(r),
    (hamilton)-[:PARTICIPATED {position:"DNF"}]->(r);

// Italy GP - Race 8
MATCH
    (r:Race {name:'Imola GP'}),
    (perez:Driver {name:'Sergio Perez'}),
    (norris:Driver {name:'Lando Norris'}),
    (piastri:Driver {name:'Oscar Piastri'}),
    (leclerc:Driver {name:'Charles Leclerc'}),
    (hamilton:Driver {name:'Lewis Hamilton'})

CREATE
    (perez)-[:PARTICIPATED {position:4}]->(r),
    (norris)-[:PARTICIPATED {position:1}]->(r),
    (piastri)-[:PARTICIPATED {position:3}]->(r),
    (sainz)-[:PARTICIPATED {position:2}]->(r),
    (hamilton)-[:PARTICIPATED {position:"DNF"}]->(r);

// Unique constraints
CREATE CONSTRAINT FOR (d:Driver) REQUIRE d.name IS UNIQUE;
CREATE CONSTRAINT FOR (t:Team) REQUIRE t.name IS UNIQUE;
CREATE CONSTRAINT FOR (c:Circuit) REQUIRE c.name IS UNIQUE;
CREATE CONSTRAINT FOR (co:Country) REQUIRE co.name IS UNIQUE;
CREATE CONSTRAINT FOR (s:Season) REQUIRE s.year IS UNIQUE;
CREATE CONSTRAINT FOR (e:Engine) REQUIRE e.name IS UNIQUE;
CREATE CONSTRAINT FOR (sp:Sponsor) REQUIRE sp.name IS UNIQUE;
CREATE CONSTRAINT FOR (tp:TeamPrincipal) REQUIRE tp.name IS UNIQUE;
CREATE CONSTRAINT FOR (car:Car) REQUIRE car.model IS UNIQUE;
CREATE CONSTRAINT FOR (r:Race) REQUIRE r.name IS UNIQUE;
CREATE CONSTRAINT FOR (ty:TyreSupplier) REQUIRE ty.name IS UNIQUE;