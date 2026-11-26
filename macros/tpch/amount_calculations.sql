{% macro net_amount(extended_price, discount) -%}
    round({{ extended_price }} * (1 - {{ discount }}), 2)
{%- endmacro %}

{% macro gross_amount(extended_price, discount, tax) -%}
    round({{ extended_price }} * (1 - {{ discount }}) * (1 + {{ tax }}), 2)
{%- endmacro %}

{% macro date_key(date_column) -%}
    to_number(to_char({{ date_column }}, 'YYYYMMDD'))
{%- endmacro %}
