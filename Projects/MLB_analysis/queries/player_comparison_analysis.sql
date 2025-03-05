-- TASK 1: View the players table to understand its structure
-- Displays all columns and rows in the players table
SELECT * FROM players;

-- TASK 2: Find players with the same birthday using string manipulation
-- Uses Common Table Expression (CTE) to standardize date format
-- Demonstrates string concatenation and GROUP_CONCAT for listing players
WITH bn AS (
    -- Create a standardized birthdate and collect player names
    SELECT 
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate,
        nameGiven
    FROM players
)
-- Group players by their birthdate, filtering for specific birth years
SELECT 
    birthdate, 
    -- GROUP_CONCAT combines multiple names into a single string
    GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players
FROM bn
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;

-- Note on string functions across different databases:
-- MySQL & SQL Server: CONCAT() for string concatenation
-- MySQL: GROUP_CONCAT() for aggregating strings
-- Other databases might use LISTAGG() or STRING_AGG()

-- TASK 3: Calculate batting stance distribution per team
-- Two solutions are provided to handle duplicate player entries

-- SOLUTION 1: Initial approach (potentially less accurate due to duplicates)
SELECT 
    s.teamID,
    -- Calculate percentage of players batting right, left, and both
    ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_right,
    ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_left,
    ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_both
FROM salaries s 
LEFT JOIN players p ON s.playerID = p.playerID
GROUP BY s.teamID;

-- SOLUTION 2: More accurate approach removing duplicate player-team combinations
-- Creates a CTE with unique player-team entries to avoid overcounting
WITH up AS (
    -- Use DISTINCT to remove duplicate player-team combinations
    SELECT DISTINCT 
        s.teamID, 
        s.playerID, 
        p.bats
    FROM salaries s 
    LEFT JOIN players p ON s.playerID = p.playerID
)
-- Calculate batting stance percentages using unique player-team data
SELECT 
    teamID,
    ROUND(SUM(CASE WHEN bats = 'R' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_right,
    ROUND(SUM(CASE WHEN bats = 'L' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_left,
    ROUND(SUM(CASE WHEN bats = 'B' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_both
FROM up
GROUP BY teamID;

-- TASK 4: Analyze changes in player height and weight across decades
-- Uses window functions to calculate decade-over-decade differences
WITH hw AS (
    -- Group players by decade and calculate average height and weight
    SELECT 
        FLOOR(YEAR(debut) / 10) * 10 AS decade,
        AVG(height) AS avg_height, 
        AVG(weight) AS avg_weight
    FROM players
    GROUP BY decade
)
-- Calculate differences in height and weight between consecutive decades
SELECT 
    decade,
    -- LAG function retrieves previous decade's values for comparison
    avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
    avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM hw
WHERE decade IS NOT NULL;