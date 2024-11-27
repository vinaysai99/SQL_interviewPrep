## Day 7: Product Sales Analysis I

### Problem Description

We aim to analyze product sales by retrieving the product name, year, and price for each record in the `Sales` table.

Two tables are provided:

1. **`Sales` Table**:
   - `sale_id`: Unique identifier for each sale (combined with `year`).
   - `product_id`: Foreign key to the `Product` table.
   - `year`: The year of the sale.
   - `quantity`: Number of units sold.
   - `price`: Price per unit.

2. **`Product` Table**:
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.

#### Goal:
- Combine the `Sales` and `Product` tables to report:
  - `product_name`
  - `year`
  - `price`

#### Key Points:
- Use an **INNER JOIN** to connect the `Sales` and `Product` tables on `product_id`.
- Return the required fields (`product_name`, `year`, `price`) for each record in the `Sales` table.

---

### Example

#### Input
**Table 1**: `Sales`

| sale_id | product_id | year | quantity | price |
|---------|------------|------|----------|-------|
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |

**Table 2**: `Product`

| product_id | product_name |
|------------|--------------|
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |

#### Output
| product_name | year  | price |
|--------------|-------|-------|
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |

---

### Intuition

To solve this problem:
1. Join the `Sales` table with the `Product` table using `product_id` as the common key.
2. Select the columns `product_name`, `year`, and `price` from the resulting table.

---

### Approach

1. Perform an **INNER JOIN** between `Sales` and `Product` tables using `product_id`.
2. Select the required columns (`product_name`, `year`, `price`).
3. Return the result table.

---

### Complexity

- **Time Complexity**:  
  $$O(n \cdot m)$$, where $$n$$ is the number of rows in the `Sales` table and $$m$$ is the number of rows in the `Product` table. This assumes a simple nested join.

- **Space Complexity**:  
  $$O(n)$$, where $$n$$ is the size of the output result.

---

### SQL Code
```sql
-- Write your MySQL query statement below
SELECT product_name,
       year,
       price
FROM Sales
INNER JOIN Product
ON Sales.product_id = Product.product_id;
```

---

### Pandas Code
For a Python-based approach using Pandas:
```python
import pandas as pd

# Perform an inner join
df = pd.merge(left=sales, right=product, how='inner', on='product_id')[['product_name', 'year', 'price']]
return df
```

---

### Notes

- **Join Type**: An **INNER JOIN** is used since we are interested only in records with matching `product_id` in both tables.
- **Order of Result**: The output can be returned in any order unless specified otherwise.

#### Problem Link
Find the problem [here](https://leetcode.com/problems/product-sales-analysis-i/).
