-- fact_sales
{{
  config(
    materialized='table'
  )
}}

SELECT index, 
  `Order ID` AS order_id, 
  Date AS date,
  Status AS status,
  {{ dbt_utils.generate_surrogate_key([
				'SKU'
			]) }} as product_id,
  {{ dbt_utils.generate_surrogate_key([
				'Fulfilment', 
				'`fulfilled-by`'
			])}} AS fulfillment_id,
  qty,
  amount,
FROM
    {{ source('bronze', 'amazon_sale_report') }}
