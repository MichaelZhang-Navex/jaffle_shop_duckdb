with order_payments as (
    select
        o.order_date,
        p.payment_method,
        p.amount
    from {{ ref('stg_orders') }} as o
    left join {{ ref('stg_payments') }} as p
        on o.order_id = p.order_id
    where p.payment_method in ('coupon', 'gift_card')
)

select
    order_date,
    SUM(amount) as amount
from order_payments
group by 1
order by 1
