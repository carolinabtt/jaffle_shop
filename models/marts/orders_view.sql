{{ config(
    materialized='view', 
    unique_key='order_id'
) }}    


select * from  {{ ref('orders') }}  
where status = 'completed'

