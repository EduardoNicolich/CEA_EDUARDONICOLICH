with 

source as (

    select * 
    from {{ source('erp', 'sales_salesorderheader') }}

)

, renamed as (

    select
        cast(salesorderid as int) as order_pk
        , cast(orderdate as date) as order_date
        , cast(customerid as int) as customer_fk
        , cast(salespersonid as int) as salesperson_fk
        , cast(territoryid as int) as territory_fk
        , cast(creditcardid as int) as creditcard_fk
        , cast(billtoaddressid as int) as billtoaddress_fk
        , cast(shiptoaddressid as int) as shiptoaddress_fk
        , cast(status as int) as status_fk
        , cast(subtotal as numeric(18,4)) as order_subtotal
        , cast(taxamt as numeric(18,4)) as order_tax_amount
        , cast(freight as numeric(18,4)) as order_freight
        , cast(totaldue as numeric(18,4)) as order_totaldue
        --, revisionnumber      
        --, duedate
        --, shipdate      
        --, onlineorderfla,
        --, purchaseordernmber,
        --, accountnumber,               
        --, shipmethodid,       
        --, creditcardapprvalcode,
        --, currencyrateid
        --, comment
        --, rowguid
        --, modifieddat

    from source

)

select * from renamed