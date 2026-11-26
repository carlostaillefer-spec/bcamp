select
    n_nationkey                             as nation_key,
    initcap({{ clean_string('n_name') }})   as nation_name,
    n_regionkey                             as region_key,
    {{ clean_string('n_comment') }}         as nation_comment,
    current_timestamp()                     as _loaded_at
from {{ source('tpch', 'nation') }}