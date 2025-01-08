### **The Latest Login in 2020**

This problem involves identifying the latest login timestamp for each user who logged in during the year 2020. Users who did not log in during 2020 should not be included in the result.

---

### **Approach**

1. **Filter for Year 2020**:
   - Use the `WHERE` clause with the `YEAR(time_stamp) = 2020` condition to filter rows where the login occurred in 2020.

2. **Group by `user_id`**:
   - Use `GROUP BY user_id` to group logins by user.

3. **Find the Maximum Timestamp**:
   - Use the `MAX()` function to find the latest `time_stamp` for each user in the filtered dataset.

4. **Select Columns**:
   - Select `user_id` and the computed latest `time_stamp` (as `last_stamp`).

---

### **SQL Query**

```sql
SELECT user_id, 
       MAX(time_stamp) AS last_stamp
FROM Logins
WHERE YEAR(time_stamp) = 2020
GROUP BY user_id;
```

---

### **Explanation**

1. **Filter Logins in 2020**:
   - `WHERE YEAR(time_stamp) = 2020` ensures only logins from the year 2020 are considered.

2. **Group by User**:
   - `GROUP BY user_id` ensures the aggregation (`MAX(time_stamp)`) is calculated separately for each user.

3. **Calculate Latest Login**:
   - `MAX(time_stamp)` retrieves the latest login timestamp for each user in the year 2020.

---

### **Example**

#### **Input**

**Logins Table**:  
| user_id | time_stamp          |  
|---------|---------------------|  
| 6       | 2020-06-30 15:06:07 |  
| 6       | 2021-04-21 14:06:06 |  
| 6       | 2019-03-07 00:18:15 |  
| 8       | 2020-02-01 05:10:53 |  
| 8       | 2020-12-30 00:46:50 |  
| 2       | 2020-01-16 02:49:50 |  
| 2       | 2019-08-25 07:59:08 |  
| 14      | 2019-07-14 09:00:00 |  
| 14      | 2021-01-06 11:59:59 |  

---

#### **Output**

| user_id | last_stamp          |  
|---------|---------------------|  
| 6       | 2020-06-30 15:06:07 |  
| 8       | 2020-12-30 00:46:50 |  
| 2       | 2020-01-16 02:49:50 |  

---

### **Explanation of Output**

1. **User 6**:
   - Logged in once in 2020 (2020-06-30). Latest login = `2020-06-30 15:06:07`.

2. **User 8**:
   - Logged in twice in 2020: February and December. Latest login = `2020-12-30 00:46:50`.

3. **User 2**:
   - Logged in once in 2020 (2020-01-16). Latest login = `2020-01-16 02:49:50`.

4. **User 14**:
   - Did not log in during 2020. Excluded from the result.

---

### **Link**

[LeetCode - The Latest Login in 2020](https://leetcode.com/problems/the-latest-login-in-2020/)
