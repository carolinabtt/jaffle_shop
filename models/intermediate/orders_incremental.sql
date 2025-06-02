{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite',
    partition_by = { 'field' : 'order_date', 'data_type' : 'date', 'copy_partitions' : true },
    cluster_by = 'order_id',
    require_partition_filter= true
) }}  


with orders as (
    select * 
    from {{ ref('stg_orders') }}
    where order_date between '{{ var("start_date") }}' and '{{ var("end_date") }}'
)
select * from orders





