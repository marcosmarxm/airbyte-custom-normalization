{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "poke",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pokemon_abilities_ability_ab3') }}
select
    _airbyte_abilities_hashid,
    url,
    {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ability_hashid
from {{ ref('pokemon_abilities_ability_ab3') }}
-- ability at pokemon/abilities/ability from {{ ref('pokemon_abilities') }}
where 1 = 1

