/*
=========================================================
Project Atlas

Question 9 - Sales Performance Driver Analysis

Business Question:
Which product categories perform best within each
country?

Business Objective:
Identify the highest-performing product categories
across different countries to support localized product
strategy and market expansion decisions.

Output:
- Country
- Category
- Total Revenue
- Total Profit
- Category Rank within Country

=========================================================
*/

WITH country_category_performance AS (

    SELECT

        st.country,

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

    INNER JOIN stores AS st
        ON s.store_key = st.store_key

    WHERE st.country <> 'Online'

    GROUP BY

        st.country,
        p.category

),

ranked_categories AS (

    SELECT

        country,

        category,

        total_revenue,

        total_profit,

        DENSE_RANK() OVER (

            PARTITION BY country

            ORDER BY total_revenue DESC

        ) AS category_rank

    FROM country_category_performance

)

SELECT

    country,

    category,

    total_revenue,

    total_profit,

    category_rank

FROM ranked_categories

ORDER BY

    country,

    category_rank,

    total_revenue DESC;