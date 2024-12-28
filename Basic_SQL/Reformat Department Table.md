### **Reformat Department Table**

The goal is to pivot the `Department` table so that each month becomes a separate column, displaying the revenue for that month. If there is no revenue for a specific month, it should be represented as `NULL`.

---

### **Problem Details**

#### **Input Table**

**`Department` Table**:
| id   | revenue | month |
|------|---------|-------|
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |

#### **Output Table**

Reformat the table so that each month is a separate column for revenue. For example:

**Result Table**:
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
|------|-------------|-------------|-------------|-----|-------------|
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |

---

### **Solution Explanation**

1. **Use Conditional Aggregation**:
   - For each month, calculate the sum of revenue, but only for rows where the `month` matches.
   - Use `SUM(IF(month = '<month>', revenue, NULL))` for each month.

2. **Group by `id`**:
   - Aggregate the results by `id` to create one row per department.

3. **Output Columns**:
   - One column for `id` and 12 additional columns for monthly revenue (e.g., `Jan_Revenue`, `Feb_Revenue`).

---

### **SQL Query**

```sql
SELECT
  id,
  SUM(IF(month = 'Jan', revenue, NULL)) AS Jan_Revenue,
  SUM(IF(month = 'Feb', revenue, NULL)) AS Feb_Revenue,
  SUM(IF(month = 'Mar', revenue, NULL)) AS Mar_Revenue,
  SUM(IF(month = 'Apr', revenue, NULL)) AS Apr_Revenue,
  SUM(IF(month = 'May', revenue, NULL)) AS May_Revenue,
  SUM(IF(month = 'Jun', revenue, NULL)) AS Jun_Revenue,
  SUM(IF(month = 'Jul', revenue, NULL)) AS Jul_Revenue,
  SUM(IF(month = 'Aug', revenue, NULL)) AS Aug_Revenue,
  SUM(IF(month = 'Sep', revenue, NULL)) AS Sep_Revenue,
  SUM(IF(month = 'Oct', revenue, NULL)) AS Oct_Revenue,
  SUM(IF(month = 'Nov', revenue, NULL)) AS Nov_Revenue,
  SUM(IF(month = 'Dec', revenue, NULL)) AS Dec_Revenue
FROM Department
GROUP BY id;
```

---

### **Query Explanation**

1. **`SUM(IF(month = 'Jan', revenue, NULL))`**:
   - This sums the `revenue` only for rows where `month = 'Jan'`. If no such rows exist, the result is `NULL`.

2. **`GROUP BY id`**:
   - Ensures that each `id` appears only once in the result, with separate columns for each month.

3. **Output Columns**:
   - The query includes one column for each month (`<Month>_Revenue`) in addition to the department `id`.

---

### **Example Execution**

**Input**:
| id   | revenue | month |
|------|---------|-------|
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |

**Output**:
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
|------|-------------|-------------|-------------|-----|-------------|
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |

---

### **Link**
[Reformat Department Table - LeetCode](https://leetcode.com/problems/reformat-department-table/)
