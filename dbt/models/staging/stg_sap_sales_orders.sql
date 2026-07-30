-- Silver layer: cleaned, typed SAP sales orders. One row per order.

select
    sap_order_id,
    customer_id,
    order_date::timestamp as order_date,
    net_value::numeric(18, 2) as net_value,
    currency,
    ingested_at
from {{ source('bronze_sap', 'sap_sales_orders') }}
where sap_order_id is not null
