# Storage Account Setup (ADLS Gen2)

## Configuration
- Name: `adlssynapsemedaldev`
- Type: Storage Account (ADLS Gen2)
- Performance: Standard
- Redundancy: LRS
- Access Tier: Hot
- Hierarchical Namespace: Enabled

## Containers Created
1. `synapsedefault` - Synapse workspace primary storage
2. `bronze` - Raw data from source systems
3. `silver` - Cleaned and validated data
4. `gold` - Analytics-ready star schema

## Access Configuration
- Public endpoint enabled
- Synapse workspace managed identity has Storage Blob Data Contributor role

## Key Vault Secret
- Secret name: `adls-access-key`
- Contains: Storage account access key (key1)

## Cost Optimization
- LRS redundancy (cheapest option)
- Hot tier only (no archive/cool tiers)
- No blob versioning or soft delete enabled