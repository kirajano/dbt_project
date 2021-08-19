-- Test for checking if total amount of orders is less than 0

SELECT
    order_id,
    SUM(amount) as total_amount
FROM {{ ref('stg_payments') }}
GROUP BY order_id
HAVING NOT(total_amount >= 0)