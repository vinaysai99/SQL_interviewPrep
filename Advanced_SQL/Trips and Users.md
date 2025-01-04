### **Trips and Users**

The objective is to calculate the cancellation rate for unbanned users (both clients and drivers) on specific days. The cancellation rate is defined as:

Cancellation Rate= Number of Cancelled Requests / Total Number of Requests

---

### **Approach**

#### **Steps**

1. **Filter Out Banned Users**:
   - Remove trips where either the client or the driver is banned.

2. **Calculate Cancellation Rate**:
   - Count the total number of valid requests.
   - Count the canceled requests (`status` is either `cancelled_by_driver` or `cancelled_by_client`).

3. **Group and Aggregate**:
   - Group the results by `request_at` (date) to calculate daily rates.

4. **Round to Two Decimal Places**:
   - Use `ROUND()` to ensure the result is formatted correctly.

---

### **SQL Query**

```sql
SELECT 
    request_at AS Day,
    ROUND(SUM(CASE 
                  WHEN status LIKE 'cancelled%' THEN 1 
                  ELSE 0 
              END) / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE 
    client_id NOT IN (
        SELECT users_id 
        FROM Users 
        WHERE banned = 'Yes'
    )
    AND driver_id NOT IN (
        SELECT users_id 
        FROM Users 
        WHERE banned = 'Yes'
    )
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at;
```

---

### **Explanation of the Query**

1. **Filter by Banned Users**:
   - Subqueries find `users_id` of banned clients or drivers.
   - The `NOT IN` clause excludes trips involving banned users.

2. **Calculate Cancellation Count**:
   - `SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END)` counts canceled trips.

3. **Total Requests**:
   - `COUNT(*)` counts all valid requests for the day.

4. **Grouping**:
   - `GROUP BY request_at` groups data by day (`request_at`).

5. **Format Results**:
   - `ROUND(..., 2)` ensures the cancellation rate is shown to two decimal places.

---

### **Example**

#### **Input**

**Trips Table**:  
| id  | client_id | driver_id | city_id | status              | request_at  |
|-----|-----------|-----------|---------|---------------------|-------------|
| 1   | 1         | 10        | 1       | completed           | 2013-10-01  |
| 2   | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01  |
| 3   | 3         | 12        | 6       | completed           | 2013-10-01  |
| 4   | 4         | 13        | 6       | cancelled_by_client | 2013-10-01  |
| 5   | 1         | 10        | 1       | completed           | 2013-10-02  |

**Users Table**:  
| users_id | banned | role    |
|----------|--------|---------|
| 1        | No     | client  |
| 2        | Yes    | client  |
| 3        | No     | client  |
| 4        | No     | client  |
| 10       | No     | driver  |

#### **Output**

| Day        | Cancellation Rate |
|------------|-------------------|
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |

---

### **Edge Cases**

1. **No Requests on a Day**:
   - The query will skip days with no valid requests.

2. **All Requests Canceled**:
   - The cancellation rate will be 1.00 for that day.

3. **No Cancellations**:
   - The cancellation rate will be 0.00 for that day.

---

### **Link**

[LeetCode - Trips and Users](https://leetcode.com/problems/trips-and-users/)
