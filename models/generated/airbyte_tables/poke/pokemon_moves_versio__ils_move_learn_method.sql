{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_moves_versio__ils_move_learn_method_ab3') }}
select
    _airbyte_version_group_details_hashid,
    url,
    {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_move_learn_method_hashid
from {{ ref('pokemon_moves_versio__ils_move_learn_method_ab3') }}
-- move_learn_method at pokemon/moves/version_group_details/move_learn_method from {{ ref('pokemon_moves_version_group_details') }}
where 1 = 1

