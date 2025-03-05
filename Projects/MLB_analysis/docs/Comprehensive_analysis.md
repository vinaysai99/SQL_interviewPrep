# Baseball Analytics SQL Project Documentation

## Project Overview
Advanced SQL analysis of baseball player data, exploring multifaceted insights across schools, salaries, careers, and player comparisons.

## Database Schema
### Tables
1. **players**
   - Comprehensive player biographical information
   - Tracks player details from birth to final game

2. **salaries**
   - Player salary information by year and team

3. **school_details**
   - Detailed information about educational institutions

4. **schools**
   - Player-school relationship tracking

## Analysis Sections

### I. School Analysis

#### Purpose
Investigate the role of educational institutions in baseball player development.

#### Key Tasks
1. **Schools and School Details Exploration**
   - Initial data investigation
   - Examine `schools` and `school_details` tables

2. **Schools Producing Players by Decade**
   - **Technique**: Numeric Functions
   - Calculate number of unique schools producing players per decade
   - **Insights**:
     - Track institutional contributions over time
     - Identify periods of player production

3. **Top Schools Producing Players**
   - **Technique**: LEFT JOIN
   - Identify top 5 schools by player production
   - **Insights**:
     - Most prolific player-producing institutions
     - Institutional impact on baseball talent

4. **Top 3 Schools per Decade**
   - **Techniques**: 
     - Window Functions
     - Common Table Expressions (CTEs)
   - Rank top schools within each decade
   - **Insights**:
     - Temporal changes in educational institution contributions
     - Detailed player development landscape

### II. Salary Analysis

#### Purpose
Analyze team spending patterns, financial trends, and economic dynamics in baseball.

#### Key Tasks
1. **Salaries Table Exploration**
   - Initial data investigation of player salaries

2. **Top 20% Teams by Annual Spending**
   - **Techniques**: 
     - Window Functions
     - Aggregation
   - Identify highest-spending teams
   - **Insights**:
     - Financial stratification
     - Team spending patterns

3. **Cumulative Team Spending**
   - **Techniques**:
     - Rolling calculations
     - Year-by-year financial tracking
   - **Insights**:
     - Team financial growth
     - Long-term spending trends

4. **First Billion-Dollar Spending Milestone**
   - **Techniques**:
     - Cumulative calculations
     - Threshold identification
   - **Insights**:
     - Financial milestones
     - Team economic evolution

### III. Player Career Analysis

#### Purpose
Explore player career trajectories, longevity, and team dynamics.

#### Key Tasks
1. **Players Table Overview**
   - Total player count
   - Initial data understanding

2. **Career Length and Age Analysis**
   - **Techniques**:
     - Datetime Functions
     - Age Calculations
   - **Insights**:
     - Player career span
     - Age demographics
     - Career longevity distribution

3. **Player Team Transitions**
   - **Techniques**:
     - Multiple INNER JOINs
     - Team and career mapping
   - **Insights**:
     - Player mobility
     - Career trajectory patterns

4. **Long-Term Single Team Players**
   - **Techniques**:
     - Complex JOIN operations
     - Career continuity filtering
   - **Insights**:
     - Team loyalty
     - Long-term player commitments

### IV. Player Comparison Analysis

#### Purpose
Comparative exploration of player characteristics and evolutionary trends.

#### Key Tasks
1. **Shared Birthday Investigation**
   - **Techniques**:
     - Date manipulation
     - String aggregation
   - **Insights**:
     - Players with identical birth dates
     - Temporal birth patterns

2. **Team Batting Style Distribution**
   - **Techniques**:
     - Pivoting
     - Percentage calculations
   - **Insights**:
     - Team batting style composition
     - Player batting diversity

3. **Physical Attributes Evolution**
   - **Techniques**:
     - Window Functions
     - Decade-based aggregation
   - **Insights**:
     - Changes in player physique
     - Generational physical trends

## Advanced SQL Techniques Demonstrated
- Window Functions
- Common Table Expressions (CTEs)
- Complex Joins
- Datetime Manipulation
- Aggregation and Pivoting
- Numeric and String Transformations

## Conclusion
This comprehensive SQL analysis provides a multifaceted view of baseball player dynamics, institutional contributions, and evolutionary trends.
