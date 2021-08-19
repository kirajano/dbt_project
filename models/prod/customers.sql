/* {{
    config(
        materialized="table"
    )
}} */

with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('fct_orders') }}
),

/* payments as (

    select * from {{ ref('stg_payments') }}
), */


customer_orders AS (

    SELECT
    customer_id,
    min(order_date) AS first_order_date,
    max(order_date) AS most_recent_order_date,
    count(order_id) AS number_of_orders,
    sum(amount) AS lft_value

    FROM orders
    --JOIN payments using (order_id)

GROUP BY customer_id
),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lft_value

    from customers

    left join customer_orders using (customer_id)
)

select * from final