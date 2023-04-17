
{{ config(severity = 'error') }}

--could also separate these out into different tests to return the results of each system
--would want to create this with severity = 'error' if the stg_poh_failures was not filtered out in stg_poh

select * from {{ ref('stg_poh_failures') }}