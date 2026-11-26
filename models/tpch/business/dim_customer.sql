
select
    customer_key,
    customer_name,
    customer_address,
    customer_phone,
    account_balance,
    market_segment,
    nation_name,
    region_name
from {{ ref('int_customers_enriched') }}