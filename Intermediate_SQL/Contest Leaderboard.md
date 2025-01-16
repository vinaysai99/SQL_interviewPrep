### **Contest Leaderboard**

The task is to compute the total score of each hacker based on their best submission scores for all challenges and display the leaderboard. This requires grouping, aggregation, and sorting while adhering to specific conditions.

---

### **Approach**

1. **Calculate Maximum Scores**:
   - For each hacker and challenge, find the maximum score from their submissions.

2. **Aggregate Total Score**:
   - Sum up the maximum scores of all challenges attempted by a hacker to get their total score.

3. **Filter Out Hackers with Zero Score**:
   - Exclude hackers whose total score is 0 from the result.

4. **Join the Tables**:
   - Use the `Hackers` table to include the `name` of each hacker in the results.

5. **Sort the Results**:
   - First, by total score in descending order.
   - If scores are tied, sort by `hacker_id` in ascending order.

---

### **SQL Query**

```sql
SELECT 
    s.hacker_id, 
    h.name, 
    SUM(s.score) AS total_score
FROM (
    SELECT 
        hacker_id, 
        challenge_id, 
        MAX(score) AS score
    FROM submissions
    GROUP BY hacker_id, challenge_id
) s
JOIN hackers h
ON s.hacker_id = h.hacker_id
GROUP BY s.hacker_id, h.name
HAVING total_score > 0
ORDER BY total_score DESC, s.hacker_id ASC;
```

---

### **Explanation**

1. **Subquery (`s`)**:
   - Groups the `submissions` table by `hacker_id` and `challenge_id`.
   - Finds the maximum score (`MAX(score)`) for each hacker's submission to a specific challenge.

2. **Main Query**:
   - Joins the result of the subquery (`s`) with the `hackers` table to retrieve the hacker's name.
   - Aggregates the scores (`SUM(score)`) for each hacker to calculate their total score.
   - Filters out hackers whose total score is 0 using the `HAVING` clause.

3. **Sorting**:
   - Orders the results by `total_score` in descending order.
   - If `total_score` is the same for multiple hackers, orders by `hacker_id` in ascending order.

---

### **Sample Input**

**Hackers Table**:
| hacker_id | name     |  
|-----------|----------|  
| 4071      | Rose     |  
| 74842     | Lisa     |  
| 84072     | Bonnie   |  
| 4806      | Angela   |  
| 26071     | Frank    |  
| 80305     | Kimberly |  
| 49438     | Patrick  |  

**Submissions Table**:
| submission_id | hacker_id | challenge_id | score |  
|---------------|-----------|--------------|-------|  
| 1             | 4071      | 19797        | 150   |  
| 2             | 4071      | 49593        | 41    |  
| 3             | 74842     | 19797        | 122   |  
| 4             | 74842     | 63132        | 52    |  
| 5             | 84072     | 49593        | 100   |  
| 6             | 4806      | 19797        | 89    |  
| 7             | 26071     | 19797        | 85    |  
| 8             | 80305     | 19797        | 67    |  
| 9             | 49438     | 19797        | 43    |  

---

### **Sample Output**

| hacker_id | name      | total_score |  
|-----------|-----------|-------------|  
| 4071      | Rose      | 191         |  
| 74842     | Lisa      | 174         |  
| 84072     | Bonnie    | 100         |  
| 4806      | Angela    | 89          |  
| 26071     | Frank     | 85          |  
| 80305     | Kimberly  | 67          |  
| 49438     | Patrick   | 43          |  

---

### **Explanation**

1. Hacker 4071 (Rose):
   - Scores: 150 (challenge 19797), 41 (challenge 49593).
   - Total Score: 150 + 41 = 191.

2. Hacker 74842 (Lisa):
   - Scores: 122 (challenge 19797), 52 (challenge 63132).
   - Total Score: 122 + 52 = 174.

3. Similarly, calculate scores for all other hackers.

---

### **Link**

[Hackerrank - Contest Leaderboard](https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=false)
