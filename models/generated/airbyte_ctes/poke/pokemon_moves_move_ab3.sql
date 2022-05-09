{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_moves_move_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_moves_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_move_hashid,
    tmp.*
from {{ ref('pokemon_moves_move_ab2') }} tmp
-- move at pokemon/moves/move
where 1 = 1

