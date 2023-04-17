--can also configure this as a test, so that if the test fails, it won't run the downstream object stg_poh. See tests > stg_poh_datatype_check.sql

{{
    config(
        materialized='table',
        database = 'tdunlap_ghx',
        schema = 'data_acq'
    )
}}


with poh as (
    select * from {{ source('ghx', 'poh') }}
),

trycast as (
	select
        cdp_unique_key
		,try_cast(quantity_of_eaches as number(24,2)) as quantity_of_eaches
		,try_cast(unit_price as number(24,4)) as unit_price
		,try_cast(extended_price as number(24,4)) as extended_price
		,try_cast(order_quantity as number(24,2)) as order_quantity
		,try_cast(po_date as date) as po_date
	from poh
)

select poh.*
from trycast tc
join poh on tc.cdp_unique_key = poh.cdp_unique_key
where 
	tc.quantity_of_eaches is null
	or tc.unit_price is null
	or tc.extended_price is null
	or tc.order_quantity is null
	or tc.po_date is null