### **Daily Leads and Partners**

The task is to calculate the number of unique `lead_id` and `partner_id` for each combination of `date_id` and `make_name` in the `DailySales` table.

---

### **Approach**

1. **Group By**:
   - Group the data by `date_id` and `make_name`.

2. **Count Distinct IDs**:
   - Use `COUNT(DISTINCT column_name)` to count the unique `lead_id` and `partner_id` for each group.

3. **Select Required Columns**:
   - Output the `date_id`, `make_name`, and the counts of unique `lead_id` and `partner_id`.

---

### **SQL Query**

```sql
SELECT 
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM 
    DailySales
GROUP BY 
    date_id, 
    make_name;
```

---

### **Explanation of Query**

1. **Group By Clause**:
   - Groups the records by `date_id` and `make_name` to aggregate data for each combination.

2. **Aggregate Functions**:
   - `COUNT(DISTINCT lead_id)` calculates the number of unique leads for each group.
   - `COUNT(DISTINCT partner_id)` calculates the number of unique partners for each group.

3. **Output Columns**:
   - Returns `date_id`, `make_name`, `unique_leads`, and `unique_partners`.

---

### **Example**

#### **Input**

**DailySales Table**:  
| date_id   | make_name | lead_id | partner_id |  
|-----------|-----------|---------|------------|  
| 2020-12-8 | toyota    | 0       | 1          |  
| 2020-12-8 | toyota    | 1       | 0          |  
| 2020-12-8 | toyota    | 1       | 2          |  
| 2020-12-7 | toyota    | 0       | 2          |  
| 2020-12-7 | toyota    | 0       | 1          |  
| 2020-12-8 | honda     | 1       | 2          |  
| 2020-12-8 | honda     | 2       | 1          |  
| 2020-12-7 | honda     | 0       | 1          |  
| 2020-12-7 | honda     | 1       | 2          |  
| 2020-12-7 | honda     | 2       | 1          |  

---

#### **Output**

| date_id   | make_name | unique_leads | unique_partners |  
|-----------|-----------|--------------|-----------------|  
| 2020-12-8 | toyota    | 2            | 3               |  
| 2020-12-7 | toyota    | 1            | 2               |  
| 2020-12-8 | honda     | 2            | 2               |  
| 2020-12-7 | honda     | 3            | 2               |  

---

### **Link**

[LeetCode - Daily Leads and Partners](https://leetcode.com/problems/daily-leads-and-partners/)
