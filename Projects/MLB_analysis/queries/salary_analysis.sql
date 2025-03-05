-- Connect to database (MySQL)
USE maven_advanced_sql;

-- PART II: SALARY ANALYSIS

-- TASK 1: View the entire salaries table to understand its structure
-- Helps in initial data exploration and understanding the table's contents
SELECT * FROM salaries;

-- TASK 2: Identify the top 20% of teams by average annual spending
-- Uses window functions to divide teams into quintiles and select the top quintile
WITH ts AS (
    -- First CTE: Calculate total team spending per year
    SELECT 
        teamID, 
        yearID, 
        SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
),
sp AS (
    -- Second CTE: Calculate average spending and assign quintile ranking
    SELECT 
        teamID, 
        AVG(total_spend) AS avg_spend,
        -- NTILE(5) divides teams into 5 groups based on average spending
        -- Top group (quintile 1) represents the top 20% of teams
        NTILE(5) OVER (ORDER BY AVG(total_spend) DESC) AS spend_pct
    FROM ts
    GROUP BY teamID
)
-- Select only the top quintile (spend_pct = 1)
-- Convert average spend to millions for readability
SELECT 
    teamID, 
    ROUND(avg_spend / 1000000, 1) AS avg_spend_millions
FROM sp
WHERE spend_pct = 1;

-- TASK 3: Calculate cumulative team spending over years
-- Demonstrates rolling/running total calculation using window function
WITH ts AS (
    -- CTE to aggregate total team spending per year
    SELECT 
        teamID, 
        yearID, 
        SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
)
-- Calculate cumulative sum of spending for each team
-- Partitioned by team, ordered by year
SELECT 
    teamID, 
    yearID,
    -- Convert cumulative sum to millions, rounded to 1 decimal place
    ROUND(SUM(total_spend) OVER (
        PARTITION BY teamID 
        ORDER BY yearID
    ) / 1000000, 1) AS cumulative_sum_millions
FROM ts;

-- TASK 4: Find the first year each team's cumulative spending exceeded 1 billion
-- Uses multiple window functions and filtering to identify milestone year
WITH ts AS (
    -- First CTE: Calculate total team spending per year
    SELECT 
        teamID, 
        yearID, 
        SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
),
cs AS (
    -- Second CTE: Calculate running cumulative sum for each team
    SELECT 
        teamID, 
        yearID,
        SUM(total_spend) OVER (
            PARTITION BY teamID 
            ORDER BY yearID
        ) AS cumulative_sum
    FROM ts
),
rn AS (
    -- Third CTE: Identify the first year cumulative spending exceeds 1 billion
    -- Uses ROW_NUMBER to select the first occurrence for each team
    SELECT 
        teamID, 
        yearID, 
        cumulative_sum,
        ROW_NUMBER() OVER (
            PARTITION BY teamID 
            ORDER BY cumulative_sum
        ) AS rn
    FROM cs
    WHERE cumulative_sum > 1000000000  -- Filter for teams exceeding 1 billion
)
-- Select the first year for each team that exceeded 1 billion in cumulative spending
SELECT 
    teamID, 
    yearID, 
    ROUND(cumulative_sum / 1000000000, 2) AS cumulative_sum_billions
FROM rn
WHERE rn = 1;