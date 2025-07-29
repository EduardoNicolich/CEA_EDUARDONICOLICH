with

    int_clients as (
        select *
        from {{ ref('int_clients__enriched') }}
    )

select *
from int_clients