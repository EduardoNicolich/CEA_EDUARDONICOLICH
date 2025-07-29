with 

source as (

    select * 
    from {{ source('erp', 'sales_store') }}

)

, renamed as (

    select
        cast(businessentityid as int) as b_e_stores_pk
        , cast(salespersonid as int) as salesperson_fk
        , name as store_name
        --demographics,
        --rowguid,
        --modifieddate

    from source

)

select * from renamed