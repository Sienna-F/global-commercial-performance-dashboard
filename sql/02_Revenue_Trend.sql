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

/*
=========================================================
Business Insight

- Monthly revenue shows fluctuations over time, reflecting
  seasonal demand and changing sales performance.

- Month-over-month (MoM) growth highlights periods of
  strong expansion as well as temporary slowdowns.

- Tracking revenue trends helps identify growth momentum,
  detect performance declines early, and evaluate the
  effectiveness of commercial initiatives.

Business Relevance

Revenue trend analysis provides executives with a clear
view of business performance over time and supports
forecasting, budgeting, and strategic planning.
=========================================================
*/
