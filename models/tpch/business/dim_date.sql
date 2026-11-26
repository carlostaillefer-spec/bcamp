
{% set start_date = '1992-01-01' %}
{% set end_date = '1998-12-31' %}

with days as (
    select
        dateadd(
            day,
            row_number() over (order by seq4()) - 1,
            '{{ start_date }}'::date
        ) as date_day
    from table(generator(rowcount => 3000))
)

select
    {{ date_key('date_day') }}          as date_key,
    date_day                            as full_date,
    year(date_day)                      as year,
    quarter(date_day)                   as quarter,
    month(date_day)                     as month,
    monthname(date_day)                 as month_name,
    day(date_day)                       as day_of_month,
    dayofweekiso(date_day)              as day_of_week,
    dayname(date_day)                   as day_name,
    dayofweekiso(date_day) in (6, 7)    as is_weekend
from days
where date_day <= '{{ end_date }}'::date