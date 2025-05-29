use newvalue;

select * from matches;

-- How many matches we’ve got in the dataset?
SELECT COUNT(*) AS Total_Matches FROM matches;



-- How many seasons we’ve got in the dataset?
SELECT COUNT(DISTINCT season) AS Total_Seasons FROM matches;



-- Which Team had won by maximum runs?
SELECT TOP 1 winner, win_by_runs 
FROM matches 
WHERE win_by_runs > 0 
ORDER BY win_by_runs DESC;


-- Which Team had won by maximum wicket?
SELECT TOP 1 winner, win_by_wickets 
FROM matches 
WHERE win_by_wickets > 0 
ORDER BY win_by_wickets DESC;


-- Which Team had won by closest Margin (minimum runs)?
SELECT TOP 1 winner, win_by_runs 
FROM matches 
WHERE win_by_runs > 0 
ORDER BY win_by_runs ASC;


-- Which Team had won by minimum wicket?
SELECT TOP 1 winner, win_by_wickets 
FROM matches 
WHERE win_by_wickets > 0 
ORDER BY win_by_wickets ASC;


-- Which Season had most number of matches?
SELECT TOP 1 season, COUNT(*) AS match_count
FROM matches 
GROUP BY season 
ORDER BY match_count DESC;


-- Which IPL Team is more successful?
 SELECT winner, COUNT(*) AS total_wins
FROM matches 
WHERE winner IS NOT NULL
GROUP BY winner 
ORDER BY total_wins DESC;
