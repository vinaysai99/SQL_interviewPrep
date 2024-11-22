## Day 11: Employee Bonus

The goal is to find employees whose bonus is either less than 1000 or missing entirely. This requires combining data from two tables: `Employee` and `Bonus`.

---

### Table: Employee

| Column Name | Type    | Description                                   |
|-------------|---------|-----------------------------------------------|
| `empId`     | int     | Unique identifier for each employee.         |
| `name`      | varchar | Name of the employee.                        |
| `supervisor`| int     | ID of the employee's supervisor.             |
| `salary`    | int     | Salary of the employee.                      |

- The `empId` column is the **Primary Key** for this table.

---

### Table: Bonus

| Column Name | Type | Description                                   |
|-------------|------|-----------------------------------------------|
| `empId`     | int  | ID of the employee receiving the bonus.       |
| `bonus`     | int  | Bonus amount received by the employee.        |

- The `empId` column in the `Bonus` table is a **Foreign Key** referencing the `Employee.empId`.

---

### Key Insights

1. **Join Tables**:
   - Use a **LEFT JOIN** to ensure all employees are included, even if they don’t have a bonus entry.

2. **Filter Criteria**:
   - Include rows where:
     - Bonus is less than 1000.
     - Bonus is `NULL` (no bonus entry).

3. **Columns to Select**:
   - Retrieve the employee `name` and the `bonus`.

---

### Example

#### Input

**Employee** table:
| empId | name   | supervisor | salary |
|-------|--------|------------|--------|
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |

**Bonus** table:
| empId | bonus |
|-------|-------|
| 2     | 500   |
| 4     | 2000  |

#### Output
| name  | bonus |
|-------|-------|
| Brad  | null  |
| John  | null  |
| Dan   | 500   |

#### Explanation
- `Brad` and `John` don’t have any bonus entry (`bonus = NULL`).
- `Dan` has a bonus of 500 (< 1000).
- `Thomas` is excluded because his bonus is 2000 (> 1000).

---

### SQL Solution

```sql
SELECT e.name,
       b.bonus
FROM Employee e
LEFT JOIN Bonus b
  ON e.empId = b.empId
WHERE b.bonus < 1000
   OR b.bonus IS NULL;
```

#### Explanation:
1. **LEFT JOIN**:
   - Ensures all employees from the `Employee` table are included, even if they don’t appear in the `Bonus` table.

2. **Filter**:
   - Include rows where:
     - `b.bonus < 1000` (bonus less than 1000).
     - `b.bonus IS NULL` (no bonus entry).

3. **Select Columns**:
   - Retrieve `e.name` and `b.bonus`.

---

### Pandas Solution

```python
import pandas as pd

# Merge Employee and Bonus tables with a left join
result = pd.merge(employee, bonus, on='empId', how='left')

# Filter rows where bonus is either less than 1000 or is null
result = result[(result['bonus'] < 1000) | (result['bonus'].isnull())]

# Select the name and bonus columns
result = result[['name', 'bonus']]

return result
```

---

### Notes

- **Optimization**:
  - Index `empId` in both tables for faster join operations.
- **Edge Cases**:
  - Employees with no bonus entry should appear in the result with `NULL` as the bonus.
  - If all bonuses are ≥ 1000, only employees with no bonus should be included.

#### Problem Link
[Employee Bonus - LeetCode](https://leetcode.com/problems/employee-bonus/)
