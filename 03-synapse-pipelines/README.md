# Synapse Pipelines Documentation

## Overview
Orchestration pipelines for Medallion architecture implementation using Synapse Pipelines (integrated ADF capabilities).

## Components

### Linked Services
- [Linked Services Summary](linked-services/linked-services-summary.md)
- All secrets managed via Key Vault
- 3 linked services: SQL, ADLS, Key Vault

### Bronze Layer
- [Bronze Pipeline Documentation](bronze-ingestion/bronze-pipeline-documentation.md)
- Pipeline: `PL_Bronze_Ingestion_All_Tables`
- Parallel ingestion of 5 tables
- Output: Parquet files in bronze container

### Silver Layer
- Coming next: Synapse Spark notebook transformations

### Orchestration
- Coming next: Master pipeline coordination

## Execution Order
1. Bronze ingestion (Synapse Pipeline)
2. Silver transformations (Synapse Spark)
3. Gold modeling (dbt)

## Key Patterns
- Parameterized pipelines for reusability
- Key Vault integration for security
- Parallel processing for efficiency