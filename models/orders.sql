{% set payment_methods = [
    'credit_card',
     'coupon',
     'bank_transfer',
     'gift_card'
    ] %}

WITH ORDERS AS (

    SELECT * FROM {{ ref('stg_orders') }}

),

PAYMENTS AS (

    SELECT * FROM {{ ref('stg_payments') }}

),

ORDER_PAYMENTS AS (

    SELECT
        ORDER_ID,

        {% for payment_method in payment_methods -%}
            sum(
                CASE
                    WHEN
                        PAYMENT_METHOD = '{{ payment_method }}'
                        THEN AMOUNT ELSE
                        0
                END
            )
                AS {{ payment_method }}_amount,
        {% endfor -%}

        sum(AMOUNT) AS TOTAL_AMOUNT

    FROM PAYMENTS

    GROUP BY ORDER_ID

),

FINAL AS (

    SELECT
        ORDERS.ORDER_ID,
        ORDERS.CUSTOMER_ID,
        ORDERS.ORDER_DATE,
        ORDERS.STATUS,

        {% for payment_method in payment_methods -%}

            ORDER_PAYMENTS.{{ payment_method }}_amount,

        {% endfor -%}

        ORDER_PAYMENTS.TOTAL_AMOUNT AS AMOUNT

    FROM ORDERS


    LEFT JOIN ORDER_PAYMENTS
        ON ORDERS.ORDER_ID = ORDER_PAYMENTS.ORDER_ID

)

SELECT * FROM FINAL
