### **Capital Gain/Loss**

The goal is to calculate the **capital gain or loss** for each stock by analyzing its buy and sell operations. For each `Buy` and `Sell` pair, the difference between the sell price and the buy price contributes to the capital gain or loss.

---

### **Problem Details**

#### **Input Table**

**`Stocks` Table**:
| stock_name    | operation | operation_day | price  |
|---------------|-----------|---------------|--------|
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |

---

### **Output Table**

**Result Table**:
| stock_name    | capital_gain_loss |
|---------------|-------------------|
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |

---

### **Solution Explanation**

To compute the capital gain/loss:
1. **For Each Stock**:
   - Sum up the `price` for `Sell` operations.
   - Sum up the `price` for `Buy` operations.
   - Compute the difference:  
     \[
     \text{Capital Gain/Loss} = \text{Total Sell Price} - \text{Total Buy Price}
     \]

2. **Steps**:
   - Use a **conditional aggregation** query:
     - Assign positive values for `Sell` prices.
     - Assign negative values for `Buy` prices.
   - Group the data by `stock_name`.

---

### **SQL Query**

#### **Approach 1**: Using Conditional Aggregation with `CASE`
```sql
SELECT 
    stock_name,
    SUM(CASE 
        WHEN operation = 'Buy' THEN -price
        WHEN operation = 'Sell' THEN price
    END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;
```

#### **Approach 2**: Using a Subquery
```sql
WITH stock_summary AS (
    SELECT 
        stock_name, 
        operation, 
        SUM(price) AS total_price
    FROM Stocks
    GROUP BY stock_name, operation
)
SELECT 
    stock_name,
    SUM(CASE 
        WHEN operation = 'Sell' THEN total_price
        WHEN operation = 'Buy' THEN -total_price
    END) AS capital_gain_loss
FROM stock_summary
GROUP BY stock_name;
```

---

### **Explanation of the Queries**

1. **`CASE` Statement**:
   - Assigns `-price` for `Buy` operations.
   - Assigns `+price` for `Sell` operations.
   - The summation aggregates the net gain/loss for each stock.

2. **Grouping**:
   - The `GROUP BY` clause ensures results are computed for each stock (`stock_name`).

3. **Alternative with Subquery**:
   - The subquery aggregates total prices for each operation type (`Buy` and `Sell`).
   - The main query calculates the difference between `Sell` and `Buy` totals.

---

### **Example Execution**

#### **Step 1: Aggregate Operations**
| stock_name    | operation | total_price |
|---------------|-----------|-------------|
| Leetcode      | Buy       | 1000        |
| Leetcode      | Sell      | 9000        |
| Corona Masks  | Buy       | 2010        |
| Corona Masks  | Sell      | 11610       |
| Handbags      | Buy       | 30000       |
| Handbags      | Sell      | 7000        |

#### **Step 2: Calculate Capital Gain/Loss**
| stock_name    | capital_gain_loss |
|---------------|-------------------|
| Leetcode      | 8000              |
| Corona Masks  | 9500              |
| Handbags      | -23000            |

---

### **Final Output**
| stock_name    | capital_gain_loss |
|---------------|-------------------|
| Corona Masks  | 9500              |
| Leetcode      | 8000              |
| Handbags      | -23000            |

---

### **Link**
[Capital Gain/Loss - LeetCode](https://leetcode.com/problems/capital-gainloss/)
