### **Bank Account Summary II**

The goal is to calculate the total balance for each user based on their account transactions and filter users whose balance exceeds 10,000.

---

### **Approach**

1. **Calculate Total Balance**:
   - Use the `Transactions` table to sum the `amount` grouped by the `account`.

2. **Filter Accounts**:
   - Add a `HAVING` clause to filter accounts with a balance greater than 10,000.

3. **Join with `Users` Table**:
   - Use an `INNER JOIN` to get the corresponding user names from the `Users` table for the filtered accounts.

4. **Format Output**:
   - Return the `name` and `balance` as per the required format.

---

### **SQL Query**

```sql
WITH total AS (
    SELECT 
        account, 
        SUM(amount) AS total_sum
    FROM 
        Transactions
    GROUP BY 
        account
    HAVING 
        total_sum > 10000
)
SELECT 
    u.name, 
    t.total_sum AS balance
FROM 
    total t
JOIN 
    Users u
ON 
    u.account = t.account;
```

---

### **Explanation of Query**

1. **CTE (`total`)**:
   - Calculates the total balance (`SUM(amount)`) for each `account`.
   - Filters accounts with a balance greater than 10,000 (`HAVING total_sum > 10000`).

2. **Join with Users**:
   - Joins the `total` CTE with the `Users` table on the `account` column to get the `name` of the account holder.

3. **Select Columns**:
   - Outputs the `name` and `balance` (`total_sum`).

---

### **Example**

#### **Input**

**Users Table**:  
| account  | name    |  
|----------|---------|  
| 900001   | Alice   |  
| 900002   | Bob     |  
| 900003   | Charlie |  

**Transactions Table**:  
| trans_id | account  | amount | transacted_on |  
|----------|----------|--------|---------------|  
| 1        | 900001   | 7000   | 2020-08-01    |  
| 2        | 900001   | 7000   | 2020-09-01    |  
| 3        | 900001   | -3000  | 2020-09-02    |  
| 4        | 900002   | 1000   | 2020-09-12    |  
| 5        | 900003   | 6000   | 2020-08-07    |  
| 6        | 900003   | 6000   | 2020-09-07    |  
| 7        | 900003   | -4000  | 2020-09-11    |  

#### **Output**

| name   | balance |  
|--------|---------|  
| Alice  | 11000   |  

---

### **Edge Cases**

1. **No Transactions**:
   - Users with no transactions will not appear in the output.
   
2. **Negative Balances**:
   - Accounts with net negative balances are filtered out by the `HAVING` clause.

3. **Exactly 10,000**:
   - Accounts with a balance equal to 10,000 are excluded because of `HAVING total_sum > 10000`.

---

### **Link**

[LeetCode - Bank Account Summary II](https://leetcode.com/problems/bank-account-summary-ii/)
