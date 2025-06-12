{{ config(materialized='incremental') }}

with online as (
    select
        order_id,
        customer_id,
        to_number(REPLACE(order_date, '-', '')) as order_date_key,
        order_value,
        null as store_id,
        'online' as sales_channel
    from {{ ref('stg_orders_online_system__orders_online') }}
),

store as (
    select
        order_id,
        customer_id,
        to_number(REPLACE(order_date, '-', '')) as order_date_key,
        order_value,
        store_id,
        'store' as sales_channel
    from {{ ref('stg_pos__orders_store') }}
),

unioned as (
    select * from online
    union all
    select * from store
),

{% if is_incremental() %}
max_existing as (
    select max(order_date_key) as max_key from {{ this }}
),
{% endif %}

filtered as (
    select *
    from unioned
    {% if is_incremental() %}
    where order_date_key > (select max_key from max_existing)
    {% endif %}
)

select * from filtered