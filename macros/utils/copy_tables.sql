{% macro copy_tables(source_database, source_schema, source_table, target_database, target_schema, target_table) %} 
    {% set source_relation = api.Relation.create(database=source_database, schema=source_schema, identifier=source_table) %}
    {% set target_relation = api.Relation.create(database=target_database, schema=target_schema, identifier=target_table) %}
    {% do adapter.copy_table(source_relation, target_relation, "table") %}
{% endmacro %}


