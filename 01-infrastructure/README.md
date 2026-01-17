# Infrastructure Setup

Azure resources for Synapse Medallion Architecture.

## Resources Created
1. Storage Account (ADLS Gen2) - Medallion containers
2. Azure SQL Database - Source data (AdventureWorksLT)
3. Key Vault - Secrets management
4. Synapse Workspace - Analytics platform

## Cost Optimization Applied
- ADLS: LRS redundancy, Hot tier only
- SQL DB: Serverless compute tier
- Synapse: Auto-pause Spark pools
- Key Vault: Standard tier

## Setup Order
1. Storage Account → [storage-account-setup.md](storage-account-setup.md)
2. SQL Database → [sql-database-setup.md](sql-database-setup.md)
3. Key Vault → [key-vault-setup.md](key-vault-setup.md)
4. Synapse Workspace → [synapse-workspace-setup.md](synapse-workspace-setup.md)

## Documentation Standards
- All configurations documented
- No secrets committed to Git
- Production-grade settings noted