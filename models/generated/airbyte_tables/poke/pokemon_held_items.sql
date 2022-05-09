{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_held_items_ab3') }}
select
    _airbyte_pokemon_hashid,
    item,
    version_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_held_items_hashid
from {{ ref('pokemon_held_items_ab3') }}
-- held_items at pokemon/held_items from {{ ref('pokemon') }}
where 1 = 1

