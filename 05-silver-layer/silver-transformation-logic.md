# Silver Layer Transformation Logic

## Purpose
Clean and enrich raw bronze data with metadata and business rules.

## Notebook: silver_transformation_generic

### Parameters
- `source_table` - Bronze folder name (e.g., "customer")
- `target_folder` - Silver folder name (e.g., "customer")

### Transformation Steps

#### 1. Read Bronze Data
- Format: Parquet
- Path: `abfss://bronze@adlssynapsemedaldev.dfs.core.windows.net/{source_table}/`
- No schema validation (raw data preserved)

#### 2. Apply Common Transformations
**Metadata Enrichment:**
- `load_timestamp` - Current timestamp (when processed)
- `source_system` - Literal "AdventureWorksLT"

**Data Quality:**
- No null handling (preserve raw state)
- No deduplication (source is transactional)
- Schema inherited from bronze

#### 3. Table-Specific Rules

**Customer Table:**
- Drop `PasswordHash` column (security)
- Drop `PasswordSalt` column (security)
- All other columns preserved

**Other Tables:**
- No specific rules (common transformations only)

#### 4. Write to Silver
- Format: **Delta Lake** (ACID transactions)
- Mode: Overwrite (full refresh)
- Schema evolution: Enabled (`overwriteSchema=true`)
- Path: `abfss://silver@adlssynapsemedaldev.dfs.core.windows.net/{target_folder}/`

### Delta Lake Benefits
- Time travel capability
- ACID transactions
- Schema enforcement and evolution
- Better query performance vs Parquet
- `_delta_log/` folder tracks all changes

### Output Structure
```
silver/
├── customer/_delta_log/ + parquet files (845 rows, 2 columns dropped)
├── product/_delta_log/ + parquet files (295 rows, 2 columns added)
├── product_category/_delta_log/ + parquet files (41 rows, 2 columns added)
├── sales_order_header/_delta_log/ + parquet files (32 rows, 2 columns added)
└── sales_order_detail/_delta_log/ + parquet files (542 rows, 2 columns added)
```

### Future Enhancements
- Incremental processing (change data capture)
- Data validation rules
- Column-level transformations
- Error handling and logging