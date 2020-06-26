
-- Creating two simple Managed Tables which have in common the field segment
CREATE TABLE IF NOT EXISTS D_customer 
(id int, name String, segment String)

INSERT INTO TABLE D_customer VALUES 
(1, 'Abbel', 's1'), 
(2, 'Berny', 's2'),
(3, 'Coltan', null),
(4, 'Devor', 's3'),
(5, 'Erbet', 's2'),
(6, 'Francis', 's5'),
(7, 'Gregory', 's1'),
(1, 'Abbel', 's1')


CREATE TABLE IF NOT EXISTS D_offers 
(segment String, discount int)

INSERT INTO TABLE D_offers VALUES 
('s1', 10), 
(null, 20), 
('s3', 30),
('s3', 40),
('s4', 80)

-- 1- join [inner join]
select c.*, o.discount from
D_customer c join D_offers o
on c.segment = o.segment

-- 2- full join
select c.*, o.discount from
D_customer c full join D_offers o
on c.segment = o.segment

-- 3- left outer join
select c.*, o.discount from
D_customer c left outer join D_offers o
on c.segment = o.segment

-- 4- left outer join with exclusion
select c.*, o.discount from
D_customer c left outer join D_offers o
on c.segment = o.segment
where o.segment is null

-- 5- right outer join
select c.*, o.discount from
D_customer c right outer join D_offers o
on c.segment = o.segment

-- 6- right outer join with exclusion
select c.*, o.discount from
D_customer c right outer join D_offers o
on c.segment = o.segment
where c.segment is null

-- 7- full outer join with exclusion
select c.*, o.discount from
D_customer c full outer join D_offers o
on c.segment = o.segment
where o.segment is null
or c.segment is null
