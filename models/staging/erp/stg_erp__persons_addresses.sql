with 

source as (

    select * 
    from {{ source('erp', 'person_address') }}

)

, renamed as (

    select
        cast(addressid as int) as address_pk
        , cast(stateprovinceid as int) as stateprovince_fk
        --, addressline1
        --, addressline2
        , city as address_city
        --, postalcode
        --, spatiallocation
        --, rowguid
        --, modifieddat

    from source

)

select * from renamed