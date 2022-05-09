{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_game_indices_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        object_to_string(adapter.quote('version')),
        'game_index',
    ]) }} as _airbyte_game_indices_hashid,
    tmp.*
from {{ ref('pokemon_game_indices_ab2') }} tmp
-- game_indices at pokemon/game_indices
where 1 = 1

