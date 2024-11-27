### 17. Project Employees I

This problem requires calculating the **average experience years** of employees for each project.

---

### Problem Requirements

1. **Tables**:
   - **Project** table: Links employees (`employee_id`) to the projects (`project_id`) they are working on.
   - **Employee** table: Contains information about employees, including their names and years of experience.

2. **Objective**:
   - Calculate the **average experience years** of all employees working on each project.
   - Round the result to **2 decimal places**.

3. **Output**:
   - A table with two columns: `project_id` and `average_years`.

---

### Schema

#### Table: `Project`

| Column Name  | Type | Description                               |
|--------------|------|-------------------------------------------|
| `project_id` | int  | Project ID.                              |
| `employee_id`| int  | Employee ID working on the project.       |

#### Table: `Employee`

| Column Name       | Type    | Description                                |
|-------------------|---------|--------------------------------------------|
| `employee_id`     | int     | Employee ID.                              |
| `name`            | varchar | Name of the employee.                     |
| `experience_years`| int     | Number of years the employee has worked.  |

---

### Example

#### Input

**Project** table:

| project_id | employee_id |
|------------|-------------|
| 1          | 1           |
| 1          | 2           |
| 1          | 3           |
| 2          | 1           |
| 2          | 4           |

**Employee** table:

| employee_id | name   | experience_years |
|-------------|--------|------------------|
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |

#### Output

| project_id | average_years |
|------------|---------------|
| 1          | 2.00          |
| 2          | 2.50          |

---

### Solution

The SQL query:

```sql
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM 
    Project p
JOIN 
    Employee e
ON 
    p.employee_id = e.employee_id
GROUP BY 
    p.project_id;
```

---

### Explanation

1. **Join Tables**:
   - Use an `INNER JOIN` to combine the `Project` and `Employee` tables based on the `employee_id`. This ensures we link each project to the relevant employees.

2. **Calculate Average**:
   - Use `AVG` to calculate the average of the `experience_years` for each `project_id`.

3. **Round Results**:
   - Use `ROUND` to round the average to 2 decimal places.

4. **Grouping**:
   - Group by `project_id` to calculate averages for each project.

---

### Example Walkthrough

1. **Project 1**:
   - Employees: 1 (3 years), 2 (2 years), 3 (1 year).
   - Average experience: \((3 + 2 + 1) / 3 = 2.00\).

2. **Project 2**:
   - Employees: 1 (3 years), 4 (2 years).
   - Average experience: \((3 + 2) / 2 = 2.50\).

---

### Problem Link
[Project Employees I - LeetCode](https://leetcode.com/problems/project-employees-i/)
