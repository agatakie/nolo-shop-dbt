{{ config(materialized='incremental') }}

with online as (
    select
        order_id,
        customer_id,
        order_date,
        order_value,
        null as store_id,
        'online' as sales_channel
    from {{ ref('stg_orders_online_system__orders_online') }}
    {% if is_incremental() %}
      where order_date > (select max(order_date) from {{ this }})
    {% endif %}
),

store as (
    select
        order_id,
        customer_id,
        order_date,
        order_value,
        store_id,
        'store' as sales_channel
    from {{ ref('stg_pos__orders_store') }}
    {% if is_incremental() %}
      where order_date > (select max(order_date) from {{ this }})
    {% endif %}
)

select * from online
union all
select * from store
