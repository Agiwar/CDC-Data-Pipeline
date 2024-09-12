{{
    config(
        materialized="table",
        engine="AggregatingMergeTree()",
        order_by="user_id",
    )
}}

WITH purchase_main AS (
    SELECT
        ID,
        AccountID,
        TransactionTime,
        TotalAmount,
        StoreID,
        PayType,
        PurchaseType
    FROM
        {{ source("ods", "PurchaseMain") }}
    WHERE
        PayType < 4
        AND PurchaseStatus in (1, 4, 7)
        AND PurchaseType in (1, 3, 5)
),
user_first_purchase AS (
    SELECT
        AccountID                     AS user_id,
        min(ID)                       AS first_purchase_id,
        min(TransactionTime)          AS first_transaction_at,
        countState(ID)                AS num_of_transaction,
        sum(TotalAmount)              AS total_amount,
        argMinState(StoreID, ID)      AS store_id,
        argMinState(PayType, ID)      AS pay_type,
        argMinState(PurchaseType, ID) AS purchase_type
    FROM
        purchase_main
    GROUP BY
        AccountID
)
SELECT
    user_id,
    min(first_purchase_id)         AS first_purchase_id,
    min(first_transaction_at)      AS first_transaction_at,
    countMerge(num_of_transaction) AS num_of_transaction,
    sum(total_amount)              AS total_amount,
    argMinMerge(store_id)          AS store_id,
    argMinMerge(pay_type)          AS pay_type,
    argMinMerge(purchase_type)     AS purchase_type
FROM
    user_first_purchase
GROUP BY
    user_id