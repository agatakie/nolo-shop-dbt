with source as (
    select * from {{ source('raw', 'orders_store') }}
)

select
    order_id,
    customer_id,
    order_date,
    order_value,
    CAST(REPLACE(store_id, 'S', '') as INTEGER) as store_id,
from source