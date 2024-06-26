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


### MySQL part4 ###
# 前三parts是使用agron5106_1，以下使用agron5106_2
SHOW Databases;
USE r11628111_field_trial;
SHOW Tables;
DESCRIBE Employee_Info;
SELECT * FROM Employee_Info;
# INSERT INTO Employee_Info (Person_name) VALUES ("Fred"); # Fail

# 'Fred_#' works in 'farm_#'
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_1",1);
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_2",2);
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_3",3);
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_4",4);
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_5",5);
INSERT INTO Employee_Info (Person_name, Farm_id)
VALUES("Fred_6",6);

# 縮寫一下
INSERT INTO Employee_Info (Person_name, Farm_id, Phone_number)
VALUES("Amy_1",1,'123-456'), ("Amy_2",2,'456-789'), ("Amy_3",3,'101-112'),
("Amy_4",'131-415'), ("Amy_5",5,'151-617'), ("Amy_6",6,'181-920');
### ERROR!!!!!!!! ###

# Check一下
SELECT * FROM Employee_Info;
WHERE Person_name = 'Fred_2' OR Person_name = 'Amy_5';

# 數各個Farm有幾個工人在工作
SELECT COUNT(Farm_id), Employee_Info.* 
FROM Employee_Info
GROUP BY Farm_id;

# 會error，因為Manager的數字只能是Employee_ID中的數字(看ER圖)
INSERT INTO Employee_Info 
(Person_name, Farm_id, Phone_number, Manager)
VALUES
("Jhon_t3", 2, '123-123', 1000),
("Tom_t3", 3, '123456', 1001),
("Jane_t3", 4, '999-999-999',1011),
("Cathy_t3", 5, '555-55555', 1111);

# Update新資訊，EX:補上電話號碼
UPDATE Employee_Info 
SET Phone_number = '123-4567'
WHERE Person_name = 'Fred_1';

# Update新資訊，EX:改名字
UPDATE Employee_Info  
SET Person_name = 'Fred_7'
WHERE Employee_ID = 102;

# Update新資訊，EX:改電話
UPDATE Employee_Info  
SET Phone_number = '246-8101'
WHERE Employee_ID = 102;

# Update新資訊，小心! 沒有用WHERE限定條件，就會所有row都update
UPDATE Employee_Info  
SET Note = 'check';

# 用UPDATE將受manager101管轄的人的田改成farm 5
UPDATE Employee_Info 
SET Farm_id = 5
WHERE Manager = 101;

SELECT * FROM Employee_Info;

# 用UPDATE將受manager101管轄的人的田改成farm5
# 並且新增受聘日=2024-04-16
# 並且標註new farm
UPDATE Employee_Info 
SET Farm_id = 3, 
    Hire_date ='2024-04-16',
    Note ='new farm'
WHERE Manager = 101;

SELECT * FROM Employee_Info;

# CONCAT()將字串合起來
SELECT CONCAT('I', ' am', ' team', ' dog'); 

# UPDATE + CONCAT()
UPDATE Employee_Info 
SET Farm_id = 4, 
    Hire_date ='2024-04-10',
    Note ='farm'
WHERE Employee_ID IN (114,115); # 先將mananger101的兩個員工調到farm4

SELECT * FROM Employee_Info
JOIN Farm_Info ON Employee_Info.Farm_id = Farm_Info.Farm_ID; # check一下

UPDATE Employee_Info
JOIN Farm_Info ON Employee_Info.Farm_id = Farm_Info.Farm_ID 
SET Note = CONCAT('Farm: ', Farm_Info.Farm_name, ' Date: ', Hire_date)
WHERE Manager =101;

SELECT * FROM Employee_Info
JOIN Farm_Info ON Employee_Info.Farm_id = Farm_Info.Farm_ID;

# DELETE_1
SELECT * FROM Employee_Info
WHERE Manager = 101 AND Farm_id = 3; # check

DELETE FROM Employee_Info 
WHERE Manager = 101 AND Farm_id = 3;

SELECT * FROM Employee_Info
WHERE Manager = 101 AND Farm_id = 3; # check

# 小心使用DELETE 跟 TRUNCATE，有可能不小心刪掉所有東西
DELETE FROM Trial_Info;
TRUNCATE TABLE Trial_Info; 

### MySQL part5 ###
# 這裡是用r11628111_field_trial這個database
SHOW Databases;
USE r11628111_field_trial;
SHOW Tables;

# 查看建table需要那些元素
DESCRIBE Company_Info;
SHOW CREATE TABLE Company_Info;

# CREATE TABLE_1
SHOW CREATE TABLE Farm_Info;

CREATE TABLE IF NOT EXISTS Farm_Info(
# 記得加"IF NOT EXISTS"，不然會error，因為Farm_Info這個table已經存在了
 Farm_ID int NOT NULL AUTO_INCREMENT, # Primary key
 Farm_Name varchar(255) NOT NULL,
 PRIMARY KEY(Farm_ID) # 宣告要設定Farm_ID為Primary key
); # 因為Farm__Info已經存在，所以這個程式可以執行，但無事發生

# CREATE TABLE_2
SHOW Tables; # check一下那些table已經存在

