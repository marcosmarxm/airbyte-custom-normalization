{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', 'abilities') }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract_scalar(unnested_column_value('abilities'), ['slot'], ['slot']) }} as slot,
    {{ json_extract('', unnested_column_value('abilities'), ['ability'], ['ability']) }} as ability,
    {{ json_extract_scalar(unnested_column_value('abilities'), ['is_hidden'], ['is_hidden']) }} as is_hidden,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- abilities at pokemon/abilities
{{ cross_join_unnest('pokemon', 'abilities') }}
where 1 = 1
and abilities is not null

