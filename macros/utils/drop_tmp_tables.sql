{% macro drop_tmp_tables(schemas=[], prefix='tmp_') %}
    {%- set adapter = target.adapter -%}
    {% do log("Scanning for temporary tables to drop...", info=True) %}

    {% for schema in schemas %}
        {% set relation_list = dbt_utils.get_relations_by_prefix(schema, prefix) %}
        {% for rel in relation_list %}
            {% do log("Dropping table: " ~ rel.identifier ~ " from schema: " ~ schema, info=True) %}
            {% do run_query('DROP TABLE IF EXISTS ' ~ rel) %}
        {% endfor %}
    {% endfor %}

    {% do log("Temporary table cleanup complete.", info=True) %}
{% endmacro %}
