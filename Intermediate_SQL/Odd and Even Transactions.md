### **Odd and Even Transactions**

This problem requires calculating the sum of transaction amounts for odd and even amounts grouped by transaction date. The output should show `0` for missing odd or even transactions for a specific date.

---

### **Approach**

1. **Odd and Even Transaction Sum**:
   - Use a `CASE` statement to separate transactions into "odd" and "even" categories based on the `amount`.
   - Apply conditional aggregation to calculate the sum for odd and even transactions.

2. **Group by Transaction Date**:
   - Group all transactions by `transaction_date` to compute the daily sums.

3. **Order by Date**:
   - Ensure the result is ordered by `transaction_date` in ascending order.

---

### **SQL Query**

```sql
SELECT 
    transaction_date,
    SUM(CASE WHEN amount % 2 = 1 THEN amount ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END) AS even_sum
FROM 
    transactions
GROUP BY 
    transaction_date
ORDER BY 
    transaction_date;
```

---

### **Explanation**

1. **`CASE` Statement**:
   - `CASE WHEN amount % 2 = 1 THEN amount ELSE 0 END`: Sums only the odd transaction amounts.
   - `CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END`: Sums only the even transaction amounts.

2. **`SUM` Function**:
   - Aggregates the results of the `CASE` statements to compute the odd and even transaction sums for each date.

3. **`GROUP BY`**:
   - Groups the data by `transaction_date` to ensure calculations are per day.

4. **`ORDER BY`**:
   - Ensures the result is sorted by `transaction_date`.

---

### **Example**

#### **Input**

**Transactions Table**:
| transaction_id | amount | transaction_date |  
|----------------|--------|------------------|  
| 1              | 150    | 2024-07-01       |  
| 2              | 200    | 2024-07-01       |  
| 3              | 75     | 2024-07-01       |  
| 4              | 300    | 2024-07-02       |  
| 5              | 50     | 2024-07-02       |  
| 6              | 120    | 2024-07-03       |  

#### **Output**

| transaction_date | odd_sum | even_sum |  
|------------------|---------|----------|  
| 2024-07-01       | 75      | 350      |  
| 2024-07-02       | 0       | 350      |  
| 2024-07-03       | 0       | 120      |  

---

### **Edge Cases**

1. **No Transactions for a Date**:
   - If there are no transactions on a specific date, it will not appear in the result since the grouping relies on existing records.

2. **All Odd or All Even Transactions**:
   - The `CASE` statements handle such cases by default, ensuring `0` is returned for the missing category.

---

### **Link**

[LeetCode - Odd and Even Transactions](https://leetcode.com/problems/odd-and-even-transactions/)
