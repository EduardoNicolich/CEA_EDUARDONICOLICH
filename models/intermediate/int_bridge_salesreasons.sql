with

    bridge_reasons as (
        select 
            --orders_details.order_detail_pk
            {{ dbt_utils.generate_surrogate_key(['sales_order_pk', 'sales_reason_fk']) }} as bridge_reasons_sk
            , sales_order_pk
            , sales_reason_fk
        from {{ ref('stg_erp__sales_order_header_reasons') }}
    )

select *
from bridge_reasons