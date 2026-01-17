# Synapse Notebook: silver_transformation_generic
# Parameters: source_table, target_folder

# Cell 1: Parameters (marked as parameter cell)
source_table = "customer"
target_folder = "customer"

print(f"Processing: {source_table} → {target_folder}")

# Cell 2: Storage configuration
from pyspark.sql.functions import current_timestamp, lit

storage_account = "adlssynapsemedaldev"
container_bronze = "bronze"
container_silver = "silver"

bronze_path = f"abfss://{container_bronze}@{storage_account}.dfs.core.windows.net/{source_table}/"
silver_path = f"abfss://{container_silver}@{storage_account}.dfs.core.windows.net/{target_folder}/"

print(f"Bronze: {bronze_path}")
print(f"Silver: {silver_path}")

# Cell 3: Read Bronze
df_bronze = spark.read.parquet(bronze_path)
print(f"Bronze records: {df_bronze.count()}")

# Cell 4: Transform
df_silver = df_bronze \
    .withColumn("load_timestamp", current_timestamp()) \
    .withColumn("source_system", lit("AdventureWorksLT"))

if source_table == "customer":
    df_silver = df_silver.drop("PasswordHash", "PasswordSalt")

print(f"Silver records: {df_silver.count()}")

# Cell 5: Write Delta
df_silver.write \
    .format("delta") \
    .mode("overwrite") \
    .option("overwriteSchema", "true") \
    .save(silver_path)

print(f"✅ Successfully written to {silver_path}")