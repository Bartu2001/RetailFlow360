{{ config(materialized='view') }}

with source as (
    select * from {{ source('retail_dataset', 'minio_retail_project_source') }}
),
cleaned as (
    select
        lower(trim(Product_ID)) as product_id,
        cast(cast(Current_Stock as float64) as int64) as current_stock,
        lower(trim(Product_Category)) as product_category
    from source
    where Product_ID is not null
)
select * from cleaned
