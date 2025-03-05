-- Connect to database (MySQL)
USE maven_advanced_sql;

-- PART III: PLAYER CAREER ANALYSIS

-- TASK 1: Explore the players table
-- View all columns in the players table to understand its structure
SELECT * FROM players;

-- Count the total number of players in the table
-- Provides a quick overview of the dataset size
SELECT COUNT(*) FROM players;

-- TASK 2: Calculate player ages and career length
-- Uses TIMESTAMPDIFF to compute ages and career duration
-- Demonstrates datetime manipulation and age calculation
SELECT 
    nameGiven,  -- Player's given name
    -- Calculate age at debut by comparing birth date to debut date
    TIMESTAMPDIFF(
        YEAR, 
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), 
        debut
    ) AS starting_age,
    
    -- Calculate age at final game
    TIMESTAMPDIFF(
        YEAR, 
        CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), 
        finalGame
    ) AS ending_age,
    
    -- Calculate total career length in years
    TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length
FROM players
-- Sort results from longest career to shortest
ORDER BY career_length DESC;

-- TASK 3: Identify players' starting and ending teams
-- Uses INNER JOINs to match players with their teams in their debut and final years
-- Combines player information with salary/team data
SELECT 
    p.nameGiven,
    -- Starting year and team (based on debut year)
    s.yearID AS starting_year, 
    s.teamID AS starting_team,
    
    -- Ending year and team (based on final game year)
    e.yearID AS ending_year, 
    e.teamID AS ending_team
FROM players p 
-- First join: Match player with team in debut year
INNER JOIN salaries s ON p.playerID = s.playerID
                     AND YEAR(p.debut) = s.yearID
-- Second join: Match player with team in final game year
INNER JOIN salaries e ON p.playerID = e.playerID
                     AND YEAR(p.finalGame) = e.yearID;

-- TASK 4: Find players who started and ended with the same team and played over a decade
-- Builds on previous query with additional filtering
SELECT 
    p.nameGiven,
    -- Starting year and team (based on debut year)
    s.yearID AS starting_year, 
    s.teamID AS starting_team,
    
    -- Ending year and team (based on final game year)
    e.yearID AS ending_year, 
    e.teamID AS ending_team
FROM players p 
-- First join: Match player with team in debut year
INNER JOIN salaries s ON p.playerID = s.playerID
                     AND YEAR(p.debut) = s.yearID
-- Second join: Match player with team in final game year
INNER JOIN salaries e ON p.playerID = e.playerID
                     AND YEAR(p.finalGame) = e.yearID
-- Filtering conditions:
-- 1. Started and ended with the same team
-- 2. Played for more than a decade
WHERE s.teamID = e.teamID 
  AND e.yearID - s.yearID > 10;