# Azure SQL Database Setup

## SQL Server Configuration
- Server name: `sqlserver-synapse-medal-dev`
- Authentication: SQL authentication
- Admin login: `sqladmin`
- Admin password: Stored in Key Vault (`sql-admin-password`)
- Location: [Same as other resources]

## Database Configuration
- Database name: `AdventureWorksLT`
- Sample data: AdventureWorksLT (pre-loaded)
- Compute tier: Serverless
- Max vCores: 2
- Auto-pause delay: 60 minutes
- Backup storage: LRS

## Firewall Rules
- Allow Azure services and resources: Enabled

## Source Tables (SalesLT Schema)
1. Customer
2. Product
3. ProductCategory
4. SalesOrderHeader
5. SalesOrderDetail

## Key Vault Secret
- Secret name: `sql-admin-password`
- Contains: SQL admin password

## Cost Optimization
- Serverless tier (pay per use)
- Auto-pause after 60 mins idle
- LRS backup redundancy