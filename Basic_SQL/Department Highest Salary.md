### Department Highest Salary

The task is to find the employees with the highest salary in each department. Each department may have multiple employees sharing the highest salary.

---

### Problem Details

1. **Input**:
   - **Table: `Employee`**
     - Columns:
       - `id`: Employee ID.
       - `name`: Employee name.
       - `salary`: Employee salary.
       - `departmentId`: ID of the department where the employee works.
   - **Table: `Department`**
     - Columns:
       - `id`: Department ID.
       - `name`: Department name.

2. **Output**:
   - A table with columns:
     - `Department`: Department name.
     - `Employee`: Employee name.
     - `Salary`: Salary of the employee.

---

### SQL Solution

```sql
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee e2
    WHERE e2.departmentId = e.departmentId
);
```

---

### Explanation

1. **Join the Tables**:
   - Use `JOIN` to combine `Employee` and `Department` tables based on `departmentId`.

2. **Filter by Highest Salary**:
   - For each department, find the highest salary using a correlated subquery:
     ```sql
     SELECT MAX(salary)
     FROM Employee e2
     WHERE e2.departmentId = e.departmentId
     ```
   - This ensures only employees with the maximum salary in their department are included.

3. **Output the Results**:
   - Select the `name` of the department, `name` of the employee, and their `salary`.

---

### Example Outputs

#### Example 1:

**Input**:

**Employee**:

| id | name  | salary | departmentId |
|----|-------|--------|--------------|
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |

**Department**:

| id | name  |
|----|-------|
| 1  | IT    |
| 2  | Sales |

**Output**:

| Department | Employee | Salary |
|------------|----------|--------|
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |

**Explanation**:
- `IT` department: Both `Jim` and `Max` have the highest salary of `90000`.
- `Sales` department: `Henry` has the highest salary of `80000`.

---

### Alternate Solution Using `WITH` and Common Table Expressions (CTE)

```sql
WITH MaxSalaries AS (
    SELECT departmentId, MAX(salary) AS maxSalary
    FROM Employee
    GROUP BY departmentId
)
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN MaxSalaries ms
    ON e.departmentId = ms.departmentId AND e.salary = ms.maxSalary
JOIN Department d
    ON e.departmentId = d.id;
```

---

### Link

[Department Highest Salary - LeetCode](https://leetcode.com/problems/department-highest-salary/)
