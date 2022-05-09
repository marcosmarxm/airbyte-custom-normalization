{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_moves_versio__details_version_group_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_version_group_details_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_version_group_hashid,
    tmp.*
from {{ ref('pokemon_moves_versio__details_version_group_ab2') }} tmp
-- version_group at pokemon/moves/version_group_details/version_group
where 1 = 1

