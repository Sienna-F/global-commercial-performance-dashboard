/*
=========================================================
Project Atlas
Question 1 - Overall Business Performance

Business Question:
How is the company's overall commercial performance?

Business Objective:
Provide an executive summary of the company's overall
commercial performance using key financial and customer KPIs.

KPIs:
- Total Revenue
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Average Order Value
=========================================================
*/

WITH sales_summary AS (

    SELECT
        SUM(s.quantity * p.unit_price) AS total_revenue,

        SUM(
            s.quantity * (p.unit_price - p.unit_cost)
        ) AS total_profit,

        COUNT(DISTINCT s.order_number) AS total_orders,

        COUNT(DISTINCT s.customer_key) AS total_customers

    FROM sales AS s

    INNER JOIN products AS p
        ON s.product_key = p.product_key
)

SELECT
    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(total_profit, 2) AS total_profit,

    ROUND(
        total_profit / NULLIF(total_revenue, 0) * 100,
        2
    ) AS profit_margin_percentage,

    total_orders,

    total_customers,

    ROUND(
        total_revenue / NULLIF(total_orders, 0),
        2
    ) AS average_order_value

FROM sales_summary;

/*
=========================================================
Business Insight

- The business generated approximately $55.8M in revenue
  and $32.7M in profit.

- The overall profit margin reached approximately 58.6%,
  indicating strong profitability across the portfolio.

- The company processed approximately 26.3K orders from
  11.9K active customers.

- Average order value was approximately $2.1K, suggesting
  relatively high-value transactions.

Business Relevance

These KPIs provide an executive baseline for evaluating
commercial scale, profitability, customer activity, and
transaction value. They also support deeper analysis of
market, category, and product-level performance.
=========================================================
*/
