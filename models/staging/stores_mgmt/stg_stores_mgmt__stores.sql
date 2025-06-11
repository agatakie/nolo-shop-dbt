with source as (
    select * from {{ source('raw', 'stores') }}
)

select
    CAST(REPLACE(store_id, 'S', '') as INTEGER) as store_id,
    store_location
from source