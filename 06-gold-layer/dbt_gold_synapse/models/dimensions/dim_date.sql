{{
  config(
    materialized='table',
    schema='gold'
  )
}}

WITH date_range AS (
    SELECT TOP 1096
        DATEADD(day, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1, '2008-01-01') AS date_day
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

SELECT
    ROW_NUMBER() OVER (ORDER BY date_day) AS date_key,
    date_day,
    YEAR(date_day) AS year,
    MONTH(date_day) AS month,
    DAY(date_day) AS day,
    DATEPART(quarter, date_day) AS quarter,
    DATENAME(month, date_day) AS month_name,
    DATENAME(weekday, date_day) AS day_name,
    DATEPART(weekday, date_day) AS day_of_week,
    DATEPART(dayofyear, date_day) AS day_of_year,
    CASE WHEN DATEPART(weekday, date_day) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend
FROM date_range
WHERE date_day <= '2010-12-31'