### MySQL part1 ###
SHOW Databases;
USE field_trial;
SHOW Tables;

DESCRIBE Company_Info;
DESCRIBE Seed_Info;

SELECT * FROM Company_Info;

SELECT Parent_company, Company_name FROM Company_Info;

SELECT * FROM Seed_Info;

SELECT Maturity, Hybrid_name FROM Seed_Info;

SELECT * FROM Seed_Info si  WHERE Maturity = 113;

SELECT * FROM Seed_Info si  WHERE Maturity != 113;

SELECT Hybrid_name, Maturity, Company_id, Seed_ID 
FROM Seed_Info
WHERE Maturity >= 109 AND Maturity <= 112;

SELECT * FROM Seed_Info si 
WHERE Hybrid_name = 'P0720Q' OR Hybrid_name = 'DKC57-71RIB';

SELECT * FROM Seed_Info si 
WHERE NOT Hybrid_name = 'P0720Q';

SELECT * FROM Seed_Info si 
WHERE Hybrid_name IN ('P0720Q', 'DKC63-90RIB', 'P1366Q');

# % = * in regular expression of R 
SELECT * FROM Seed_Info si
WHERE Hybrid_name LIKE 'P%8%'; # 'P%8%' = start with P and contain 8 in the middle

# _ = one character
SELECT * FROM Seed_Info si
WHERE Hybrid_name LIKE 'P__8%'; # 'P__8%' = want 8 at the 4th site
