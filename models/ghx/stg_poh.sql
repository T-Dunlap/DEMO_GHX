{{
    config(
        materialized='ephemeral',
        database = 'tdunlap_ghx',
        schema = 'data_acq'
    )
}}

with poh as (
    select * from {{ source('ghx', 'poh') }}
),

failures as (
    select cdp_unique_key from {{ ref('stg_poh_failures') }}
)

select 
poh.*
from poh
left join failures on failures.cdp_unique_key = poh.cdp_unique_key
where failures.cdp_unique_key is null 
