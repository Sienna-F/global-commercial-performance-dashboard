# Global Commercial Performance Dashboard

An end-to-end Business Intelligence project that analyzes global commercial performance using SQL and Power BI.

The project explores revenue drivers, product performance, profitability, and strategic growth opportunities through interactive dashboards and business-focused analysis.

---

## Dashboard Preview

### Executive Overview

![Executive Overview](1.PNG)

---

### Commercial Performance Analysis

![Commercial Performance Analysis](2.PNG)

---

### Strategic Insights & Recommendations

![Strategic Insights](3.PNG)

## Data Model

The dashboard is built using a star schema, with Sales as the central fact table connected to multiple dimension tables including Customers, Products, Stores, and Date. 

The model structure supports scalable KPI calculations and business performance analysis using DAX measures.

![Data Model](4.PNG)

## Project Overview

This project simulates a real-world commercial analytics scenario for a global electronics retailer.

The objective is to evaluate commercial performance, identify revenue concentration, compare profitability across product categories, and generate strategic recommendations for future business growth.

---

## Business Objectives

• Identify key revenue drivers.

• Evaluate product profitability.

• Assess revenue concentration.

• Discover commercial growth opportunities.

• Deliver actionable business recommendations.

---

## Business Questions

1. How is the company performing across its core commercial KPIs?
2. How has revenue changed over time?
3. Which products generate the highest revenue?
4. Which products generate the highest profit?
5. Which product categories deliver the strongest revenue, profit, and margin?
6. Which countries are the strongest commercial markets?
7. Which customers contribute the greatest business value?
8. Which stores achieve the highest operational productivity?
9. Which product categories perform best within each country?

---

## End-to-End Workflow

```text
Raw Data
    │
    ▼
Power Query (Data Cleaning & Transformation)
    │
    ▼
Data Modeling (Star Schema)
    │
    ▼
DAX Measures & KPIs
    │
    ▼
SQL Business Analysis
    │
    ▼
Interactive Power BI Dashboard
    │
    ▼
Business Insights & Strategic Recommendations
```

---

## Tech Stack

- SQL
- Power BI
- DAX
- Power Query
- Excel

## Key Findings

- Computers generated the highest revenue contribution.
- Revenue and profitability show a strong positive relationship.
- Revenue is concentrated in a limited number of categories.
- Mid-tier categories present future growth opportunities.

## Repository Structure

📁 sql

- 01_Overall_Business_Performance.sql
- 02_Revenue_Trend.sql
- 03_Top_Products_by_Revenue.sql
- 04_Top_Products_by_Profit.sql
- 05_Category_Performance.sql
- 06_Geographic_Performance.sql
- 07_Customer_Value_Analysis.sql
- 08_Store_Productivity_Analysis.sql
- 09_Sales_Performance_Driver_Analysis.sql


📄 README.md


🖼 Dashboard Screenshots
