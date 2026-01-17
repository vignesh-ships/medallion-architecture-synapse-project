# Synapse Workspace Setup

## Workspace Configuration
- Name: `synapse-medallion-dev`
- Region: [Same as other resources]
- Managed resource group: Auto-generated
- Primary storage: `adlssynapsemedaldev` / `synapsedefault`
- SQL admin login: `sqladmin`
- SQL admin password: Stored in Key Vault (`synapse-sql-admin-password`)

## Network Configuration
- Public endpoint enabled
- Storage access: Workspace managed identity has Storage Blob Data Contributor role

## Spark Pool Configuration
- Name: `spmeddev`
- Node size: Small (4 vCores, 32 GB Memory)
- Node size family: Memory Optimized
- Autoscale: Enabled (Min: 3, Max: 6 nodes)
- Auto-pause: Enabled (15 minutes idle)
- Apache Spark version: 3.4+
- Session level packages: Enabled
- Intelligent cache: 50%

## Access URLs
- Synapse Studio: https://web.azuresynapse.net
- Workspace URL: https://[workspace-name].dev.azuresynapse.net

## Spark Pool Usage
- Bronze → Silver transformations
- PySpark notebooks
- Distributed data processing