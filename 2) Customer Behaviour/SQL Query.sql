-- 1. CUSTOMER LOYALTY (REPEAT CUSTOMERS)
WITH customer_type AS (
-- Identifies repeat customers based on order history volume
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders,   
        CASE
            WHEN COUNT(o.order_id) > 1 THEN 'repeat_customer'
            ELSE 'one_time_customer'
        END AS customer_type
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT 
-- Repeat vs one time customer volume
    COUNT(customer_unique_id) AS total_customers,
    SUM(CASE WHEN customer_type = 'one_time_customer' THEN 1 ELSE 0 END) AS total_one_time_customers, 
    SUM(CASE WHEN customer_type = 'repeat_customer' THEN 1 ELSE 0 END) AS total_repeat_customers,
    ROUND(
        SUM(CASE WHEN customer_type = 'repeat_customer' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(customer_unique_id), 
        2
    ) AS repeat_customer_pct
FROM customer_type;

-- CUSTOMER CHURN (RECENCY)
WITH last_orders AS (
-- Returns the latest order purchase date for each customer
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_order_date
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
dataset_max_date AS (
-- Latest order purchase date in the dataset
    SELECT
        MAX(order_purchase_timestamp) AS max_order_date
    FROM orders
),
customer_status AS (
-- Allocates a churn status based on if a customer has placed their latest order within 6 months of the latest order in the dataset
    SELECT
        lo.customer_unique_id,
        CASE
            WHEN lo.last_order_date < DATE_SUB(d.max_order_date, INTERVAL 6 MONTH)
            THEN 'churned'
            ELSE 'active'
        END AS churn_status
    FROM last_orders lo
    CROSS JOIN dataset_max_date d
)

-- Churn summary
SELECT
    COUNT(*) AS total_customers,
	SUM(CASE WHEN churn_status = 'active' THEN 1 ELSE 0 END) AS active_customers,
    SUM(CASE WHEN churn_status = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN churn_status = 'churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percent
FROM customer_status;

-- GEOGRAPHIC DISTRIBUTION
-- Customer orders by state and city
SELECT
    c.customer_state,
    c.customer_city,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    ROUND(
        COUNT(o.order_id) * 1.0 / COUNT(DISTINCT c.customer_unique_id),
        2
    ) AS avg_orders_per_customer
FROM customers c
JOIN orders o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_state, c.customer_city
ORDER BY total_orders DESC;

-- PAYMENT BEHAVIOUR
-- Customer preferred payment methods
SELECT
    p.payment_type,
    COUNT(DISTINCT o.customer_id) AS customers,
    COUNT(o.order_id) AS orders,
    ROUND(AVG(p.payment_installments), 2) AS avg_installments
FROM order_payments p
JOIN orders o
  ON p.order_id = o.order_id
GROUP BY p.payment_type
ORDER BY orders DESC;

-- Payment installment behaviour

SELECT
    CASE
        WHEN payment_installments > 1 THEN 'installments'
        ELSE 'single_payment'
    END AS payment_behavior,
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(o.order_id) AS orders,
    ROUND(
        COUNT(o.order_id) * 1.0 / COUNT(DISTINCT c.customer_unique_id),
        2
    ) AS avg_orders_per_customer
FROM order_payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY payment_behavior;

-- REVIEW SCORES VS CUSTOMER BEHAVIOUR

WITH customer_reviews AS (
    SELECT
        c.customer_unique_id,
        AVG(r.review_score) AS avg_review_score,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_reviews r ON o.order_id = r.order_id
    GROUP BY c.customer_unique_id
)
SELECT
    ROUND(avg_review_score, 0) AS review_score_bucket,
    COUNT(*) AS customers,
    ROUND(AVG(order_count), 2) AS avg_orders_per_customer
FROM customer_reviews
GROUP BY review_score_bucket
ORDER BY review_score_bucket DESC;

-- Review Comment Analysis
SELECT
    CASE
        WHEN r.review_comment_title IS NOT NULL
          OR r.review_comment_message IS NOT NULL
        THEN 'left_comment'
        ELSE 'no_comment'
    END AS review_behavior,
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY review_behavior;


