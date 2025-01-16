WITH SOURCE AS (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    SELECT * FROM {{ ref('raw_payments') }}

),

RENAMED AS (

    SELECT
        ID AS PAYMENT_ID,
        ORDER_ID,
        PAYMENT_METHOD,

        -- `amount` is currently stored in cents, so we convert it to dollars
        AMOUNT / 100 AS AMOUNT

    FROM SOURCE

)

SELECT * FROM RENAMED
