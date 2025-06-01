
use newvalue;

select * from matches;

-- 1. Total matches
SELECT COUNT(*) FROM matches;

-- 2. Total seasons
SELECT COUNT(DISTINCT season) FROM matches;

-- 3. Max win by runs
SELECT TOP 1 winner FROM matches WHERE win_by_runs > 0 ORDER BY win_by_runs DESC;


-- 4. Max win by wickets
SELECT TOP 1 winner FROM matches WHERE win_by_wickets > 0 ORDER BY win_by_wickets DESC;


-- 5. Closest win by runs
SELECT TOP 1 winner FROM matches WHERE win_by_runs > 0 ORDER BY win_by_runs ASC;


-- 6. Min win by wickets
SELECT TOP 1 winner FROM matches WHERE win_by_wickets > 0 ORDER BY win_by_wickets ASC;


-- 7. Season with most matches
SELECT TOP 1 season FROM matches GROUP BY season ORDER BY COUNT(*) DESC;


-- 8. Most successful team
SELECT TOP 1 winner FROM matches WHERE winner IS NOT NULL GROUP BY winner ORDER BY COUNT(*) DESC;
