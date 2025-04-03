use maven_advanced_sql;

SELECT * FROM orders;

WITH Order_Month AS (
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS month_year,
        count(*) as freq
    FROM orders
    GROUP BY customer_id,month_year
),
Order_Months AS (
    SELECT
        customer_id,
        CAST(LEFT(month_year, 4) AS UNSIGNED) * 12 + CAST(RIGHT(month_year, 2) AS UNSIGNED) AS order_year_month
    FROM Order_Month
),
Consecutive_Months AS (
    SELECT
        customer_id,
		order_year_month,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_year_month) AS rn
    FROM Order_Months
),
Consecutive_Groups AS (
    SELECT
        customer_id,
        order_year_month,
        order_year_month - rn AS group_id
    FROM Consecutive_Months
),
Valid_Groups AS (
    SELECT
        customer_id,
        COUNT(*) AS consecutive_months
    FROM Consecutive_Groups
    GROUP BY customer_id, group_id
)
SELECT customer_id
FROM Valid_Groups
WHERE consecutive_months >= 3;



select customer_id,order_date from orders
where customer_id in (19394,31299)
order by customer_id,order_date;
