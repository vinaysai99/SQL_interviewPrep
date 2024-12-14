### Sales Person Problem

The task is to find the names of all salespersons who did not have any orders associated with the company named "RED."

---

### Problem Details

1. **Input**:
   - **Table: `SalesPerson`**
     - Contains details of salespersons (e.g., `sales_id`, `name`, `salary`, etc.).
   - **Table: `Company`**
     - Contains details of companies (e.g., `com_id`, `name`, `city`, etc.).
   - **Table: `Orders`**
     - Contains information about orders (e.g., `order_id`, `com_id`, `sales_id`, `amount`, etc.).

2. **Output**:
   - A table with a single column (`name`) containing the names of salespersons who have no orders linked to the company "RED."

3. **Constraints**:
   - A salesperson is linked to a company via the `Orders` table (`sales_id` and `com_id`).

---

### SQL Solution

```sql
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT DISTINCT sales_id
    FROM Orders
    JOIN Company ON Orders.com_id = Company.com_id
    WHERE Company.name = 'RED'
);
```

---

### Explanation

1. **Inner Query**:
   - `SELECT DISTINCT sales_id FROM Orders JOIN Company ON Orders.com_id = Company.com_id WHERE Company.name = 'RED'`:
     - Retrieves the unique `sales_id` of all salespersons who have orders associated with the company "RED."

2. **Outer Query**:
   - `SELECT name FROM SalesPerson WHERE sales_id NOT IN (...)`:
     - Retrieves the names of all salespersons whose `sales_id` is **not in** the list of salespersons returned by the inner query.

---

### Example Outputs

#### Example 1:

**Input**:

**SalesPerson Table**:

| sales_id | name  | salary  | commission_rate | hire_date |
|----------|-------|---------|-----------------|-----------|
| 1        | John  | 100000  | 6               | 4/1/2006  |
| 2        | Amy   | 12000   | 5               | 5/1/2010  |
| 3        | Mark  | 65000   | 12              | 12/25/2008 |
| 4        | Pam   | 25000   | 25              | 1/1/2005  |
| 5        | Alex  | 5000    | 10              | 2/3/2007  |

**Company Table**:

| com_id | name   | city     |
|--------|--------|----------|
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |

**Orders Table**:

| order_id | order_date | com_id | sales_id | amount  |
|----------|------------|--------|----------|---------|
| 1        | 1/1/2014   | 3      | 4        | 10000   |
| 2        | 2/1/2014   | 4      | 5        | 5000    |
| 3        | 3/1/2014   | 1      | 1        | 50000   |
| 4        | 4/1/2014   | 1      | 4        | 25000   |

**Output**:

| name  |
|-------|
| Amy   |
| Mark  |
| Alex  |

**Explanation**:
- John and Pam have orders related to the company "RED."
- Salespersons Amy, Mark, and Alex do not have any orders with "RED."

---

### Link

[Sales Person - LeetCode](https://leetcode.com/problems/sales-person/)
