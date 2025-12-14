{{ config(
    materialized='incremental',
    unique_key='payment_id'
    )
}}

with source as (
    
    select * from {{ source('raw_dataset','raw_payments') }}

),

renamed as (

    select
        id as payment_id,
        order_id,
        payment_method,
        --`amount` is currently stored in cents, so we convert it to dollars
        amount / 100 as amount

    from source

)

select * from renamed
