-- Gold layer: SAP sales order fact, ready for Power BI.

select
    sap_order_id,
    customer_id,
    order_date,
    net_value,
    currency,
    'SAP' as source_system
from {{ ref('stg_sap_sales_orders') }}
