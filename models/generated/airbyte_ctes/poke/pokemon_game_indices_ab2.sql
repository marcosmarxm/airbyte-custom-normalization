{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_game_indices_ab1') }}
select
    _airbyte_pokemon_hashid,
    cast({{ adapter.quote('version') }} as {{ type_json() }}) as {{ adapter.quote('version') }},
    cast(game_index as {{ dbt_utils.type_bigint() }}) as game_index,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_game_indices_ab1') }}
-- game_indices at pokemon/game_indices
where 1 = 1

