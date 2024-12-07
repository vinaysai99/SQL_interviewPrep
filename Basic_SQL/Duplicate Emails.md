### Duplicate Emails

The task is to identify duplicate emails in a table where each email is guaranteed to be not null.

---

### Problem Details

1. **Input**:
   - A table `Person` with the following columns:
     - `id`: Unique ID of the person.
     - `email`: Email address of the person.

2. **Output**:
   - A single column, `Email`, containing all email addresses that appear more than once.

---

### SQL Solution

```sql
SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1;
```

---

### Explanation

1. **Group By**:
   - `GROUP BY email`: Groups all rows by the `email` column to calculate aggregate values for each unique email.

2. **Count and Filter**:
   - `HAVING COUNT(email) > 1`: Filters only those groups where the count of occurrences of the email is greater than 1.

3. **Select Duplicates**:
   - `SELECT email AS Email`: Selects the duplicate email addresses as `Email`.

---

### Example Outputs

#### Example 1:

**Input**:

| id | email   |
|----|---------|
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |

**Output**:

| Email   |
|---------|
| a@b.com |

**Explanation**:
- The email `a@b.com` appears twice, so it is included in the result.

---

### Link

[Duplicate Emails - LeetCode](https://leetcode.com/problems/duplicate-emails/)
