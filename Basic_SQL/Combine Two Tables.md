### Combine Two Tables

The task is to combine the data from two tables: `Person` and `Address`, such that for every person in the `Person` table, we include their corresponding `city` and `state` from the `Address` table. If a person does not have an address, their `city` and `state` values should be `NULL`.

---

### Problem Requirements

1. **Input**:
   - **Person Table**:
     - `personId`: Unique identifier for each person.
     - `firstName`: First name of the person.
     - `lastName`: Last name of the person.
   - **Address Table**:
     - `addressId`: Unique identifier for each address.
     - `personId`: Foreign key linking to the `Person` table.
     - `city`: City of the address.
     - `state`: State of the address.

2. **Output**:
   - A table with the following columns:
     - `firstName`: First name of the person.
     - `lastName`: Last name of the person.
     - `city`: City of the person (from the `Address` table or `NULL` if missing).
     - `state`: State of the person (from the `Address` table or `NULL` if missing).

---

### Example

#### Input:

**Person Table**:

| personId | lastName | firstName |
|----------|----------|-----------|
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |

**Address Table**:

| addressId | personId | city          | state      |
|-----------|----------|---------------|------------|
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |

#### Output:

| firstName | lastName | city          | state    |
|-----------|----------|---------------|----------|
| Allen     | Wang     | NULL          | NULL     |
| Bob       | Alice    | New York City | New York |

---

### SQL Solution

```sql
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM 
    Person p
LEFT JOIN 
    Address a
ON 
    p.personId = a.personId;
```

---

### Explanation of the Query

1. **Join Tables**:
   - Perform a `LEFT JOIN` between the `Person` and `Address` tables. This ensures all records from the `Person` table are included, even if there is no matching `personId` in the `Address` table.

2. **Select Columns**:
   - Retrieve:
     - `firstName` and `lastName` from the `Person` table.
     - `city` and `state` from the `Address` table. If no matching `personId` exists, these values will be `NULL`.

3. **Null Handling**:
   - The `LEFT JOIN` naturally returns `NULL` for `city` and `state` if a `personId` does not exist in the `Address` table.

---

### Output for the Example:

| firstName | lastName | city          | state    |
|-----------|----------|---------------|----------|
| Allen     | Wang     | NULL          | NULL     |
| Bob       | Alice    | New York City | New York |

---

### Link

[Combine Two Tables - LeetCode](https://leetcode.com/problems/combine-two-tables/)
