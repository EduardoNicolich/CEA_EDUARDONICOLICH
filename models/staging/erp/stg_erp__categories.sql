with 

source as (

    select * 
    from {{ source('erp', 'production_productcategory') }}

)

, renamed as (

    select
        cast(productcategoryid as int) as category_pk
        , name as category_name
        --rowguid,
        --modifieddate
    from source

)

select * from renamed