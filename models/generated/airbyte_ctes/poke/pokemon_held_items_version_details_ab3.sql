{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_held_items_version_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_held_items_hashid',
        'rarity',
        object_to_string(adapter.quote('version')),
    ]) }} as _airbyte_version_details_hashid,
    tmp.*
from {{ ref('pokemon_held_items_version_details_ab2') }} tmp
-- version_details at pokemon/held_items/version_details
where 1 = 1

