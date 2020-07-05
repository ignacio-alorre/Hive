-- Creating the sampel tables
CREATE TABLE IF NOT EXISTS D_sensor 
(date String, value Int) 
PARTITIONED BY (sensor String)

INSERT INTO TABLE D_sensor 
PARTITION (sensor = 'S1')
(value, date)
VALUES
(10, '2020-03-01'),
(12, '2020-03-02'), 
(11, '2020-03-03'), 
(13, '2020-03-04')

INSERT INTO TABLE D_sensor 
PARTITION (sensor = 'S2')
(value, date)
VALUES
(11, '2020-03-01'), 
(12, '2020-03-02'), 
(13, '2020-03-03'), 
(11, '2020-03-04') 

-- LAG on OVER PARTITION
SELECT sensor, 
LAG(value, 1, 0) OVER (PARTITION BY sensor ORDER BY date) as prevValue
FROM D_sensor;

-- LEAD on OVER PARTITION
SELECT sensor, date, value, 
LEAD(value, 1 , 0) OVER (PARTITION BY sensor ORDER BY date) as leadValue
FROM D_sensor;

-- FIRST_VALUE on OVER PARTITION
SELECT sensor, value,
FIRST_VALUE(value) OVER (PARTITION BY sensor ORDER BY date) as avgVal
FROM D_sensor;

-- LAST_VALUE on OVER PARTITION
SELECT sensor, value,
LAST_VALUE(value) OVER (PARTITION BY sensor ORDER BY date) as lastVal
FROM D_sensor;

-- SUM on OVER PARTITION WINDOW OF 1
SELECT sensor, value,
SUM(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) as sum
FROM D_sensor;

-- SUM on OVER PARTITION WINDOW OF 2
SELECT sensor, value,
SUM(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as sum
FROM D_sensor;

-- MIN on OVER PARTITION
SELECT sensor, value,
MIN(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as minVal
FROM D_sensor;

-- MAX on OVER PARTITION
SELECT sensor, value,
MAX(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as maxVal
FROM D_sensor;

-- COUNT on OVER PARTITION
SELECT sensor, value,
COUNT(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as countVal
FROM D_sensor;

-- AVG on OVER PARTITION
SELECT sensor, value,
AVG(value) OVER (PARTITION BY sensor ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as avgVal
FROM D_sensor;


-- Preparing new table with repeated values
INSERT INTO TABLE D_sensor 
PARTITION (sensor = 'S1')
(value, date)
VALUES
(10, '2020-03-01'),
(12, '2020-03-02'), 
(11, '2020-03-03'), 
(12, '2020-03-03'),
(14, '2020-03-04'),
(14, '2020-03-04')

SELECT *
FROM D_sensor
where sensor = 'S1';

-- RANK
-- ROW_NUMBER
-- DENSE_RANK
SELECT sensor, value,
RANK() OVER (PARTITION BY sensor ORDER BY date) AS rank,
ROW_NUMBER() OVER (PARTITION BY sensor ORDER BY date) AS rowNumber,
DENSE_RANK() OVER(PARTITION BY sensor ORDER BY date) AS denseRank
FROM D_sensor
where sensor = 'S1';


-- CUME_DIST
-- PERCENT_RANK
SELECT sensor, value,
CUME_DIST() OVER (PARTITION BY sensor ORDER BY date) AS cumeDist,
PERCENT_RANK() OVER (PARTITION BY sensor ORDER BY date) AS pecentRank
FROM D_sensor
where sensor = 'S1';


SELECT sensor, date, value,
NTILE(2) OVER (PARTITION BY sensor ORDER BY date) AS ntile2,
NTILE(3) OVER (PARTITION BY sensor ORDER BY date) AS ntile3,
NTILE(4) OVER (PARTITION BY sensor ORDER BY date) AS ntile4
FROM D_sensor
where sensor = 'S1';
