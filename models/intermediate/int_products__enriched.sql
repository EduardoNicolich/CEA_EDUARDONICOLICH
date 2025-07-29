with
    -- importing models
    products as(
        select *
        from {{ ref('stg_erp__products') }}
    )
    , categories as(
        select *
        from {{ ref('stg_erp__categories') }}
    )
    , subcategories as(
        select *
        from {{ ref('stg_erp__subcategories') }}
    )
    , models as(
        select *
        from {{ ref('stg_erp__models') }}
    )
    , joined as (
        select 
            product_pk
            , product_name
            , category_name as category
            , subcategory_name as subcategory
            , model_name as model
        from products
        left join subcategories on products.product_subcategory_fk = subcategories.subcategory_pk
        left join categories on subcategories.category_fk = categories.category_pk
        left join models on products.product_model_fk = models.model_pk
    )
    select *
    from joined