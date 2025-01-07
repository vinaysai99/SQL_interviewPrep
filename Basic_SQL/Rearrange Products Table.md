### **Rearrange Products Table**

The goal is to transform the given `Products` table so that the output lists each product's `product_id`, the store in which it is available (`store1`, `store2`, or `store3`), and the price in that store. If the product is not available in a store (price is `NULL`), that row should be excluded.

---

### **Approach**

1. **Extract Data for Each Store**:
   - Use a `SELECT` statement for each store column (`store1`, `store2`, and `store3`).
   - Assign a store name (e.g., `'store1'`) to a new column named `store`.

2. **Filter Non-NULL Prices**:
   - Include only rows where the price in the corresponding store is not `NULL`.

3. **Combine Results**:
   - Use the `UNION` operator to combine the results from the three `SELECT` statements.

4. **Output Columns**:
   - Ensure the output columns are named as `product_id`, `store`, and `price`.

---

### **SQL Query**

```sql
SELECT product_id, 'store1' AS store, store1 AS price 
FROM Products 
WHERE store1 IS NOT NULL
UNION 
SELECT product_id, 'store2' AS store, store2 AS price 
FROM Products 
WHERE store2 IS NOT NULL
UNION 
SELECT product_id, 'store3' AS store, store3 AS price 
FROM Products 
WHERE store3 IS NOT NULL;
```

---

### **Explanation**

1. **`SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL`**:
   - Selects all `product_id`s and `store1` prices where `store1` is not `NULL`.
   - Assigns `'store1'` as the `store` value.

2. **Repeat for `store2` and `store3`**:
   - Similar logic is applied to `store2` and `store3`.

3. **Combine Using `UNION`**:
   - Combines the results into a single table while removing duplicate rows (if any). Since `product_id` is unique, duplicates are unlikely here.

4. **Output**:
   - The resulting table has columns `product_id`, `store`, and `price`.

---

### **Example**

#### **Input**

**Products Table**:  
| product_id | store1 | store2 | store3 |  
|------------|--------|--------|--------|  
| 0          | 95     | 100    | 105    |  
| 1          | 70     | NULL   | 80     |  

---

#### **Output**

| product_id | store  | price |  
|------------|--------|-------|  
| 0          | store1 | 95    |  
| 0          | store2 | 100   |  
| 0          | store3 | 105   |  
| 1          | store1 | 70    |  
| 1          | store3 | 80    |  

---

### **Explanation**

1. Product `0`:
   - Available in all three stores: `store1` (95), `store2` (100), `store3` (105).

2. Product `1`:
   - Available in `store1` (70) and `store3` (80). Not available in `store2` (`NULL`).

---

### **Link**

[LeetCode - Rearrange Products Table](https://leetcode.com/problems/rearrange-products-table/)
