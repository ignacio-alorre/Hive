-- Challenge: The company
-- https://www.hackerrank.com/challenges/the-company/problem

-- To take away: Multiple outer join, the group by & count distinct need to be performed in each table independently before the join

select c.company_code, c.founder, 
ld.lmcnt, sm.smcnt, m.mcnt, e.ecnt from
company c
left outer join
(select company_code, count(distinct lead_manager_code) as lmcnt from lead_manager group by company_code) ld
on c.company_code = ld.company_code
left outer join
(select company_code, count(distinct senior_manager_code) as smcnt from senior_manager group by company_code) sm
on c.company_code = sm.company_code
left outer join
(select company_code, count(distinct manager_code) as mcnt from manager group by company_code) m
on c.company_code = m.company_code
left outer join
(select company_code, count(distinct employee_code) as ecnt from employee group by company_code) e
on c.company_code = e.company_code
order by c.company_code;