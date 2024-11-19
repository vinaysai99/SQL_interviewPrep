## Day 2: Find Customer Referee

### Problem Description

We need to find the names of customers who were **not referred** by the customer with `id = 2`. The table `Customer` contains the following columns:

- `id`: Primary key representing the unique identifier of the customer.
- `name`: The name of the customer.
- `referee_id`: The `id` of the customer who referred them. This can be `NULL` if they were not referred by anyone.

#### Example Input
**Table**: `Customer`

| id | name | referee_id |
|----|------|------------|
| 1  | Will | NULL       |
| 2  | Jane | NULL       |
| 3  | Alex | 2          |
| 4  | Bill | NULL       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |

#### Example Output
| name  |
|-------|
| Will  |
| Jane  |
| Bill  |
| Zack  |

#### Problem Link
You can find the problem [here](https://leetcode.com/problems/find-customer-referee/).

---

### Intuition

The goal is to exclude customers whose `referee_id` is `2`.  
- Customers with `referee_id = NULL` are not referred by anyone and should be included in the result.
- For other rows, only those with `referee_id <> 2` are valid.

---

### Approach

1. Use a **`SELECT` query** to retrieve the `name` column.
2. Apply a **`WHERE` condition** to filter rows:
   - Include rows where `referee_id IS NULL` (not referred by anyone).
   - Include rows where `referee_id <> 2` (not referred by customer `id = 2`).
3. Return the filtered results.

---

### Complexity

- **Time Complexity**:  
  $$O(n)$$, where $$n$$ is the number of rows in the `Customer` table. Each row is evaluated once to check the conditions.
  
- **Space Complexity**:  
  $$O(1)$$, as no extra space is used aside from the query execution.

---

### Code
```sql
SELECT NAME
FROM   customer
WHERE  referee_id IS NULL
        OR referee_id <> 2; 
```

---

### Notes

- Rows with `referee_id = NULL` are explicitly included since they are not referred by anyone.
- The output is unordered because no specific sorting is required by the problem statement.
