with 

source as (

    select * 
    from {{ source('erp', 'sales_salesorderdetail') }}

)

, renamed as (

    select
        cast(salesorderid as int) as order_fk
        , cast(salesorderdetailid as int) as order_detail_pk
        , cast(orderqty as int) as order_quantity
        , cast(productid as int) as product_fk
        , cast(specialofferid as int) as special_offer_fk
        , cast(unitprice as numeric(18,4)) as order_unit_price
        , cast(unitpricediscount as numeric(18,2)) as order_price_discount
        --carriertrackingnumber,
        --rowguid,
        --modifieddate

    from source

)

select * from renamed