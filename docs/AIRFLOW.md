# Instructions to run AIRFLOW ELT Orquestration Pipeline

Bronze → Silver → Gold, orchestrated end to end by Airflow:

start_pipeline (success)
extract_sap_orders + sync_retail_transactions run in parallel (both success)
transform_with_dbt — runs dbt build, which built:
silver.stg_sap_sales_orders, silver.stg_retail_transactions (views)
gold.fct_sap_sales_orders, gold.fct_retail_transactions, gold.fct_daily_revenue_summary (tables)

Option A — show it already ran (safest, zero live risk):

docker exec prepal_postgres psql -U admin -d prepal_dwh -c "SELECT * FROM gold.fct_daily_revenue_summary;"
This table is the direct result of an Airflow DAG that extracted from both source systems and ran dbt to unify them — let me show you the DAG and the models that produced it." Then walk through the DAG file and the fct_daily_revenue_summary.sql model.

Option B — trigger it live ("wow" factor):

docker exec prepal_airflow airflow dags trigger prepal_medallion_ingestion
Then check task states with:

docker exec prepal_airflow airflow tasks states-for-dag-run prepal_medallion_ingestion "the run_id printed above"

Option C - Live DAG IN Airflow UI in the Browser

Open localhost:8085 in a browser

Get the password with:

```docker exec prepal_airflow cat /opt/airflow/simple_auth_manager_passwords.json.generated```
