
select
    c.customer_key,
    c.customer_name,
    c.customer_address,
    c.customer_phone,
    c.account_balance,
    c.market_segment,
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from {{ ref('stg_tpch__customer') }} as c
left join {{ ref('stg_tpch__nation') }} as n
    on c.nation_key = n.nation_key
left join {{ ref('stg_tpch__region') }} as r
    on n.region_key = r.region_key