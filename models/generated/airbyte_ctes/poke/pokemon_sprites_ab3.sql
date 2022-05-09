{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_sprites_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        'back_shiny',
        'back_female',
        'front_shiny',
        'back_default',
        'front_female',
        'front_default',
        'back_shiny_female',
        'front_shiny_female',
    ]) }} as _airbyte_sprites_hashid,
    tmp.*
from {{ ref('pokemon_sprites_ab2') }} tmp
-- sprites at pokemon/sprites
where 1 = 1

