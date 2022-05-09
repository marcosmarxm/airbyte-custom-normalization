{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_poke",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('name'),
        array_to_string('forms'),
        array_to_string('moves'),
        adapter.quote('order'),
        array_to_string('stats'),
        array_to_string(adapter.quote('types')),
        'height',
        'weight',
        object_to_string('species'),
        object_to_string('sprites'),
        array_to_string('abilities'),
        array_to_string('held_items'),
        boolean_to_string(adapter.quote('is_default ')),
        array_to_string('game_indices'),
        'base_experience',
        'location_area_encounters',
    ]) }} as _airbyte_pokemon_hashid,
    tmp.*
from {{ ref('pokemon_ab2') }} tmp
-- pokemon
where 1 = 1

