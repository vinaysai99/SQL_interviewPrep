### **Market Analysis I**

The problem requires finding the join date and the number of orders made by each user as a buyer in the year 2019. The output should include all users, with `0` as the count for those who did not make any orders as a buyer in 2019.

---

### **Approach**

1. **Filter Orders for 2019**:
   - Use a `WHERE` clause to filter orders where `YEAR(order_date) = 2019`.
   - Group the data by `buyer_id` and count the orders.

2. **Combine with Users Table**:
   - Perform a `LEFT JOIN` between the `Users` table and the summarized orders data (`order_cte`).
   - Ensure all users are included, even those with no orders in 2019.

3. **Handle Missing Data**:
   - Use `COALESCE` to replace `NULL` values in the count of orders with `0`.

4. **Output the Result**:
   - Select `user_id` as `buyer_id`, `join_date`, and the calculated order count (`orders_in_2019`).

---

### **SQL Query**

```sql
WITH order_cte AS (
    SELECT buyer_id, COUNT(order_id) AS orders_in_2019
    FROM Orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
)
SELECT 
    user_id AS buyer_id,
    join_date,
    COALESCE(orders_in_2019, 0) AS orders_in_2019
FROM Users
LEFT JOIN order_cte
ON Users.user_id = order_cte.buyer_id;
```

---

### **Explanation**

1. **`WITH order_cte`**:
   - Filters orders for 2019.
   - Groups by `buyer_id` to count the number of orders made by each buyer in 2019.

2. **`LEFT JOIN`**:
   - Ensures all users from the `Users` table are included, even if they did not make any orders in 2019.

3. **`COALESCE`**:
   - Converts `NULL` values in `orders_in_2019` (for users without orders in 2019) to `0`.

4. **Result Columns**:
   - `user_id` renamed to `buyer_id`.
   - Includes the `join_date` from the `Users` table.
   - The calculated order count (`orders_in_2019`).

---

### **Example**

#### **Input**

**Users Table**:
| user_id | join_date  | favorite_brand |  
|---------|------------|----------------|  
| 1       | 2018-01-01 | Lenovo         |  
| 2       | 2018-02-09 | Samsung        |  
| 3       | 2018-01-19 | LG             |  
| 4       | 2018-05-21 | HP             |  

**Orders Table**:
| order_id | order_date | item_id | buyer_id | seller_id |  
|----------|------------|---------|----------|-----------|  
| 1        | 2019-08-01 | 4       | 1        | 2         |  
| 2        | 2018-08-02 | 2       | 1        | 3         |  
| 3        | 2019-08-03 | 3       | 2        | 3         |  
| 4        | 2018-08-04 | 1       | 4        | 2         |  
| 5        | 2018-08-04 | 1       | 3        | 4         |  
| 6        | 2019-08-05 | 2       | 2        | 4         |  

---

#### **Output**

| buyer_id | join_date  | orders_in_2019 |  
|----------|------------|----------------|  
| 1        | 2018-01-01 | 1              |  
| 2        | 2018-02-09 | 2              |  
| 3        | 2018-01-19 | 0              |  
| 4        | 2018-05-21 | 0              |  

---

### **Edge Case**

- **No Orders in 2019**:
  - If no orders exist in 2019, the output should list all users with `orders_in_2019` as `0`.

---

### **Link**

[LeetCode - Market Analysis I](https://leetcode.com/problems/market-analysis-i/)
