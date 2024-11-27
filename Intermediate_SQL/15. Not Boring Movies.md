### Day 15. Not Boring Movies

This problem requires filtering rows in the `Cinema` table based on specific conditions and then ordering the results by the `rating` column.

---

### Problem Requirements

1. **Filter Conditions**:
   - The `id` of the movie must be **odd** (`id % 2 = 1`).
   - The `description` of the movie must **not** contain the word `"boring"`.

2. **Ordering**:
   - The results should be ordered by `rating` in descending order.

---

### Schema

#### Table: `Cinema`

| Column Name  | Type    | Description                       |
|--------------|---------|-----------------------------------|
| `id`         | int     | Primary key, unique identifier.  |
| `movie`      | varchar | Name of the movie.               |
| `description`| varchar | Short description of the movie.  |
| `rating`     | float   | Rating of the movie (2 decimals).|

---

### Example

#### Input

**Cinema** table:
| id  | movie      | description | rating |
|-----|------------|-------------|--------|
| 1   | War        | great 3D    | 8.9    |
| 2   | Science    | fiction     | 8.5    |
| 3   | irish      | boring      | 6.2    |
| 4   | Ice song   | Fantacy     | 8.6    |
| 5   | House card | Interesting | 9.1    |

#### Output

| id  | movie      | description | rating |
|-----|------------|-------------|--------|
| 5   | House card | Interesting | 9.1    |
| 1   | War        | great 3D    | 8.9    |

---

### Solution

The SQL query:

```sql
SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND description NOT LIKE '%boring%'
ORDER BY rating DESC;
```

---

### Explanation

1. **Filtering Odd-Numbered IDs**:
   - Use the modulo operator (`id % 2 = 1`) to filter rows where the `id` is odd.

2. **Excluding Descriptions Containing "boring"**:
   - Use the `NOT LIKE '%boring%'` condition to exclude rows with the word `"boring"` in the `description`.

3. **Ordering by Rating**:
   - Use `ORDER BY rating DESC` to sort the results by `rating` in descending order.

---

### Example Walkthrough

1. **Filtering**:
   - Odd-numbered IDs: `{1, 3, 5}`.
   - Exclude `id = 3` because its `description` contains `"boring"`.
   - Remaining IDs: `{1, 5}`.

2. **Ordering**:
   - Ratings for `{1, 5}`: `{8.9, 9.1}`.
   - Sort in descending order: `{5, 1}`.

3. **Result**:
   - Rows corresponding to IDs `{5, 1}`.

---

### Problem Link
[Not Boring Movies - LeetCode](https://leetcode.com/problems/not-boring-movies/)
