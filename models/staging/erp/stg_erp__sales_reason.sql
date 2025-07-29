with 

source as (

    select * 
    from {{ source('erp', 'sales_salesreason') }}

)

, renamed as (

    select
        cast(salesreasonid as int) as sales_reason_pk
        , name as reason_name
        , reasontype as reason_type
        -- , modifieddat

    from source

)

select * from renamed