select
    r_regionkey                             as region_key,
    initcap({{ clean_string('r_name') }})   as region_name,
    {{ clean_string('r_comment') }}         as region_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'region') }}
