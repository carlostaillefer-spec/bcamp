
select
    supplier_key,
    supplier_name,
    supplier_address,
    supplier_phone,
    account_balance,
    nation_name,
    region_name
from {{ ref('int_suppliers_enriched') }}