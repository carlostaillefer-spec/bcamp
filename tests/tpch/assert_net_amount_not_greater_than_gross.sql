-- Test singular: el importe neto nunca puede superar al bruto (los impuestos no son negativos).
-- El test falla si esta consulta devuelve alguna fila.
select
    lineitem_key,
    net_amount,
    gross_amount
from {{ ref('fct_sales') }}
where net_amount > gross_amount