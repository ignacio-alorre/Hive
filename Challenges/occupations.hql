-- This is SQL Oracle [Pivot is not an option in Hive]
-- Challenge: https://www.hackerrank.com/challenges/occupations/problem?h_r=next-challenge&h_v=zen
-- 
-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
-- 
-- Note: Print NULL when there are no more names corresponding to an occupation.

-- Example:
-- Aamina Ashley Christeen Eve 
-- Julia Belvet Jane Jennifer 
-- Priya Britney Jenny Ketty 
-- NULL Maria Kristeen Samantha 
-- NULL Meera NULL NULL 
-- NULL Naomi NULL NULL 
-- NULL Priyanka NULL NULL 

select doctor, professor, singer, actor 
from(
select * from (
select Name, occupation, (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) as row_num 
from occupations 
order by name asc) 
pivot ( min(name) for occupation in ('Doctor' as doctor,'Professor' as professor,'Singer' as singer,'Actor' as actor)) 
order by row_num);