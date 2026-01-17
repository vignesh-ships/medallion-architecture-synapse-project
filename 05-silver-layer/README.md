# Silver Layer Documentation

## Overview
Cleaned and validated data with business rules applied using Synapse Spark notebooks.

## Components

### Notebook
- [silver_transformation_generic.py](synapse-notebooks/silver_transformation_generic.py)
- Parameterized for reusability
- Processes any bronze table to silver

### Transformation Logic
- [silver-transformation-logic.md](silver-transformation-logic.md)
- Common transformations: metadata columns
- Table-specific rules: sensitive data removal
- Output format: Delta Lake

## Pipeline Integration
- Pipeline: `PL_Silver_Transformation_All_Tables`
- Execution: Sequential (resource-optimized)
- Spark pool: `spmeddev`
- Runtime: ~15-20 minutes (5 tables)

## Delta Lake Features Used
- ACID transactions
- Schema evolution
- Overwrite mode with schema merge
- Time travel capability (future use)

## Tables Processed
1. customer (847 → 847 rows, security columns dropped)
2. product (295 → 295 rows)
3. product_category (41 → 41 rows)
4. sales_order_header (32 → 32 rows)
5. sales_order_detail (542 → 542 rows)

## Next Steps
- Gold layer star schema modeling with dbt
- Dimensional modeling (dims + facts)