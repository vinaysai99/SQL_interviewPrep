### **Rank Scores**

The goal is to rank the scores in a `Scores` table based on the following rules:

1. **Descending Order**:
   - The highest score receives rank 1.
   - Lower scores are ranked accordingly.

2. **Tie Handling**:
   - Scores that are the same receive the same rank.

3. **Dense Ranking**:
   - The next rank after a tie is the next consecutive integer, with no gaps in ranking.

---

### **Approach**

#### **Steps**

1. Use the `DENSE_RANK()` window function to assign ranks.
2. Order the scores in descending order (`ORDER BY score DESC`).
3. Return the scores with their respective ranks.

---

### **SQL Query**

```sql
SELECT 
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM Scores;
```

---

### **Explanation**

1. **`DENSE_RANK()`**:
   - Assigns ranks to the scores without skipping any rank numbers after ties.

2. **`ORDER BY score DESC`**:
   - Ensures the scores are ranked from highest to lowest.

3. **Result**:
   - Returns a result table with scores and their corresponding ranks.

---

### **Example**

#### **Input**

| id  | score |
|-----|-------|
| 1   | 3.50  |
| 2   | 3.65  |
| 3   | 4.00  |
| 4   | 3.85  |
| 5   | 4.00  |
| 6   | 3.65  |

#### **Output**

| score | rank |
|-------|------|
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |

---

### **Edge Cases**

1. **Single Score**:
   - If there’s only one score, it gets rank 1.

2. **All Scores the Same**:
   - If all scores are the same, they all get rank 1.

3. **Scores in Ascending Order**:
   - The query still handles ranking correctly as `ORDER BY score DESC` ensures proper sorting.

---

### **Link**

[LeetCode - Rank Scores](https://leetcode.com/problems/rank-scores/)
