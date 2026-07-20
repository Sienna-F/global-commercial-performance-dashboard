/*
=========================================================
Project Atlas

Question 5 - Category Performance

Business Question:
Which product categories generate the highest revenue,
profit, and profit margin?

Business Objective:
Evaluate category-level financial performance to support
product portfolio optimization and strategic investment
decisions.

Output:
- Category
- Total Revenue
- Total Profit
- Profit Margin

=========================================================
*/

WITH category_performance AS (

    SELECT

        p.category,

        ROUND(
            SUM(
                s.quantity * p.unit_price
            ),
            2
        ) AS total_revenue,

        ROUND(
            SUM(
                s.quantity * (
                    p.unit_price - p.unit_cost
                )
            ),
            2
        ) AS total_profit

    FROM sales AS s

    INNER JOIN products AS p

        ON s.product_key = p.product_key

    GROUP BY

        p.category

)

SELECT

    category,

    total_revenue,

    total_profit,

    ROUND(

        total_profit
        / NULLIF(total_revenue, 0)
        * 100,

        2

    ) AS profit_margin

FROM category_performance

ORDER BY

    total_revenue DESC,

    total_profit DESC;


/*
=========================================================
Business Insight

- Product categories differ significantly in revenue,
  profitability, and profit margin, indicating varying
  levels of commercial performance.

- High-revenue categories are not necessarily the most
  profitable, making it important to evaluate both sales
  volume and margin when prioritizing investments.

- Categories with strong profit margins may represent
  opportunities for expansion, while low-margin categories
  may require pricing or cost optimization.

Business Relevance

Category-level performance analysis supports strategic
product portfolio management by identifying where to
invest, optimize, or improve profitability across the
business.
=========================================================
*/
