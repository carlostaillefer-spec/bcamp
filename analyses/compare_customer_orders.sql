{{ audit_helper.compare_relations(
    a_relation=ref('customer_orders_legacy'),
    b_relation=ref('fct_customer_orders'),
    primary_key='order_id'
) }}