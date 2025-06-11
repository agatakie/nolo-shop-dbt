{{ config(materialized='incremental') }}

with order_items_all as (
    select order_id, product_id, quantity, item_price
    from {{ ref('stg_orders_online_system__order_items_online') }}
    
    union all

    select order_id, product_id, quantity, item_price
    from {{ ref('stg_pos__order_items_store') }}
),

items_with_date as (
    select
        i.order_id,
        i.product_id,
        i.quantity,
        i.item_price
    from order_items_all i
    join {{ ref('int_orders') }} o using (order_id)
    
    {% if is_incremental() %}
      where o.order_date > (select max(order_date) from {{ this }})
    {% endif %}
)

select * from items_with_date