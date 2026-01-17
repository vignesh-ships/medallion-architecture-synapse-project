# Silver Layer Pipeline Documentation

## Pipeline: PL_Silver_Transformation_All_Tables

### Purpose
Execute Synapse Spark notebook transformations to convert Bronze to Silver layer data.

### Architecture Pattern
- **Pattern:** Parameterized ForEach with Notebook activity
- **Execution:** Sequential (cost-optimized for 3-node cluster)
- **Spark Pool:** spmeddev
- **Runtime:** ~15-20 minutes (5 tables)

### Parameters

**TableList (Array):**
```json
[
  {"source_table":"customer", "target_folder":"customer"},
  {"source_table":"product", "target_folder":"product"},
  {"source_table":"product_category", "target_folder":"product_category"},
  {"source_table":"sales_order_header", "target_folder":"sales_order_header"},
  {"source_table":"sales_order_detail", "target_folder":"sales_order_detail"}
]
```

### Activities

#### ForEach_Table
- Iterates through TableList parameter
- Sequential: True (prevents resource starvation)
- Items expression: `@pipeline().parameters.TableList`

#### Run_Silver_Transformation
- **Type:** Notebook activity
- **Notebook:** silver_transformation_generic
- **Spark pool:** spmeddev
- **Base parameters:**
  - `source_table`: `@item().source_table`
  - `target_folder`: `@item().target_folder`

### Execution Flow
1. ForEach loops through 5 tables sequentially
2. Each iteration launches notebook with parameters
3. Notebook reads bronze Parquet → transforms → writes silver Delta
4. Spark pool auto-pauses after 15 mins idle

### Output
- Format: Delta Lake
- Location: silver container
- Structure: One folder per table with `_delta_log/` metadata

### Key Design Decisions
1. Sequential execution for cost optimization (limited to 3 nodes)
2. Delta Lake for ACID and schema evolution
3. Parameterized notebook for scalability
4. Overwrite mode for simplicity (incremental load future enhancement)

### Monitoring
- Synapse Studio → Monitor → Pipeline runs
- Each notebook execution tracked separately
- Spark pool metrics available in cluster monitoring