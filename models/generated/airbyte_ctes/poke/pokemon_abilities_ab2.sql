{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_abilities_ab1') }}
select
    _airbyte_pokemon_hashid,
    cast(slot as {{ dbt_utils.type_bigint() }}) as slot,
    cast(ability as {{ type_json() }}) as ability,
    {{ cast_to_boolean('is_hidden') }} as is_hidden,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_abilities_ab1') }}
-- abilities at pokemon/abilities
where 1 = 1

