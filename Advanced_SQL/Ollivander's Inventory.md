### **Harry Potter and the Wands**

The task is to determine the minimum number of gold galleons needed to buy each **non-evil wand** of high power and age. We need to display the id, age, coins_needed, and power of the wands sorted in descending order of power. If multiple wands have the same power, sort by descending age.

---

### **Approach**

1. **Filter Non-Evil Wands**:
   - Only consider wands where `is_evil = 0`.

2. **Find Minimum Coins for Each Age, Code, and Power**:
   - Group by `age`, `code`, and `power` and find the minimum value of `coins_needed`.

3. **Select Wand ID**:
   - Use the `wands` table to fetch the `id` corresponding to the minimum `coins_needed`.

4. **Sort the Result**:
   - First, by `power` in descending order.
   - If `power` is the same, sort by `age` in descending order.

---

### **SQL Query**

```sql
SELECT 
    w.id, 
    wp.age, 
    w.coins_needed, 
    w.power
FROM wands w
JOIN wands_property wp
    ON w.code = wp.code
   AND wp.is_evil = 0
JOIN (
    SELECT 
        wp.age, 
        w.code, 
        w.power, 
        MIN(w.coins_needed) AS min_coins
    FROM wands w
    JOIN wands_property wp
        ON w.code = wp.code
       AND wp.is_evil = 0
    GROUP BY wp.age, w.code, w.power
) AS min_data
    ON w.code = min_data.code
   AND w.power = min_data.power
   AND w.coins_needed = min_data.min_coins
ORDER BY w.power DESC, wp.age DESC;
```

---

### **Explanation**

1. **Filter Non-Evil Wands**:
   - `ON w.code = wp.code AND wp.is_evil = 0` ensures that only non-evil wands are considered.

2. **Find Minimum Coins Needed**:
   - The subquery (`min_data`) groups by `age`, `code`, and `power` and calculates the minimum `coins_needed`.

3. **Join to Get Wand ID**:
   - Join the `min_data` result with the `wands` table to fetch the corresponding `id`.

4. **Sorting**:
   - Results are sorted in descending order of `power`.
   - For ties in `power`, they are sorted by descending `age`.

---

### **Sample Input**

**Wands Table**:
| id  | code | coins_needed | power |  
|-----|------|--------------|-------|  
| 1   | 1    | 3688         | 8     |  
| 5   | 1    | 6020         | 2     |  
| 9   | 4    | 1647         | 10    |  
| 12  | 5    | 9897         | 10    |  
| 10  | 4    | 504          | 5     |  

**Wands_Property Table**:
| code | age | is_evil |  
|------|-----|---------|  
| 1    | 45  | 0       |  
| 2    | 40  | 0       |  
| 4    | 20  | 0       |  
| 5    | 17  | 0       |  

---

### **Sample Output**

| id  | age | coins_needed | power |  
|-----|-----|--------------|-------|  
| 9   | 45  | 1647         | 10    |  
| 12  | 17  | 9897         | 10    |  
| 1   | 45  | 3688         | 8     |  
| 5   | 45  | 6020         | 2     |  

---

### **Link**

[Hackerrank - Harry Potter and Wands](https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true)
