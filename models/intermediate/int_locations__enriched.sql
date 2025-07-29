with
    -- importing models
    addresses as(
        select *
        from {{ ref('stg_erp__persons_addresses') }}
    )
    , countriregions as(
        select *
        from {{ ref('stg_erp__persons_countryregions') }}
    )
    , stateprovinces as(
        select *
        from {{ ref('stg_erp__persons_stateprovinces') }}
    )
    , territories as(
        select *
        from {{ ref('stg_erp__territories') }}
    )
    , joined as (
        select
            address_pk
            , address_city
            , state_province_code_fk as stateprovince_code
            , state_province_name
            , territory_name
            , country_code
            , country_region_name as country_name
            , continent
        from addresses
        left join stateprovinces on stateprovinces.stateprovince_pk = addresses.stateprovince_fk        
        left join territories on territories.territory_pk = stateprovinces.territory_fk
        left join countriregions on stateprovinces.country_region_code_fk = countriregions.country_region_code_pk
    )
    select *
    from joined
