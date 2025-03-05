-- Database Selection and Context
-- Connect to the specific database for advanced SQL analysis
USE maven_advanced_sql;

-- PART I: SCHOOL ANALYSIS

-- TASK 1: View the complete contents of schools and school_details tables
-- This query helps to understand the structure and initial data of the tables
SELECT * FROM schools;
SELECT * FROM school_details;

-- TASK 2: Count of schools producing players by decade
-- Uses FLOOR() to group years into decades and COUNT(DISTINCT) to avoid duplicate schools
-- This helps understand the distribution of schools over time
SELECT 
    FLOOR(yearID / 10) * 10 AS decade,       -- Convert years to decade groups
    COUNT(DISTINCT schoolID) AS num_schools  -- Count unique schools per decade
FROM schools
GROUP BY decade                              -- Aggregate by decade
ORDER BY decade;                             -- Sort results chronologically

-- TASK 3: Top 5 schools by number of players produced
-- Uses LEFT JOIN to combine schools and school details
-- Provides full school names along with player count
SELECT 
    sd.name_full,                            -- Full school name
    COUNT(DISTINCT s.playerID) AS num_players -- Count unique players
FROM schools s 
LEFT JOIN school_details sd ON s.schoolID = sd.schoolID
GROUP BY s.schoolID                          -- Group by unique school
ORDER BY num_players DESC                    -- Sort by player count
LIMIT 5;                                     -- Retrieve top 5 schools

-- TASK 4: Top 3 schools producing players in each decade
-- Complex query using Common Table Expressions (CTEs) and Window Functions
-- Demonstrates advanced SQL techniques for ranking and partitioning data
WITH ds AS (
    -- First CTE: Calculate player count per school per decade
    SELECT 
        FLOOR(s.yearID / 10) * 10 AS decade,  -- Decade grouping
        sd.name_full,                         -- School name
        COUNT(DISTINCT s.playerID) AS num_players  -- Player count
    FROM schools s 
    LEFT JOIN school_details sd ON s.schoolID = sd.schoolID
    GROUP BY decade, s.schoolID
),
rn AS (
    -- Second CTE: Rank schools within each decade by player count
    SELECT 
        decade, 
        name_full, 
        num_players,
        -- ROW_NUMBER() assigns unique rank to each school in a decade
        -- DENSE_RANK() would handle ties differently, potentially including more schools
        ROW_NUMBER() OVER (
            PARTITION BY decade 
            ORDER BY num_players DESC
        ) AS row_num
    FROM ds
)
-- Final selection of top 3 schools per decade
SELECT 
    decade, 
    name_full, 
    num_players
FROM rn
WHERE row_num <= 3  -- Limit to top 3 schools
ORDER BY decade DESC, row_num;  -- Sort by most recent decade first