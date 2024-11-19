## Day 4: Article Views I

### Problem Description

We need to find all authors who have viewed at least one of their own articles.  
The table `Views` contains the following columns:

- `article_id`: The ID of the article.
- `author_id`: The ID of the author who wrote the article.
- `viewer_id`: The ID of the person who viewed the article.
- `view_date`: The date when the article was viewed.

**Key Points**:
- If `author_id = viewer_id`, it means the author viewed their own article.
- The result should contain distinct `author_id` values sorted in ascending order.

#### Example Input
**Table**: `Views`

| article_id | author_id | viewer_id | view_date  |
|------------|-----------|-----------|------------|
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |

#### Example Output
| id   |
|------|
| 4    |
| 7    |

#### Problem Link
You can find the problem [here](https://leetcode.com/problems/article-views-i/).

---

### Intuition

The task involves filtering rows where the `author_id` is equal to the `viewer_id`. Since the result must only include unique authors, we use the **`DISTINCT`** keyword. Finally, the output must be sorted by the `author_id`.

---

### Approach

1. Use a **`SELECT` query** to extract the `author_id` column as `id`.
2. Filter rows where `author_id = viewer_id` (authors who viewed their own articles).
3. Use the **`DISTINCT`** keyword to remove duplicates.
4. Sort the result in ascending order by `author_id`.

---

### Complexity

- **Time Complexity**:  
  $$O(n \cdot \log(n))$$, where $$n$$ is the number of rows in the `Views` table.  
  - Filtering takes $$O(n)$$.  
  - Sorting the distinct `author_id` values takes $$O(n \cdot \log(n))$$.

- **Space Complexity**:  
  $$O(1)$$, as no additional data structures are used apart from the query execution.

---

### Code
```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
```

---

### Notes

- **Duplicate Rows**: The `DISTINCT` keyword ensures duplicate rows are eliminated.
- **Ordering**: The `ORDER BY` clause ensures the output is sorted by `id` in ascending order, as required.
