with

    int_bridge_reasons as (
        select *
        from {{ ref('int_bridge_salesreasons') }}
    )

select *
from int_bridge_reasons