/*
=========================================================
Project Atlas
Question 2 - Revenue Trend Analysis

Business Question:
How has revenue changed over time?

Business Objective:
Analyze monthly revenue trends and month-over-month growth.
=========================================================
*/

WITH monthly_revenue AS (

    SELECT

        DATE_TRUNC('month', s.order_date) AS order_month,

        SUM(
            s.quantity * p.unit_price
        ) AS revenue

    FROM sales AS s

    INNER JOIN products AS p
        ON s.product_key = p.product_key

    GROUP BY
        DATE_TRUNC('month', s.order_date)

)

SELECT

    order_month,

    ROUND(revenue,2) AS monthly_revenue,

    ROUND(
        LAG(revenue) OVER(
            ORDER BY order_month
        ),
        2
    ) AS previous_month_revenue,


    ROUND(
        (
            revenue -
            LAG(revenue) OVER(
                ORDER BY order_month
            )
        )
        /
        NULLIF(
            LAG(revenue) OVER(
                ORDER BY order_month
            ),
            0
        )
        * 100,
        2
    ) AS mom_growth_percentage


FROM monthly_revenue

ORDER BY order_month;