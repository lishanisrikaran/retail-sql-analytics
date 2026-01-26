<h1>Retail SQL Analytics Project</h1>
<p><strong>End-to-end data analysis using SQL and Power BI on the Brazilian Olist e-commerce dataset</strong></p>

<img width="800" height="451" alt="image" src="https://github.com/user-attachments/assets/15045289-62ea-41ee-bb12-ee3c62ac0066" />

<div class="section">
  <h2>Project Overview</h2>
  <p>
    This project analyses a multi-table retail e-commerce dataset using advanced SQL techniques to uncover insights into revenue trends, customer behaviour, retention patterns, cohort dynamics, product performance, and order value distribution.
  </p>
  <p>
    Insights are presented using Power BI dashboards and supported with structured written analysis to demonstrate both technical capability and business thinking.
  </p>
</div>

<div class="section">
  <h2>Dataset</h2>
  <p><strong>Brazilian E-Commerce Public Dataset by Olist (Kaggle)</strong></p>
  <ul>
    <li>Orders, customers, sellers</li>
    <li>Payments and reviews</li>
    <li>Products and categories</li>
    <li>Geographic information</li>
  </ul>
  <p>
    The dataset was chosen for its rich relational structure and realistic commercial complexity.
  </p>
</div>

<div class="section">
  <h2>Tools & Skills Demonstrated</h2>
  <ul>
    <li><strong>SQL:</strong> CTEs, recursive CTEs, window functions, cohort analysis, segmentation, ranking, time series analysis</li>
    <li><strong>Power BI:</strong> Interactive dashboards, trend visualisation, histograms</li>
    <li><strong>Analytics Skills:</strong> KPI design, business interpretation, growth vs maturity diagnosis, commercial recommendations</li>
  </ul>
</div>

<div class="section">
  <h2>Project Structure</h2>
  <p>Each section follows the format:</p>
  <div class="highlight">
    SQL Query → Power BI Visualisation → Written Analysis
  </div>
</div>

<div class="section">
  <h2>1. Revenue & Order Performance</h2>

  <h3>Objective</h3>
  <p>
    Evaluate monthly revenue and order trends and quantify month-over-month growth to identify growth patterns, seasonality, and volatility.
  </p>

  <h3>Key Insights</h3>
  <ul>
    <li>Rapid growth throughout 2017 suggests strong acquisition and scaling</li>
    <li>Clear seasonality with strong Q4 (November) peak</li>
    <li>Revenue occasionally outpaces order growth, indicating higher order values</li>
    <li>Growth stabilises in mid-2018, indicating maturity</li>
  </ul>

  <h3>Strategic Implications</h3>
  <ul>
    <li>Forecasting should explicitly account for seasonality</li>
    <li>Marketing and inventory should align with Q4 demand peaks</li>
    <li>Growth strategy should shift toward retention and basket size</li>
  </ul>
</div>

<div class="section">
  <h2>2. Customer Behaviour & Retention</h2>

  <h3>Key Insights</h3>
  <ul>
    <li>Only 3.12% of customers are repeat buyers</li>
    <li>Over 70% churn rate</li>
    <li>Demand heavily concentrated in São Paulo and Rio de Janeiro</li>
    <li>High satisfaction does not translate into higher repeat behaviour</li>
  </ul>

  <h3>Strategic Implications</h3>
  <ul>
    <li>Retention is the single largest growth opportunity</li>
    <li>Post-purchase lifecycle strategies are critical</li>
    <li>Geographic concentration enables focused experimentation</li>
  </ul>
</div>

<div class="section">
  <h2>3. Cohort Analysis – Retention Over Time</h2>

  <h3>Key Insights</h3>
  <ul>
    <li>Month 1 retention consistently below 1%</li>
    <li>Retention collapse is immediate</li>
    <li>Later cohorts do not improve despite acquisition growth</li>
    <li>Long-term reactivation exists but is commercially insignificant</li>
  </ul>

  <h3>Strategic Implications</h3>
  <ul>
    <li>Business is structurally dependent on acquisition</li>
    <li>CLV is extremely low</li>
    <li>Retention improvement would generate outsized impact</li>
  </ul>
</div>

<div class="section">
  <h2>4. Product & Category Performance</h2>

  <h3>Key Insights</h3>
  <ul>
    <li>No individual product contributes more than 0.5% of revenue</li>
    <li>Strong long-tail structure at product level</li>
    <li>Top 5 categories contribute over 40% of revenue</li>
    <li>Category strategy is a stronger lever than SKU optimisation</li>
  </ul>

  <h3>Strategic Implications</h3>
  <ul>
    <li>Focus investment on high-performing categories</li>
    <li>Support mid-tier products to scale</li>
    <li>Rationalise low-performing catalogue segments</li>
  </ul>
</div>

<div class="section">
  <h2>5. Order Value Distribution</h2>

  <h3>Key Insights</h3>
  <ul>
    <li>Average order value: R$159.83</li>
    <li>Median order value: R$105.28</li>
    <li>Distribution is strongly right-skewed</li>
  </ul>

  <h3>Strategic Implications</h3>
  <ul>
    <li>Median is more reliable for pricing and thresholds</li>
    <li>High-value customers should be targeted for retention</li>
    <li>Promotional thresholds should align closer to typical spend</li>
  </ul>
</div>

<div class="section">
  <h2>Overall Conclusion</h2>
  <p>
    The business demonstrates strong acquisition-driven growth but extremely weak retention. 
    Sustainable performance would depend primarily on improving customer lifetime value, lifecycle engagement, and category-level optimisation rather than increasing acquisition volume alone.
  </p>
</div>

</body>
</html>

