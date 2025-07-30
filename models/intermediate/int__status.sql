with

    seed_status as (
        select
            codigo as status_pk
            , titulo as status_name
        from {{ ref('status_de_para') }}
    )

select *
from seed_status