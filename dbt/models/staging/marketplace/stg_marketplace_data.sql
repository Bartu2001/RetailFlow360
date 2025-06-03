{{ config(materialized='view') }}

with source as (
    select * from {{ source('retail_dataset', 'marketplace_data') }}
),
renamed as (
    select
        transaction_id,
        lower(trim(product_category)) as product_category,
        quantity,
        total_amount
    from source
)
select * from renamed
