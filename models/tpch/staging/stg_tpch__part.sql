select
    p_partkey                               as part_key,
    {{ clean_string('p_name') }}            as part_name,
    {{ clean_string('p_mfgr') }}            as manufacturer,
    {{ clean_string('p_brand') }}           as brand,
    {{ clean_string('p_type') }}            as part_type,
    p_size                                  as part_size,
    {{ clean_string('p_container') }}       as container,
    cast(p_retailprice as number(12, 2))    as retail_price,
    {{ clean_string('p_comment') }}         as part_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'part') }}
