{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_moves_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        object_to_string(adapter.quote('move')),
        array_to_string('version_group_details'),
    ]) }} as _airbyte_moves_hashid,
    tmp.*
from {{ ref('pokemon_moves_ab2') }} tmp
-- moves at pokemon/moves
where 1 = 1

