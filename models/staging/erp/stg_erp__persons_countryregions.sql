with 

source as (

    select * 
    from {{ source('erp', 'person_countryregion') }}

)

, renamed as (

    select
        countryregioncode as country_region_code_pk
        , name as country_region_name
        --modifieddate

    from source

)

select * from renamed