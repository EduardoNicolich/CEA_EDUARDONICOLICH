with

    salesreasons as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )

select *
from salesreasons
