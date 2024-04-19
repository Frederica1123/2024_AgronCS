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


### MySQL part3 ###
DESCRIBE Seed_Info;

SELECT * FROM Seed_Info;
SELECT Maturity FROM Seed_Info;
SELECT EXP(1), LOG(2), POWER(2,5), SQRT(1029); # 計算機功能
SELECT PI(), ROUND(PI(),2), CEILING(PI()), FLOOR(PI()); # 取小數、無條件捨棄、無條件進位

SELECT AVG(Yield), MAX(Yield), MIN(Yield) FROM Trial_Info;
SELECT STD(Yield), VARIANCE(Yield), SQRT(VARIANCE(Yield))
FROM Trial_Info;

SELECT
ROUND(STD(Yield),1),
ROUND(STD(Yield),2),
ROUND(STD(Yield),3),
ROUND(STD(Yield),4),
ROUND(STD(Yield),5) FROM Trial_Info;

# CONCAT('A', 'B') = 把'A'、'B'和在一起變'AB'
SELECT 'ABC', 'XYZ', CONCAT('ABC', 'XYZ'), 
LENGTH('A_VERY_LONG_COMPANY_NAME_XYZ'), # 算長度
LEFT('A_VERY_LONG_COMPANY_NAME_XYZ',5), # 只出現左邊前5個字就好
RIGHT('A_VERY_LONG_COMPANY_NAME_XYZ',5), # 只出現右邊前5個字就好
# 從'LONG_COMPANY_NAME'中，將'COMPANY'換成'SEED'
REPLACE('LONG_COMPANY_NAME', 'COMPANY','SEED'),
REVERSE('ABCDE'),
# 從第6個字開始，印出7個字
SUBSTRING('LONG_COMPANY_NAME', 6, 7); 

SELECT DAY('2024-04-09'), MONTH('2024-04-09'),
YEAR('2024-04-09');

SELECT HOUR('13:55:15'), MINUTE('13:55:15'),
SECOND('13:55:15');

SELECT DAYOFWEEK('2024-04-09'), DAYOFMONTH('2024-04-09'),
DAYOFYEAR('2024-04-09');

SELECT DATE_FORMAT('2024-04-09 15:57:25', '%Y %M %D'),
DATE_FORMAT('2024-04-09 15:57:25', '%Y %M(%b) %D'),
DATE_FORMAT('2024-04-09 15:57:25', '%y %c %d'),
# H =  24小時制, h = 12小時制
DATE_FORMAT('2024-04-09 15:57:25', '%W %w %H %h %i %s');

# 比一比 JOIN
SELECT * 
FROM State_Info
JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id;

# 比一比 RIGHT JOIN
SELECT * 
FROM State_Info
RIGHT JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id;

# 比一比 LEFT JOIN
SELECT * 
FROM State_Info
LEFT JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id;

# 比一比 LEFT JOIN = RIGHT JOIN(看誰是table A)
SELECT * 
FROM State_Info
RIGHT JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id;

SELECT * 
FROM Farm_Info
RIGHT JOIN State_Info
ON State_Info.State_ID = Farm_Info.State_id;

# UNION ALL = combine the results
SELECT * FROM Seed_Info WHERE Maturity > 111;
SELECT * FROM Seed_Info WHERE Maturity < 108;

SELECT * FROM Seed_Info WHERE Maturity > 111 #記得把分號拿掉
UNION ALL
SELECT * FROM Seed_Info WHERE Maturity < 108;

# UNION ALL
SELECT State_Info.State_name, Farm_Info.Farm_name 
FROM State_Info
LEFT JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id
UNION ALL
SELECT State_Info.State_name, Farm_Info.Farm_name 
FROM State_Info
RIGHT JOIN Farm_Info
ON State_Info.State_ID = Farm_Info.State_id;
# WHERE State_Info.State_ID IS NULL; # 去掉combine時前後表重複的項目

