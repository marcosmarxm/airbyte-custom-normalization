{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_abilities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        'slot',
        object_to_string('ability'),
        boolean_to_string('is_hidden'),
    ]) }} as _airbyte_abilities_hashid,
    tmp.*
from {{ ref('pokemon_abilities_ab2') }} tmp
-- abilities at pokemon/abilities
where 1 = 1

