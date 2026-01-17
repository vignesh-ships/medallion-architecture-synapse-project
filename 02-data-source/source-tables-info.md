# Source Tables Information

## Database Details
- Server: `sqlserver-synapse-medal-dev.database.windows.net`
- Database: `AdventureWorksLT`
- Schema: `SalesLT`
- Sample data: Pre-loaded from Microsoft

## Tables Overview

| Table Name | Row Count | Purpose |
|------------|-----------|---------|
| Customer | 847 | Customer master data |
| Product | 295 | Product catalog |
| ProductCategory | 41 | Product categories |
| SalesOrderHeader | 32 | Sales order headers |
| SalesOrderDetail | 542 | Sales order line items |

**Total Records:** 1,757

## Table Relationships
- Product → ProductCategory (ProductCategoryID)
- SalesOrderHeader → Customer (CustomerID)
- SalesOrderDetail → SalesOrderHeader (SalesOrderID)
- SalesOrderDetail → Product (ProductID)

## Data Characteristics
- Small dataset (< 2000 rows total)
- OLTP structure (normalized)
- Contains standard e-commerce data
- Date range: 2008-2010 (historical sample data)