{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon_moves') }}
select
    _airbyte_moves_hashid,
    {{ json_extract_scalar(adapter.quote('move'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(adapter.quote('move'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_moves') }} as table_alias
-- move at pokemon/moves/move
where 1 = 1
and {{ adapter.quote('move') }} is not null

