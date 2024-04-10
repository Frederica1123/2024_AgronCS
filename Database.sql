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

### MySQL part2 ###
USE field_trial;

SELECT * 
FROM Company_Info 
JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID;

SELECT Company_Info.Company_ID, 
Seed_Info.Company_id, 
Company_Info.Company_name, 
Seed_Info.Hybrid_name 
FROM Company_Info 
JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID;

SELECT Company_Info.Company_ID, 
Seed_Info.Company_id, 
Company_Info.Company_name, 
Seed_Info.Hybrid_name 
FROM Company_Info 
JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID
WHERE Maturity > 110;

# count how many row in dataframe
SELECT COUNT(*) FROM Company_Info;
SELECT COUNT(*) FROM Seed_Info;

SELECT #* #COUNT(*) 
FROM Company_Info 
JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID
WHERE Maturity > 110;

# DISTINCT
SELECT DISTINCT Company_Info.Company_name  
FROM Company_Info 
JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID
WHERE Maturity > 107;

# LIMIT # = read the first # rows
SELECT * FROM Trial_Info LIMIT 10;

# ASC = in ascending order 升冪排列
SELECT * 
FROM Seed_Info
ORDER BY Maturity ASC;

# DESC = in descending order 降冪排列
SELECT * 
FROM Seed_Info
ORDER BY Maturity DESC;

SELECT * 
FROM Seed_Info
ORDER BY Maturity DESC LIMIT 5;

SELECT * 
FROM Seed_Info
ORDER BY Maturity, Company_id;

SELECT * 
FROM Seed_Info
ORDER BY Maturity DESC, Company_id ASC;

SELECT * 
FROM Seed_Info
WHERE Maturity >= 111 AND Company_id = 2
ORDER BY Maturity DESC, Company_id ASC
LIMIT 2;

# WHERE (A) or (B)
SELECT Company_Info.Company_name, Seed_Info.Maturity , Seed_Info.Company_id 
FROM Company_Info JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID 
WHERE Maturity >= 111 AND Company_name = 'Pioneer'

SELECT Company_Info.Company_name, Seed_Info.Maturity , Seed_Info.Company_id 
FROM Company_Info JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID 
WHERE (Maturity >= 111 AND Company_name = 'Pioneer')
OR (Maturity <= 109 AND Company_name = 'Dekalb')

SELECT Company_Info.Company_name, Seed_Info.Maturity , Seed_Info.Company_id 
FROM Company_Info JOIN Seed_Info
ON Seed_Info.Company_id = Company_Info.Company_ID 
WHERE (Maturity >= 111 AND Company_name = 'Pioneer')
OR (Maturity <= 109 AND Company_name = 'Dekalb')
ORDER BY Company_Info.Company_name DESC 
LIMIT 2;

#
DESCRIBE State_Info;
SELECT * FROM State_Info; 

DESCRIBE Farm_Info;
SELECT * FROM Farm_Info;

# 不好的例子
SELECT *
# FROM Farm_Info JOIN State_Info # 也可以這樣寫
FROM State_Info JOIN Farm_Info
# ON State_Info.State_ID = Farm_Info.State_id # 也可以這樣寫
ON Farm_Info.State_id = State_Info.State_ID;
GROUP BY State_Info.State_name 

# 修正不好的例子
SELECT State_Info.State_name, State_Info.Two_letters
# FROM Farm_Info JOIN State_Info # 也可以這樣寫
FROM State_Info JOIN Farm_Info
# ON State_Info.State_ID = Farm_Info.State_id # 也可以這樣寫
ON Farm_Info.State_id = State_Info.State_ID
GROUP BY State_Info.State_name; 

SELECT State_Info.State_name, Farm_Info.Irrigation ,
COUNT(*)
# FROM Farm_Info JOIN State_Info # 也可以這樣寫
FROM State_Info JOIN Farm_Info
# ON State_Info.State_ID = Farm_Info.State_id # 也可以這樣寫
ON Farm_Info.State_id = State_Info.State_ID
WHERE Irrigation = 1
GROUP BY State_Info.State_name; 

SELECT State_Info.State_name, Farm_Info.Irrigation ,
COUNT(*)
# FROM Farm_Info JOIN State_Info # 也可以這樣寫
FROM State_Info JOIN Farm_Info
# ON State_Info.State_ID = Farm_Info.State_id # 也可以這樣寫
ON Farm_Info.State_id = State_Info.State_ID
GROUP BY State_Info.State_name, Farm_Info.Irrigation;

SELECT State_Info.State_name, Farm_Info.Irrigation ,
COUNT(*)
# FROM Farm_Info JOIN State_Info # 也可以這樣寫
FROM State_Info JOIN Farm_Info
# ON State_Info.State_ID = Farm_Info.State_id # 也可以這樣寫
ON Farm_Info.State_id = State_Info.State_ID
GROUP BY State_Info.State_name
HAVING COUNT(*) >= 2; 

DESCRIBE Trial_Info;
SELECT COUNT(*) FROM Trial_Info;
SELECT DISTINCT Seed_Info_id FROM Trial_Info;

SELECT SI.Hybrid_name, COUNT(*),
MAX(Yield) AS Max_Y, # AS...=命名colume name
MIN(Yield) AS Min_Y,
SUM(Disease_rating) AS DR,
ROUND(AVG(Yield), 1) AS Y, # ROUND(..., 1)取到小數第一位
ROUND(AVG(Yield), 2) # ROUND(..., 2)取到小數第二位
FROM Trial_Info AS TI JOIN Seed_Info AS SI # AS也能命名table name
ON TI.Seed_info_id = SI.Seed_ID
GROUP BY Seed_info_id;
HAVING AVG(Y) > 76;
