{#
  Granularidad: una fila por línea de pedido.
  Combina lineitem + orders + partsupp y calcula las métricas de negocio
  con las macros net_amount y gross_amount.
#}
with lineitem as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

partsupp as (
    select * from {{ ref('stg_tpch__partsupp') }}
),

joined as (
    select
        l.lineitem_key,
        l.order_key,
        l.line_number,
        o.customer_key,
        l.part_key,
        l.supplier_key,
        o.order_date,
        o.order_status,
        o.order_priority,
        l.ship_date,
        l.commit_date,
        l.receipt_date,
        l.ship_mode,
        l.return_flag,
        l.line_status,
        l.quantity,
        l.extended_price,
        l.discount,
        l.tax,
        {{ net_amount('l.extended_price', 'l.discount') }}            as net_amount,
        {{ gross_amount('l.extended_price', 'l.discount', 'l.tax') }} as gross_amount,
        round(ps.supply_cost * l.quantity, 2)                         as total_supply_cost
    from lineitem as l
    inner join orders as o
        on l.order_key = o.order_key
    left join partsupp as ps
        on l.part_key = ps.part_key
       and l.supplier_key = ps.supplier_key
)

select
    *,
    net_amount - total_supply_cost                   as margin,
    datediff(day, order_date, ship_date)             as days_to_ship,
    receipt_date > commit_date                       as is_late_delivery
from joined