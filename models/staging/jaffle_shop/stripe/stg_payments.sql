/* USE WITHOUT CTE if need to streamline to customers directly */

WITH payments as ( 
    SELECT
        orderid as order_id,
        status,
        amount / 100 as amount  --stored in cents, converting to dollars
    
    FROM raw.stripe.payment
)

SELECT
    order_id,
    sum(CASE WHEN status = 'success' THEN amount END) as amount
FROM payments
GROUP BY order_id