{{
  config(
    materialized='table',
    schema='gold'
  )
}}

WITH silver_product AS (
    SELECT *
    FROM silver_ext.product
),

silver_category AS (
    SELECT *
    FROM silver_ext.product_category
)

SELECT
    ROW_NUMBER() OVER (ORDER BY p.ProductID) AS product_key,
    p.ProductID AS product_business_key,
    p.Name AS product_name,
    p.ProductNumber AS product_number,
    p.Color AS color,
    p.StandardCost AS standard_cost,
    p.ListPrice AS list_price,
    p.Size AS size,
    p.Weight AS weight,
    c.Name AS category_name,
    c.ProductCategoryID AS category_id,
    p.load_timestamp,
    p.source_system
FROM silver_product p
LEFT JOIN silver_category c ON p.ProductCategoryID = c.ProductCategoryID