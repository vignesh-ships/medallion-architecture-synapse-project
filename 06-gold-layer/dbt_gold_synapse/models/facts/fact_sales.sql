{{
  config(
    materialized='table',
    schema='gold'
  )
}}

WITH silver_order_detail AS (
    SELECT * FROM silver_ext.sales_order_detail
),

silver_order_header AS (
    SELECT * FROM silver_ext.sales_order_header
),

dim_customer AS (
    SELECT customer_key, customer_business_key
    FROM {{ ref('dim_customer') }}
),

dim_product AS (
    SELECT product_key, product_business_key
    FROM {{ ref('dim_product') }}
),

dim_date AS (
    SELECT date_key, date_day
    FROM {{ ref('dim_date') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY d.SalesOrderID, d.SalesOrderDetailID) AS sales_key,
    dc.customer_key,
    dp.product_key,
    dd.date_key,
    d.SalesOrderID AS order_id,
    d.SalesOrderDetailID AS order_line_id,
    d.OrderQty AS quantity,
    d.UnitPrice AS unit_price,
    d.UnitPriceDiscount AS discount,
    d.LineTotal AS line_total,
    h.SubTotal AS order_subtotal,
    h.TaxAmt AS tax_amount,
    h.Freight AS freight,
    h.TotalDue AS order_total,
    d.load_timestamp,
    d.source_system
FROM silver_order_detail d
INNER JOIN silver_order_header h ON d.SalesOrderID = h.SalesOrderID
LEFT JOIN dim_customer dc ON h.CustomerID = dc.customer_business_key
LEFT JOIN dim_product dp ON d.ProductID = dp.product_business_key
LEFT JOIN dim_date dd ON CAST(h.OrderDate AS DATE) = dd.date_day