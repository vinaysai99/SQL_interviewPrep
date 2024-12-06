### Second Highest Salary

The goal is to find the second-highest distinct salary from the `Employee` table. If there is no second-highest salary, the result should return `NULL`.

---

### Problem Details

1. **Input**:
   - A table `Employee` with the following columns:
     - `id`: Unique identifier for the employee.
     - `salary`: The employee's salary.

2. **Output**:
   - A single column, `SecondHighestSalary`, containing:
     - The second-highest distinct salary if it exists.
     - `NULL` otherwise.

---

### SQL Solution

```sql
SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;
```

---

### Explanation

1. **Subquery**:
   - `SELECT DISTINCT salary FROM Employee`: Retrieve all distinct salaries from the `Employee` table.

2. **Sorting**:
   - `ORDER BY salary DESC`: Sort the salaries in descending order.

3. **Limiting and Offset**:
   - `LIMIT 1 OFFSET 1`: Skip the highest salary (OFFSET 1) and return the next one (LIMIT 1), which is the second-highest salary.

4. **Handling No Second-Highest Salary**:
   - If the table has fewer than two distinct salaries, the subquery returns no result, and the outer query returns `NULL`.

---

### Example Outputs

#### Example 1:

**Input**:

| id | salary |
|----|--------|
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |

**Output**:

| SecondHighestSalary |
|---------------------|
| 200                 |

---

#### Example 2:

**Input**:

| id | salary |
|----|--------|
| 1  | 100    |

**Output**:

| SecondHighestSalary |
|---------------------|
| NULL                |

---

### Alternative Approach (Without `LIMIT` or `OFFSET`)

If your SQL environment does not support `LIMIT` or `OFFSET`, you can use a `WHERE` clause to filter salaries:

```sql
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
```

---

### Link

[Second Highest Salary - LeetCode](https://leetcode.com/problems/second-highest-salary/)
