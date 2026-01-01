# retail-sql-analytics
Analyse multi-table retail e-commerce data using advanced SQL techniques to uncover revenue trends, customer behaviour, retention patterns, and product performance. Present insights via a Power BI dashboard suitable for business stakeholders.

Document the business problem, SQL techniques used, key insights, and future improvements.
Use this project to confidently discuss advanced SQL, business logic, and data storytelling in
interviews.

Core Tables:
- orders (order lifecycle and dates)
- order_items (product-level revenue)
- customers (customer identifiers and signup dates)
- products (product categories and names)

CTEs, window functions (LAG, LEAD, ROW_NUMBER, DENSE_RANK), DATE_TRUNC,
DATE_PART, NOT EXISTS, EXISTS, FILTER, CASE statements, COALESCE,
PERCENTILE_CONT (median), and multi-table joins.

4.1 Revenue & Order Performance
Analyse monthly revenue trends, total orders, and month-over-month growth using DATE_TRUNC
and LAG window functions.
4.2 Customer Behaviour & Retention
Identify repeat customers, calculate retention rates, and detect churned customers using NOT
EXISTS and CASE logic.
4.3 Cohort Analysis
Group customers by signup month and analyse retention over time using date arithmetic and
window functions.
4.4 Product Performance & Ranking
Rank products and categories by revenue using DENSE_RANK and GROUP BY, accounting for
ties.
4.5 Order Value Distribution
Calculate median and average order values using PERCENTILE_CONT and aggregation functions.
4.6 Time Series & Seasonality
Analyse weekly and monthly trends and handle missing time periods using GENERATE_SERIES.
