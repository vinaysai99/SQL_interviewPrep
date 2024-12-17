### Actors and Directors Who Cooperated At Least Three Times

The task is to find all pairs of `actor_id` and `director_id` where the actor has collaborated with the director at least three times.

---

### Problem Details

1. **Input**:
   - **Table: `ActorDirector`**
     - Columns:
       - `actor_id`: ID of the actor.
       - `director_id`: ID of the director.
       - `timestamp`: Unique timestamp of their collaboration (primary key).

2. **Output**:
   - The pairs `(actor_id, director_id)` where the count of their collaborations is at least three.

3. **Constraints**:
   - The result table should not have duplicates.
   - Order of output does not matter.

---

### SQL Solution

```sql
SELECT actor_id,
       director_id
FROM   actordirector
GROUP  BY actor_id, director_id
HAVING COUNT(timestamp) >= 3;
```

---

### Explanation

1. **GROUP BY Clause**:
   - Groups the rows by `actor_id` and `director_id`, so we can count the number of collaborations for each pair.

2. **HAVING Clause**:
   - Filters the grouped results to include only those pairs where the count of collaborations is at least three (`COUNT(timestamp) >= 3`).

---

### Example Outputs

#### Example 1:

**Input**:

| actor_id | director_id | timestamp |
|----------|-------------|-----------|
| 1        | 1           | 0         |
| 1        | 1           | 1         |
| 1        | 1           | 2         |
| 1        | 2           | 3         |
| 1        | 2           | 4         |
| 2        | 1           | 5         |
| 2        | 1           | 6         |

**Output**:

| actor_id | director_id |
|----------|-------------|
| 1        | 1           |

**Explanation**:
- Actor 1 and Director 1 collaborated 3 times (`timestamp`: 0, 1, 2).
- Actor 1 and Director 2 collaborated 2 times (`timestamp`: 3, 4).
- Actor 2 and Director 1 collaborated 2 times (`timestamp`: 5, 6).

---

### Link

[Actors and Directors Who Cooperated At Least Three Times - LeetCode](https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/)
