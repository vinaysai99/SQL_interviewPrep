### 16. Average Selling Price

This problem involves calculating the average selling price of products based on their prices over different periods and the units sold during those periods.

---

### Problem Requirements

1. **Tables**:
   - **Prices** table contains price details for each product across specific date ranges.
   - **UnitsSold** table contains information about units sold for each product on specific dates.

2. **Objective**:
   - Calculate the **average selling price** for each product by considering the units sold and the price during the corresponding period.
   - If a product has no units sold, its average selling price should be **0**.
   - Round the result to **2 decimal places**.

3. **Formula**:
   The average selling price for a product is calculated as:
   Average Price= ∑(Price×Units Sold)/∑(Units Sold)


---

### Schema

#### Table: `Prices`

| Column Name | Type     | Description                             |
|-------------|----------|-----------------------------------------|
| `product_id`| int      | Product ID.                            |
| `start_date`| date     | Start date of the price period.        |
| `end_date`  | date     | End date of the price period.          |
| `price`     | int      | Price of the product during the period.|

#### Table: `UnitsSold`

| Column Name  | Type     | Description                              |
|--------------|----------|------------------------------------------|
| `product_id` | int      | Product ID.                             |
| `purchase_date` | date  | Date when the product was sold.         |
| `units`      | int      | Number of units sold on that date.      |

---

### Example

#### Input

**Prices** table:

| product_id | start_date | end_date   | price |
|------------|------------|------------|-------|
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |

**UnitsSold** table:

| product_id | purchase_date | units |
|------------|---------------|-------|
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

#### Output

| product_id | average_price |
|------------|---------------|
| 1          | 6.96          |
| 2          | 16.96         |

---

### Solution

The SQL query:

```sql
SELECT p.product_id,
       CASE
         WHEN SUM(u.units) > 0 THEN ROUND(( ( SUM(p.price * u.units) ) / SUM(u.units) ), 2)
         ELSE 0
       END AS average_price
FROM prices p
LEFT JOIN unitsSold u
  ON p.product_id = u.product_id
  AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

---

### Explanation

1. **JOIN**:
   - We join the `Prices` table with the `UnitsSold` table on `product_id` and check if the `purchase_date` is within the price period (`BETWEEN p.start_date AND p.end_date`).
   
2. **Calculating Average Price**:
   - For each product, calculate the total price for each period (`price * units`) and sum up the units sold.
   - Use `ROUND` to round the result to 2 decimal places.

3. **Handling Products with No Units Sold**:
   - If a product has no units sold, the result for that product will be `0`.

4. **Grouping**:
   - Group by `product_id` to calculate the average selling price for each product.

---

### Example Walkthrough

1. **Product 1**:
   - Total units sold: `100 (2019-02-25)` + `15 (2019-03-01)` = `115`.
   - Total price: `(100 * 5) + (15 * 20)` = `500 + 300 = 800`.
   - Average selling price: `800 / 115 = 6.96`.

2. **Product 2**:
   - Total units sold: `200 (2019-02-10)` + `30 (2019-03-22)` = `230`.
   - Total price: `(200 * 15) + (30 * 30)` = `3000 + 900 = 3900`.
   - Average selling price: `3900 / 230 = 16.96`.

---

### Problem Link
[Average Selling Price - LeetCode](https://leetcode.com/problems/average-selling-price/)
