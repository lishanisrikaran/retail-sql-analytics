# retail-sql-analytics

This project undertakes analysis from a multi-table retail e-commerce dataset using advanced SQL techniques to uncover revenue trends, customer behaviour, retention patterns, and product performance. Furthermore, the findings are presented via a Power BI dashboard suitable for business stakeholders.

## Dataset:
The analysis is based on the [Brazilian E-Commerce Public Dataset (Kaggle)](https://www.kaggle.com/datasets/carrie1/ecommerce-data), selected for its rich transactional and customer data, allowing meaningful exploration of commercial performance and customer behaviour at scale.

## Analysed areas:

### **1) Revenue & Order Performance**
**Objective**: To evaluate monthly revenue and order trends and quantify month-over-month (MoM) growth, in order to identify growth patterns, seasonality, and performance volatility that may impact strategic decision-making. 

**Approach:** Using advanced SQL techniques, transaction data was aggregated at a monthly level. For each month, total orders and total revenue were calculated, alongside prior-month comparisons to derive MoM growth percentages for both metrics. <br>

Note: Month-over-month calculations assume continuous monthly data, as the dataset does not contain missing months. If gaps were present, MoM comparisons would require a calendar table to ensure accuracy.


**Key Findings**
- The business experienced rapid growth during 2017, with sustained increases in both orders and revenue, indicating successful customer acquisition and scaling.
- Seasonal demand peaks are evident in Q4, particularly November, followed by sharp post-peak declines in December and early Q1.
- Periods where revenue growth outpaces order growth suggest improvements in average order value, potentially driven by pricing, product mix, or promotional strategies.
- Several extreme MoM changes highlight either one-off events (e.g. promotions or system launches) or potential data completeness issues that warrant further investigation.
- From mid-2018 onwards, growth begins to stabilise and flatten, indicating a transition from high-growth to a more mature operating phase.

**Business Implications**
- Forecasting models should explicitly account for seasonality and volatility to avoid overstating expected performance.
- Marketing and inventory strategies can be optimised by aligning investment with historically high-performing months.
- Leadership should monitor stabilising growth trends as a signal to shift focus from acquisition to retention, basket size, and customer lifetime value.




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
