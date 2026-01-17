# Synapse Medallion Architecture Project

End-to-end data pipeline implementation using Azure Synapse Analytics with cost-optimized configurations.

## Architecture

**Medallion Pattern:** Bronze (Raw) → Silver (Cleaned) → Gold (Star Schema)
```
Source (Azure SQL) → Bronze (Parquet) → Silver (Delta) → Gold (dbt Star Schema)
        ↓                    ↓                ↓              ↓
    ADF Pipeline      Synapse Spark    Synapse Spark    dbt + Dedicated Pool
```

## Tech Stack

- **Orchestration:** Synapse Pipelines (integrated ADF)
- **Processing:** Synapse Spark Pools (auto-pause enabled)
- **Storage:** Azure Data Lake Storage Gen2 (LRS redundancy)
- **Source:** Azure SQL Database (AdventureWorksLT sample)
- **Transformation:** dbt-synapse
- **Analytics Layer:** Dedicated SQL Pool (DW100c)

## Project Structure
```
├── 01-infrastructure/          # Azure resources setup & cost config
├── 02-data-source/             # Source DB profiling & mappings
├── 03-synapse-pipelines/       # Pipeline definitions & linked services
├── 04-bronze-layer/            # Raw data ingestion (Parquet)
├── 05-silver-layer/            # Cleansed data (Delta Lake)
├── 06-gold-layer/              # Star schema (dbt models)
├── 07-orchestration/           # Master pipeline (future)
└── 08-spark-pool-config/       # Spark optimization settings
```

## Data Flow

### Bronze Layer
- **Tool:** Synapse Pipeline (Copy activity)
- **Pattern:** Parallel ingestion (5 tables)
- **Format:** Parquet
- **Tables:** Customer, Product, ProductCategory, SalesOrderHeader, SalesOrderDetail

### Silver Layer
- **Tool:** Synapse Spark Notebook
- **Pattern:** Sequential transformations
- **Format:** Delta Lake
- **Transformations:**
  - Add metadata columns (load_timestamp, source_system)
  - Remove sensitive data (PasswordHash, PasswordSalt)
  - Schema validation

### Gold Layer
- **Tool:** dbt-synapse
- **Pattern:** Star schema with surrogate keys
- **Format:** Dedicated SQL Pool tables
- **Models:**
  - dim_customer (847 rows)
  - dim_product (295 rows)
  - dim_date (1,096 rows)
  - fact_sales (542 rows)

## Key Features

✅ **Parameterized Pipelines** - Reusable for any table  
✅ **Delta Lake** - ACID transactions, time travel  
✅ **Surrogate Keys** - Industry-standard dimensional modeling  
✅ **Data Quality Tests** - dbt unique/not_null validations  
✅ **Lineage Tracking** - dbt docs with visual graph  
✅ **Cost Optimized** - Auto-pause, minimal resources

## Azure Resources

| Resource | Configuration | Monthly Cost |
|----------|--------------|--------------|
| ADLS Gen2 | Standard LRS, Hot tier | $3-5 |
| Azure SQL DB | Serverless, 2 vCores, 60min pause | $5-8 |
| Synapse Workspace | Serverless SQL (free) | $0 |
| Spark Pool | Small nodes, 3-6 autoscale, 15min pause | $10-20 |
| Dedicated SQL Pool | DW100c, manual pause | $0 (paused) |
| Key Vault | Standard tier | <$1 |
| **Total** | | **~$20-35/month** |

## Cost Management

**Critical Actions:**
- ✅ Spark pool auto-pauses after 15 mins
- ⚠️ **Dedicated SQL Pool: MANUAL PAUSE REQUIRED** after use
- ✅ Serverless SQL: Pay per query
- ✅ No scheduled pipeline triggers (manual only)

**To Pause Dedicated Pool:**  
Azure Portal → Synapse workspace → SQL pools → dedicatedsqlpool → Pause

## Setup Instructions

### Prerequisites
- Azure subscription with resource group access
- Python 3.12+
- Azure CLI
- dbt-synapse

### Quick Start

1. **Infrastructure:** Follow [01-infrastructure/README.md](01-infrastructure/README.md)
2. **Bronze Pipeline:** [03-synapse-pipelines/bronze-ingestion/](03-synapse-pipelines/bronze-ingestion/)
3. **Silver Notebook:** [05-silver-layer/README.md](05-silver-layer/README.md)
4. **Gold dbt:** [06-gold-layer/dbt_gold_synapse/README.md](06-gold-layer/dbt_gold_synapse/README.md)

### dbt Commands
```bash
cd 06-gold-layer/dbt_gold_synapse
dbt debug          # Test connection
dbt run            # Build models
dbt test           # Data quality tests
dbt docs generate  # Generate docs
dbt docs serve     # View lineage
```

## Key Learnings

1. **Parameterization** - Single pipeline handles N tables
2. **Delta Lake** - Better than Parquet for Silver/Gold
3. **Surrogate Keys** - Industry standard for dimensions
4. **External Tables** - Bridge Delta files to SQL
5. **Cost Awareness** - Manual pause critical for Dedicated Pool
6. **Documentation** - dbt lineage invaluable for understanding
7. **Spark vs SQL** - Use right tool for each layer

## Security

- All credentials in Azure Key Vault
- Managed identity authentication
- No secrets committed to Git
- RBAC for resource access

## Next Steps (Future Enhancements)

- [ ] Incremental loads (change data capture)
- [ ] Master orchestration pipeline
- [ ] Monitoring & alerting
- [ ] Power BI integration
- [ ] Automated testing in CI/CD
- [ ] Performance tuning (indexes, partitions)

## References

- [Azure Synapse Documentation](https://docs.microsoft.com/azure/synapse-analytics/)
- [dbt Documentation](https://docs.getdbt.com/)
- [Delta Lake](https://delta.io/)

---

**Project Status:** ✅ Complete  
**Last Updated:** January 2026