### **Employees With Missing Information**

This problem involves identifying employees with incomplete records. An employee's information is considered missing if either:
1. Their name is missing from the `Employees` table.
2. Their salary is missing from the `Salaries` table.

---

### **Approach**

1. **Identify Complete Records**:
   - Use an `INNER JOIN` between `Employees` and `Salaries` tables on `employee_id` to find employees with both name and salary available.

2. **Find Missing Records**:
   - Use `NOT IN` or a `LEFT JOIN` to identify employees who are either:
     - Present in `Employees` but missing in `Salaries`.
     - Present in `Salaries` but missing in `Employees`.

3. **Union Results**:
   - Combine the results from the above queries using `UNION` to get all employees with missing information.

4. **Order by `employee_id`**:
   - Sort the result in ascending order by `employee_id`.

---

### **SQL Query**

```sql
WITH complete_records AS (
    SELECT e.employee_id
    FROM Employees e
    JOIN Salaries s
    ON e.employee_id = s.employee_id
)
SELECT employee_id
FROM Employees
WHERE employee_id NOT IN (SELECT employee_id FROM complete_records)
UNION
SELECT employee_id
FROM Salaries
WHERE employee_id NOT IN (SELECT employee_id FROM complete_records)
ORDER BY employee_id;
```

---

### **Explanation**

1. **Common Records (`complete_records`)**:
   - The `WITH` clause creates a temporary table (`complete_records`) containing all `employee_id` values with complete information.

2. **Missing in Employees Table**:
   - Select employees from `Salaries` who are not in `complete_records`.

3. **Missing in Salaries Table**:
   - Select employees from `Employees` who are not in `complete_records`.

4. **Combine Results**:
   - Use `UNION` to merge the results from the two queries.

5. **Order Results**:
   - The `ORDER BY employee_id` ensures the final result is sorted in ascending order of `employee_id`.

---

### **Example**

#### **Input**

**Employees Table**:
| employee_id | name     |  
|-------------|----------|  
| 2           | Crew     |  
| 4           | Haven    |  
| 5           | Kristian |  

**Salaries Table**:
| employee_id | salary |  
|-------------|--------|  
| 5           | 76071  |  
| 1           | 22517  |  
| 4           | 63539  |  

---

#### **Output**

| employee_id |  
|-------------|  
| 1           |  
| 2           |  

---

#### **Explanation**

1. **Complete Records**:
   - Employees with both name and salary:  
     - `employee_id = 4`  
     - `employee_id = 5`

2. **Missing Records**:
   - `employee_id = 1` is missing from the `Employees` table.
   - `employee_id = 2` is missing from the `Salaries` table.

3. **Final Result**:
   - Combine and sort the missing IDs: `1`, `2`.

---

### **Link**

[LeetCode - Employees With Missing Information](https://leetcode.com/problems/employees-with-missing-information/)
