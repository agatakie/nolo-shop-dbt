with source as (
    select * from {{ source('raw', 'customers') }}
)

select
    customer_id,
    email,
    city
from source