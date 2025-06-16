{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwirte',
    partition_by = {'field' : 'order_date', 'data_type' : 'date'}
    )
}}

with source as (

    select * from {{ source('raw_dataset','raw_customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name
        ----,email

    from source

)

select * from renamed
