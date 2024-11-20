## Day 8: Customer Who Visited but Did Not Make Any Transactions

### Problem Description

We aim to find the customers who visited the mall but did not make any transactions during those visits. Additionally, we want to count how many times these types of visits occurred for each customer.

Two tables are provided:

1. **`Visits` Table**:
   - `visit_id`: Unique identifier for each visit.
   - `customer_id`: ID of the customer who visited the mall.

2. **`Transactions` Table**:
   - `transaction_id`: Unique identifier for each transaction.
   - `visit_id`: Corresponding visit during which the transaction was made.
   - `amount`: Amount of the transaction.

#### Goal:
- Find `customer_id` for customers who visited the mall but did not make any transactions during those visits.
- Count the number of such visits (`count_no_trans`) for each customer.

#### Key Points:
- Use the `Visits` table to identify visits where no corresponding `visit_id` exists in the `Transactions` table.
- Count the number of such visits for each `customer_id`.
- Group results by `customer_id`.

---

### Example

#### Input
**Table 1**: `Visits`

| visit_id | customer_id |
|----------|-------------|
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |

**Table 2**: `Transactions`

| transaction_id | visit_id | amount |
|----------------|----------|--------|
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |

#### Output
| customer_id | count_no_trans |
|-------------|----------------|
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |

---

### Intuition

To solve this problem:
1. Identify `visit_id` values in the `Visits` table that are **not** in the `Transactions` table. These represent visits without transactions.
2. Count how many such visits occurred for each `customer_id`.
3. Group the data by `customer_id` and return the results.

---

### Approach

1. Use a subquery to get all `visit_id` values in the `Transactions` table.
2. Use the `NOT IN` or `<> ALL` operator to filter out visits in `Visits` that did not have a corresponding transaction.
3. Group the remaining visits by `customer_id` and count the number of such visits.
4. Return the results.

---

### Complexity

- **Time Complexity**:  
  $$O(n + m)$$ where $$n$$ is the number of rows in `Visits` and $$m$$ is the number of rows in `Transactions`.

- **Space Complexity**:  
  $$O(k)$$ where $$k$$ is the number of unique `visit_id` values in `Transactions`.

---

### SQL Code
```sql
SELECT customer_id,
       COUNT(customer_id) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT DISTINCT visit_id FROM Transactions)
GROUP BY customer_id;
```

---

### Pandas Code
For a Python-based approach using Pandas:
```python
# Identify visits without transactions
no_trans_visits = visits[~visits['visit_id'].isin(transactions['visit_id'])]

# Group by customer_id and count such visits
result = no_trans_visits.groupby('customer_id').size().reset_index(name='count_no_trans')

return result
```

---

### Notes

- **Join Type**: A `NOT IN` subquery is used to identify visits that do not appear in the `Transactions` table.
- **Order of Result**: The output can be returned in any order unless specified otherwise.

#### Problem Link
Find the problem [here](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/).
