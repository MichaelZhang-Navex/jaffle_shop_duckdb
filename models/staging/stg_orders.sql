WITH SOURCE AS (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    SELECT * FROM {{ ref('raw_orders') }}

),

RENAMED AS (

    SELECT
        ID AS ORDER_ID,
        USER_ID AS CUSTOMER_ID,
        ORDER_DATE,
        STATUS

    FROM SOURCE

)

SELECT * FROM RENAMED
