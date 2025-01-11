### **Tree Node**

The problem asks us to determine the type of each node in a tree structure stored in the `Tree` table. Each node can be categorized as:
1. **"Root"**: The node has no parent (`p_id IS NULL`).
2. **"Inner"**: The node has both a parent and at least one child.
3. **"Leaf"**: The node has a parent but no children.

---

### **Approach**

1. **Identify Root Nodes**:
   - Nodes where `p_id IS NULL` are classified as "Root".

2. **Identify Inner Nodes**:
   - Nodes that are referenced as `p_id` (parent) in the table are classified as "Inner".

3. **Identify Leaf Nodes**:
   - Nodes that are not classified as "Root" and are not listed as `p_id` in the table are classified as "Leaf".

4. **Combine Results**:
   - Use a `CASE` statement to classify each node based on the above criteria.

---

### **SQL Query**

```sql
SELECT id,
       CASE
           WHEN p_id IS NULL THEN 'Root'
           WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
           ELSE 'Leaf'
       END AS type
FROM Tree;
```

---

### **Explanation**

1. **Root Nodes**:
   - `p_id IS NULL` directly identifies root nodes.

2. **Inner Nodes**:
   - Nodes that appear in the `p_id` column (`id IN (SELECT DISTINCT p_id FROM Tree)`) have children and are classified as "Inner".

3. **Leaf Nodes**:
   - All remaining nodes, which have a parent (`p_id IS NOT NULL`) but are not listed as `p_id`, are classified as "Leaf".

4. **Combine and Return**:
   - The `CASE` statement ensures each node is categorized into one of the three types. 

---

### **Example**

#### **Input**

**Tree Table**:
| id  | p_id  |  
|-----|-------|  
| 1   | null  |  
| 2   | 1     |  
| 3   | 1     |  
| 4   | 2     |  
| 5   | 2     |  

---

#### **Output**

| id  | type   |  
|-----|--------|  
| 1   | Root   |  
| 2   | Inner  |  
| 3   | Leaf   |  
| 4   | Leaf   |  
| 5   | Leaf   |  

---

### **Explanation**

1. **Node 1**:
   - `p_id IS NULL`, so it is a "Root".

2. **Node 2**:
   - Appears as `p_id` for nodes 4 and 5, so it is "Inner".

3. **Nodes 3, 4, 5**:
   - These nodes do not appear as `p_id` and have a parent, so they are "Leaf".

---

### **Edge Case**

#### **Input**

**Tree Table**:
| id  | p_id  |  
|-----|-------|  
| 1   | null  |  

#### **Output**

| id  | type   |  
|-----|--------|  
| 1   | Root   |  

---

### **Link**

[LeetCode - Tree Node](https://leetcode.com/problems/tree-node/)
