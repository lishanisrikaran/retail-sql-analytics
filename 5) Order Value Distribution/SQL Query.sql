WITH order_values AS (
-- Collates the total revenue per delivered order
    SELECT
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
)

SELECT
-- Total orders per R$50 revenue bin interval 
    FLOOR(order_value / 50) * 50 AS bin_start,
    FLOOR(order_value / 50) * 50 + 50 AS bin_end,
    COUNT(*) AS order_count
FROM order_values
GROUP BY bin_start, bin_end
ORDER BY bin_start;
