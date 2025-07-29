with 

source as (

    select * 
    from {{ source('erp', 'sales_salesorderheadersalesreason') }}

)

, renamed as (

    select
        cast(salesorderid as int) as sales_order_pk
        , cast(salesreasonid as int) as sales_reason_fk
        --, modifieddate

    from source

)

select * from renamed