{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_moves_versio__details_version_group_ab3') }}
select
    _airbyte_version_group_details_hashid,
    url,
    {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_version_group_hashid
from {{ ref('pokemon_moves_versio__details_version_group_ab3') }}
-- version_group at pokemon/moves/version_group_details/version_group from {{ ref('pokemon_moves_version_group_details') }}
where 1 = 1

