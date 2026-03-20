{{ config(materialized='table') }}

select
    coalesce(pc.product_category_name_english, p.product_category_name, 'Unknown') as category,
    count(distinct o.order_id) as total_orders,
    count(distinct oi.product_id) as total_products,
    round(sum(oi.price), 2) as total_revenue,
    round(avg(oi.price), 2) as avg_price,
    round(avg(r.review_score), 2) as avg_review_score
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
left join {{ ref('stg_product_category') }} pc
    on p.product_category_name = pc.product_category_name
left join {{ ref('stg_order_reviews') }} r
    on o.order_id = r.order_id
where o.order_status = 'delivered'
group by 1
order by total_revenue desc