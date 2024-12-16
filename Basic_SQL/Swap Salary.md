### Swap Salary

The task is to swap the values of the `sex` column in the `Salary` table such that:
- `'m'` becomes `'f'`
- `'f'` becomes `'m'`

---

### Problem Details

1. **Input**:
   - **Table: `Salary`**
     - Columns:
       - `id`: Primary key for each employee.
       - `name`: Name of the employee.
       - `sex`: Gender of the employee (`'m'` or `'f'`).
       - `salary`: Salary of the employee.

2. **Output**:
   - The `sex` column values swapped (`'m'` to `'f'` and vice versa).

3. **Constraints**:
   - Must use a single `UPDATE` statement.
   - No intermediate tables or `SELECT` statements are allowed.

---

### SQL Solution

```sql
UPDATE salary
SET sex = 
    CASE 
        WHEN sex = 'm' THEN 'f'
        WHEN sex = 'f' THEN 'm'
    END;
```

---

### Explanation

1. **UPDATE Statement**:
   - Updates the `sex` column for all rows in the `Salary` table.

2. **CASE Statement**:
   - Checks the current value of `sex`:
     - If it is `'m'`, change it to `'f'`.
     - If it is `'f'`, change it to `'m'`.

---

### Example Outputs

#### Example 1:

**Input**:

| id  | name | sex | salary |
|-----|------|-----|--------|
| 1   | A    | m   | 2500   |
| 2   | B    | f   | 1500   |
| 3   | C    | m   | 5500   |
| 4   | D    | f   | 500    |

**Output**:

| id  | name | sex | salary |
|-----|------|-----|--------|
| 1   | A    | f   | 2500   |
| 2   | B    | m   | 1500   |
| 3   | C    | f   | 5500   |
| 4   | D    | m   | 500    |

**Explanation**:
- Rows with `'m'` (`id: 1, 3`) are changed to `'f'`.
- Rows with `'f'` (`id: 2, 4`) are changed to `'m'`.

---

### Link

[Swap Salary - LeetCode](https://leetcode.com/problems/swap-salary/)
