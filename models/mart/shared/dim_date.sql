{{ config(materialized='table') }}

with date_spine as (
    select
        dateadd(day, row_number() over (order by 1), '2022-01-01') as date_day
    from table(generator(rowcount => 5000))
),

dim_date as (
    select
        date_day,
        to_number(to_char(date_day, 'YYYYMMDD')) as date_key,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(quarter from date_day) as quarter,
        extract(week from date_day) as week,
        case when extract(dow from date_day) in (6, 0) then true else false end as is_weekend
    from date_spine
)

select * from dim_date