{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_abilities_ability_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_abilities_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_ability_hashid,
    tmp.*
from {{ ref('pokemon_abilities_ability_ab2') }} tmp
-- ability at pokemon/abilities/ability
where 1 = 1

