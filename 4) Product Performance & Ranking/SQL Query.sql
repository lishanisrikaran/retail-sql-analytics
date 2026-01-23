-- 4) Product Performance & Ranking

-- Products ranked by revenue
	SELECT
		oi.product_id,
		ROUND(SUM(oi.price), 2) AS total_revenue,
		DENSE_RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank,
		ROUND(SUM(oi.price) / SUM(SUM(oi.price)) OVER () * 100, 2) AS revenue_pct
	FROM order_items oi
	GROUP BY oi.product_id
	ORDER BY revenue_rank;

-- Product count by revenue bands
WITH product_revenue AS (
    SELECT
        oi.product_id,
        SUM(oi.price) AS total_revenue
    FROM order_items oi
    GROUP BY oi.product_id
)

SELECT
    CASE
        WHEN total_revenue < 10 THEN '£0–£10'
        WHEN total_revenue < 50 THEN '£10–£50'
        WHEN total_revenue < 200 THEN '£50–£200'
        WHEN total_revenue < 500 THEN '£200–£500'
        WHEN total_revenue < 1000 THEN '£500–£1k'
        WHEN total_revenue < 2500 THEN '£1k–£2.5k'
        WHEN total_revenue < 5000 THEN '£2.5k–£5k'
        WHEN total_revenue < 10000 THEN '£5k–£10k'
        ELSE '£10k+'
    END AS revenue_band,

    COUNT(*) AS product_count,
    ROUND(SUM(total_revenue), 2) AS band_revenue,
    ROUND(
        SUM(total_revenue) / SUM(SUM(total_revenue)) OVER () * 100,
        2
    ) AS revenue_pct

FROM product_revenue
GROUP BY revenue_band
ORDER BY MIN(total_revenue);

-- Product categories ranked by revenue
SELECT
	t.product_category_name_english AS category,
	ROUND(SUM(oi.price), 2) AS total_revenue,
	DENSE_RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank,
	ROUND(SUM(oi.price) / SUM(SUM(oi.price)) OVER () * 100, 2) AS revenue_pct
FROM order_items oi
JOIN olist_products_dataset p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation t
	ON p.product_category_name = t.ï»¿product_category_name
GROUP BY t.product_category_name_english
ORDER BY revenue_rank;
