{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', 'game_indices') }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract('', unnested_column_value('game_indices'), ['version'], ['version']) }} as {{ adapter.quote('version') }},
    {{ json_extract_scalar(unnested_column_value('game_indices'), ['game_index'], ['game_index']) }} as game_index,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- game_indices at pokemon/game_indices
{{ cross_join_unnest('pokemon', 'game_indices') }}
where 1 = 1
and game_indices is not null

