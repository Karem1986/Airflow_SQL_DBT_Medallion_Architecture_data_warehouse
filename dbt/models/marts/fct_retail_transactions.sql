-- Gold layer: retail transaction line fact, ready for Power BI.

select
    txn_id,
    store_id,
    product_id,
    quantity,
    unit_price,
    line_amount,
    txn_timestamp,
    'ON_PREM_WMS' as source_system
from {{ ref('stg_retail_transactions') }}
