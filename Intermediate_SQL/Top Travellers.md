### **Top Travellers**

The task is to calculate the total distance traveled by each user, even if the user has not traveled at all.

---

### **Problem Details**

#### **Input Tables**

**`Users` Table**:
| id   | name      |
|------|-----------|
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |

**`Rides` Table**:
| id   | user_id  | distance |
|------|----------|----------|
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |

---

### **Output**

**Result Table**:
| name     | travelled_distance |
|----------|--------------------|
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |

---

### **Approach**

1. **Calculate Total Distance per User**:
   - Group the `Rides` table by `user_id` and sum the `distance`.

2. **Include Users Without Rides**:
   - Use a **RIGHT JOIN** to ensure all users are included, even those without rides.
   - Use `COALESCE` to set their distance to `0`.

3. **Ordering Results**:
   - Order by `travelled_distance` in descending order.
   - For users with the same distance, order by `name` in ascending order.

---

### **SQL Query**

```sql
WITH travel AS (
    SELECT 
        user_id, 
        SUM(distance) AS travelled_distance
    FROM 
        Rides
    GROUP BY 
        user_id
)
SELECT 
    u.name, 
    COALESCE(t.travelled_distance, 0) AS travelled_distance
FROM 
    Users u
LEFT JOIN 
    travel t
ON 
    u.id = t.user_id
ORDER BY 
    travelled_distance DESC, 
    name ASC;
```

---

### **Explanation of the Query**

1. **`WITH travel` Common Table Expression (CTE)**:
   - Groups the `Rides` table by `user_id`.
   - Calculates the total `travelled_distance` for each user.

2. **`LEFT JOIN` with `Users` Table**:
   - Ensures all users are included, even those with no rides.
   - The `COALESCE` function sets `travelled_distance` to `0` for users with no rides.

3. **Ordering**:
   - First by `travelled_distance` in descending order.
   - Then by `name` in ascending order.

---

### **Execution Steps**

#### Intermediate `travel` Table:
| user_id | travelled_distance |
|---------|--------------------|
| 1       | 120                |
| 2       | 317                |
| 3       | 222                |
| 7       | 450                |
| 13      | 312                |
| 19      | 450                |

#### Final Result:
| name     | travelled_distance |
|----------|--------------------|
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |

---

### **Link**
[LeetCode - Top Travellers](https://leetcode.com/problems/top-travellers/)
