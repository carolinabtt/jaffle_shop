{{ config(
    materialized='table',
    partition_by = {'field' : 'order_date', 'data_type' : 'date'}
    )
}}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        cast(concat(substr(cast(order_date as string),1,4), substr(cast(order_date as string),6,2), 
            substr(cast(order_date as string),9,2)) as int64) as pk_anyomesdia,
        status

    from source

)

select * from renamed
