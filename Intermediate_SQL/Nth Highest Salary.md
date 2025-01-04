### **Nth Highest Salary**

This task is about creating a SQL function that retrieves the **nth highest salary** from the `Employee` table. If the `nth` salary does not exist, it should return `NULL`.

---

### **Problem Details**

#### **Input**

**Employee Table**:
| id   | salary |
|------|--------|
| 1    | 100    |
| 2    | 200    |
| 3    | 300    |

#### **Output**

For `n = 2`, the output is:
| getNthHighestSalary(2) |
|-------------------------|
| 200                     |

For `n = 2` with only one record:
| getNthHighestSalary(2) |
|-------------------------|
| null                   |

---

### **Approach**

1. **Distinct Salaries**:
   - Use `DISTINCT` to ensure only unique salaries are considered.

2. **Sorting**:
   - Sort salaries in descending order to rank them from highest to lowest.

3. **Offset**:
   - Use `LIMIT` with an `OFFSET` to skip the first `n-1` rows and retrieve the `nth` highest salary.

4. **Handle Edge Cases**:
   - If `n` exceeds the number of distinct salaries, the query returns `NULL`.

---

### **SQL Query**

```sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE offset_index INT;
    SET offset_index = N - 1;

    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET offset_index
    );
END;
```

---

### **Explanation**

1. **`DECLARE offset_index`**:
   - Declares a variable to calculate the zero-based offset.

2. **Sorting and Selecting**:
   - `DISTINCT` ensures no duplicate salaries are considered.
   - `ORDER BY salary DESC` sorts salaries in descending order.
   - `LIMIT 1 OFFSET offset_index` skips the first `n-1` rows and selects the `nth` salary.

3. **Edge Case**:
   - If `N` is greater than the total distinct salaries, `LIMIT` with no matching rows returns `NULL`.

---

### **Examples**

#### **Example 1**:  
Input:
```sql
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```
`n = 2`

Output:
```sql
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
```

---

#### **Example 2**:  
Input:
```sql
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
```
`n = 2`

Output:
```sql
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
```

---

### **Edge Cases**
1. `N = 1` with no records → Output: `NULL`.
2. Duplicate salaries should not affect the result.
3. If `N` is greater than the number of distinct salaries → Output: `NULL`.

---

### **Link**
[LeetCode - Nth Highest Salary](https://leetcode.com/problems/nth-highest-salary/)
