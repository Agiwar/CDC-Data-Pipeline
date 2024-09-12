{{
    config(
        materialized="table",
        engine="ReplacingMergeTree()",
        order_by="id",
    ) 
}}

WITH source AS (
    SELECT
        id::UInt32               AS id,
        user_id::UInt32          AS user_id,
        transaction_at::DateTime AS transaction_at,
        amount::Decimal(18, 2)   AS amount
    FROM
        {{ ref("raw_purchase")}}
)
SELECT * FROM source