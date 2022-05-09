{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_abilities_ab3') }}
select
    _airbyte_pokemon_hashid,
    slot,
    ability,
    is_hidden,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_abilities_hashid
from {{ ref('pokemon_abilities_ab3') }}
-- abilities at pokemon/abilities from {{ ref('pokemon') }}
where 1 = 1

