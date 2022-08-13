alter session set current_schema = SA_TRANSACTIONS;

--month pizza orders by pizza_name ROLLUP
SELECT  EXTRACT(month FROM CUSTOMER_SALE_DATE)as month,GROUPING(EXTRACT(month FROM CUSTOMER_SALE_DATE)) as grouping_month,PIZZA_NAME,GROUPING(PIZZA_NAME) as grouping_name, COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY rollup(EXTRACT(month FROM CUSTOMER_SALE_DATE), PIZZA_NAME)
HAVING EXTRACT(month FROM CUSTOMER_SALE_DATE) IS NOT NULL AND PIZZA_NAME IS NOT NULL
order by EXTRACT(month FROM CUSTOMER_SALE_DATE);

--month pizza orders general ROLLUP
SELECT  EXTRACT(month FROM CUSTOMER_SALE_DATE) as month,GROUPING(EXTRACT(month FROM CUSTOMER_SALE_DATE)) as grouping_month, COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY rollup(EXTRACT(month FROM CUSTOMER_SALE_DATE))
HAVING EXTRACT(month FROM CUSTOMER_SALE_DATE) IS NOT NULL 
order by EXTRACT(month FROM CUSTOMER_SALE_DATE);