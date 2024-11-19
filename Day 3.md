## Day 3: Big Countries

### Problem Description

We need to identify the **big countries** from the `World` table. A country is considered **big** if it satisfies either of the following conditions:

1. **Area** is at least 3,000,000 (i.e., 3 million km²), or  
2. **Population** is at least 25,000,000 (i.e., 25 million).

The table `World` contains the following columns:

- `name`: The name of the country (Primary Key).
- `continent`: The continent the country belongs to.
- `area`: The total area of the country in km².
- `population`: The population of the country.
- `gdp`: The gross domestic product of the country.

#### Example Input
**Table**: `World`

| name         | continent | area    | population | gdp          |
|--------------|-----------|---------|------------|--------------|
| Afghanistan  | Asia      | 652230  | 25500100   | 20343000000  |
| Albania      | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria      | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra      | Europe    | 468     | 78115      | 3712000000   |
| Angola       | Africa    | 1246700 | 20609294   | 100990000000 |

#### Example Output
| name         | population | area    |
|--------------|------------|---------|
| Afghanistan  | 25500100   | 652230  |
| Algeria      | 37100000   | 2381741 |

#### Problem Link
You can find the problem [here](https://leetcode.com/problems/big-countries/).

---

### Intuition

The task requires filtering rows based on two conditions:
1. The **area** of the country is greater than or equal to 3,000,000.
2. The **population** of the country is greater than or equal to 25,000,000.

Countries meeting either condition qualify as **big**. A simple **`WHERE` clause** with the **`OR` operator** can achieve this.

---

### Approach

1. Use a **`SELECT` query** to retrieve the `name`, `population`, and `area` columns.
2. Apply a **`WHERE` condition** to filter rows based on:
   - `population >= 25000000`, or  
   - `area >= 3000000`.
3. Return the filtered rows.

---

### Complexity

- **Time Complexity**:  
  $$O(n)$$, where $$n$$ is the number of rows in the `World` table. Each row is evaluated once to check the conditions.

- **Space Complexity**:  
  $$O(1)$$, as no additional data structures are used aside from the query execution.

---

### Code
```sql
SELECT name,
       population,
       area
FROM World
WHERE population >= 25000000
   OR area >= 3000000;
```

---

### Notes

- This query does not specify a sorting order because the problem does not require it.
- The output includes only the columns `name`, `population`, and `area` as per the problem's requirements.
