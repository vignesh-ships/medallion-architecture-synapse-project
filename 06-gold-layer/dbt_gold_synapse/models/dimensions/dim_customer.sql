{{
  config(
    materialized='table',
    schema='gold'
  )
}}

WITH silver_customer AS (
    SELECT *
    FROM silver_ext.customer
)

SELECT
    ROW_NUMBER() OVER (ORDER BY CustomerID) AS customer_key,
    CustomerID AS customer_business_key,
    CONCAT(FirstName, ' ', LastName) AS customer_name,
    FirstName AS first_name,
    LastName AS last_name,
    EmailAddress AS email,
    CompanyName AS company_name,
    Phone AS phone,
    load_timestamp,
    source_system
FROM silver_customer