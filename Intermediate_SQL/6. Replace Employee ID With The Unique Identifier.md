## Day 6: Replace Employee ID With The Unique Identifier

### Problem Description

The goal is to retrieve the unique identifier (`unique_id`) for each employee, replacing missing `unique_id` values with `null`.  

Two tables are provided:

1. **`Employees` Table**:
   - `id`: The unique identifier for each employee.
   - `name`: The name of the employee.

2. **`EmployeeUNI` Table**:
   - `id`: The unique identifier for each employee.
   - `unique_id`: A secondary unique identifier for some employees.

We must return a table with the columns:
- `unique_id`
- `name`

**Key Points**:
- Perform a **left join** on the `Employees` table and `EmployeeUNI` table using the `id` column.
- If there is no matching `unique_id`, return `null`.

#### Example Input
**Table 1**: `Employees`

| id  | name     |
|-----|----------|
| 1   | Alice    |
| 7   | Bob      |
| 11  | Meir     |
| 90  | Winston  |
| 3   | Jonathan |

**Table 2**: `EmployeeUNI`

| id  | unique_id |
|-----|-----------|
| 3   | 1         |
| 11  | 2         |
| 90  | 3         |

#### Example Output
| unique_id | name     |
|-----------|----------|
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |

---

### Intuition

To solve this problem:
- Use a **left join** to keep all rows from the `Employees` table, regardless of whether they have a matching row in the `EmployeeUNI` table.
- Select the `unique_id` from the `EmployeeUNI` table and `name` from the `Employees` table.
- Handle unmatched rows by displaying `null` for the `unique_id`.

---

### Approach

1. Perform a **left join** of the `Employees` table with the `EmployeeUNI` table on the `id` column.
2. Select the `unique_id` (from `EmployeeUNI`) and `name` (from `Employees`).
3. Return the result table in any order.

---

### Complexity

- **Time Complexity**:  
  $$O(n + m)$$, where $$n$$ and $$m$$ are the number of rows in the `Employees` and `EmployeeUNI` tables, respectively.  
  Joining is linear with respect to the sizes of the tables.

- **Space Complexity**:  
  $$O(n)$$, where $$n$$ is the size of the output result.

---

### SQL Code
```sql
-- Write your MySQL query statement below
SELECT unique_id,
       name
FROM Employees
LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;
```

---

### Pandas Code
For a Python-based approach using Pandas:
```python
import pandas as pd

# Perform a left join and select the required columns
df = pd.merge(left=employees, right=employee_uni, how='left', on='id')[['unique_id', 'name']]
return df
```

---

### Notes

- **Handling Missing Matches**: The `LEFT JOIN` ensures unmatched rows have `null` for `unique_id`.
- **Order of Result**: The result can be returned in any order as the problem does not specify sorting.

#### Problem Link
Find the problem [here](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/).

