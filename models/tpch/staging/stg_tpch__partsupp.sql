select
    {{ surrogate_key(['ps_partkey', 'ps_suppkey']) }} as partsupp_key,
    ps_partkey                              as part_key,
    ps_suppkey                              as supplier_key,
    ps_availqty                             as available_quantity,
    cast(ps_supplycost as number(12, 2))    as supply_cost,
    {{ clean_string('ps_comment') }}        as partsupp_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'partsupp') }}
