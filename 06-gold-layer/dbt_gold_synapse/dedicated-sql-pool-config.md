# Dedicated SQL Pool Configuration

## Pool Details
- **Name:** dedicatedsqlpool
- **Performance Level:** DW100c (minimum tier)
- **Cost:** ~$1.20/hour when running
- **Status:** Paused (auto-pause not available, manual pause required)

## When to Use
- dbt model development and testing
- Gold layer table creation
- Data quality validation
- Documentation generation

## Cost Management

### Start Pool
Azure Portal → Synapse workspace → SQL pools → dedicatedsqlpool → Resume

### Pause Pool (CRITICAL!)
Azure Portal → Synapse workspace → SQL pools → dedicatedsqlpool → Pause

**Always pause after:**
- dbt run complete
- Testing complete
- Development session ends

### Estimated Costs
- 1 hour active: $1.20
- 10 minute session: ~$0.20
- Daily runs (10 mins): ~$6/month
- Storage (paused): Minimal

## Schemas Created
- `gold` - dbt models output
- `silver_ext` - external tables pointing to Delta files

## Performance Notes
- DW100c sufficient for small datasets (<1M rows)
- Single distribution for learning project
- No indexes created (default heap tables)

## Alternative Considered
- Serverless SQL Pool (free but limited Delta support)
- Spark notebooks (used for bronze/silver, not gold)
- Databricks SQL (different platform)

## Deletion
When project complete:
```
Azure Portal → Synapse workspace → SQL pools → dedicatedsqlpool → Delete
```
Confirm deletion to stop all charges.