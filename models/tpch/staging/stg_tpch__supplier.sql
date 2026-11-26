select
    s_suppkey                               as supplier_key,
    {{ clean_string('s_name') }}            as supplier_name,
    {{ clean_string('s_address') }}         as supplier_address,
    s_nationkey                             as nation_key,
    {{ clean_string('s_phone') }}           as supplier_phone,
    cast(s_acctbal as number(12, 2))        as account_balance,
    {{ clean_string('s_comment') }}         as supplier_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'supplier') }}
