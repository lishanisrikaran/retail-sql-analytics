WITH customer_orders AS (
-- All customer orders listed against the month commencement of when they were placed
    SELECT
        c.customer_unique_id,
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS order_month
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
),

cohorts AS (
-- Lists the month commencement for each customer's first order 
    SELECT
        customer_unique_id,
        MIN(order_month) AS cohort_month
    FROM customer_orders
    GROUP BY customer_unique_id
),

cohort_activity AS (
-- Lists all customer orders and how many months difference there is in comparison to their initial order
    SELECT
        co.customer_unique_id,
        c.cohort_month,
        co.order_month,
        TIMESTAMPDIFF(MONTH, c.cohort_month, co.order_month) AS month_number
    FROM customer_orders co
    JOIN cohorts c
        ON co.customer_unique_id = c.customer_unique_id
),

cohort_counts AS (
-- The number of active users are listed by order month for all cohorts
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_unique_id) AS active_customers
    FROM cohort_activity
    GROUP BY cohort_month, month_number
),

cohort_sizes AS (
-- Number of customers witin each cohort
    SELECT
        cohort_month,
        active_customers AS cohort_size
    FROM cohort_counts
    WHERE month_number = 0
)

-- Retention rates for all cohorts by order month
SELECT
    cc.cohort_month,
    cc.month_number,
    cc.active_customers,
    cs.cohort_size,
    ROUND(cc.active_customers / cs.cohort_size * 100, 2) AS retention_rate
FROM cohort_counts cc
JOIN cohort_sizes cs
    ON cc.cohort_month = cs.cohort_month
ORDER BY cc.cohort_month, cc.month_number;
