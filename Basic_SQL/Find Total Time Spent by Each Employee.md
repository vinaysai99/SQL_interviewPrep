### **Find Total Time Spent by Each Employee**

The goal is to calculate the total time in minutes spent by each employee in the office on each day. The `in_time` and `out_time` for an employee represent the entry and exit times, and the time spent for each entry is calculated as `out_time - in_time`.

---

### **Approach**

1. **Calculate Time Spent**:
   - For each row, the time spent by the employee is `out_time - in_time`.

2. **Group By**:
   - Group the data by `event_day` and `emp_id` to calculate the total time spent by the employee on that day.

3. **Aggregate Function**:
   - Use `SUM(out_time - in_time)` to calculate the total time spent for each group.

4. **Rename Columns**:
   - Rename `event_day` to `day` and calculate the total time for each employee.

---

### **SQL Query**

```sql
SELECT 
    event_day AS day,
    emp_id,
    SUM(out_time - in_time) AS total_time
FROM 
    Employees
GROUP BY 
    event_day, 
    emp_id;
```

---

### **Explanation of Query**

1. **`SUM(out_time - in_time)`**:
   - Computes the total time spent by summing up the differences between `out_time` and `in_time` for each `event_day` and `emp_id`.

2. **`GROUP BY event_day, emp_id`**:
   - Groups the data by `event_day` and `emp_id` so that the total time is calculated separately for each employee and each day.

3. **Column Aliases**:
   - `event_day` is renamed to `day` in the output as required by the result format.

---

### **Example**

#### **Input**

**Employees Table**:  
| emp_id | event_day  | in_time | out_time |  
|--------|------------|---------|----------|  
| 1      | 2020-11-28 | 4       | 32       |  
| 1      | 2020-11-28 | 55      | 200      |  
| 1      | 2020-12-03 | 1       | 42       |  
| 2      | 2020-11-28 | 3       | 33       |  
| 2      | 2020-12-09 | 47      | 74       |  

---

#### **Output**

| day        | emp_id | total_time |  
|------------|--------|------------|  
| 2020-11-28 | 1      | 173        |  
| 2020-11-28 | 2      | 30         |  
| 2020-12-03 | 1      | 41         |  
| 2020-12-09 | 2      | 27         |  

---

### **Explanation**

1. Employee `1`:
   - On `2020-11-28`:  
     Time spent = `(32 - 4) + (200 - 55) = 173`.
   - On `2020-12-03`:  
     Time spent = `(42 - 1) = 41`.

2. Employee `2`:
   - On `2020-11-28`:  
     Time spent = `(33 - 3) = 30`.
   - On `2020-12-09`:  
     Time spent = `(74 - 47) = 27`.

---

### **Link**

[LeetCode - Find Total Time Spent by Each Employee](https://leetcode.com/problems/find-total-time-spent-by-each-employee/)
