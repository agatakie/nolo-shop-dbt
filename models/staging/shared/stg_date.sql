with source as (
    select * from {{ source('raw', 'date_dim') }}
)

select
    cast(date_id as integer) as date_id,
    date,
    week,
    month,
    year
from source