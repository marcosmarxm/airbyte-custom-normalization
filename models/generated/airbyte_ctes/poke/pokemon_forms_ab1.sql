{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon') }}
{{ unnest_cte(ref('pokemon'), 'pokemon', 'forms') }}
select
    _airbyte_pokemon_hashid,
    {{ json_extract_scalar(unnested_column_value('forms'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(unnested_column_value('forms'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon') }} as table_alias
-- forms at pokemon/forms
{{ cross_join_unnest('pokemon', 'forms') }}
where 1 = 1
and forms is not null

