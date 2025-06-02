 -- macros/drop_group.sql
{%- macro drop_rows(table_name, start_date, end_date, field, value) -%}

    {%- set drop_rows_query -%}
        delete from {{ target.schema }}.{{ table_name }} 
        where order_date >= '{{ start_date }}' and  order_date <=  '{{ end_date }}'
            and {{ field }} = '{{ value }}'
    {%- endset -%}
    {% do run_query(drop_rows_query) %}
    
{%- endmacro -%}