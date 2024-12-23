### **Sales Analysis III**

The goal is to identify products that were only sold in the first quarter (January 1 to March 31) of 2019. 

---

### **Problem Details**

#### **Input Tables**

1. **`Product` Table**:
   | product_id | product_name | unit_price |
   |------------|--------------|------------|
   | 1          | S8           | 1000       |
   | 2          | G4           | 800        |
   | 3          | iPhone       | 1400       |

2. **`Sales` Table**:
   | seller_id | product_id | buyer_id | sale_date  | quantity | price |
   |-----------|------------|----------|------------|----------|-------|
   | 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
   | 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
   | 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
   | 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |

---

### **Output**
The result should only include products sold **exclusively** in the first quarter of 2019.  

**Output**:
| product_id | product_name |
|------------|--------------|
| 1          | S8           |

---

### **Solution Explanation**

To determine which products meet the criteria:
1. **Filter Sales by Date**:
   - Create a flag (`season`) where:
     - `0` = sales occurred in Q1 2019 (between `2019-01-01` and `2019-03-31`).
     - `1` = sales occurred outside Q1 2019.

2. **Group by Product**:
   - Sum up the `season` flag for each product. 
   - Products with a total `season` sum of `0` were sold **only** in Q1 2019.

3. **Join with the `Product` Table**:
   - Retrieve the `product_name` for the filtered products.

---

### **SQL Query**

```sql
WITH cte AS (
    SELECT 
        product_id,
        CASE 
            WHEN sale_date BETWEEN '2019-01-01' AND '2019-03-31' THEN 0
            ELSE 1
        END AS season
    FROM sales
),
season_cte AS (
    SELECT 
        product_id,
        SUM(season) AS total_season
    FROM cte
    GROUP BY product_id
    HAVING SUM(season) = 0
)
SELECT 
    season_cte.product_id,
    product_name
FROM season_cte
JOIN product
    ON season_cte.product_id = product.product_id;
```

---

### **Explanation of Query Steps**

1. **`cte`**:
   - Adds a column `season`:
     - `0` for sales in Q1 2019.
     - `1` for sales outside Q1 2019.

   Example:
   | product_id | season |
   |------------|--------|
   | 1          | 0      |
   | 2          | 0      |
   | 2          | 1      |
   | 3          | 1      |

2. **`season_cte`**:
   - Filters products whose total `season` sum is `0`.

   Example:
   | product_id | total_season |
   |------------|--------------|
   | 1          | 0            |

3. **Final Selection**:
   - Joins `season_cte` with the `Product` table to get the product name.

   Result:
   | product_id | product_name |
   |------------|--------------|
   | 1          | S8           |

---

### **Link**
[Sales Analysis III - LeetCode](https://leetcode.com/problems/sales-analysis-iii/)
