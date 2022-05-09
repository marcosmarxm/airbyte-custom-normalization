{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_pokemon_hashid',
        object_to_string('stat'),
        'effort',
        'base_stat',
    ]) }} as _airbyte_stats_hashid,
    tmp.*
from {{ ref('pokemon_stats_ab2') }} tmp
-- stats at pokemon/stats
where 1 = 1

