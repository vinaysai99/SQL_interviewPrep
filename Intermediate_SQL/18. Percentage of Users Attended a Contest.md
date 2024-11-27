### 18. Percentage of Users Attended a Contest

This problem involves finding the percentage of users registered for each contest from the given `Users` and `Register` tables.

---

### Problem Requirements

1. **Tables**:
   - **Users** table: Contains a list of all users with their `user_id` and `user_name`.
   - **Register** table: Contains the contests (`contest_id`) each user (`user_id`) has registered for.

2. **Objective**:
   - Calculate the **percentage of users** who registered for each contest, rounded to **2 decimal places**.
   - Order the results:
     - By percentage in **descending order**.
     - By `contest_id` in **ascending order** in case of ties.

3. **Output**:
   - A table with two columns: `contest_id` and `percentage`.

---

### Schema

#### Table: `Users`

| Column Name | Type    | Description               |
|-------------|---------|---------------------------|
| `user_id`   | int     | Primary key, user ID.     |
| `user_name` | varchar | Name of the user.         |

#### Table: `Register`

| Column Name | Type | Description                     |
|-------------|------|---------------------------------|
| `contest_id`| int  | Contest ID.                     |
| `user_id`   | int  | User ID who registered.         |

---

### Example

#### Input

**Users** table:

| user_id | user_name |
|---------|-----------|
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |

**Register** table:

| contest_id | user_id |
|------------|---------|
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |

#### Output

| contest_id | percentage |
|------------|------------|
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |

---

### Solution

The SQL query:

```sql
SELECT 
    r.contest_id,
    ROUND(
        (COUNT(r.user_id) / (SELECT COUNT(user_id) FROM Users)) * 100, 
        2
    ) AS percentage
FROM 
    Register r
GROUP BY 
    r.contest_id
ORDER BY 
    percentage DESC,
    r.contest_id ASC;
```

---

### Explanation

1. **Join and Group**:
   - Use the `Register` table directly since it already contains the contests and registered users.
   - Group by `contest_id` to calculate stats for each contest.

2. **Calculate Total Users**:
   - Use a subquery `(SELECT COUNT(user_id) FROM Users)` to find the total number of users.

3. **Calculate Percentage**:
   - Divide the count of users registered in each contest by the total number of users.
   - Multiply by 100 to get the percentage.
   - Use `ROUND` to round the result to 2 decimal places.

4. **Order the Results**:
   - First by `percentage` in **descending order**.
   - Then by `contest_id` in **ascending order** in case of ties.

---

### Example Walkthrough

1. **Total Users**:
   - There are 3 users (`user_id` = 6, 2, 7).

2. **Contest 208**:
   - Registered users: 2, 6, 7 (all users).
   - Percentage = \((3 / 3) * 100 = 100.00\).

3. **Contest 209**:
   - Registered users: 2, 6, 7 (all users).
   - Percentage = \((3 / 3) * 100 = 100.00\).

4. **Contest 210**:
   - Registered users: 2, 6, 7 (all users).
   - Percentage = \((3 / 3) * 100 = 100.00\).

5. **Contest 215**:
   - Registered users: 6, 7.
   - Percentage = \((2 / 3) * 100 ≈ 66.67\).

6. **Contest 207**:
   - Registered users: 2.
   - Percentage = \((1 / 3) * 100 ≈ 33.33\).

---

### Problem Link
[Percentage of Users Attended a Contest - LeetCode](https://leetcode.com/problems/percentage-of-users-attended-a-contest/)
