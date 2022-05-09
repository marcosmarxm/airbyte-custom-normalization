{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon_held_items') }}
{{ unnest_cte(ref('pokemon_held_items'), 'held_items', 'version_details') }}
select
    _airbyte_held_items_hashid,
    {{ json_extract_scalar(unnested_column_value('version_details'), ['rarity'], ['rarity']) }} as rarity,
    {{ json_extract('', unnested_column_value('version_details'), ['version'], ['version']) }} as {{ adapter.quote('version') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_held_items') }} as table_alias
-- version_details at pokemon/held_items/version_details
{{ cross_join_unnest('held_items', 'version_details') }}
where 1 = 1
and version_details is not null

