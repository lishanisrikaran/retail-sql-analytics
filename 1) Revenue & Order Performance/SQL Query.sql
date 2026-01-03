-- Revenue & Order Performance

-- Sets all order purchase dates to the start of the month and returns the order count and total revenue made per month. 
-- Included as a CTE for a cleaner reference when performing window functions to compare MoM.
WITH monthly_metrics AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS order_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY order_month
)

-- Adds onto the CTE data by pulling in the order count and total revenue from the prior month, allowing a MoM growth calculation for each.

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

/*SELECT * FROM CUSTOMERS LIMIT 100;
SELECT * FROM GEOLOCATION LIMIT 100;
SELECT * FROM OLIST_PRODUCTS_DATASET LIMIT 100;
SELECT * FROM ORDER_ITEMS LIMIT 100;
SELECT * FROM ORDER_PAYMENTS LIMIT 100;
SELECT * FROM ORDER_REVIEWS LIMIT 100;
SELECT * FROM ORDERS LIMIT 100;
SELECT * FROM PRODUCT_CATEGORY_NAME_TRANSLATION LIMIT 100;
SELECT * FROM SELLERS LIMIT 100;*/