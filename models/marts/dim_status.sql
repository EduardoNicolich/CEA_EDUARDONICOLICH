with

    int_status as (
        select *
        from {{ ref('int__status') }}
    )

select *
from int_status