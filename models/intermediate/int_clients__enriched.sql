with
    customers as (
        select customer_pk, person_fk, store_fk
        from {{ ref('stg_erp__customers') }}
    )
    , persons as (
        select b_e_persons_pk, person_firstname, person_lastname, person_middlename, person_type
        from {{ ref('stg_erp__persons') }}
    )
    , stores as (
        select b_e_stores_pk, store_name
        from {{ ref('stg_erp__stores') }}
    )
    , person_type as (
        select *
        from {{ ref('de_para_person_type') }}
    )
    , joined as (
        select 
        c.customer_pk
        , c.store_fk
        , c.person_fk
        -- businessentityid: usa store_fk se tiver, senão person_fk
        --, coalesce(c.store_fk, c.person_fk) as businessentityid
        -- nome da pessoa
        , case 
            when p.person_firstname is not null and p.person_lastname is not null then 
                p.person_firstname || 
                case when p.person_middlename is not null then ' ' || p.person_middlename else '' end || 
                ' ' || p.person_lastname
            when p.person_firstname is not null then p.person_firstname
            else null
        end as person_name
        , pt.tipo as person_type        
        -- nome da loja
        , s.store_name
        -- nome do cliente
        , case 
            when p.person_type = 'SC' then s.store_name
            else person_name
        end as customer_name
        ---- tipo do cliente
        , case
            when p.person_type = 'SC' then 'Stores'
            else 'Direct Sales'
        end as customer_type
        from customers c
        left join persons p on p.b_e_persons_pk = c.person_fk
        left join stores s on s.b_e_stores_pk = c.store_fk
        left join person_type pt on p.person_type = pt.Codigo
    )
    select *
    from joined
    where trim(person_type) = 'Store Contact' or trim(person_type) = 'Individual'
    

