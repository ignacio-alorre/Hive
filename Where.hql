DROP TABLE IF EXISTS d_customer;
CREATE TABLE IF NOT EXISTS d_customer 
(id int, name String, primary_email array(String), secondary_email array(String))

-- We need to add this weird syntax to add complex types
INSERT INTO TABLE D_customer SELECT 1, 'Abbel', array('email1', 'email2'), array('email1', 'email3') FROM (SELECT 'a') x;
INSERT INTO TABLE D_customer SELECT 2, 'Berny', array('email1', 'email3'), array('email3', 'email1') FROM (SELECT 'a') x;
INSERT INTO TABLE D_customer SELECT 3, 'Coltan', array(null), array('email1', 'email3') FROM (SELECT 'a') x;
INSERT INTO TABLE D_customer SELECT 4, 'Devor', array('email1', 'email2', 'email4'), array('email1', 'email3') FROM (SELECT 'a') x;

/*
 d_customer.id	d_customer.name	d_customer.primary_email		d_customer.secondary_email
1				Abbel			["email1","email2"]				["email1","email3"]
2				Berny			["email1","email3"]				["email3","email1"]
3				Coltan			NULL							["email1","email3"]
4				Devor			["email1","email2","email4"]	["email1","email3"]
*/

-- 1: Using WHERE to compare simple types 
SELECT name 
FROM d_customer 
where size(primary_email) = size(secondary_email);

/*
Abbel
Berny
*/


-- 2: Using WHERE to compare complex types 
-- It is required to:
--		Flatten the array first by sorting its values
-- 		Concatenate the different values to generate a string


SELECT name FROM
(SELECT name, 
concat_ws('-',sort_array(primary_email)) as primary_email_flatten,
concat_ws('-',sort_array(secondary_email)) as secondary_email_flatten
FROM D_customer) cust
WHERE primary_email_flatten = secondary_email_flatten

/*
Berny
*/


