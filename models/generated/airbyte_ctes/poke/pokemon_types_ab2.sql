{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pokemon_types_ab1') }}
select
    _airbyte_pokemon_hashid,
    cast(slot as {{ dbt_utils.type_bigint() }}) as slot,
    cast({{ adapter.quote('type') }} as {{ type_json() }}) as {{ adapter.quote('type') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_types_ab1') }}
-- types at pokemon/types
where 1 = 1

