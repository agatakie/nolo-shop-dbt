with source as (
    select * from {{ source('raw', 'order_items_online') }}
)

select
    order_id,
    product_id,
    quantity,
    item_price
from source