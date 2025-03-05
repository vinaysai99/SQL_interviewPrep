# Baseball Analytics SQL Project

## 🏆 Project Overview
Advanced SQL analytics project exploring comprehensive baseball player data, focusing on:
- School and player demographics
- Salary trends
- Career trajectory analysis
- Player comparative insights

## Project Directory Structure
```
baseball-sql-analytics/
│
├── database/
│   ├── create_statements_final_project_mysql.sql
│   └── final_project.sql
│
├── docs/
│   ├── schema_explanation.md
│   ├── analysis_insights.md
│   └── query_breakdowns.md
│
├── queries/
│   ├── school_analysis.sql
│   ├── salary_analysis.sql
│   ├── player_career_analysis.sql
│   └── player_comparison_analysis.sql
│
├── .gitignore
├── README.md
└── LICENSE
```

## 📊 Database Schema

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

## 🔍 Analysis Sections

### I. School Analysis
- Schools producing players by decade
- Top educational institutions for player development
- Geographic distribution of player origins

### II. Salary Analysis
- Team spending patterns
- Cumulative team expenditure
- Salary evolution over time

### III. Player Career Analysis
- Career length calculations
- Team transition patterns
- Long-term player-team relationships

### IV. Player Comparison Analysis
- Shared birthday investigations
- Team batting style distribution
- Physical attribute trends

## 🛠 Technologies
- **Database**: MySQL
- **Analysis**: Advanced SQL Techniques
- **Tools**: MySQL Workbench

## 🚀 Getting Started

### Prerequisites
- MySQL Server
- MySQL Workbench
- Sample Baseball Dataset

### Installation
1. Clone the repository
   ```bash
   git clone https://github.com/[your-username]/baseball-sql-analytics.git
   ```

2. Create Database
   ```sql
   CREATE DATABASE maven_advanced_sql;
   USE maven_advanced_sql;
   ```

3. Run Setup Scripts
   ```bash
   mysql -u [username] -p maven_advanced_sql < database/create_statements_final_project_mysql.sql
   ```

## 📈 Usage
Execute analysis queries in `final_project.sql` to explore:
- Decade-wise player production
- Salary trends
- Career insights

## 🤝 Contributing
Please read [CONTRIBUTING.md](Contributing.md) for details on our code of conduct and the process for submitting pull requests.

## 📧 Contact
Vinay Mandala
[Linkedin](www.linkedin.com/in/vinaymandala99)

## 🌟 Acknowledgments
- [alice zhao](https://mavenanalytics.io/meet-the-team/alice-zhao)
- Maven Analytics
