{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_moves_ab3') }}
select
    _airbyte_pokemon_hashid,
    {{ adapter.quote('move') }},
    version_group_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_moves_hashid
from {{ ref('pokemon_moves_ab3') }}
-- moves at pokemon/moves from {{ ref('pokemon') }}
where 1 = 1

