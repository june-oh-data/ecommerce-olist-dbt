{{ config(materialized='table') }}

select
    coalesce(pc.product_category_name_english, p.product_category_name, 'Unknown') as category,
    count(distinct r.review_id) as total_reviews,
    round(avg(r.review_score), 2) as avg_review_score,
    countif(r.review_score = 5) as five_star_reviews,
    countif(r.review_score = 1) as one_star_reviews,
    round(countif(r.review_score >= 4) / count(distinct r.review_id) * 100, 1) as positive_review_pct
from {{ ref('stg_order_reviews') }} r
left join {{ ref('stg_orders') }} o
    on r.order_id = o.order_id
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
left join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
left join {{ ref('stg_product_category') }} pc
    on p.product_category_name = pc.product_category_name
where o.order_status = 'delivered'
group by 1
order by total_reviews desc