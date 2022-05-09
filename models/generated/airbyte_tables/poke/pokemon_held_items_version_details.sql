{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_held_items_version_details_ab3') }}
select
    _airbyte_held_items_hashid,
    rarity,
    {{ adapter.quote('version') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_version_details_hashid
from {{ ref('pokemon_held_items_version_details_ab3') }}
-- version_details at pokemon/held_items/version_details from {{ ref('pokemon_held_items') }}
where 1 = 1

