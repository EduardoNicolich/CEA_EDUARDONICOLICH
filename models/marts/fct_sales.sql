with

    fct_sales as (
        select *
        from {{ ref('int_sales_metrics') }}
    )

select *
from fct_sales