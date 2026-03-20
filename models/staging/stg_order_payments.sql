select
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
from {{ source('ecommerce_olist', 'olist_order_payments') }}