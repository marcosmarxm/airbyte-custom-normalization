{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon_held_items_version_details') }}
select
    _airbyte_version_details_hashid,
    {{ json_extract_scalar(adapter.quote('version'), ['url'], ['url']) }} as url,
    {{ json_extract_scalar(adapter.quote('version'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_held_items_version_details') }} as table_alias
-- version at pokemon/held_items/version_details/version
where 1 = 1
and {{ adapter.quote('version') }} is not null

