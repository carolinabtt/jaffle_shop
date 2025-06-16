{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwirte',
    partition_by = {'field' : 'order_date', 'data_type' : 'date'}
    )
}}

with source as (

    select * from {{ source('raw_dataset','raw_orders') }}

),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        cast(concat(substr(cast(order_date as string),1,4), substr(cast(order_date as string),6,2), 
            substr(cast(order_date as string),9,2)) as int64) as order_yyyymmdd,
        status,
        current_timestamp() as updated_at

    from source

)

select * from renamed
