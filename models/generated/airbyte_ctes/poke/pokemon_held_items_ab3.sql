{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_held_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        object_to_string('item'),
        array_to_string('version_details'),
    ]) }} as _airbyte_held_items_hashid,
    tmp.*
from {{ ref('pokemon_held_items_ab2') }} tmp
-- held_items at pokemon/held_items
where 1 = 1

