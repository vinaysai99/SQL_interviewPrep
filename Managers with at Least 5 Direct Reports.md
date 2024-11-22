## 13. Managers with at Least 5 Direct Reports

The task is to find managers who have at least five employees directly reporting to them.

---

### Table: Employee

| Column Name | Type    | Description                                     |
|-------------|---------|-------------------------------------------------|
| `id`        | int     | Unique identifier for each employee.            |
| `name`      | varchar | Name of the employee.                           |
| `department`| varchar | Department of the employee.                     |
| `managerId` | int     | The ID of the employee's manager (nullable).     |

- `id` is the **Primary Key** for the table.
- If `managerId` is `NULL`, the employee has no manager.
- No employee manages themselves.

---

### Key Insights

1. **Employee Relationships**:
   - Each `id` can act as a `managerId` for other employees.

2. **Count Direct Reports**:
   - Use `GROUP BY` on `managerId` to count how many employees report directly to each manager.

3. **Filter Managers**:
   - Use `HAVING` to filter managers with `COUNT(managerId) >= 5`.

4. **Join to Get Manager Names**:
   - Self-join the `Employee` table to get the names of managers.

---

### Example

#### Input

**Employee** table:
| id  | name  | department | managerId |
|-----|-------|------------|-----------|
| 101 | John  | A          | NULL      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |

#### Output
| name |
|------|
| John |

#### Explanation
- Manager `John (id: 101)` has five direct reports: Dan, James, Amy, Anne, and Ron.
- No other employee has at least five direct reports.

---

### SQL Solution

```sql
SELECT 
    e2.name AS name
FROM 
    Employee e1
RIGHT JOIN 
    Employee e2
ON 
    e1.managerId = e2.id
GROUP BY 
    e2.id, e2.name
HAVING 
    COUNT(e1.managerId) >= 5;
```

---

### Explanation

1. **Self-Join**:
   - `e1` represents the employees.
   - `e2` represents the managers.
   - The `ON e1.managerId = e2.id` condition links employees to their managers.

2. **Grouping**:
   - Group by `e2.id` and `e2.name` to count the number of employees (`e1`) reporting to each manager.

3. **Filter Managers**:
   - Use `HAVING COUNT(e1.managerId) >= 5` to filter managers with at least five direct reports.

---

### Alternative Query

```sql
SELECT 
    name
FROM 
    Employee
WHERE 
    id IN (
        SELECT 
            managerId
        FROM 
            Employee
        GROUP BY 
            managerId
        HAVING 
            COUNT(*) >= 5
    );
```

---

### Optimization Tips

- **Indexing**:
   - Index the `managerId` column to speed up grouping and filtering.
- **Avoid NULLs**:
   - Ensure `managerId` is properly handled to exclude non-managers.

---

### Problem Link
[Managers with at Least 5 Direct Reports - LeetCode](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/)
