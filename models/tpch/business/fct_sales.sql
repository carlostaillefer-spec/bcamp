
select
    lineitem_key,
    order_key,
    line_number,

    
    customer_key,
    supplier_key,
    part_key,
    {{ date_key('order_date') }}    as order_date_key,
    {{ date_key('ship_date') }}     as ship_date_key,

    
    order_status,
    order_priority,
    ship_mode,
    return_flag,
    line_status,

    
    quantity,
    extended_price,
    discount,
    tax,
    net_amount,
    gross_amount,
    total_supply_cost,
    margin,
    days_to_ship,
    is_late_delivery
from {{ ref('int_lineitem_enriched') }}