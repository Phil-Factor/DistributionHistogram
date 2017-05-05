
/* Create a table type. */ 
IF OBJECT_ID('dbo.ColumnHistogram') IS NOT NULL
DROP FUNCTION ColumnHistogram
GO
IF EXISTS(SELECT * FROM sys.types WHERE name LIKE 'independentVariable')
DROP TYPE independentVariable

CREATE TYPE IndependentVariable AS TABLE   
(number FLOAT NOT null) 
GO  

/* Create a procedure to receive data for the table-valued parameter. */  
CREATE function ColumnHistogram
    (@InVar IndependentVariable READONLY)  
RETURNS @Histogram TABLE   
(  
    line NVARCHAR(200) NOT NULL, 
	y int NOT null
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN

DECLARE @variable TABLE(value INT);
DECLARE @Maximum NUMERIC(18,2), @Minimum NUMERIC(18,2) , @MaxIndividualCount INT;
SELECT @Maximum = MAX(number), @minimum = MIN(number) FROM @InVar;
--we convert the values to integers, with an origin of zero and range of 40
IF (@Maximum-@Minimum)>40
INSERT INTO @variable (value)
  SELECT CONVERT(INT, CEILING((number - @minimum) / (@Maximum - @minimum) * 40.00))
   FROM @InVar;
ELSE 
INSERT INTO @variable (value)
  SELECT CONVERT(INT, number - @minimum+1)
   FROM @InVar;
  -- 40 represents the number of ranges. We adjust to a zero-based origin
  -- to make the plotting easier
  -- we need to know the value of the largest pocket (the highest frequency)
SELECT @MaxIndividualCount = MAX(f.IndividualCount)
  FROM
    (SELECT COUNT(*) AS IndividualCount
       FROM @variable
       GROUP BY [@variable].value
	   HAVING value>0
    ) f;

INSERT INTO @Histogram(line,y)
SELECT CASE WHEN y=10 THEN CONVERT(CHAR(12),@MaxIndividualCount)+N'│' --we add in the highest frequency 
			WHEN y=3 THEN CONVERT(CHAR(12),@minimum)+N'│' -- the top of the Y axis
			WHEN y=2 THEN N'   …to…     │' --and we also add the maximum and minimum values
			WHEN y=1 THEN CONVERT(CHAR(12),@Maximum)+N'│' 
			ELSE N'            │'end+
--SELECT '      │'+
MAX(CASE WHEN x=1 AND  filled=1 THEN N'█' ELSE N' ' END)+
MAX(CASE WHEN x=2 AND  filled=1 THEN N'█' WHEN x=2  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=3 AND  filled=1 THEN N'█' WHEN x=3  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=4 AND  filled=1 THEN N'█' WHEN x=4  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=5 AND  filled=1 THEN N'█' WHEN x=5  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=6 AND  filled=1 THEN N'█' WHEN x=6  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=7 AND  filled=1 THEN N'█' WHEN x=7  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=8 AND  filled=1 THEN N'█' WHEN x=8  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=9 AND  filled=1 THEN N'█' WHEN x=9  AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=10 AND filled=1 THEN N'█' WHEN x=10 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=11 AND filled=1 THEN N'█' WHEN x=11 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=12 AND filled=1 THEN N'█' WHEN x=12 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=13 AND filled=1 THEN N'█' WHEN x=13 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=14 AND filled=1 THEN N'█' WHEN x=14 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=15 AND filled=1 THEN N'█' WHEN x=15 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=16 AND filled=1 THEN N'█' WHEN x=16 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=17 AND filled=1 THEN N'█' WHEN x=17 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=18 AND filled=1 THEN N'█' WHEN x=18 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=19 AND filled=1 THEN N'█' WHEN x=19 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=20 AND filled=1 THEN N'█' WHEN x=20 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=21 AND filled=1 THEN N'█' WHEN x=21 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=22 AND filled=1 THEN N'█' WHEN x=22 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=23 AND filled=1 THEN N'█' WHEN x=23 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=24 AND filled=1 THEN N'█' WHEN x=24 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=25 AND filled=1 THEN N'█' WHEN x=25 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=26 AND filled=1 THEN N'█' WHEN x=26 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=27 AND filled=1 THEN N'█' WHEN x=27 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=28 AND filled=1 THEN N'█' WHEN x=28 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=29 AND filled=1 THEN N'█' WHEN x=29 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=30 AND filled=1 THEN N'█' WHEN x=30 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=31 AND filled=1 THEN N'█' WHEN x=31 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=32 AND filled=1 THEN N'█' WHEN x=32 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=33 AND filled=1 THEN N'█' WHEN x=33 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=34 AND filled=1 THEN N'█' WHEN x=34 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=35 AND filled=1 THEN N'█' WHEN x=35 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=36 AND filled=1 THEN N'█' WHEN x=36 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=37 AND filled=1 THEN N'█' WHEN x=37 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=38 AND filled=1 THEN N'█' WHEN x=38 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=39 AND filled=1 THEN N'█' WHEN x=39 AND  filled=2 THEN N'▄' ELSE N' ' END)+
MAX(CASE WHEN x=40 AND filled=1 THEN N'█' WHEN x=40 AND  filled=2 THEN N'▄' ELSE N' ' END),y
FROM 
(
 SELECT x,y, --we work out whether the cell has data or not (1-filled, 2 means around half)
		CASE WHEN f.frequency*10.00/@MaxIndividualCount>CONVERT(NUMERIC(8,2),y) THEN 1
		     WHEN f.frequency*10.00/@MaxIndividualCount>CONVERT(NUMERIC(8,2),y-0.5) THEN 2
		     ELSE 0 END AS filled

 FROM
(VALUES ( 1), (2), (3), (4), (5), (6), (7), (8), (9), (10))OneToTen(y)--the Y axis (inverted!)
CROSS join
(SELECT OneToForty.value AS x, SUM(CASE WHEN g.value IS NOT NULL THEN 1 ELSE 0 END )AS frequency	
FROM 
(VALUES --the range of each 'pocket'
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10),( 11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),( 31), (32), (33), (34), (35), (36), (37), (38), (39), (40)
)OneToForty(value)
LEFT OUTER JOIN
	 @variable g
ON g.value=OneToForty.value
GROUP BY OneToForty.value)f
)g
GROUP BY y
RETURN
END
GO
DECLARE @Variable IndependentVariable; --a simple table of numbers
DECLARE @Mean FLOAT; --the mean (and median if normally distributed)
DECLARE @StandardDeviation FLOAT; --(the Standard deviation you want)
DECLARE @ii INT; --counter
DECLARE @TotalWanted INT; --counter

