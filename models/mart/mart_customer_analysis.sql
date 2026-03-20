{{ config(materialized='table') }}

select
    c.customer_state,
    c.customer_city,
    count(distinct c.customer_unique_id) as total_customers,
    count(distinct o.order_id) as total_orders,
    round(sum(oi.price), 2) as total_revenue,
    round(avg(oi.price), 2) as avg_order_value,
    count(distinct case when order_count > 1 then c.customer_unique_id end) as repeat_customers
from {{ ref('stg_customers') }} c
left join {{ ref('stg_orders') }} o
    on c.customer_id = o.customer_id
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join (
    select
        customer_unique_id,
        count(distinct o2.order_id) as order_count
    from {{ ref('stg_customers') }} c2
    left join {{ ref('stg_orders') }} o2
        on c2.customer_id = o2.customer_id
    where o2.order_status = 'delivered'
    group by 1
) repeat
    on c.customer_unique_id = repeat.customer_unique_id
where o.order_status = 'delivered'
group by 1, 2
order by total_revenue desc