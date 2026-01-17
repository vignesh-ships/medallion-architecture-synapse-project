# Bronze Layer Pipeline Documentation

## Pipeline: PL_Bronze_Ingestion_All_Tables

### Purpose
Ingest raw data from Azure SQL Database to Bronze layer (ADLS Gen2) in parallel.

### Architecture Pattern
- **Pattern:** Parameterized ForEach loop
- **Parallelization:** Enabled (all tables copy simultaneously)
- **Format:** Parquet (columnar, compressed)
- **Transformations:** None (raw copy)

### Parameters

**TableList (Array):**
```json
[
  {"SchemaName":"SalesLT", "TableName":"Customer", "FolderName":"customer"},
  {"SchemaName":"SalesLT", "TableName":"Product", "FolderName":"product"},
  {"SchemaName":"SalesLT", "TableName":"ProductCategory", "FolderName":"product_category"},
  {"SchemaName":"SalesLT", "TableName":"SalesOrderHeader", "FolderName":"sales_order_header"},
  {"SchemaName":"SalesLT", "TableName":"SalesOrderDetail", "FolderName":"sales_order_detail"}
]
```

### Activities

#### ForEach_Table
- Iterates through TableList parameter
- Sequential: False (parallel execution)
- Items expression: `@pipeline().parameters.TableList`

#### Copy_Table_To_Bronze
- **Source:** DS_SQL_Generic dataset
  - Dynamic schema: `@item().SchemaName`
  - Dynamic table: `@item().TableName`
- **Sink:** DS_ADLS_Bronze_Parquet dataset
  - Container: bronze
  - Dynamic folder: `@item().FolderName`
- **Settings:**
  - Staging: Disabled
  - Partition: None
  - Type conversion: Enabled

### Datasets

#### DS_SQL_Generic
- Parameterized source dataset
- Parameters: SchemaName, TableName
- Reusable for any SQL table

#### DS_ADLS_Bronze_Parquet
- Parameterized sink dataset
- Parameter: FolderName
- Format: Parquet
- Compression: None

### Output Structure
```
bronze/
├── customer/*.parquet (847 rows)
├── product/*.parquet (295 rows)
├── product_category/*.parquet (41 rows)
├── sales_order_header/*.parquet (32 rows)
└── sales_order_detail/*.parquet (542 rows)
```

### Execution
- Trigger: Manual
- Runtime: ~1-2 minutes
- Cost: Minimal (small data size)

### Key Design Decisions
1. Parallel execution for speed
2. Parquet for compression and query performance
3. Parameterization for scalability (easy to add new tables)
4. No transformations (bronze = raw data principle)