{{ config(
    materialized='incremental',
    unique_key='customer_id'
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