# UNION ALL
SELECT COUNT(*) FROM Trial_Info
UNION ALL
SELECT COUNT(*) FROM Trial_Info WHERE Yield > 80
UNION ALL
SELECT AVG(Yield) FROM Trial_Info
UNION ALL
SELECT COUNT(*) FROM Trial_Info WHERE Yield > 75.109;

# Subquery
# SELECT AVG(Yield) FROM Trial_Info
# SELECT COUNT(*) FROM Trial_Info WHERE Yield > 75.109
# 通常在真實世界資料庫的data會不斷更新，先算AVG，再給定一個"Yield>75.109"會很麻煩，因為AVG數值可能會不斷改變
# 可以寫一個類似function的東西:
SELECT COUNT(*) as 'Trial > AVG'
FROM Trial_Info
WHERE Yield > (
  SELECT AVG(Yield) FROM Trial_Info
);
# or
SELECT * 
FROM Trial_Info
WHERE Yield > (
  SELECT AVG(Yield) FROM Trial_Info
);

# Subquery
SELECT Farm_info_id, Disease_rating
FROM Trial_Info
WHERE Disease_rating > 4;

SELECT *
FROM Trial_Info 
WHERE Farm_info_id IN (
  SELECT Farm_info_id
  FROM Trial_Info
  WHERE Disease_rating > 4
);

# Subquery
SELECT MAX(Yield), MIN(Yield) FROM Trial_Info;

SELECT Farm_info_id, 
AVG(Yield) AS AVG_Yield,
COUNT(Seed_info_id) AS Num_Seed
FROM Trial_Info
GROUP BY Farm_info_id; 

SELECT MAX(AVG_Yield), MIN(AVG_Yield),
MAX(Num_Seed), MIN(Num_Seed)
FROM (
  SELECT Farm_info_id, 
  AVG(Yield) AS AVG_Yield,
  COUNT(Seed_info_id) AS Num_Seed
  FROM Trial_Info
  GROUP BY Farm_info_id
)
AS avg_yield_per_farm; 
# 當creat a table like FROM(...)，一定要用AS給定table name

SELECT Farm_info_id, Yield,
Farm_Info.State_id 
FROM Trial_Info JOIN Farm_Info
ON Trial_Info.Farm_info_id =
Farm_Info.Farm_ID
WHERE State_id <= 2;

SELECT Farm_info_id, State_id, MAX(Yield), MIN(Yield)
FROM(
  SELECT Farm_info_id, Yield,
  Farm_Info.State_id 
  FROM Trial_Info JOIN Farm_Info
  ON Trial_Info.Farm_info_id =Farm_Info.Farm_ID
  WHERE State_id <= 2
) AS subset_farms
GROUP BY Farm_info_id;

# 承上，把WHERE State_id <= 2換句話說
SELECT Farm_info_id, State_id, MAX(Yield), MIN(Yield)
FROM(
  SELECT Farm_info_id, Yield,
  Farm_Info.State_id 
  FROM Trial_Info 
    JOIN Farm_Info
    ON Trial_Info.Farm_info_id =Farm_Info.Farm_ID
    JOIN State_Info
    ON Farm_Info.State_id = State_Info.State_ID 
    WHERE Two_Letters IN ('CA', 'FL')
    # 也可以寫 WHERE State_name IN ('California', 'Florida')
) AS subset_farms
GROUP BY Farm_info_id;

SELECT Farm_info_id, State_id, AVG(Yield), MAX(Yield), MIN(Yield)
FROM(
  SELECT Farm_info_id, Yield,
  Farm_Info.State_id 
  FROM Trial_Info 
    JOIN Farm_Info
    ON Trial_Info.Farm_info_id =Farm_Info.Farm_ID
    JOIN State_Info
    ON Farm_Info.State_id = State_Info.State_ID 
    WHERE Two_Letters IN ('CA', 'FL')
) AS subset_farms
WHERE Yield > (
  SELECT AVG(Yield) FROM Trial_Info
)
GROUP BY Farm_info_id
HAVING MIN(Yield) < 80
ORDER BY MIN(Yield);
