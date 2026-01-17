# Data Profiling

## Customer Table (847 rows)

**Key Columns:**
- CustomerID (int, PK, NOT NULL)
- FirstName, LastName (nvarchar, NOT NULL)
- EmailAddress (nvarchar 50, NULL)
- CompanyName (nvarchar 128, NULL)
- ModifiedDate (datetime, NOT NULL)

**Data Quality Notes:**
- Title, MiddleName, Suffix are nullable
- PasswordHash/PasswordSalt present (exclude from analytics)
- rowguid for replication tracking

## Product Table (295 rows)

**Key Columns:**
- ProductID (int, PK, NOT NULL)
- Name (nvarchar 50, NOT NULL)
- ProductNumber (nvarchar 25, NOT NULL)
- StandardCost, ListPrice (money, NOT NULL)
- ProductCategoryID (int, NULL) - FK to ProductCategory
- SellStartDate, SellEndDate (datetime)

**Data Quality Notes:**
- Color, Size, Weight are nullable (not all products have these)
- ThumbNailPhoto (varbinary) - binary data, exclude from transformations
- DiscontinuedDate tracks product lifecycle

## ProductCategory Table (41 rows)
- Simple lookup table
- ProductCategoryID, Name, ParentProductCategoryID
- Hierarchical structure (parent-child relationships)

## SalesOrderHeader Table (32 rows)
- Order-level information
- CustomerID, OrderDate, DueDate, ShipDate
- TotalDue, SubTotal, TaxAmt, Freight

## SalesOrderDetail Table (542 rows)
- Line item level (grain of fact table)
- SalesOrderID, ProductID, OrderQty, UnitPrice
- LineTotal = OrderQty × UnitPrice

## Bronze Layer Strategy
- Full load for all tables (small data size)
- Parquet format
- No transformations (raw copy)

## Silver Layer Transformations Needed
1. Exclude sensitive columns (PasswordHash, PasswordSalt)
2. Add metadata columns (load_timestamp, source_system)
3. Handle nulls in optional fields
4. Convert datetime formats
5. Join Product with ProductCategory

## Gold Layer Design
- Dimension: dim_customer (from Customer)
- Dimension: dim_product (from Product + ProductCategory)
- Dimension: dim_date (generated)
- Fact: fact_sales (from SalesOrderDetail + SalesOrderHeader)