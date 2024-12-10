### Game Play Analysis I

The task is to find the first login date for each player in the `Activity` table.

---

### Problem Details

1. **Input**:
   - **Table: `Activity`**
     - Columns:
       - `player_id`: The ID of the player.
       - `device_id`: The device used by the player.
       - `event_date`: The date when the player logged in.
       - `games_played`: The number of games played on that date.

2. **Output**:
   - A table with two columns:
     - `player_id`: The ID of the player.
     - `first_login`: The earliest `event_date` for the player.

3. **Constraints**:
   - Each combination of `player_id` and `event_date` is unique.

---

### SQL Solution

```sql
SELECT 
    player_id,
    MIN(event_date) AS first_login
FROM 
    Activity
GROUP BY 
    player_id;
```

---

### Explanation

1. **GROUP BY**:
   - Group rows by `player_id` so that all records for a specific player are considered together.

2. **MIN(event_date)**:
   - For each `player_id`, find the smallest `event_date`, which represents the first login.

3. **Output**:
   - Return the `player_id` and the corresponding `first_login`.

---

### Example Outputs

#### Example 1:

**Input**:

| player_id | device_id | event_date | games_played |
|-----------|-----------|------------|--------------|
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |

**Output**:

| player_id | first_login |
|-----------|-------------|
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |

**Explanation**:
- Player 1's first login was on `2016-03-01`.
- Player 2's first login was on `2017-06-25`.
- Player 3's first login was on `2016-03-02`.

---

### Alternate Solution Using Window Functions

If we want to preserve all rows and add a column indicating whether it's the first login:

```sql
SELECT 
    player_id,
    event_date AS first_login
FROM (
    SELECT 
        player_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk
    FROM 
        Activity
) subquery
WHERE rnk = 1;
```

---

### Link

[Game Play Analysis I - LeetCode](https://leetcode.com/problems/game-play-analysis-i/)
