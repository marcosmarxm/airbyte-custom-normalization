{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_types_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        'slot',
        object_to_string(adapter.quote('type')),
    ]) }} as _airbyte_types_hashid,
    tmp.*
from {{ ref('pokemon_types_ab2') }} tmp
-- types at pokemon/types
where 1 = 1

