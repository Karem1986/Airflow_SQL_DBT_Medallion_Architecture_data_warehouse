-- Silver layer: cleaned, typed retail transactions with a computed line amount.

select
    txn_id,
    store_id,
    product_id,
    quantity,
    unit_price::numeric(18, 2) as unit_price,
    (quantity * unit_price)::numeric(18, 2) as line_amount,
    txn_timestamp,
    ingested_at
from {{ source('bronze_onprem', 'retail_transactions') }}
where txn_id is not null
