## Day 9: Rising Temperature

The goal is to find the IDs of dates (`recordDate`) where the temperature is higher compared to the previous date (yesterday).

### Table: Weather

| Column Name  | Type  | Description                                               |
|--------------|-------|-----------------------------------------------------------|
| `id`         | int   | Unique identifier for each row (Primary Key).             |
| `recordDate` | date  | The date of the recorded temperature.                     |
| `temperature`| int   | The temperature on the corresponding `recordDate`.        |

- Each row contains temperature data for a single day.
- No two rows have the same `recordDate`.

---

### Key Insights

1. **Compare Consecutive Dates**:
   - Find rows where the temperature is higher than the temperature on the previous day.

2. **Join with Itself**:
   - To compare a day's temperature with the previous day's, join the table with itself on `recordDate`.

---

### Example

#### Input

**Weather** table:
| id  | recordDate | temperature |
|-----|------------|-------------|
| 1   | 2015-01-01 | 10          |
| 2   | 2015-01-02 | 25          |
| 3   | 2015-01-03 | 20          |
| 4   | 2015-01-04 | 30          |

#### Output
| id  |
|-----|
| 2   |
| 4   |

#### Explanation
- On `2015-01-02`, temperature (`25`) > previous day (`10`) → `id = 2`.
- On `2015-01-04`, temperature (`30`) > previous day (`20`) → `id = 4`.

---

### SQL Solution

```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

#### Explanation:
1. **Self-Join**:
   - Join the `Weather` table with itself (`w1` and `w2`) to compare two rows.
   - Use the condition `DATEDIFF(w1.recordDate, w2.recordDate) = 1` to match consecutive dates.

2. **Filter**:
   - Use `w1.temperature > w2.temperature` to filter rows where the current temperature is higher than the previous day.

---

### Pandas Solution

```python
# Ensure data is sorted by recordDate
weather = weather.sort_values(by='recordDate')

# Shift the temperature and recordDate columns to compare
weather['prev_temp'] = weather['temperature'].shift(1)
weather['prev_date'] = weather['recordDate'].shift(1)

# Filter rows where the temperature is higher than the previous day's
result = weather[weather['temperature'] > weather['prev_temp']][['id']]

return result
```

---

### Notes

- **Optimization**:
  - Use indexes on `recordDate` for efficient joins in SQL.
- **Edge Cases**:
  - If there's only one record in the table, no output should be generated.
  - Ensure the `recordDate` column does not contain gaps.

#### Problem Link
[Rising Temperature - LeetCode](https://leetcode.com/problems/rising-temperature/)
