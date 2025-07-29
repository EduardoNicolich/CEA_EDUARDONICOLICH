with
    -- importing models
    orders_details as(
        select *
        from {{ ref('stg_erp__orders_details') }}
    )
    , orders as(
        select *
        from {{ ref('stg_erp__orders') }}
    )
    , creditcards as(
        select *
        from {{ ref('stg_erp__creditcards') }}
    )
-- transformation
    , joined as (
        select
            --orders_details.order_detail_pk
            {{ dbt_utils.generate_surrogate_key(['order_detail_pk', 'order_pk']) }} as order_item_sk
            , orders.order_pk as order_fk
            , orders_details.product_fk
            , orders_details.special_offer_fk
            , orders.customer_fk
            , orders.salesperson_fk
            , orders.territory_fk
            , orders.creditcard_fk       
            , orders_details.order_quantity
            , orders_details.order_unit_price
            , orders_details.order_price_discount
            , orders.order_date
            , orders.order_subtotal
            , orders.order_tax_amount
            , orders.order_freight
            , orders.order_totaldue
            , orders.shiptoaddress_fk
            , orders.billtoaddress_fk
            , orders.status
            , creditcards.cardtype
        from orders_details
        left join orders on orders_details.order_fk = orders.order_pk
        left join creditcards on orders.creditcard_fk = creditcards.creditcard_pk
    )
    , metrics as (
        select
            order_item_sk
            , order_fk
            , product_fk
            , special_offer_fk
            , customer_fk
            --, person_fk
            --, store_fk
            , salesperson_fk
            , territory_fk
            --, creditcard_fk
            , shiptoaddress_fk
            , billtoaddress_fk
            , order_date
            , status
            , case
                when cardtype is null then 'Payment without credit card'
                else cardtype
            end as cardtype       
            , order_quantity as qty
            , cast(order_unit_price as numeric(18,4)) as unit_price
            , cast((order_unit_price * order_quantity) as numeric(18,4)) as total_gross
            , cast(order_price_discount as numeric(18,2)) as discount
            , order_unit_price * (1 - order_price_discount) * 
                order_quantity as subtotal
            , cast((subtotal * order_freight / sum(subtotal) over (partition by order_fk)) 
                as numeric(18,4)) as freight_allocated
            , cast((subtotal * order_tax_amount / sum(subtotal) over (partition by order_fk)) 
                as numeric(18,4)) as tax_allocated
            , subtotal + freight_allocated + tax_allocated as total_due
            --, order_subtotal
            --, order_tax_amount
            --, order_freight
            --, order_totaldue
        from joined
    )
select * 
from metrics