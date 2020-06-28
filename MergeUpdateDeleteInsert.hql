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

CREATE TABLE IF NOT EXISTS D_customer_new 
(id int, name String, segment String)

-- INSERT
INSERT INTO TABLE D_customer_new VALUES 
(8, 'Helcur', 's3'), 
(1, 'Abbel', 's3'),
(2, 'Bernard', 's2'),
(9, 'Jackeline', 's9')

UPDATE D_customer_new SET segment = 's7' WHERE segment = 's3';
-- AnalysisException: Impala does not support modifying a non-Kudu table: emcg.d_customer_new

DELETE FROM D_customer_new WHERE segment = 's3';
-- AnalysisException: Impala does not support modifying a non-Kudu table: emcg.d_customer_new

MERGE INTO D_customer
using ( select * from D_customer_new) updt
on updt.id = D_customer.id
when matched then update set name = updt.name, segment = sub.segment
when not matched then insert values (updt.id, updt.name, updt.segment);

