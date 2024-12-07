### Employees Earning More Than Their Managers

This problem requires identifying employees whose salaries exceed their respective managers' salaries.

---

### Problem Details

1. **Input**:
   - A table `Employee` with the following columns:
     - `id`: Unique ID of the employee.
     - `name`: Employee's name.
     - `salary`: Employee's salary.
     - `managerId`: The ID of the employee's manager (can be `NULL` if the employee has no manager).

2. **Output**:
   - A single column, `Employee`, containing the names of employees earning more than their managers.

---

### SQL Solution

```sql
SELECT e1.name AS Employee
FROM Employee e1
JOIN Employee e2
  ON e1.managerId = e2.id
WHERE e1.salary > e2.salary;
```

---

### Explanation

1. **Table Aliases**:
   - `e1` represents the employee.
   - `e2` represents the manager.

2. **JOIN Condition**:
   - `ON e1.managerId = e2.id`: Matches the employee (`e1`) with their manager (`e2`) based on the `managerId`.

3. **Filtering**:
   - `WHERE e1.salary > e2.salary`: Ensures only employees earning more than their managers are selected.

4. **Selecting Names**:
   - `SELECT e1.name`: Retrieves the names of employees meeting the criteria.

---

### Example Outputs

#### Example 1:

**Input**:

| id | name  | salary | managerId |
|----|-------|--------|-----------|
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |

**Output**:

| Employee |
|----------|
| Joe      |

**Explanation**:
- Joe's manager is Sam (`id = 3`) with a salary of 60,000.
- Joe earns 70,000, which is more than Sam's salary.

---

### Link

[Employees Earning More Than Their Managers - LeetCode](https://leetcode.com/problems/employees-earning-more-than-their-managers/)
