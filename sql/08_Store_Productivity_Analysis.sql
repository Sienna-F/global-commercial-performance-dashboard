/*
=========================================================
Project Atlas

Question 8 - Store Productivity Analysis

Business Question:
Which stores achieve the strongest operational
productivity based on revenue generated per square meter?

Business Objective:
Evaluate store productivity using revenue, profit,
order volume, and revenue generated per square meter
to identify high-efficiency locations and support
retail expansion and operational optimization.

Output:
- Productivity Rank
- Store Key
- Country
- Square Meters
- Total Revenue
- Total Profit
- Total Orders
- Revenue per Square Meter

=========================================================
*/

WITH store_performance AS (

    SELECT
        st.store_key,
        st.country,
        st.square_meters,

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

    INNER JOIN products AS p
        ON s.product_key = p.product_key

    INNER JOIN stores AS st
        ON s.store_key = st.store_key

    WHERE st.country <> 'Online'

    GROUP BY
        st.store_key,
        st.country,
        st.square_meters

),

store_productivity AS (

    SELECT
        store_key,
        country,
        square_meters,
        total_revenue,
        total_profit,
        total_orders,

        ROUND(
            total_revenue
            / NULLIF(square_meters, 0),
            2
        ) AS revenue_per_square_meter

    FROM store_performance

),

ranked_stores AS (

    SELECT
        store_key,
        country,
        square_meters,
        total_revenue,
        total_profit,
        total_orders,
        revenue_per_square_meter,

        ROW_NUMBER() OVER (
            ORDER BY
                revenue_per_square_meter DESC,
                total_revenue DESC
        ) AS productivity_rank

    FROM store_productivity

)

SELECT
    productivity_rank,
    store_key,
    country,
    square_meters,
    total_revenue,
    total_profit,
    total_orders,
    revenue_per_square_meter

FROM ranked_stores

ORDER BY
    productivity_rank

LIMIT 10;