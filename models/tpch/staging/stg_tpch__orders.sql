{{
    config(
        materialized='incremental',
        unique_key='order_key',
        incremental_strategy='merge'
    )
}}

with source as (

    select * from {{ source('tpch', 'orders') }}

    {% if is_incremental() %}
    where o_orderdate >= (select coalesce(max(order_date), '1900-01-01'::date) from {{ this }})
    {% endif %}

)

select
    o_orderkey                              as order_key,
    o_custkey                               as customer_key,
    {{ clean_string('o_orderstatus') }}     as order_status,
    cast(o_totalprice as number(12, 2))     as total_price,
    o_orderdate                             as order_date,
    {{ clean_string('o_orderpriority') }}   as order_priority,
    {{ clean_string('o_clerk') }}           as clerk,
    o_shippriority                          as ship_priority,
    {{ clean_string('o_comment') }}         as order_comment,
    current_timestamp()                     as _loaded_at
from source
