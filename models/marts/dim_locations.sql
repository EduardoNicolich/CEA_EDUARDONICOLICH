with

    int_locations as (
        select *
        from {{ ref('int_locations__enriched') }}
    )

select *
from int_locations