CREATE TABLE IF NOT EXISTS Job_Info(
 Job_ID int NOT NULL AUTO_INCREMENT,
 Job_Title varchar(127) NOT NULL,
 PRIMARY KEY(Job_ID)
);

SHOW Tables; # check一下Job_Info有沒有建成功
SHOW CREATE TABLE Job_Info;
DESCRIBE Job_Info;

# insert資料到table
INSERT INTO Job_Info (Job_Title) Values
('Manager'), ('CEO'), ('Temp_worker');

SELECT * FROM Job_Info;

# 加入FOREIGN KEY
DESCRIBE Company_Info;

CREATE TABLE IF NOT EXISTS Job_Info_take2(
Job_ID int NOT NULL AUTO_INCREMENT,
Job_desc varchar(255), # Job_desc = job describe
Company_id int,
CONSTRAINT FK_job_company_id FOREIGN KEY(Company_id) # FK=foreign key
  REFERENCES Company_Info (Company_ID),
PRIMARY KEY(Job_ID)
);

DESCRIBE Job_Info_take2; # check結果
SELECT * FROM Company_Info; # check結果

# insert資料到Job_Info_take2
INSERT INTO Job_Info_take2 (Job_desc, Company_id) # 不能打(Job_ID, Company_id)，因為Job_ID是primary key
  VALUES ('CEO', 1);

SELECT * FROM Job_Info_take2
JOIN Company_Info
ON Job_Info_take2.Company_id = Company_Info.Company_ID; # check

# insert foreign key只能insert其已經存在的範圍
INSERT INTO Job_Info_take2 (Job_desc, Company_id) # 不能打(Job_ID, Company_id)，因為Job_ID是primary key
  VALUES ('CEO', 5); # 會跑error，因為Company_id是foreign key且最多只到2
 
# 刪除table，小心使用! drop前記得檢查自己有再create一次的資料或code
SHOW Tables;
DROP TABLE Job_Info;
DROP TABLE Job_Info; # 會跑error，因為剛剛已經drop完，Job_Info已經不存在，不能再drop
DROP TABLE IF EXISTS Job_Info; # 這樣修改才不會error

# 修改table內容
ALTER TABLE Employee_Info 
  ADD Job_desc varchar(255); # 新增一個colum
  
DESCRIBE Employee_Info; # check

ALTER TABLE Employee_Info 
  DROP Job_desc; # 刪除一個colum
  
DESCRIBE Employee_Info; # check

ALTER TABLE Employee_Info 
  ADD Job_desc varchar(255) AFTER Person_name; # 新增一個colum，希望這個colum位置再Person_name後面

DESCRIBE Employee_Info; # check

ALTER TABLE Employee_Info 
  MODIFY Job_desc int; # MODIFY = 修改欄的"資料性質"

DESCRIBE Employee_Info; # check

ALTER TABLE Employee_Info 
  CHANGE COLUMN Job_desc Job_id int; # CHANGE COLUMN = 修改欄的"名稱"
 
DESCRIBE Employee_Info; # check

ALTER TABLE Employee_Info 
  ADD CONSTRAINT FK_job_take2 FOREIGN KEY (Job_id)
  REFERENCES Job_Info_take2 (Job_ID);
 
# 只是準備一下之後要用的資料
SELECT * FROM Employee_Info;
SELECT * FROM Job_Info_take2;
DELETE FROM Job_Info_take2;

INSERT INTO Job_Info_take2 (Job_desc) 
VALUES('CEO'),('Manager'),('Temp_worker');

SELECT * FROM Job_Info_take2;

# 比較3種update的方法
# 1 #
UPDATE Employee_Info SET Job_id=2;

SELECT * FROM Employee_Info; # check

# 2 #
UPDATE Employee_Info 
  SET Employee_Info.Job_id=1
  WHERE Employee_Info.Person_name = 'Fred_1';

SELECT * FROM Employee_Info; # check

# 3 #
UPDATE Employee_Info
  SET Employee_Info.Job_id = (
    SELECT Job_id FROM Job_Info_take2 
    WHERE Job_desc = 'Temp_worker'
  )
  WHERE Employee_Info.Person_name = 'Fred_1'

SELECT * FROM Employee_Info; # check

# 顯示所有table name = "Employee_Info"的constraints
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Employee_Info';

SHOW CREATE TABLE Employee_Info;

# 加入Job_rank這個column，並且限定她的範圍只能1~5
# ALTER TABLE Job_Info_take2
# DROP Job_rank;

ALTER TABLE Job_Info_take2 ADD Job_rank int;
DESCRIBE Job_Info_take2;
SELECT * FROM Job_Info_take2;

ALTER TABLE Job_Info_take2
  ADD CONSTRAINT CHK_ranking
      CHECK(Job_rank > 0 AND Job_rank < 6);

SHOW CREATE TABLE Job_Info;

INSERT INTO Job_Info_take2(Job_desc, Job_rank)
  VALUES('basic_job', 6); # 會error，因為Joob_rank已經限定是1-5的整數

# 如何去除Job_rank 1-5整數的限制?
ALTER TABLE Job_Info_take2
  DROP CONSTRAINT CHK_ranking;
