# SQL Business Analysis

This directory contains nine SQL analyses developed for the [Global Commercial Performance Dashboard](../README.md). Each query translates a commercial question into a reproducible analysis covering executive performance, time trends, products, categories, markets, customers, stores, and localized sales patterns.

## Analysis Overview

| # | Analysis | Business question | Key output | SQL techniques |
|---:|---|---|---|---|
| 01 | [Overall Business Performance](01_Overall_Business_Performance.sql) | How is the business performing overall? | Revenue, profit, margin, orders, active customers, AOV | CTE, joins, aggregation, `DISTINCT`, `NULLIF` |
| 02 | [Revenue Trend](02_Revenue_Trend.sql) | How has monthly revenue changed over time? | Monthly revenue, prior-month revenue, MoM growth | CTE, `DATE_TRUNC`, `LAG`, window functions |
| 03 | [Top Products by Revenue](03_Top_Products_by_Revenue.sql) | Which products generate the highest revenue? | Top 10 products and revenue rank | CTE, joins, aggregation, `ROW_NUMBER` |
| 04 | [Top Products by Profit](04_Top_Products_by_Profit.sql) | Which products generate the highest profit? | Top 10 products and profit rank | CTE, calculated metrics, `ROW_NUMBER` |
| 05 | [Category Performance](05_Category_Performance.sql) | Which categories deliver the strongest revenue, profit, and margin? | Category revenue, profit, and margin | CTE, joins, aggregation, `NULLIF` |
| 06 | [Geographic Performance](06_Geographic_Performance.sql) | Which countries generate the highest commercial value? | Country revenue, profit, margin, orders, and rank | Multiple joins, CTEs, `DENSE_RANK` |
| 07 | [Customer Value Analysis](07_Customer_Value_Analysis.sql) | Which customers contribute the greatest business value? | Customer revenue, profit, orders, AOV, and rank | Multiple joins, CTEs, `ROW_NUMBER`, `NULLIF` |
| 08 | [Store Productivity Analysis](08_Store_Productivity_Analysis.sql) | Which stores use retail space most productively? | Revenue per square metre and productivity rank | Multiple CTEs, normalized KPI, `ROW_NUMBER` |
| 09 | [Country-Category Performance](09_Sales_Performance_Driver_Analysis.sql) | Which categories perform best within each country? | Revenue, profit, and category rank within country | CTEs, multiple joins, partitioned `DENSE_RANK` |

## Data Model Used

The queries use the same fact-and-dimension structure as the Power BI report:

- `sales`: transactional fact table containing order, customer, product, store, date, and quantity fields
- `products`: product attributes, category, unit price, and unit cost
- `customers`: customer identifiers and customer names
- `stores`: store identifiers, country, and floor area

The main relationships used in SQL are:

```text
sales.product_key  -> products.product_key
sales.customer_key -> customers.customer_key
sales.store_key    -> stores.store_key
```

Revenue and profit are calculated consistently across the analyses:

```sql
-- Revenue
SUM(s.quantity * p.unit_price)

-- Profit
SUM(s.quantity * (p.unit_price - p.unit_cost))
```

## Query Details

### 01. Overall Business Performance

Establishes the executive KPI baseline used to evaluate commercial scale, profitability, customer activity, and transaction value.

**Metrics returned:**

- Total revenue
- Total profit
- Profit margin percentage
- Distinct orders
- Distinct active customers
- Average order value

**Key design choice:** `NULLIF` prevents division-by-zero errors when calculating margin and average order value.

---

### 02. Revenue Trend

Aggregates revenue by month and uses `LAG` to compare each month with the preceding month.

**Metrics returned:**

- Monthly revenue
- Previous-month revenue
- Month-over-month growth percentage

**Key design choice:** `DATE_TRUNC('month', ...)` creates a consistent monthly time grain, while the ordered window calculation preserves the sequence of performance changes.

---

### 03. Top Products by Revenue

Ranks individual products by total revenue to identify the largest contributors to commercial scale.

**Metrics returned:**

- Product name
- Total revenue
- Revenue rank

**Business use:** supports product prioritization, inventory planning, and revenue-concentration monitoring.

---

### 04. Top Products by Profit

Ranks products by profit contribution rather than revenue alone.

**Metrics returned:**

- Product name
- Total profit
- Profit rank

**Business use:** helps distinguish high-sales products from products creating the strongest financial contribution.

---

### 05. Category Performance

Compares product categories using revenue, profit, and profit margin.

**Metrics returned:**

- Category
- Total revenue
- Total profit
- Profit margin

**Business use:** supports portfolio decisions by evaluating both commercial scale and profitability.

---

### 06. Geographic Performance

Evaluates physical-market performance at country level. Online transactions are excluded to keep the comparison focused on geographic store markets.

**Metrics returned:**

- Revenue rank
- Country
- Total revenue
- Total profit
- Profit margin
- Total orders

**Key design choice:** `DENSE_RANK` preserves equal ranking when countries generate the same revenue.

---

### 07. Customer Value Analysis

Evaluates customer value using multiple dimensions rather than total spending alone.

**Metrics returned:**

- Customer rank
- Customer name
- Total revenue
- Total profit
- Distinct orders
- Average order value

**Business use:** supports customer prioritization, retention analysis, loyalty initiatives, and targeted marketing.

---

### 08. Store Productivity Analysis

Normalizes store revenue by floor area to compare operational productivity across differently sized physical locations.

**Metrics returned:**

- Productivity rank
- Store and country
- Square metres
- Total revenue
- Total profit
- Distinct orders
- Revenue per square metre

**Key design choice:** ranking first by revenue per square metre and then by total revenue distinguishes space efficiency from absolute sales scale.

---

### 09. Country-Category Performance

Ranks product categories separately within each country to reveal differences in local demand and category contribution. Online transactions are excluded from the geographic comparison.

**Metrics returned:**

- Country
- Category
- Total revenue
- Total profit
- Category rank within country

**Key design choice:** `DENSE_RANK() OVER (PARTITION BY country ...)` restarts the category ranking for every market.

**Business use:** supports localized assortment, marketing, and market-investment decisions.

## SQL Techniques Demonstrated

- Translating business questions into analytical queries
- Joining fact and dimension tables
- Building modular calculations with Common Table Expressions (CTEs)
- Calculating revenue, profit, margin, AOV, and productivity metrics
- Using `NULLIF` for safe division
- Applying `ROW_NUMBER`, `DENSE_RANK`, and `LAG` window functions
- Using `PARTITION BY` for within-market ranking
- Filtering online records from physical-market analyses
- Producing management-ready, ordered result sets

## SQL Dialect and Execution

The queries use PostgreSQL-style syntax, including `DATE_TRUNC` and `LIMIT`.

To run the analyses:

1. Load the `sales`, `products`, `customers`, and `stores` tables into a PostgreSQL-compatible database.
2. Confirm that the table and column names match those referenced in the queries.
3. Run the scripts in numerical order from `01` to `09`.
4. Compare the query outputs with the Power BI measures and dashboard findings.

> The underlying dataset is used for an independent portfolio project based on a simulated commercial scenario. The SQL results support exploratory business analysis and should not be interpreted as real-company financial performance.

## Return to Project

[View the complete dashboard, DAX measures, findings, and recommendations](../README.md)
