### Customers Who Never Order

The task is to find all customers from the `Customers` table who have never placed an order, based on the `Orders` table.

---

### Problem Details

1. **Input**:
   - **Table: `Customers`**
     - Columns:
       - `id`: Unique ID of the customer.
       - `name`: Name of the customer.
   - **Table: `Orders`**
     - Columns:
       - `id`: Unique ID of the order.
       - `customerId`: The ID of the customer who placed the order.

2. **Output**:
   - A single column, `Customers`, containing the names of customers who have never placed any orders.

---

### SQL Solution

```sql
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (
    SELECT DISTINCT customerId
    FROM Orders
);
```

---

### Explanation

1. **Subquery**:
   - `SELECT DISTINCT customerId FROM Orders`: Retrieves a distinct list of `customerId` values from the `Orders` table.

2. **Filter Customers**:
   - `WHERE id NOT IN (...)`: Filters out customers whose `id` appears in the list of `customerId` values from the `Orders` table. These are customers who never placed an order.

3. **Rename the Result**:
   - `SELECT name AS Customers`: Outputs the names of customers as the column `Customers`.

---

### Example Outputs

#### Example 1:

**Input**:

**Customers**:

| id | name  |
|----|-------|
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |

**Orders**:

| id | customerId |
|----|------------|
| 1  | 3          |
| 2  | 1          |

**Output**:

| Customers |
|-----------|
| Henry     |
| Max       |

**Explanation**:
- `Joe` (id = 1) and `Sam` (id = 3) have placed orders.
- `Henry` (id = 2) and `Max` (id = 4) have not placed any orders, so they are included in the output.

---

### Alternate Solution Using `LEFT JOIN`

```sql
SELECT C.name AS Customers
FROM Customers C
LEFT JOIN Orders O
ON C.id = O.customerId
WHERE O.customerId IS NULL;
```

**Explanation**:
- Perform a `LEFT JOIN` between `Customers` and `Orders`.
- The `WHERE O.customerId IS NULL` condition ensures only customers with no matching records in `Orders` are selected.

---

### Link

[Customers Who Never Order - LeetCode](https://leetcode.com/problems/customers-who-never-order/)
