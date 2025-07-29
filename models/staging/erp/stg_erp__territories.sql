with 

source as (

    select * from {{ source('erp', 'sales_salesterritory') }}

),

renamed as (

    select
        cast(territoryid as int) as territory_pk
        , name as territory_name
        , countryregioncode as country_code
        , "group" as continent
        , cast(salesytd as numeric(18,4)) as territory_salesytd
        , cast(saleslastyear as numeric(18,4)) as territory_salesly
        --, cast(costytd as numeric(18,4))
        --, cast(costlastyear as numeric(18,4))
        --, rowguid
        --, modifieddat

    from source

)

select * from renamed