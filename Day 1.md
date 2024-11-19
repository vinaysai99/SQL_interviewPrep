## Day 1: Recyclable and Low Fat Products

### Problem Description

We are tasked with identifying products that are both **low fat** and **recyclable** from a given table `Products`. The table contains the following columns:

- `product_id`: Unique identifier for each product.
- `low_fats`: Enum type (`'Y'` or `'N'`), indicating if the product is low fat.
- `recyclable`: Enum type (`'Y'` or `'N'`), indicating if the product is recyclable.

#### Example Input
**Table**: `Products`

| product_id | low_fats | recyclable |
|------------|----------|------------|
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

#### Example Output
| product_id |
|------------|
| 1          |
| 3          |

#### Problem Link
You can find the problem [here](https://leetcode.com/problems/recyclable-and-low-fat-products/).

---

### Intuition

The goal is to filter rows where both `low_fats` and `recyclable` are `'Y'`. This can be achieved using a straightforward **`WHERE` clause** that checks these conditions.

---

### Approach

1. Use a **`SELECT` query** to extract the `product_id` column.
2. Apply a **`WHERE` condition** to ensure:
   - `low_fats` equals `'Y'`
   - `recyclable` equals `'Y'`
3. Return the filtered results.

---

### Complexity

- **Time Complexity**:  
  $$O(n)$$, where $$n$$ is the number of rows in the `Products` table. Each row is evaluated once to check the conditions.
  
- **Space Complexity**:  
  $$O(1)$$, as no extra space is used aside from the query execution.

---

### Code
```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

---

### Notes

- The query assumes the `Products` table follows the structure defined in the problem.
- The output order is unspecified, as the question does not require a specific sorting.

---
