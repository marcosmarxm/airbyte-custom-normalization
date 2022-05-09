{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_moves_versio__ils_move_learn_method_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_version_group_details_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_move_learn_method_hashid,
    tmp.*
from {{ ref('pokemon_moves_versio__ils_move_learn_method_ab2') }} tmp
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method
where 1 = 1

