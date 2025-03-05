# SQL Query Analysis and Technique Breakdown

## Methodology Overview
Advanced SQL techniques applied across four key analysis areas, demonstrating complex data manipulation and insights extraction.

## I. School Analysis Queries

### 1. Schools per Decade
```sql
SELECT 	FLOOR(yearID / 10) * 10 AS decade, 
         COUNT(DISTINCT schoolID) AS num_schools
FROM	schools
GROUP BY decade
ORDER BY decade;
```
#### Techniques Used
- Numeric Function: `FLOOR()` for decade calculation
- Aggregation: `COUNT(DISTINCT)` to avoid duplicate counting
- Grouping: Decade-based analysis

#### Query Breakdown
- Converts year to decade
- Counts unique schools per decade
- Provides temporal view of educational institution contributions

### 2. Top 5 Schools Producing Players
```sql
SELECT	 sd.name_full, 
         COUNT(DISTINCT s.playerID) AS num_players
FROM	 schools s LEFT JOIN school_details sd
		 ON s.schoolID = sd.schoolID
GROUP BY s.schoolID
ORDER BY num_players DESC
LIMIT 	 5;
```
#### Techniques Used
- LEFT JOIN: Combining schools and school details
- Distinct Player Counting
- Limiting Results

#### Query Breakdown
- Joins schools with detailed school information
- Counts unique players per school
- Ranks and limits to top 5 schools

## II. Salary Analysis Queries

### 1. Top 20% Teams by Spending
```sql
WITH ts AS (SELECT 	teamID, yearID, 
                    SUM(salary) AS total_spend),
     sp AS (SELECT	teamID, 
                    AVG(total_spend) AS avg_spend,
					NTILE(5) OVER (ORDER BY AVG(total_spend) DESC) AS spend_pct)
SELECT	teamID, 
        ROUND(avg_spend / 1000000, 1) AS avg_spend_millions
FROM	sp
WHERE	spend_pct = 1;
```
#### Techniques Used
- Common Table Expressions (CTEs)
- Window Function: `NTILE()`
- Aggregation: Average spending calculation
- Rounding for readability

#### Query Breakdown
- Calculates team spending per year
- Uses `NTILE()` to divide teams into quintiles
- Identifies top 20% spending teams

### 2. Cumulative Team Spending
```sql
WITH ts AS (SELECT	 teamID, yearID, 
                     SUM(salary) AS total_spend)
SELECT	teamID, yearID,
		ROUND(SUM(total_spend) OVER (PARTITION BY teamID ORDER BY yearID) / 1000000, 1)
			AS cumulative_sum_millions
FROM	ts;
```
#### Techniques Used
- Window Function: Cumulative Sum
- Partitioning by Team
- Ordered Calculation

#### Query Breakdown
- Calculates total spend per team per year
- Uses running total across years
- Converts to millions for readability

## III. Player Career Analysis Queries

### 1. Career Length Calculation
```sql
SELECT 	nameGiven,
        TIMESTAMPDIFF(YEAR, 
            CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), 
            debut) AS starting_age,
		TIMESTAMPDIFF(YEAR, 
            CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), 
            finalGame) AS ending_age,
		TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length
FROM	players
ORDER BY career_length DESC;
```
#### Techniques Used
- Datetime Manipulation
- `TIMESTAMPDIFF()` for age calculations
- String Concatenation for Date Creation
- Ordering by Derived Column

#### Query Breakdown
- Calculates player's starting and ending ages
- Determines career length
- Sorts by longest careers

## IV. Player Comparison Analysis Queries

### 1. Shared Birthday Analysis
```sql
WITH bn AS (
    SELECT	CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate,
			nameGiven
	FROM	players
)
SELECT	birthdate, 
        GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players
FROM	bn
WHERE	YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;
```
#### Techniques Used
- Common Table Expression
- Date Manipulation
- `GROUP_CONCAT()` for String Aggregation
- Date Range Filtering

#### Query Breakdown
- Identifies players with same birthdate
- Limits to specific year range
- Aggregates player names

## Advanced Techniques Demonstration
- Window Functions
- Common Table Expressions
- Complex Joins
- Datetime Manipulation
- Aggregation Strategies

## Conclusion
A comprehensive demonstration of advanced SQL techniques for deep data analysis, showcasing the power of sophisticated query construction.
