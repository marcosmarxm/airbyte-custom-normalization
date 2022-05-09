{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_held_items_version_details_ab1') }}
select
    _airbyte_held_items_hashid,
    cast(rarity as {{ dbt_utils.type_bigint() }}) as rarity,
    cast({{ adapter.quote('version') }} as {{ type_json() }}) as {{ adapter.quote('version') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_held_items_version_details_ab1') }}
-- version_details at pokemon/held_items/version_details
where 1 = 1

