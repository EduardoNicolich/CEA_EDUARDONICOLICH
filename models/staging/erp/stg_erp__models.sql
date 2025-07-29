with 

source as (

    select * 
    from {{ source('erp', 'production_productmodel') }}

)

, renamed as (

    select
        cast(productmodelid as int) as model_pk
        , name as model_name
        --catalogdescription,
        --instructions,
        --rowguid,
        --modifieddate
    from source

)

select * from renamed