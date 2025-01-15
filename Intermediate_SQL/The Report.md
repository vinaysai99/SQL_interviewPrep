### **The Report**

The goal of this problem is to generate a report that includes `Name`, `Grade`, and `Marks` while meeting specific sorting and formatting conditions based on the grade values.

---

### **Approach**

1. **Filter and Format Names Based on Grades**:
   - If a student's grade is less than 8, replace their name with `"NULL"`.
   - For grades 8 and above, keep the original name.

2. **Sorting Requirements**:
   - First, sort by `grade` in descending order.
   - For grades 8 and above:
     - Sort alphabetically by `name`.
   - For grades below 8:
     - Sort by `marks` in ascending order.

3. **Join the Tables**:
   - Use the `Grades` table to determine the grade for each student based on their marks. Match `marks` to the appropriate `min_mark` and `max_mark` range in the `Grades` table.

4. **Output the Results**:
   - The output should be formatted with the columns: `Name`, `Grade`, and `Marks`.

---

### **SQL Query**

```sql
SELECT 
    CASE 
        WHEN grade < 8 THEN 'NULL'
        ELSE name
    END AS name,
    grade,
    marks
FROM students
JOIN grades
ON marks BETWEEN min_mark AND max_mark
ORDER BY 
    grade DESC,
    CASE 
        WHEN grade >= 8 THEN name
        ELSE NULL
    END ASC,
    CASE 
        WHEN grade < 8 THEN marks
        ELSE NULL
    END ASC;
```

---

### **Explanation**

1. **`CASE` Clause**:
   - For grades below 8, replace the `name` with `"NULL"`.
   - Otherwise, display the student's original `name`.

2. **Join Operation**:
   - The `students` table is joined with the `grades` table based on the condition `marks BETWEEN min_mark AND max_mark` to find the appropriate grade for each student.

3. **Sorting**:
   - The query is sorted primarily by `grade` in descending order.
   - For grades 8 and above:
     - Names are sorted alphabetically (`ASC`).
   - For grades below 8:
     - Marks are sorted in ascending order (`ASC`).

---

### **Sample Input**

**Students Table**:
| ID   | Name      | Marks |  
|------|-----------|-------|  
| 1    | Maria     | 99    |  
| 2    | Jane      | 81    |  
| 3    | Julia     | 88    |  
| 4    | Scarlet   | 78    |  
| 5    | Daniel    | 63    |  
| 6    | Alice     | 68    |  

**Grades Table**:
| Grade | Min_Mark | Max_Mark |  
|-------|----------|----------|  
| 1     | 0        | 10       |  
| 2     | 11       | 20       |  
| ...   | ...      | ...      |  
| 7     | 61       | 70       |  
| 8     | 71       | 80       |  
| 9     | 81       | 90       |  
| 10    | 91       | 100      |  

---

### **Sample Output**

| Name     | Grade | Marks |  
|----------|-------|-------|  
| Maria    | 10    | 99    |  
| Jane     | 9     | 81    |  
| Julia    | 9     | 88    |  
| Scarlet  | 8     | 78    |  
| NULL     | 7     | 63    |  
| NULL     | 7     | 68    |  

---

### **Explanation**

1. **Grades 8 and Above**:
   - Names are retained.
   - Sorted by grade descending, then by name alphabetically.

2. **Grades Below 8**:
   - Names are replaced with `"NULL"`.
   - Sorted by grade descending, then by marks ascending.

---

### **Link**

[Hackerrank - The Report](https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=false)
