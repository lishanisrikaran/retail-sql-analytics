-- Revenue & Order Performance

WITH RECURSIVE months AS (
    -- Generate a complete list of months in the dataset
    SELECT DATE('2016-10-01') AS order_month
    UNION ALL
    SELECT DATE_ADD(order_month, INTERVAL 1 MONTH)
    FROM months
    WHERE order_month < '2018-08-01'
),

order_revenue AS (
    -- Calculate revenue at the order level to avoid freight duplication
    SELECT
        o.order_id,
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS order_month,
        SUM(oi.price) + MAX(oi.freight_value) AS order_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_purchase_timestamp >= '2016-10-01'
      AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY o.order_id, order_month
),

monthly_metrics AS (
    -- Aggregate orders and revenue per month
    SELECT
        m.order_month,
        COUNT(orv.order_id) AS total_orders,
        COALESCE(SUM(orv.order_revenue), 0) AS total_revenue
    FROM months m
    LEFT JOIN order_revenue orv
        ON m.order_month = orv.order_month
    GROUP BY m.order_month
)

-- Pulls order count and total revenue from the prior month which allows MoM growth calculations
SELECT
    order_month,
    total_orders,
    total_revenue,

    LAG(total_orders) OVER (ORDER BY order_month) AS prev_month_orders,
    LAG(total_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,

    ROUND(
        (total_orders - LAG(total_orders) OVER (ORDER BY order_month))
        / NULLIF(LAG(total_orders) OVER (ORDER BY order_month), 0) * 100,
        2
    ) AS mom_order_growth_pct,

    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month))
        / NULLIF(LAG(total_revenue) OVER (ORDER BY order_month), 0) * 100,
        2
    ) AS mom_revenue_growth_pct

FROM monthly_metrics
ORDER BY order_month;
