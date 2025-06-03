{{ config(materialized='view') }}

with source as (
    select * from {{ source('retail_dataset', 'sales_data') }}
),
renamed as (
    select
        transaction_ID as transaction_id,
        date,
        quantity,
        customer_ID as customer_id,
        gender,
        age,
        lower(trim(product_category)) as product_category,
        price_per_unit,
        total_amount
    from source
)
select * from renamed
