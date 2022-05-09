{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_moves_version_group_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_moves_hashid',
        object_to_string('version_group'),
        'level_learned_at',
        object_to_string('move_learn_method'),
    ]) }} as _airbyte_version_group_details_hashid,
    tmp.*
from {{ ref('pokemon_moves_version_group_details_ab2') }} tmp
-- version_group_details at pokemon/moves/version_group_details
where 1 = 1

