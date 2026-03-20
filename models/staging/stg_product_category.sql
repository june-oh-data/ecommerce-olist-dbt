select
    string_field_0 as product_category_name,
    string_field_1 as product_category_name_english
from {{ source('ecommerce_olist', 'product_category_name_translation') }}