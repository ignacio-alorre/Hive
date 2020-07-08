-- Challenge full score 
-- https://www.hackerrank.com/challenges/full-score/problem

-- Take away: There are two filtering here, one before the group by, and another after the group by.
-- For the first filter you can use where, for the second filter having

select t.hacker_id, t.name from(
select s.hacker_id, h.name, count((s.score-d.score+1) = 1) as ascore from 
submissions  s
left outer join
hackers h
on s.hacker_id = h.hacker_id
left outer join
challenges  c
on s.challenge_id = c.challenge_id
left outer join
difficulty d
on c.difficulty_level = d.difficulty_level
where (s.score-d.score+1) = 1
group by s.hacker_id, h.name
having count((s.score-d.score+1) = 1) > 1
order by ascore desc, s.hacker_id asc)t