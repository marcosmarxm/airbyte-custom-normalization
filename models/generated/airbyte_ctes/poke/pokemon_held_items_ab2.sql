{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_held_items_ab1') }}
select
    _airbyte_pokemon_hashid,
    cast(item as {{ type_json() }}) as item,
    version_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_held_items_ab1') }}
-- held_items at pokemon/held_items
where 1 = 1

