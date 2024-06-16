# DuckDB Wrapper for Supabase

The DuckDB wrapper allows you to read parquet files stored in an S3 bucket directly from your Supabase project using DuckDB. This document outlines the setup instructions and usage examples for integrating the DuckDB wrapper into your Supabase project.

## Setup Instructions

1. Ensure that the `wrappers` extension is installed on your database:

```sql
CREATE EXTENSION IF NOT EXISTS wrappers WITH SCHEMA extensions;
```

2. Create the foreign data wrapper for DuckDB:

```sql
CREATE FOREIGN DATA WRAPPER duckdb_wrapper
  HANDLER duckdb_fdw_handler
  VALIDATOR duckdb_fdw_validator;
```

3. Create a server for the DuckDB FDW:

```sql
CREATE SERVER duckdb_server
  FOREIGN DATA WRAPPER duckdb_wrapper
  OPTIONS (
    dbname 'path/to/your/duckdb_file.duckdb'
  );
```

4. Create a foreign table to read parquet files from S3:

```sql
CREATE FOREIGN TABLE duckdb_parquet_table (
  -- Define your table schema here
)
  SERVER duckdb_server
  OPTIONS (
    filename 's3://your-bucket/your-file.parquet',
    access_key_id 'your_access_key_id',
    secret_access_key 'your_secret_access_key',
    region 'your_aws_region'
  );
```

## Usage Examples

After setting up the DuckDB wrapper, you can query your parquet files stored in S3 as if they were local tables in your Supabase project. Here's an example query:

```sql
SELECT *
FROM duckdb_parquet_table
WHERE condition = 'value';
```

This query will read data from the specified parquet file in S3, leveraging DuckDB's efficient columnar storage and query execution capabilities.

## Notes

- Ensure that the AWS credentials provided have the necessary permissions to read from the specified S3 bucket.
- The path to the DuckDB file (`dbname` option) should be accessible by the database server.
- The `filename` option in the foreign table creation specifies the path to the parquet file in S3.

For more information on DuckDB and its features, visit the [DuckDB documentation](https://duckdb.org/docs).
