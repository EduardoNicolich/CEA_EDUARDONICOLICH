with 

source as (

    select * 
    from {{ source('erp', 'sales_creditcard') }}

)

, renamed as (

    select
        cast(creditcardid as int) as creditcard_pk,
        cardtype,
        --cardnumber,
        --expmonth,
        --expyear,
        --modifieddate

    from source

)

select * from renamed