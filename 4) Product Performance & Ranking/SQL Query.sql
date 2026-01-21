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
