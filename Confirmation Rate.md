### 14. Confirmation Rate

This problem requires calculating the confirmation rate for each user. The confirmation rate is defined as the number of `confirmed` actions divided by the total number of actions (`confirmed + timeout`) for each user.

---

### Tables and Schema

#### Table: `Signups`

| Column Name | Type     | Description                          |
|-------------|----------|--------------------------------------|
| `user_id`   | int      | Unique identifier for each user.     |
| `time_stamp`| datetime | Timestamp of the signup event.       |

- `user_id` is a **Primary Key**.

#### Table: `Confirmations`

| Column Name | Type     | Description                               |
|-------------|----------|-------------------------------------------|
| `user_id`   | int      | User ID, foreign key referencing Signups. |
| `time_stamp`| datetime | Timestamp of the confirmation event.      |
| `action`    | ENUM     | Can be `'confirmed'` or `'timeout'`.      |

- `user_id` and `time_stamp` together form the **Primary Key**.

---

### Key Insights

1. **Confirmation Rate Calculation**:
   - If a user has no confirmation requests, their confirmation rate is `0.00`.
   - Otherwise:  
     \[
     \text{Confirmation Rate} = \frac{\text{Confirmed Count}}{\text{Total Actions}}
     \]
     Round the result to 2 decimal places.

2. **Handling Missing Data**:
   - Use `LEFT JOIN` to ensure all users from `Signups` are included in the result, even those who have no entries in `Confirmations`.

3. **Grouping Data**:
   - Group by `user_id` to aggregate counts of `confirmed` and `timeout` actions.

---

### Example

#### Input

**Signups** table:
| user_id | time_stamp          |
|---------|---------------------|
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |

**Confirmations** table:
| user_id | time_stamp          | action    |
|---------|---------------------|-----------|
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |

#### Output

| user_id | confirmation_rate |
|---------|-------------------|
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

---

### SQL Solution

```sql
WITH action_cte AS (
    SELECT 
        s.user_id,
        SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count,
        SUM(CASE WHEN c.action = 'timeout' THEN 1 ELSE 0 END) AS timeout_count
    FROM 
        Signups s
    LEFT JOIN 
        Confirmations c
    ON 
        s.user_id = c.user_id
    GROUP BY 
        s.user_id
)
SELECT 
    user_id,
    CASE
        WHEN (confirmed_count + timeout_count) > 0 THEN 
            ROUND(confirmed_count / (confirmed_count + timeout_count), 2)
        ELSE 0.00
    END AS confirmation_rate
FROM 
    action_cte;
```

---

### Explanation

1. **`action_cte`**:
   - Counts `confirmed` and `timeout` actions for each `user_id` using conditional aggregation.

2. **Main Query**:
   - Calculates the confirmation rate:
     - If the total actions (`confirmed + timeout`) are greater than 0, calculate the rate and round it to 2 decimal places.
     - Otherwise, return `0.00`.

3. **Join**:
   - A `LEFT JOIN` ensures all users from `Signups` are included, even if they have no confirmation records.

4. **Grouping**:
   - `GROUP BY` ensures aggregation at the user level.

---

### Optimization Tips

- Add indexes on `user_id` in both tables for faster joins and aggregations.
- Use `ENUM` type for the `action` column to optimize storage and query performance.

---

### Problem Link
[Confirmation Rate - LeetCode](https://leetcode.com/problems/confirmation-rate/)
