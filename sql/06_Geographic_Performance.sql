/*
=========================================================
Project Atlas

Question 6 - Geographic Performance

Business Question:
Which countries generate the highest revenue, profit,
and order volume?

Business Objective:
Evaluate country-level market performance to identify
the company's strongest geographic markets and support
market investment and expansion decisions.

Output:
- Revenue Rank
- Country
- Total Revenue
- Total Profit
- Profit Margin
- Total Orders

=========================================================
*/

WITH country_performance AS (

    SELECT
        st.country,

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
        st.country

),

ranked_countries AS (

    SELECT
        country,
        total_revenue,
        total_profit,

        ROUND(
            total_profit
            / NULLIF(total_revenue, 0)
            * 100,
            2
        ) AS profit_margin,

        total_orders,

        DENSE_RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM country_performance

)

SELECT
    revenue_rank,
    country,
    total_revenue,
    total_profit,
    profit_margin,
    total_orders

FROM ranked_countries

ORDER BY
    revenue_rank,
    total_profit DESC;


/*
=========================================================
Business Insight

- Revenue and profitability vary significantly across
  countries, highlighting differences in market maturity
  and commercial performance.

- High-revenue markets are not always the most profitable,
  emphasizing the importance of evaluating both scale and
  efficiency when prioritizing geographic investments.

- Markets with strong profit margins and consistent order
  volumes represent attractive opportunities for future
  expansion.

Business Relevance

Geographic performance analysis enables business leaders
to identify high-performing markets, optimize regional
resource allocation, and support data-driven international
expansion strategies.
=========================================================
*/
