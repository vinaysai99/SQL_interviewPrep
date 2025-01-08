### **Calculate Special Bonus**

The goal is to calculate the bonus for each employee based on the following conditions:
1. An employee gets a bonus equal to 100% of their salary if:
   - Their `employee_id` is an odd number.
   - Their name does **not** start with the letter `'M'`.
2. Otherwise, the bonus is `0`.

The result should be ordered by `employee_id`.

---

### **Approach**

1. **Use a `CASE` Statement**:
   - Check if the `employee_id` is odd (`employee_id % 2 = 1`).
   - Check if the `name` does **not** start with `'M'` (`name NOT LIKE 'M%'`).
   - If both conditions are true, assign `salary` as the bonus; otherwise, assign `0`.

2. **Order Results by `employee_id`**:
   - Use `ORDER BY employee_id` to ensure the output is sorted.

---

### **SQL Query**

```sql
SELECT employee_id,
       CASE 
           WHEN (name NOT LIKE 'M%') AND (employee_id % 2 = 1) THEN salary
           ELSE 0
       END AS bonus
FROM Employees
ORDER BY employee_id;
```

---

### **Explanation**

1. **`name NOT LIKE 'M%'`**:
   - Checks if the `name` does not start with the letter `'M'`.

2. **`employee_id % 2 = 1`**:
   - Checks if the `employee_id` is an odd number.

3. **`CASE` Statement**:
   - If both conditions are true, return the `salary` as the `bonus`.
   - Otherwise, return `0`.

4. **`ORDER BY employee_id`**:
   - Ensures the result is sorted by `employee_id`.

---

### **Example**

#### **Input**

**Employees Table**:  
| employee_id | name    | salary |  
|-------------|---------|--------|  
| 2           | Meir    | 3000   |  
| 3           | Michael | 3800   |  
| 7           | Addilyn | 7400   |  
| 8           | Juan    | 6100   |  
| 9           | Kannon  | 7700   |  

---

#### **Output**

| employee_id | bonus |  
|-------------|-------|  
| 2           | 0     |  
| 3           | 0     |  
| 7           | 7400  |  
| 8           | 0     |  
| 9           | 7700  |  

---

### **Explanation**

1. Employee `2`:  
   - `employee_id` is even → Bonus = `0`.

2. Employee `3`:  
   - Name starts with `'M'` → Bonus = `0`.

3. Employee `7`:  
   - `employee_id` is odd, and name does not start with `'M'` → Bonus = `7400`.

4. Employee `8`:  
   - `employee_id` is even → Bonus = `0`.

5. Employee `9`:  
   - `employee_id` is odd, and name does not start with `'M'` → Bonus = `7700`.

---

### **Link**

[LeetCode - Calculate Special Bonus](https://leetcode.com/problems/calculate-special-bonus/)
