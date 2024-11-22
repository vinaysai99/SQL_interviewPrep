## Day 10: Average Time of Process per Machine

The goal is to calculate the **average processing time** for each machine in a factory by analyzing the `Activity` table.

---

### Table: Activity

| Column Name    | Type    | Description                                                                          |
|----------------|---------|--------------------------------------------------------------------------------------|
| `machine_id`   | int     | Unique ID of the machine.                                                           |
| `process_id`   | int     | Unique ID of the process running on the machine.                                     |
| `activity_type`| enum    | Can be `start` or `end`, indicating when a process starts and ends, respectively.    |
| `timestamp`    | float   | The exact time (in seconds) of the activity.                                         |

- `(machine_id, process_id, activity_type)` forms the **Primary Key**.
- Each `(machine_id, process_id)` pair has exactly one `start` and one `end` timestamp.

---

### Key Insights

1. **Find Process Time**:
   - For each `(machine_id, process_id)` pair, calculate the time difference:  
     Process Time = End Timestamp - Start Timestamp

2. **Average Process Time**:
   - Group by `machine_id` and compute the **average process time** across all processes for that machine.

3. **Precision**:
   - The result should display the average processing time rounded to **3 decimal places**.

---

### Example

#### Input

**Activity** table:
| machine_id | process_id | activity_type | timestamp |
|------------|------------|---------------|-----------|
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |

#### Output
| machine_id | processing_time |
|------------|-----------------|
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |

#### Explanation
- For `machine_id = 0`:  
   ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894 

- For `machine_id = 1`:  
   ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995 

- For `machine_id = 2`:  
   ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456 

---

### SQL Solution

```sql
SELECT start.machine_id AS machine_id,
       ROUND(AVG(ending.timestamp - start.timestamp), 3) AS processing_time
FROM Activity AS start
JOIN Activity AS ending
  ON start.machine_id = ending.machine_id
 AND start.process_id = ending.process_id
WHERE start.activity_type = 'start'
  AND ending.activity_type = 'end'
GROUP BY start.machine_id;
```

#### Explanation:
1. **Self-Join**:
   - Join the `Activity` table with itself:
     - Match `machine_id` and `process_id`.
     - Filter pairs where `start.activity_type = 'start'` and `ending.activity_type = 'end'`.

2. **Calculate Time**:
   - Compute the time difference (`ending.timestamp - start.timestamp`) for each process.

3. **Group & Average**:
   - Group by `machine_id` and compute the average process time.
   - Use `ROUND` to format the result to 3 decimal places.

---

### Pandas Solution

```python
import pandas as pd

# Split the table into start and end activities
start = activity[activity['activity_type'] == 'start'].rename(columns={'timestamp': 'start_time'})
end = activity[activity['activity_type'] == 'end'].rename(columns={'timestamp': 'end_time'})

# Merge the start and end tables on machine_id and process_id
merged = pd.merge(start, end, on=['machine_id', 'process_id'])

# Calculate process time
merged['process_time'] = merged['end_time'] - merged['start_time']

# Group by machine_id and calculate the average processing time
result = merged.groupby('machine_id')['process_time'].mean().reset_index()

# Rename columns and round to 3 decimal places
result = result.rename(columns={'process_time': 'processing_time'})
result['processing_time'] = result['processing_time'].round(3)

return result
```

---

### Notes

- **Optimization**:
  - Ensure indexes on `machine_id` and `process_id` for faster joins.
- **Edge Cases**:
  - If there are no records for a machine, it won't appear in the result.
  - Ensure timestamps are properly formatted to prevent floating-point errors.

#### Problem Link
[Average Time of Process per Machine - LeetCode](https://leetcode.com/problems/average-time-of-process-per-machine/)
