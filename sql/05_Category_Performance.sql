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