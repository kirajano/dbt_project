with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

merge_payments as (
    SELECT
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        payments.amount
    from orders
    join payments using (order_id)
),

final as (
    SELECT
        merge_payments.*,
        customers.first_name,
        customers.last_name
    FROM merge_payments
    JOIN customers using (customer_id)
)

select * from final