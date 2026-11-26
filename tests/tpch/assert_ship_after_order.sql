
select
    lineitem_key,
    days_to_ship
from {{ ref('fct_sales') }}
where days_to_ship < 0