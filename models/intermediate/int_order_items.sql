{{ config(materialized='incremental') }}

with order_items_all as (
    select order_id, product_id, quantity, item_price
    from {{ ref('stg_orders_online_system__order_items_online') }}
    
    union all

    select order_id, product_id, quantity, item_price
    from {{ ref('stg_pos__order_items_store') }}
),

{% if is_incremental() %}
max_existing as (
    select max(order_date) as max_order_date
    from {{ ref('int_orders') }}
),
{% endif %}

items_with_date as (
    select
        i.order_id,
        i.product_id,
        i.quantity,
        i.item_price
    from order_items_all i
    join {{ ref('int_orders') }} o using (order_id)
    
    {% if is_incremental() %}
    join max_existing m
        on o.order_date > m.max_order_date
    {% endif %}
)

select * from items_with_date