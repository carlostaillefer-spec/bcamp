select
    c_custkey                               as customer_key,
    {{ clean_string('c_name') }}            as customer_name,
    {{ clean_string('c_address') }}         as customer_address,
    c_nationkey                             as nation_key,
    {{ clean_string('c_phone') }}           as customer_phone,
    cast(c_acctbal as number(12, 2))        as account_balance,
    upper({{ clean_string('c_mktsegment') }}) as market_segment,
    {{ clean_string('c_comment') }}         as customer_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'customer') }}