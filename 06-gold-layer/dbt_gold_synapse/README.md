# Gold Layer - dbt Star Schema

## Overview
Star schema dimensional model using dbt with Azure Synapse Dedicated SQL Pool.

## Setup

### Prerequisites
- Python 3.12+
- dbt-synapse installed
- Azure CLI authenticated

### Configuration
- profiles.yml location: `~/.dbt/profiles.yml`
- Target database: `dedicatedsqlpool`
- Schema: `gold`

## Models

### Dimensions
- **dim_customer** (847 rows) - Customer master with surrogate keys
- **dim_product** (295 rows) - Product catalog with category
- **dim_date** (1,096 rows) - Date dimension 2008-2010

### Facts
- **fact_sales** (542 rows) - Sales transactions (grain: order line item)

## Data Sources
External tables from silver Delta Lake files:
- silver_ext.customer
- silver_ext.product
- silver_ext.product_category
- silver_ext.sales_order_header
- silver_ext.sales_order_detail

## Commands
```bash
dbt debug          # Test connection
dbt run            # Build all models
dbt test           # Run data quality tests
dbt docs generate  # Generate documentation
dbt docs serve     # View lineage graph
```

## Key Features
- Surrogate keys for all dimensions
- Star schema design
- Data quality tests (unique, not_null)
- Lineage tracking
- Automated documentation

## Cost Note
**PAUSE dedicated SQL pool after use!** (~$1.20/hour when running)