-- Gold layer: unifies the SAP (cloud ERP) and on-premises (WMS) revenue streams
-- into a single daily grain, so Power BI reports one number instead of two
-- disagreeing ones per source system.

with sap_daily as (

    select
        date_trunc('day', order_date)::date as revenue_date,
        'SAP' as source_system,
        sum(net_value) as total_revenue,
        count(*) as transaction_count
    from {{ ref('stg_sap_sales_orders') }}
    group by 1

),

retail_daily as (

    select
        date_trunc('day', txn_timestamp)::date as revenue_date,
        'ON_PREM_WMS' as source_system,
        sum(line_amount) as total_revenue,
        count(*) as transaction_count
    from {{ ref('stg_retail_transactions') }}
    group by 1

)

select * from sap_daily
union all
select * from retail_daily
order by revenue_date, source_system
