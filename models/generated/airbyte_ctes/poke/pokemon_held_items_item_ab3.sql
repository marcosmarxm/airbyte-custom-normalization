{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_poke",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pokemon_held_items_item_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_held_items_hashid',
        'url',
        adapter.quote('name'),
    ]) }} as _airbyte_item_hashid,
    tmp.*
from {{ ref('pokemon_held_items_item_ab2') }} tmp
-- item at pokemon/held_items/item
where 1 = 1

