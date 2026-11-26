{{
    config(
        materialized='incremental',
        unique_key=['order_key', 'line_number'],
        incremental_strategy='merge'
    )
}}

with source as (

    select * from {{ source('tpch', 'lineitem') }}

    {% if is_incremental() %}
    where l_shipdate >= (select coalesce(max(ship_date), '1900-01-01'::date) from {{ this }})
    {% endif %}

)

select
    {{ surrogate_key(['l_orderkey', 'l_linenumber']) }} as lineitem_key,
    l_orderkey                              as order_key,
    l_linenumber                            as line_number,
    l_partkey                               as part_key,
    l_suppkey                               as supplier_key,
    cast(l_quantity as number(12, 2))       as quantity,
    cast(l_extendedprice as number(12, 2))  as extended_price,
    cast(l_discount as number(4, 2))        as discount,
    cast(l_tax as number(4, 2))             as tax,
    {{ clean_string('l_returnflag') }}      as return_flag,
    {{ clean_string('l_linestatus') }}      as line_status,
    l_shipdate                              as ship_date,
    l_commitdate                            as commit_date,
    l_receiptdate                           as receipt_date,
    {{ clean_string('l_shipinstruct') }}    as ship_instructions,
    {{ clean_string('l_shipmode') }}        as ship_mode,
    {{ clean_string('l_comment') }}         as lineitem_comment,
    current_timestamp()                     as _loaded_at
from source
