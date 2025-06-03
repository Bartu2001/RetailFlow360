{{ config(materialized='view') }}

-- # MODEL: int_marketplace_vs_sales
-- # OUR GOAL:
-- # Sales and marketplace data are compared by product category.

with sales as (
    select lower(trim(product_category)) as product_category, quantity
    from {{ ref('stg_sales_data') }}
),
marketplace as (
    select lower(trim(product_category)) as product_category, quantity
    from {{ ref('stg_marketplace_data') }}
),
aggregated_sales as (
    select product_category, sum(quantity) as total_sales_quantity
    from sales group by product_category
),
aggregated_marketplace as (
    select product_category, sum(quantity) as total_marketplace_quantity
    from marketplace group by product_category
),
joined as (
    select
        coalesce(s.product_category, m.product_category) as product_category,
        s.total_sales_quantity,
        m.total_marketplace_quantity
    from aggregated_sales s
    full outer join aggregated_marketplace m
      on s.product_category = m.product_category
)
select * from joined
