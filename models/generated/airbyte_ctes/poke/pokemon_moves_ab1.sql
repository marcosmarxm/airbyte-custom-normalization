{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', 'moves') }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract('', unnested_column_value('moves'), ['move'], ['move']) }} as {{ adapter.quote('move') }},
    {{ json_extract_array(unnested_column_value('moves'), ['version_group_details'], ['version_group_details']) }} as version_group_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- moves at pokemon/moves
{{ cross_join_unnest('pokemon', 'moves') }}
where 1 = 1
and moves is not null

