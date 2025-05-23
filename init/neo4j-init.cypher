// NODE PENGGUNA
CREATE (:User {name: "Faisal"});
CREATE (:User {name: "Ai"});
CREATE (:User {name: "Takumi"});

// NODE FILM 
CREATE (:Movie {title: "Demon Slayer"});
CREATE (:Movie {title: "Jujutsu Kaisen"});
CREATE (:Movie {title: "Violet Evergarden"});
CREATE (:Movie {title: "Kimi no Nawa"});
CREATE (:Movie {title: "Fairy Tail"});

// NODE GENRE
CREATE (:Genre {name: "Demon"});
CREATE (:Genre {name: "Fantasy"});
CREATE (:Genre {name: "Drama"});
CREATE (:Genre {name: "Romance"});
CREATE (:Genre {name: "Military"});
CREATE (:Genre {name: "Comedy"});

// ==== RELASI HAS_GENRE ====
// Demon Slayer
MATCH (m:Movie {title: "Demon Slayer"}), (g:Genre {name: "Demon"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Demon Slayer"}), (g:Genre {name: "Fantasy"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Demon Slayer"}), (g:Genre {name: "Comedy"}) CREATE (m)-[:HAS_GENRE]->(g);

// Jujutsu Kaisen
MATCH (m:Movie {title: "Jujutsu Kaisen"}), (g:Genre {name: "Demon"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Jujutsu Kaisen"}), (g:Genre {name: "Fantasy"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Jujutsu Kaisen"}), (g:Genre {name: "Comedy"}) CREATE (m)-[:HAS_GENRE]->(g);

// Violet Evergarden
MATCH (m:Movie {title: "Violet Evergarden"}), (g:Genre {name: "Romance"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Violet Evergarden"}), (g:Genre {name: "Drama"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Violet Evergarden"}), (g:Genre {name: "Military"}) CREATE (m)-[:HAS_GENRE]->(g);

// Kimi no Nawa
MATCH (m:Movie {title: "Kimi no Nawa"}), (g:Genre {name: "Romance"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Kimi no Nawa"}), (g:Genre {name: "Comedy"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Kimi no Nawa"}), (g:Genre {name: "Fantasy"}) CREATE (m)-[:HAS_GENRE]->(g);

// Fairy Tail
MATCH (m:Movie {title: "Fairy Tail"}), (g:Genre {name: "Demon"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Fairy Tail"}), (g:Genre {name: "Fantasy"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Fairy Tail"}), (g:Genre {name: "Comedy"}) CREATE (m)-[:HAS_GENRE]->(g);
MATCH (m:Movie {title: "Fairy Tail"}), (g:Genre {name: "Romance"}) CREATE (m)-[:HAS_GENRE]->(g);

// RELASI RATED
MATCH (u:User {name: "Faisal"}), (m:Movie {title: "Fairy Tail"}) CREATE (u)-[:RATED {score: 8}]->(m);
MATCH (u:User {name: "Faisal"}), (m:Movie {title: "Violet Evergarden"}) CREATE (u)-[:RATED {score: 9}]->(m);
MATCH (u:User {name: "Ai"}), (m:Movie {title: "Kimi no Nawa"}) CREATE (u)-[:RATED {score: 8}]->(m);
MATCH (u:User {name: "Takumi"}), (m:Movie {title: "Demon Slayer"}) CREATE (u)-[:RATED {score: 5}]->(m);
MATCH (u:User {name: "Takumi"}), (m:Movie {title: "Fairy Tail"}) CREATE (u)-[:RATED {score: 4}]->(m);


// Query Pengecekan
// 1. Temukan semua film yang diberi peringkat oleh pengguna tertentu, beserta peringkatnya
MATCH (u:User {name: "Faisal"})-[r:RATED]->(m:Movie)
RETURN m.title AS JudulFilm, r.score AS Peringkat;

// 2. Temukan semua pengguna yang memberi peringkat pada film tertentu dengan peringkat 4 atau lebih tinggi
MATCH (u:User)-[r:RATED]->(m:Movie {title: "Fairy Tail"})
WHERE r.score >= 4
RETURN u.name AS NamaPengguna, r.score AS Skor;

// 3. Queri Rekomendasi: Rekomendasikan film yang belum diberi peringkat oleh pengguna, berdasarkan genre yang disukai (score ≥ 4)
// Temukan genre yang diberi rating >= 4 oleh Faisal
MATCH (u:User {name: "Faisal"})-[:RATED]->(m:Movie)-[:HAS_GENRE]->(g:Genre)
WHERE (u)-[:RATED {score: 4}]->(m) OR (u)-[:RATED {score: 5}]->(m) OR (u)-[:RATED {score: 6}]->(m)
      OR (u)-[:RATED {score: 7}]->(m) OR (u)-[:RATED {score: 8}]->(m) OR (u)-[:RATED {score: 9}]->(m)
WITH DISTINCT g

// Temukan film dengan genre tersebut, yang belum diberi rating oleh Faisal
MATCH (g)<-[:HAS_GENRE]-(rec:Movie)
WHERE NOT EXISTS {
  MATCH (:User {name: "Faisal"})-[r:RATED]->(rec)
}
RETURN DISTINCT rec.title AS RekomendasiFilm;
