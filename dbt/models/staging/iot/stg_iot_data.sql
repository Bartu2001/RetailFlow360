{{ config(materialized='view') }}

with source as (
    select * from {{ source('iot_dataset', 'iot_data') }}
),
renamed as (
    select
        lower(trim(device_id)) as device_id,
        timestamp,
        temperature,
        humidity
    from source
    where device_id is not null
)
select * from renamed
