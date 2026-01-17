# Linked Services Summary

## Created Linked Services

### 1. LS_KeyVault
- **Type:** Azure Key Vault
- **Purpose:** Centralized secrets management
- **Authentication:** Synapse managed identity
- **Secrets stored:**
  - `adls-access-key`
  - `sql-admin-password`
  - `synapse-sql-admin-password`

### 2. LS_AzureSQL_AdventureWorks
- **Type:** Azure SQL Database
- **Purpose:** Source database connection
- **Server:** sqlserver-synapse-medal-dev
- **Database:** AdventureWorksLT
- **Authentication:** SQL authentication via Key Vault
- **Credentials:** Username: sqladmin, Password from Key Vault secret

### 3. LS_ADLS_Medallion
- **Type:** Azure Data Lake Storage Gen2
- **Purpose:** Bronze/Silver/Gold storage
- **Storage account:** adlssynapsemedaldev
- **Authentication:** Account key via Key Vault
- **Containers:** bronze, silver, gold, synapsedefault

## Security Pattern
All credentials stored in Key Vault and referenced via `LS_KeyVault` linked service. No hardcoded secrets in pipeline definitions.