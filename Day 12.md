## Day 11: Students and Examinations

The goal is to calculate how many times each student attended each subject exam. This requires combining data from three tables: `Students`, `Subjects`, and `Examinations`.

---

### Table: Students

| Column Name   | Type    | Description                                     |
|---------------|---------|-------------------------------------------------|
| `student_id`  | int     | Unique identifier for each student.             |
| `student_name`| varchar | Name of the student.                            |

- The `student_id` column is the **Primary Key** for this table.

---

### Table: Subjects

| Column Name   | Type    | Description                                     |
|---------------|---------|-------------------------------------------------|
| `subject_name`| varchar | Unique name of the subject.                     |

- The `subject_name` column is the **Primary Key** for this table.

---

### Table: Examinations

| Column Name   | Type    | Description                                     |
|---------------|---------|-------------------------------------------------|
| `student_id`  | int     | ID of the student who attended the exam.        |
| `subject_name`| varchar | Name of the subject for the exam attended.      |

- No **Primary Key**, and duplicates are allowed.

---

### Key Insights

1. **Cross Join Students and Subjects**:
   - Generate all combinations of students and subjects, ensuring every student is paired with every subject.

2. **Aggregate Examinations**:
   - Use `COUNT` to calculate the number of times a student attended a subject's exam.

3. **Left Join with Aggregated Data**:
   - Combine the full list of student-subject combinations with the aggregated data.
   - Use `CASE` to replace `NULL` with `0` for combinations where no exam was attended.

4. **Sort the Result**:
   - Order the output by `student_id` and `subject_name`.

---

### Example

#### Input

**Students** table:
| student_id | student_name |
|------------|--------------|
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |

**Subjects** table:
| subject_name |
|--------------|
| Math         |
| Physics      |
| Programming  |

**Examinations** table:
| student_id | subject_name |
|------------|--------------|
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |

#### Output
| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |

---

### SQL Solution

```sql
WITH exams AS (
    SELECT 
        student_id,
        subject_name,
        COUNT(subject_name) AS attended_exams
    FROM 
        Examinations 
    GROUP BY 
        student_id, subject_name
)
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COALESCE(e.attended_exams, 0) AS attended_exams
FROM 
    Students s
CROSS JOIN 
    Subjects sub
LEFT JOIN 
    exams e
ON 
    s.student_id = e.student_id 
    AND sub.subject_name = e.subject_name
ORDER BY 
    s.student_id, sub.subject_name;
```

---

### Explanation

1. **Common Table Expression (CTE)**:
   - Aggregate the `Examinations` table to count the number of exams for each `student_id` and `subject_name`.

2. **CROSS JOIN**:
   - Generate all possible combinations of students and subjects using a `CROSS JOIN`.

3. **LEFT JOIN**:
   - Match aggregated counts with the full combinations.

4. **Handle Missing Data**:
   - Use `COALESCE` to replace `NULL` values with `0` for students who did not attend any exams.

5. **Sort Results**:
   - Order by `student_id` and `subject_name` as specified.

---

### Pandas Solution

```python
import pandas as pd

# Generate all combinations of students and subjects
students_subjects = pd.merge(students.assign(key=1), subjects.assign(key=1), on='key').drop('key', axis=1)

# Count the number of times each student attended each subject exam
exam_counts = examinations.groupby(['student_id', 'subject_name']).size().reset_index(name='attended_exams')

# Merge with the full list of student-subject combinations
result = pd.merge(students_subjects, exam_counts, 
                  on=['student_id', 'subject_name'], how='left').fillna(0)

# Cast attended_exams to integer and sort results
result['attended_exams'] = result['attended_exams'].astype(int)
result = result.sort_values(by=['student_id', 'subject_name'])

return result
```

---

### Notes

- **Optimization**:
  - Index `student_id` in `Examinations` for faster grouping.
- **Edge Cases**:
  - If a student hasn’t attended any exams, their `attended_exams` should be `0` for all subjects.
  - Ensure all subjects appear for each student, even if unattempted.

#### Problem Link
[Students and Examinations - LeetCode](https://leetcode.com/problems/students-and-examinations/)
