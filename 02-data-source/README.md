# Data Source Documentation

## Overview
Source system: Azure SQL Database with AdventureWorksLT sample data

## Contents
- [source-tables-info.md](source-tables-info.md) - Table names, row counts, relationships
- [data-profiling.md](data-profiling.md) - Column details, data quality notes, transformation strategy

## Source Database Connection
- Server: `sqlserver-synapse-medal-dev.database.windows.net`
- Database: `AdventureWorksLT`
- Authentication: SQL (credentials in Key Vault)

## Tables to Ingest
1. SalesLT.Customer (847 rows)
2. SalesLT.Product (295 rows)
3. SalesLT.ProductCategory (41 rows)
4. SalesLT.SalesOrderHeader (32 rows)
5. SalesLT.SalesOrderDetail (542 rows)

## Next Steps
- Bronze layer ingestion via Synapse Pipelines
- Silver layer transformations via Synapse Spark
- Gold layer star schema via dbt