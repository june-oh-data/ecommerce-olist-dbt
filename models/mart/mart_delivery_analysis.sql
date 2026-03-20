{{ config(materialized='table') }}

select
    c.customer_state,
    count(distinct o.order_id) as total_orders,
    round(avg(
        timestamp_diff(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp,
            day)
    ), 1) as avg_delivery_days,
    round(avg(
        timestamp_diff(
            o.order_estimated_delivery_date,
            o.order_purchase_timestamp,
            day)
    ), 1) as avg_estimated_days,
    countif(
        o.order_delivered_customer_date > o.order_estimated_delivery_date
    ) as late_deliveries,
    round(countif(
        o.order_delivered_customer_date > o.order_estimated_delivery_date
    ) / count(distinct o.order_id) * 100, 1) as late_delivery_rate_pct
from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
where o.order_status = 'delivered'
    and o.order_delivered_customer_date is not null
group by 1
order by late_delivery_rate_pct desc