with source as (
    select * from {{ source('raw', 'orders_online') }}
)

select
    order_id,
    customer_id,
    order_date,
    order_value
from source