{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_stats_stat_ab3') }}
select
    _airbyte_stats_hashid,
    url,
    {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_stat_hashid
from {{ ref('pokemon_stats_stat_ab3') }}
-- stat at pokemon/stats/stat from {{ ref('pokemon_stats') }}
where 1 = 1

