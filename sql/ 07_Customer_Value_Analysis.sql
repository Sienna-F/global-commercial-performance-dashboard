/*
=========================================================
Project Atlas

Question 7 - Customer Value Analysis

Business Question:
Which customers contribute the greatest business value
based on revenue, profit, purchasing frequency, and
average order value?

Business Objective:
Identify the company's highest-value customers to
support customer retention, loyalty programs, and
targeted marketing strategies.

Output:
- Customer Rank
- Customer Name
- Total Revenue
- Total Profit
- Total Orders
- Average Order Value

=========================================================
*/

WITH customer_performance AS (

    SELECT

        c.customer_name,

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
        ) AS total_profit,

        COUNT(
            DISTINCT s.order_number
        ) AS total_orders

    FROM sales AS s

    INNER JOIN customers AS c
        ON s.customer_key = c.customer_key

    INNER JOIN products AS p
        ON s.product_key = p.product_key

    GROUP BY

        c.customer_name

),

ranked_customers AS (

    SELECT

        customer_name,

        total_revenue,

        total_profit,

        total_orders,

        ROUND(
            total_revenue
            / NULLIF(total_orders, 0),
            2
        ) AS average_order_value,

        ROW_NUMBER() OVER (
            ORDER BY total_revenue DESC
        ) AS customer_rank

    FROM customer_performance

)

SELECT

    customer_rank,

    customer_name,

    total_revenue,

    total_profit,

    total_orders,

    average_order_value

FROM ranked_customers

ORDER BY

    customer_rank

LIMIT 10;