{{ config(
    materialized='view', 
    unique_key='order_id'
) }}    

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (

    select * from {{ ref('stg_orders') }}

    where order_date between '{{ var("start_date") }}' and '{{ var("end_date") }}'

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_payments as (

    select
        order_id,

        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
        {% endfor -%}

        sum(amount) as total_amount

    from payments

    group by 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,

        {% for payment_method in payment_methods -%}

        order_payments.{{ payment_method }}_amount,

        {% endfor -%}

        order_payments.total_amount as amount

        --This adds the last build time per row 
        ,CURRENT_TIMESTAMP as build_time

        --This adds the build source of the last build (full/incremental)
        ,{% if is_incremental() %}
            'incremental'
        {% else %}
            'full'
        {% endif %} as build_type

    from orders

    left join order_payments using (order_id)

)

select * from final
            
where order_date between '{{ var("start_date") }}' and '{{ var("end_date") }}'
--and order_id not in (select order_id from {{ ref('orders') }} )
