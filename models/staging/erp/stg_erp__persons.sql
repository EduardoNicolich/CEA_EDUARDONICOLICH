with 

source as (

    select * 
    from {{ source('erp', 'person_person') }}

)

, renamed as (

    select
        cast(businessentityid as int) as b_e_persons_pk
        , persontype as person_type
        --, namestyle as person_name
        , title as person_title
        , firstname as person_firstname
        , middlename as person_middlename
        , lastname as person_lastname
        --, suffix as 
        --, emailpromotion as 
        --, additionalcontactinfo as 
        --, demographics as 
        --, rowguid as 
        --, modifieddat as 

    from source

)

select * from renamed