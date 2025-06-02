{{ config(
    materialized='ephemeral',
    unique_key='customer_id'
    ) 
}}  

with orders as (
    select * from {{ ref('stg_orders') }}
    where order_date between '{{ var("start_date") }}' and '{{ var("end_date") }}'

)
select * from orders
