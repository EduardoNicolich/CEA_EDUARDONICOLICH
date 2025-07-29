with

    int_salesreasons as (
        select *
        from {{ ref('int__salesreason') }}
    )

select *
from int_salesreasons