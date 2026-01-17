# Cost Optimization Configuration

## Storage Account (ADLS Gen2)
- Redundancy: LRS (vs GRS/ZRS)
- Access tier: Hot only (no cool/archive)
- No blob versioning enabled
- No soft delete enabled
- **Estimated cost:** $3-5/month

## Azure SQL Database
- Compute: Serverless (pay per use)
- Max vCores: 2 (minimal)
- Auto-pause: 60 minutes idle
- Backup storage: LRS
- **Estimated cost:** $5-8/month

## Key Vault
- Tier: Standard (not Premium)
- Secrets only (no certificates/keys)
- **Estimated cost:** $1-2/month

## Synapse Workspace
- Spark pool: Small nodes (4 vCores)
- Autoscale: 3-6 nodes (minimal range)
- Auto-pause: 15 minutes (aggressive)
- No dedicated SQL pool
- Serverless SQL: Pay per query
- **Estimated cost:** $10-20/month (usage-based)

## Key Vault
- Standard tier
- **Estimated cost:** <$1/month

## Total Estimated Monthly Cost
**$20-35/month** (based on minimal usage pattern)

## Cost Saving Strategies Applied
1. Auto-pause on all compute resources
2. Serverless tiers where available
3. Minimal node sizes and counts
4. LRS redundancy across all resources
5. No premium features enabled
6. Manual pipeline triggers (no schedules during development)

## Monitoring
- Check Azure Cost Management daily
- Set budget alerts at $50/month
- Delete resources when not in use for extended periods