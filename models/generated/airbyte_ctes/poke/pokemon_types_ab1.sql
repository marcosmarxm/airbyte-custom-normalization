{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', adapter.quote('types')) }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract_scalar(unnested_column_value(adapter.quote('types')), ['slot'], ['slot']) }} as slot,
    {{ json_extract('', unnested_column_value(adapter.quote('types')), ['type'], ['type']) }} as {{ adapter.quote('type') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- types at pokemon/types
{{ cross_join_unnest('pokemon', adapter.quote('types')) }}
where 1 = 1
and {{ adapter.quote('types') }} is not null

