WITH sales AS
(
    SELECT 
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price','quantity') }} AS calculated_gross_amount,
        gross_amount,
        payment_method
    from 
        {{ ref('bronze_sales') }}
),

products AS
(
    SELECT 
        product_sk,
        category
    from 
        {{ ref('bronze_product') }}

),

customer AS 
(
    SELECT 
        customer_sk,
        gender
    from 
        {{ ref('bronze_customer') }}
),

joined_query AS (
select 
    sales.sales_id,
    sales.gross_amount,
    sales.payment_method,
    products.category,
    customer.gender
from 
    sales
JOIN 
    products ON sales.product_sk = products.product_sk
JOIN 
    customer ON sales.customer_sk = customer.customer_sk
)

SELECT 
    category,
    gender,
    SUM(gross_amount) AS total_sales
FROM 
    joined_query
GROUP BY 
    category,
    gender
ORDER BY
    total_sales DESC
