import pandas 

def model(dbt, session):
    dbt.config(materialized = "table")
    # DataFrame representing an upstream model
    upstream_model = dbt.ref("stg_orders")

    # DataFrame representing an upstream source
    # upstream_source = dbt.source("upstream_source_name", "raw_orders")

    return upstream_model