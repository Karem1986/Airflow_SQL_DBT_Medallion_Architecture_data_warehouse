{#
    By default dbt concatenates the profile's target schema with the
    custom schema (e.g. "public_silver"). This project names its schemas
    to match the Medallion layers directly (silver, gold), so we override
    the default macro to use the custom schema name as-is.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
