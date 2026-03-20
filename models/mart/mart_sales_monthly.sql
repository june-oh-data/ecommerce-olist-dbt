{{ config(materialized='table') }}

select
    date_trunc(o.order_purchase_timestamp, month) as order_month,
    count(distinct o.order_id) as total_orders,
    count(distinct o.customer_id) as total_customers,
    round(sum(oi.price), 2) as total_revenue,
    round(sum(oi.freight_value), 2) as total_freight,
    round(avg(oi.price), 2) as avg_order_value
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by 1
order by 1