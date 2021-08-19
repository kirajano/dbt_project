SELECT
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount,
    created

FROM raw.stripe.payment