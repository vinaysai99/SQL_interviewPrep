### **Human Traffic of Stadium**

The problem requires identifying rows in the `Stadium` table where there are at least three consecutive rows with IDs in increasing order and each row having `people >= 100`. The result should include all such rows, ordered by `visit_date`.

---

### **Approach**

1. **Identify Consecutive Rows with People ≥ 100**:
   - Use window functions like `LEAD` to look ahead to the next two rows for each row.
   - Check if the current row, the next row, and the row after that all meet the condition `people >= 100`.

2. **Filter the Rows**:
   - Use a Common Table Expression (CTE) or subquery to isolate rows where the condition is satisfied for at least three consecutive rows.

3. **Join Back to the Original Table**:
   - Using the filtered rows, retrieve the full details for the consecutive rows.

4. **Sort by Visit Date**:
   - Ensure the final result is ordered by `visit_date`.

---

### **SQL Query**

```sql
WITH RankedRows AS (
    SELECT 
        id, 
        people,
        LEAD(people, 1) OVER (ORDER BY id) AS next_row_people,
        LEAD(people, 2) OVER (ORDER BY id) AS next_2nd_row_people
    FROM stadium
),
FilteredRows AS (
    SELECT 
        id 
    FROM RankedRows
    WHERE people >= 100 
      AND next_row_people >= 100 
      AND next_2nd_row_people >= 100
)
SELECT DISTINCT s.id, s.visit_date, s.people
FROM stadium s
JOIN FilteredRows f
ON s.id BETWEEN f.id AND f.id + 2
ORDER BY s.visit_date;
```

---

### **Explanation**

1. **`RankedRows` CTE**:
   - Adds two additional columns (`next_row_people` and `next_2nd_row_people`) using the `LEAD` function to check the values of `people` for the next two rows.

2. **`FilteredRows` CTE**:
   - Identifies rows where the current row and the next two rows have `people >= 100`.

3. **`JOIN` and Retrieval**:
   - For each filtered row, join back to the original `Stadium` table to retrieve all rows in the range `[id, id+2]`.

4. **Sorting**:
   - The result is sorted by `visit_date` to meet the requirement.

---

### **Example Walkthrough**

#### **Input**

**Stadium Table**:
| id  | visit_date | people |  
|-----|------------|--------|  
| 1   | 2017-01-01 | 10     |  
| 2   | 2017-01-02 | 109    |  
| 3   | 2017-01-03 | 150    |  
| 4   | 2017-01-04 | 99     |  
| 5   | 2017-01-05 | 145    |  
| 6   | 2017-01-06 | 1455   |  
| 7   | 2017-01-07 | 199    |  
| 8   | 2017-01-09 | 188    |  

#### **Output**

**Result Table**:
| id  | visit_date | people |  
|-----|------------|--------|  
| 5   | 2017-01-05 | 145    |  
| 6   | 2017-01-06 | 1455   |  
| 7   | 2017-01-07 | 199    |  
| 8   | 2017-01-09 | 188    |  

---

### **Edge Cases**

1. **No Consecutive Rows**:
   - If there are no three consecutive rows meeting the criteria, the result will be empty.

2. **More than Three Consecutive Rows**:
   - All rows in the consecutive range will be included.

3. **Sparse Data**:
   - Gaps in `id` values do not affect the solution, as the check is based on consecutive IDs.

---

### **Link**

[LeetCode - Human Traffic of Stadium](https://leetcode.com/problems/human-traffic-of-stadium/description/)
