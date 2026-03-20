# Brazilian E-Commerce Analytics | Olist 2016–2018

An end-to-end data pipeline project analyzing Brazilian e-commerce trends using the Olist dataset, built with a modern data stack.

## Dashboard

[View Tableau Dashboard](https://public.tableau.com/app/profile/june.oh7427/viz/BrazilianE-CommerceAnalytics2016-2018/BrazilianE-CommerceAnalytics)

## Pipeline Architecture

```
Kaggle: Olist Brazilian E-Commerce Dataset (9 CSV files)
        ↓
BigQuery (Raw Data Storage)
        ↓
dbt (Data Transformation)
    ├── Staging (9 models): Cleaned & standardized raw tables
    └── Mart (5 models):    Aggregated analytics-ready tables
        ↓
Tableau Public (Dashboard & Visualization)
```

## Tech Stack

| Tool | Purpose |
|------|---------|
| Python | Data exploration |
| BigQuery | Cloud data warehouse |
| dbt Core | Data transformation & testing |
| Tableau Public | Dashboard & visualization |
| GitHub | Version control |

## Project Structure

```
ecommerce_olist/
├── models/
│   ├── staging/
│   │   ├── sources.yml                   # Raw data source definitions
│   │   ├── schema.yml                    # Documentation & tests
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_order_payments.sql
│   │   ├── stg_order_reviews.sql
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_sellers.sql
│   │   ├── stg_geolocation.sql
│   │   └── stg_product_category.sql
│   └── mart/
│       ├── schema.yml                    # Documentation & tests
│       ├── mart_sales_monthly.sql
│       ├── mart_sales_by_category.sql
│       ├── mart_customer_analysis.sql
│       ├── mart_delivery_analysis.sql
│       └── mart_review_analysis.sql
└── dbt_project.yml
```

## Data Models

### Staging Models
| Model | Description |
|-------|-------------|
| `stg_orders` | Cleaned order data with standardized timestamps |
| `stg_order_items` | Order line items with price and freight |
| `stg_order_payments` | Payment details by order |
| `stg_order_reviews` | Customer review scores and timestamps |
| `stg_customers` | Customer info with city and state |
| `stg_products` | Product details and dimensions |
| `stg_sellers` | Seller info with location |
| `stg_geolocation` | Zip code level geo coordinates |
| `stg_product_category` | Portuguese to English category translation |

### Mart Models
| Model | Description |
|-------|-------------|
| `mart_sales_monthly` | Monthly revenue, orders, and customer trends |
| `mart_sales_by_category` | Revenue and review scores by product category |
| `mart_customer_analysis` | Customer distribution, revenue, and repeat rate by state |
| `mart_delivery_analysis` | Actual vs estimated delivery days and late delivery rate by state |
| `mart_review_analysis` | Review scores and positive review rate by category |

## Dashboard Highlights

- **Monthly Revenue & Order Trends** — Track growth from 2016 to 2018 with Black Friday peak visible in Nov 2017
- **Top 10 Product Categories by Revenue** — Identify best performing categories
- **Revenue by State** — Brazil choropleth map showing São Paulo dominance
- **Repeat vs New Customers by State** — Understand customer loyalty by region
- **Actual vs Estimated Delivery Days** — Compare delivery performance by state
- **Late Delivery Rate by State (%)** — Identify delivery bottlenecks
- **Top 10 Categories by Average Review Score** — Measure customer satisfaction
- **Top 10 Categories by Positive Review Rate (%)** — Find highest rated categories

## Data Quality Tests

dbt tests configured across all models:
- `not_null` on key columns
- `unique` on primary keys

Run tests with:
```bash
dbt test
```

## How to Run

### Prerequisites
- Python 3.9+
- dbt Core with BigQuery adapter
- Google Cloud account with BigQuery access

### Setup
```bash
# Install dbt
pip install dbt-bigquery

# Authenticate with Google Cloud
gcloud auth application-default login

# Run dbt pipeline
cd ecommerce_olist
dbt build
```

## Data Source

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle