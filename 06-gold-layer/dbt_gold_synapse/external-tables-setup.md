# External Tables Setup

## Purpose
Connect silver Delta Lake files to Synapse Dedicated SQL Pool for dbt access.

## Setup Steps

### 1. Master Key
```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123!';
```

### 2. Database Scoped Credential
```sql
CREATE DATABASE SCOPED CREDENTIAL ADLSCredential
WITH IDENTITY = 'Managed Identity';
```

### 3. External Data Source
```sql
CREATE EXTERNAL DATA SOURCE silver_adls
WITH (
    LOCATION = 'abfss://silver@adlssynapsemedaldev.dfs.core.windows.net/',
    CREDENTIAL = ADLSCredential
);
```

### 4. External File Format
```sql
CREATE EXTERNAL FILE FORMAT ParquetFormat
WITH (FORMAT_TYPE = PARQUET);
```

### 5. Schema
```sql
CREATE SCHEMA silver_ext;
```

### 6. External Tables
Created 5 external tables:
- silver_ext.customer
- silver_ext.product
- silver_ext.product_category
- silver_ext.sales_order_header
- silver_ext.sales_order_detail

## Key Considerations
- Delta Lake files stored as Parquet internally
- UniqueIdentifier type not supported - use NVARCHAR
- rowguid columns mapped as NVARCHAR(100)
- Managed Identity authentication (no access keys)

## Validation
```sql
SELECT TOP 10 * FROM silver_ext.customer;
SELECT COUNT(*) FROM silver_ext.sales_order_detail;
```