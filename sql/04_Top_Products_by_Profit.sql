/*
=========================================================
Project Atlas

Question 4 - Top Products by Profit

Business Question:
Which products generate the highest profit?

Business Objective:
Identify the company's most profitable products
to support pricing strategy and product portfolio
optimization.

Output:
- Product Name
- Total Profit
- Profit Rank

=========================================================
*/

WITH product_profit AS (

    SELECT

        p.product_name,

        ROUND(
            SUM(
                s.quantity * (p.unit_price - p.unit_cost)
            ),
            2
        ) AS total_profit

    FROM sales AS s

    INNER JOIN products AS p
        ON s.product_key = p.product_key

    GROUP BY
        p.product_name

)

SELECT

    ROW_NUMBER() OVER (
        ORDER BY total_profit DESC
    ) AS profit_rank,

    product_name,

    total_profit

FROM product_profit

ORDER BY
    total_profit DESC

LIMIT 10;


/*
=========================================================
Business Insight

- The highest-profit products are not always the same as
  the highest-revenue products, highlighting differences
  between sales volume and profitability.

- Profit analysis helps identify products with the
  strongest financial contribution rather than simply
  the highest sales.

- Prioritizing high-profit products can improve pricing
  strategy, product portfolio optimization, and long-term
  business profitability.

Business Relevance

Profit-based product analysis supports strategic decisions
on pricing, inventory investment, and product portfolio
management, ensuring resources are allocated to the most
valuable products.
=========================================================
*/
