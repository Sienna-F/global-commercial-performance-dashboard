/*
=========================================================
Project Atlas

Question 3 - Top Products by Revenue

Business Question:
Which products generate the highest revenue?

Business Objective:
Identify the company's highest revenue-generating products
to support product investment and inventory decisions.

Output:
- Product Name
- Total Revenue
- Revenue Rank

=========================================================
*/

WITH product_revenue AS (

    SELECT

        p.product_name,

        ROUND(
            SUM(
                s.quantity * p.unit_price
            ),
            2
        ) AS total_revenue

    FROM sales AS s

    INNER JOIN products AS p
        ON s.product_key = p.product_key

    GROUP BY
        p.product_name

)

SELECT

    product_name,

    total_revenue,

    ROW_NUMBER() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank

FROM product_revenue

ORDER BY
    total_revenue DESC

LIMIT 10;


/*
=========================================================
Business Insight

- A small number of products contribute a significant
  proportion of total revenue.

- Identifying top-performing products helps prioritize
  inventory planning, marketing investment, and product
  portfolio management.

- High-revenue products should be monitored closely to
  maintain sustainable commercial performance.

Business Relevance

Product-level revenue analysis enables data-driven
decisions on product strategy, resource allocation,
and future growth opportunities.
=========================================================
*/
