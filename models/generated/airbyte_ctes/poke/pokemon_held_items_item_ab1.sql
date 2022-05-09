{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('pokemon_held_items') }}
select
    _airbyte_held_items_hashid,
    {{ json_extract_scalar('item', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('item', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pokemon_held_items') }} as table_alias
-- item at pokemon/held_items/item
where 1 = 1
and item is not null

