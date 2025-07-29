with 

source as (

    select * 
    from {{ source('erp', 'person_stateprovince') }}

)

, renamed as (

    select
        cast(stateprovinceid as int) as stateprovince_pk
        , cast(territoryid as int) as territory_fk
        , stateprovincecode as state_province_code_fk
        , countryregioncode as country_region_code_fk
        --, isonlystateprovinceflag
        , name as state_province_name
        --rowguid,
        --modifieddate

    from source

)

select * from renamed