
select
    s.supplier_key,
    s.supplier_name,
    s.supplier_address,
    s.supplier_phone,
    s.account_balance,
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from {{ ref('stg_tpch__supplier') }} as s
left join {{ ref('stg_tpch__nation') }} as n
    on s.nation_key = n.nation_key
left join {{ ref('stg_tpch__region') }} as r
    on n.region_key = r.region_key