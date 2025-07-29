with 

source as (

    select * 
    from {{ source('erp', 'production_product') }}

)

, renamed as (

    select
        cast(productid as int) as product_pk
        , name as product_name
        --productnumber,
        --makeflag,
        --finishedgoodsflag,
        --color,
        --safetystocklevel,
        --reorderpoint,
        --standardcost,
        --listprice,
        --size,
        --sizeunitmeasurecode,
        --weightunitmeasurecode,
        --weight,
        --daystomanufacture,
        --productline,
        --class,
        --style,
        , productsubcategoryid as product_subcategory_fk
        , productmodelid as product_model_fk
        --sellstartdate,
        --sellenddate,
        --discontinueddate,
        --rowguid,
        --modifieddate




    from source

)

select * from renamed