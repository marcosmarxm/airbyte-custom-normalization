{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_sprites_ab3') }}
select
    _airbyte_pokemon_hashid,
    back_shiny,
    back_female,
    front_shiny,
    back_default,
    front_female,
    front_default,
    back_shiny_female,
    front_shiny_female,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sprites_hashid
from {{ ref('pokemon_sprites_ab3') }}
-- sprites at pokemon/sprites from {{ ref('pokemon') }}
where 1 = 1

