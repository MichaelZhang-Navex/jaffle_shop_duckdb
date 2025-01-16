WITH SOURCE AS (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    SELECT * FROM {{ ref('raw_customers') }}

),

RENAMED AS (

    SELECT
        ID AS CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME

    FROM SOURCE

)

SELECT * FROM RENAMED
