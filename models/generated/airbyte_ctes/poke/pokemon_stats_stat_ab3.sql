{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_stats_stat_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_stats_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_stat_hashid,
    tmp.*
from {{ ref('pokemon_stats_stat_ab2') }} tmp
-- stat at pokemon/stats/stat
where 1 = 1

