### 19. Queries Quality and Percentage

This problem involves analyzing a database table of query results to calculate two metrics for each `query_name`:

1. **Quality**: The average of the ratio between `rating` and `position`.
2. **Poor Query Percentage**: The percentage of queries with a `rating` less than 3.

---

### Problem Requirements

1. **Tables**:
   - **Queries** table:
     - Contains information about database query results.
     - Columns:
       - `query_name`: Name of the query.
       - `result`: Result of the query.
       - `position`: Position of the result in the query's output (1–500).
       - `rating`: Rating of the result (1–5).

2. **Metrics to Calculate**:
   - **Quality**:
     - \[
     \text{Quality} = \text{Average of } \frac{\text{rating}}{\text{position}}
     \]
   - **Poor Query Percentage**:
     - \[
     \text{Poor Query Percentage} = \left( \frac{\text{Number of Poor Queries (rating < 3)}}{\text{Total Queries}} \right) \times 100
     \]

3. **Formatting**:
   - Both metrics should be **rounded to 2 decimal places**.
   - Return the result in **any order**.

---

### Schema

#### Table: `Queries`

| Column Name | Type    | Description                              |
|-------------|---------|------------------------------------------|
| `query_name`| varchar | Name of the query.                       |
| `result`    | varchar | The query result.                        |
| `position`  | int     | Position of the result (1–500).          |
| `rating`    | int     | Rating of the result (1–5).              |

---

### Example

#### Input

**Queries** table:

| query_name | result            | position | rating |
|------------|-------------------|----------|--------|
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |

#### Output

| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |

#### Explanation

1. **Dog**:
   - Quality:
     - \[
     \text{Quality} = \frac{5}{1} + \frac{5}{2} + \frac{1}{200} \text{ (average of ratios)}
     \]
     - \[
     \text{Quality} = \frac{5 + 2.5 + 0.005}{3} = 2.50
     \]
   - Poor Query Percentage:
     - Only 1 query has `rating < 3` (out of 3 total queries).
     - \[
     \text{Percentage} = \left( \frac{1}{3} \right) \times 100 = 33.33
     \]

2. **Cat**:
   - Quality:
     - \[
     \text{Quality} = \frac{2}{5} + \frac{3}{3} + \frac{4}{7}
     \]
     - \[
     \text{Quality} = \frac{0.4 + 1 + 0.5714}{3} = 0.66
     \]
   - Poor Query Percentage:
     - Only 1 query has `rating < 3` (out of 3 total queries).
     - \[
     \text{Percentage} = \left( \frac{1}{3} \right) \times 100 = 33.33
     \]

---

### Solution

#### SQL Query

```sql
SELECT 
    query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(AVG(IF(rating < 3, 1, 0)) * 100, 2) AS poor_query_percentage
FROM 
    Queries
GROUP BY 
    query_name;
```

---

### Explanation of the Query

1. **Calculating Quality**:
   - Use `AVG(rating / position)` to compute the average of the ratio for each `query_name`.
   - Use `ROUND` to round the result to 2 decimal places.

2. **Calculating Poor Query Percentage**:
   - Use `IF(rating < 3, 1, 0)` to mark poor queries (1 for poor, 0 otherwise).
   - Calculate the average of these markers and multiply by 100 to get the percentage.
   - Round the result to 2 decimal places.

3. **Grouping**:
   - Group the results by `query_name` to compute metrics for each query.

---

### Link

[Queries Quality and Percentage - LeetCode](https://leetcode.com/problems/queries-quality-and-percentage/)