SELECT @Mean = 500, @StandardDeviation = 100, @ii = 1, @TotalWanted = 100000;
SET NOCOUNT ON;
/* now we generate the numbers we want, with the mean and standard deviation we want */
WHILE @ii <= @TotalWanted
  BEGIN
  INSERT INTO @Variable
    (number)
    SELECT ((RAND() * 2 - 1) + (RAND() * 2 - 1) + (RAND() * 2 - 1))
           * @StandardDeviation + @Mean;
  SELECT @ii = @ii + 1;
  END;

SELECT ColumnHistogram.line AS 'Normally Distributed Variable '
  FROM dbo.ColumnHistogram(@Variable)
  ORDER BY ColumnHistogram.y DESC;
GO
DECLARE @SecondVariable IndependentVariable; --a simple table of numbers
INSERT INTO @SecondVariable
  (number)
  SELECT ASCII(SUBSTRING(Person.LastName, 1, 1))
  FROM AdventureWorks2012.Person.Person;
SELECT ColumnHistogram.line AS 'Customers Surnames'
  FROM dbo.ColumnHistogram(@SecondVariable)
  ORDER BY ColumnHistogram.y DESC;
GO

DECLARE @ThirdVariable IndependentVariable; --a simple table of numbers
INSERT INTO @ThirdVariable
  (number)
  SELECT CONVERT(FLOAT, SalesOrderHeader.OrderDate)
  FROM AdventureWorks2012.Sales.SalesOrderHeader;
SELECT ColumnHistogram.line AS 'No. of orders per date period'
  FROM dbo.ColumnHistogram(@ThirdVariable)
  ORDER BY ColumnHistogram.y DESC;

