{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_held_items_version_details_version_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_version_details_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_version_hashid,
    tmp.*
from {{ ref('pokemon_held_items_version_details_version_ab2') }} tmp
-- version at pokemon/held_items/version_details/version
where 1 = 1

