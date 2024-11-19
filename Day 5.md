## Day 5: Invalid Tweets

### Problem Description

We need to identify the `tweet_id` of tweets that are **invalid**. A tweet is considered **invalid** if its content exceeds 15 characters.  

The table `Tweets` contains the following columns:
- `tweet_id`: The unique identifier for each tweet (Primary Key).
- `content`: The actual text content of the tweet.

**Key Points**:
- Use the `LENGTH()` function to determine the number of characters in the `content`.
- A tweet is **invalid** if `LENGTH(content) > 15`.

#### Example Input
**Table**: `Tweets`

| tweet_id | content                           |
|----------|-----------------------------------|
| 1        | Let us Code                       |
| 2        | More than fifteen chars are here! |

#### Example Output
| tweet_id |
|----------|
| 2        |

#### Explanation
- **Tweet 1**: Content length = 11. It is valid.  
- **Tweet 2**: Content length = 33. It is invalid because it exceeds 15 characters.

#### Problem Link
You can find the problem [here](https://leetcode.com/problems/invalid-tweets/).

---

### Intuition

The task requires filtering tweets based on the length of their content. A simple **`WHERE` clause** with the **`LENGTH()`** function can identify invalid tweets.

---

### Approach

1. Use a **`SELECT` query** to retrieve the `tweet_id` of invalid tweets.
2. Apply a **`WHERE` condition** to filter rows where `LENGTH(content) > 15`.
3. Return the result without any specific ordering, as the problem does not require it.

---

### Complexity

- **Time Complexity**:  
  $$O(n)$$, where $$n$$ is the number of rows in the `Tweets` table.  
  Each row is evaluated once to compute the `LENGTH()` of the `content`.

- **Space Complexity**:  
  $$O(1)$$, as no additional space is used apart from the query execution.

---

### Code
```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

---

### Notes

- **Character Length**: The `LENGTH()` function calculates the number of characters in the `content` column.
- **No Sorting Required**: Since the result can be returned in any order, no `ORDER BY` clause is needed.

---

This can be added under the **Day 5** section in your repository. Let me know if there’s anything else to include!
