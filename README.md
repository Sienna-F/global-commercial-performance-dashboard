# Global Commercial Performance Dashboard

**End-to-End Business Intelligence Project | SQL · Power BI · Power Query · DAX**

An end-to-end business intelligence project analyzing six years of commercial data for a simulated global electronics retailer. I independently transformed the data, designed the analytical model, developed SQL and DAX calculations, built a three-page Power BI dashboard, and translated the findings into commercial recommendations.

## Project at a Glance

| Scope | Result |
|---|---:|
| Analysis period | 2016-2021 |
| Total revenue | $55.8M |
| Total profit | $32.7M |
| Profit margin | 58.6% |
| Orders | 26.3K |
| Active customers | 11.9K |
| Average order value | $2.1K |
| SQL analyses | 9 |
| Dashboard pages | 3 |

## Business Context

Management needs a consolidated view of revenue, profitability, customer activity, product performance, and market performance. The purpose of this project is to convert transactional sales data into an executive reporting solution that supports performance monitoring and commercial decision-making.

The analysis focuses on four management priorities:

- Monitor overall revenue, profit, margin, orders, customers, and average order value.
- Identify the products, categories, markets, customers, and stores contributing the most business value.
- Compare revenue contribution with profitability to avoid evaluating performance through sales alone.
- Translate analytical findings into practical commercial actions and areas for further investigation.

## Business Questions

1. What are the key drivers of overall commercial performance?
2. How have revenue and profit changed between 2016 and 2021?
3. Which products and categories contribute the most revenue and profit?
4. Which geographic markets generate the greatest commercial value?
5. Which customers and store locations contribute most strongly to performance?
6. How do order volume and average order value help explain differences in sales performance?

## My Contribution

I independently completed the full analytical workflow:

- Cleaned and transformed the source data using Power Query.
- Designed the analytical model and table relationships in Power BI.
- Developed reusable DAX measures for revenue, profit, margin, orders, active customers, and average order value.
- Separated numeric measures from presentation-specific display measures to support both analysis and consistent executive KPI formatting.
- Developed nine SQL analyses to investigate and validate commercial performance drivers.
- Designed a three-page Power BI dashboard for executive reporting, diagnostic analysis, and strategic recommendations.
- Converted analytical findings into business recommendations while distinguishing observed relationships from causal conclusions.

## Dashboard Walkthrough

### 1. Executive Overview

Provides a management-level view of the core KPIs, revenue and profit trends, leading markets, and category contribution.

![Executive Overview](01_Executive_Overview.PNG)

### 2. Commercial Performance Analysis

Examines category revenue contribution and the relationship between product revenue and profit to identify concentration, profitability patterns, and diversification opportunities.

![Commercial Performance Analysis](02_Commercial_Performance_Analysis.PNG)

### 3. Strategic Insights and Recommendations

Summarizes the main findings, proposed commercial actions, and areas requiring further analysis.

![Strategic Insights and Recommendations](03_Strategic_Insights_and_Recommendations.PNG)

## Data Model

The Power BI model uses `Sales` as the central fact table, connected to `Customers`, `Products`, `Stores`, and `Date` dimension tables through one-to-many relationships.

This structure separates transactional measures from descriptive business attributes, supports consistent filtering across dashboard pages, and reduces duplicated calculation logic. Dedicated measure tables organize reusable numeric calculations and presentation-specific KPI measures.

![Power BI Data Model](04_Data_Model.PNG)

> `Exchange_Rates` is not included in the documented analytical model because the reviewed core measures use USD product prices directly and do not reference the table.

## DAX Measure Design

The dashboard separates reusable numeric measures from display measures. Numeric measures remain available for aggregation, filtering, and visual analysis, while display measures format executive KPI cards as values such as `$55.8M`, `26.3K`, and `58.6%`.

### Total Revenue

```DAX
Total Revenue Value =
SUMX(
    Sales,
    Sales[Quantity] * RELATED(Products[Unit Price USD])
)
```

### Total Profit

```DAX
Total Profit Value =
[Total Revenue Value] - [Total Cost]
```

### Total Orders

```DAX
Total Orders Value =
DISTINCTCOUNT(Sales[Order Number])
```

### Active Customers

```DAX
Active Customers Value =
DISTINCTCOUNT(Sales[CustomerKey])
```

### Average Order Value

```DAX
Average Order Value Value =
DIVIDE(
    [Total Revenue Value],
    [Total Orders Value]
)
```

### Profit Margin

```DAX
Profit Margin Value =
DIVIDE(
    [Total Profit Value],
    [Total Revenue Value]
)
```

These measures use iterator, relationship, distinct-count, and safe-division functions to keep KPI definitions consistent throughout the report.

## SQL Business Analysis

SQL was used to translate management questions into analytical queries and validate the performance patterns presented in Power BI.

