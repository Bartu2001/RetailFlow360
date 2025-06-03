{{ config(materialized='view') }}

-- # MODEL: int_sales_enriched
-- # OUR GOAL:
-- # We join the stg_sales_data and stg_inventory_data tables
-- # using 'product_category'.
-- # Each sale is enriched with real-time stock and a low_stock flag.

with sales as (
    select * from {{ ref('stg_sales_data') }}
),
inventory as (
    select * from {{ ref('stg_inventory_data') }}
),
joined as (
    select
        sales.transaction_id,
        sales.customer_id,
        sales.date,
        sales.gender,
        sales.age,
        sales.product_category,
        sales.quantity,
        sales.price_per_unit,
        sales.total_amount,
        inventory.product_id,
        inventory.current_stock,
        case
            when inventory.current_stock < 20 then true
            else false
        end as is_low_stock
    from sales
    left join inventory
      on lower(trim(sales.product_category)) = lower(trim(inventory.product_category))
)
select * from joined
