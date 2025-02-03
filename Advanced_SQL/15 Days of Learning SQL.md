### **15 Days of Learning SQL (Hackerrank SQL Challenge)**

**Problem Statement:**  
We need to analyze **15 days of learning SQL** and generate a report with the following columns:
1. **Submission Date**
2. **Number of active hackers** who have made a submission on that date and have submitted exactly as many days as the difference between the submission date and March 1, 2016.
3. **Hacker ID** of the user who made the most submissions on that date.
4. **Hacker Name** corresponding to the above hacker ID.

---

### **Approach:**
1. **Extract Unique Submission Dates**  
   - Use a subquery to extract distinct `SUBMISSION_DATE` from the `SUBMISSIONS` table.

2. **Count Active Hackers for Each Date**  
   - Count **distinct `HACKER_ID`** where the number of days they have made submissions is exactly equal to `DATEDIFF(SUBMISSION_DATE, '2016-03-01')`.

3. **Find the Hacker with Most Submissions on Each Date**  
   - Group by `HACKER_ID` for each `SUBMISSION_DATE`.
   - Order by **submission count (descending)** and **hacker ID (ascending)**.
   - Limit to **1 record** to get the hacker with the most submissions.

4. **Retrieve the Hacker Name**  
   - Use a subquery to fetch the `NAME` from the `HACKERS` table for the selected `HACKER_ID`.

---

### **SQL Solution**
```sql
SELECT 
    S1.SUBMISSION_DATE,

    -- Count of hackers who have been active exactly as many days as the difference from March 1, 2016
    (SELECT COUNT(DISTINCT S2.HACKER_ID)  
     FROM SUBMISSIONS S2  
     WHERE S2.SUBMISSION_DATE = S1.SUBMISSION_DATE  
     AND (SELECT COUNT(DISTINCT S3.SUBMISSION_DATE)  
          FROM SUBMISSIONS S3  
          WHERE S3.HACKER_ID = S2.HACKER_ID 
          AND S3.SUBMISSION_DATE < S1.SUBMISSION_DATE) 
         = DATEDIFF(S1.SUBMISSION_DATE , '2016-03-01')) AS ACTIVE_HACKERS,

    -- Find the hacker with the most submissions on that date
    (SELECT HACKER_ID 
     FROM SUBMISSIONS S2 
     WHERE S2.SUBMISSION_DATE = S1.SUBMISSION_DATE 
     GROUP BY HACKER_ID 
     ORDER BY COUNT(SUBMISSION_ID) DESC, HACKER_ID 
     LIMIT 1) AS MAX_HACKER_ID,

    -- Retrieve the name of the top hacker
    (SELECT NAME 
     FROM HACKERS 
     WHERE HACKER_ID = MAX_HACKER_ID) AS HACKER_NAME

FROM (SELECT DISTINCT SUBMISSION_DATE FROM SUBMISSIONS) S1  
GROUP BY S1.SUBMISSION_DATE;
```

---

### **Explanation of the Query**
1. **Extract distinct submission dates** (`S1.SUBMISSION_DATE`).
2. **Count active hackers**:
   - Check if the hacker has made exactly **"N" days of submissions** where `N = DATEDIFF(SUBMISSION_DATE, '2016-03-01')`.
3. **Find the hacker with the most submissions on that date**:
   - Group submissions by `HACKER_ID`, count them, order by count (descending) and ID (ascending).
4. **Fetch the hacker's name** from the `HACKERS` table.

---

### **Performance Considerations**
- **Indexes** on `SUBMISSIONS(SUBMISSION_DATE, HACKER_ID)` and `HACKERS(HACKER_ID)` improve query performance.
- **Subquery optimizations**:
  - Using **`COUNT(DISTINCT SUBMISSION_DATE)`** rather than a subquery scan speeds up active hacker counts.
  - **JOINING instead of Subqueries** can further optimize performance.

---

### **Expected Output Format**
| SUBMISSION_DATE | ACTIVE_HACKERS | MAX_HACKER_ID | HACKER_NAME |
|----------------|---------------|--------------|------------|
| 2016-03-01    | 1             | 12345        | Alice      |
| 2016-03-02    | 3             | 67890        | Bob        |

---

### **Link to Challenge**  
[Hackerrank - 15 Days of Learning SQL](https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem?isFullScreen=false)
