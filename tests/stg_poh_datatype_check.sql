
{{ config(severity = 'warn') }}

--could also separate these out into different tests to return the results of each system
--would want to create this with severity = 'error' if the stg_poh_failures was not filtered out in stg_poh

with trycast as (
	select
        cdp_unique_key
		,try_cast(quantity_of_eaches as number(24,2)) as quantity_of_eaches
		,try_cast(unit_price as number(24,4)) as unit_price
		,try_cast(extended_price as number(24,4)) as extended_price
		,try_cast(order_quantity as number(24,2)) as order_quantity
		,try_cast(po_date as date) as po_date
	from {{ source('ghx', 'poh') }}
)

select * 
from trycast 
where 
	quantity_of_eaches is null
	or unit_price is null
	or extended_price is null
	or order_quantity is null
	or po_date is null