| Analysis | Business purpose | Main techniques |
|---|---|---|
| [Overall Business Performance](sql/01_Overall_Business_Performance.sql) | Establish the executive KPI baseline | Aggregation, distinct counts |
| [Revenue Trend](sql/02_Revenue_Trend.sql) | Evaluate performance over time | Date grouping, aggregation |
| [Top Products by Revenue](sql/03_Top_Products_by_Revenue.sql) | Rank products by sales contribution | Joins, aggregation, ranking |
| [Top Products by Profit](sql/04_Top_Products_by_Profit.sql) | Compare product profitability | Joins, calculated metrics, ranking |
| [Category Performance](sql/05_Category_Performance.sql) | Compare category revenue, profit, and margin | CTEs, grouped metrics |
| [Geographic Performance](sql/06_Geographic_Performance.sql) | Evaluate performance across markets | Multi-table joins, aggregation |
| [Customer Value Analysis](sql/07_Customer_Value_Analysis.sql) | Identify high-value customers | CTEs, aggregation, ranking |
| [Store Productivity Analysis](sql/08_Store_Productivity_Analysis.sql) | Compare store-level efficiency | Aggregation, normalized KPIs |
| [Sales Performance Driver Analysis](sql/09_Sales_Performance_Driver_Analysis.sql) | Examine the roles of order volume and order value | CTEs, window functions |

The complete queries and supporting notes are available in the [`sql`](sql/) directory.

## Key Findings

- The business generated **$55.8M in revenue** and **$32.7M in profit**, representing an overall profit margin of **58.6%** across **26.3K orders**.
- **Computers generated $19.3M**, making them the largest category contributor and indicating meaningful reliance on a limited part of the product portfolio.
- Home Appliances were the second-largest category at **$10.8M**, followed by Cameras and Camcorders at **$6.5M**, Cell Phones at **$6.2M**, and TV and Video at **$5.9M**.
- Product revenue and profit showed a strong positive relationship, but products still differed in their revenue and profitability profiles; commercial prioritization should therefore consider both measures.
- Revenue was concentrated across a limited number of categories and markets, creating both performance strength and concentration risk.
- Mid-tier categories may provide diversification opportunities, but inventory, promotion, demand, and acquisition-cost data would be required before making investment decisions.

## Business Recommendations

1. **Protect core-category performance**  
   Monitor revenue, profit, margin, and concentration within the Computers category rather than relying on total sales growth alone.

2. **Prioritize profitable growth**  
   Evaluate products using both revenue contribution and profitability before allocating commercial resources.

3. **Test portfolio diversification**  
   Identify mid-tier categories with stable margins and test targeted promotions before committing to broader expansion.

4. **Strengthen market-level monitoring**  
   Track revenue, active customers, order volume, and average order value together to distinguish broad-based growth from market concentration.

5. **Extend the analysis with operational data**  
   Incorporate inventory, returns, promotional spend, and customer acquisition cost to improve commercial planning and explain performance changes more fully.

## Analytical Workflow

1. Reviewed the business scenario and defined the management questions.
2. Cleaned and transformed the source data in Power Query.
3. Designed the fact-and-dimension data model in Power BI.
4. Created reusable numeric and display DAX measures.
5. Used SQL to investigate and validate business performance patterns.
6. Built the executive and diagnostic dashboard pages.
7. Translated the findings into recommendations and further-analysis priorities.

## Tools and Techniques

- **Power BI:** data modeling, interactive reporting, KPI design, dashboard development
- **Power Query:** data cleaning and transformation
- **DAX:** `SUMX`, `RELATED`, `DISTINCTCOUNT`, `DIVIDE`, reusable measures, display formatting
- **SQL:** joins, aggregations, CTEs, window functions, ranking, business-question analysis
- **Excel:** source-data handling and preliminary review

## Data and Limitations

This is a portfolio project based on a simulated commercial dataset and does not represent the performance of a real company.

The available data does not capture every possible commercial driver, including inventory availability, returns, promotional spend, customer acquisition cost, or competitor activity. The findings identify patterns and relationships in the available data; they should not be interpreted as proof of causality or as financial forecasts.

## Repository Structure

```text
global-commercial-performance-dashboard/
├── README.md
├── 01_Executive_Overview.PNG
├── 02_Commercial_Performance_Analysis.PNG
├── 03_Strategic_Insights_and_Recommendations.PNG
├── 04_Data_Model.PNG
└── sql/
    ├── README.md
    ├── 01_Overall_Business_Performance.sql
    ├── 02_Revenue_Trend.sql
    ├── 03_Top_Products_by_Revenue.sql
    ├── 04_Top_Products_by_Profit.sql
    ├── 05_Category_Performance.sql
    ├── 06_Geographic_Performance.sql
    ├── 07_Customer_Value_Analysis.sql
    ├── 08_Store_Productivity_Analysis.sql
    └── 09_Sales_Performance_Driver_Analysis.sql
```

## Author

**Wenqing Fu**  
Business Intelligence · Data Analysis · Commercial Performance
