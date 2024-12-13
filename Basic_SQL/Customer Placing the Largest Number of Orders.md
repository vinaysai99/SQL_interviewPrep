### Customer Placing the Largest Number of Orders

This task involves identifying the `customer_number` of the customer who placed the largest number of orders in the `Orders` table.

---

### Problem Details

1. **Input**:
   - **Table: `Orders`**
     - Columns:
       - `order_number`: The unique ID for each order.
       - `customer_number`: The ID of the customer who placed the order.

2. **Output**:
   - A table with a single column:
     - `customer_number`: The customer who placed the highest number of orders.

3. **Constraints**:
   - The test cases guarantee that there is exactly one customer with the most orders.

---

### SQL Solution

```sql
SELECT 
    customer_number
FROM 
    Orders
GROUP BY 
    customer_number
ORDER BY 
    COUNT(order_number) DESC
LIMIT 1;
```

---

### Explanation

1. **GROUP BY**:
   - Group rows by `customer_number` to calculate the number of orders for each customer.

2. **COUNT(order_number)**:
   - Count the number of orders placed by each customer.

3. **ORDER BY COUNT(order_number) DESC**:
   - Sort the results in descending order based on the number of orders.

4. **LIMIT 1**:
   - Select only the top result, which corresponds to the customer with the most orders.

---

### Example Outputs

#### Example 1:

**Input**:

| order_number | customer_number |
|--------------|-----------------|
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |

**Output**:

| customer_number |
|-----------------|
| 3               |

**Explanation**:
- Customer 3 placed 2 orders, while customers 1 and 2 placed only 1 order each. 
- Thus, the result is `customer_number = 3`.

---

### Link

[Customer Placing the Largest Number of Orders - LeetCode](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/)
