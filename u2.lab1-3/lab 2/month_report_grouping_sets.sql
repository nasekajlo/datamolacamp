alter session set current_schema = SA_TRANSACTIONS;

--month pizza orders GROUPING SETS by month
SELECT  EXTRACT(month FROM CUSTOMER_SALE_DATE) as month,GROUPING(EXTRACT(month FROM CUSTOMER_SALE_DATE)) as grouping_month,COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY GROUPING SETS(EXTRACT(month FROM CUSTOMER_SALE_DATE))
HAVING EXTRACT(month FROM CUSTOMER_SALE_DATE) IS NOT NULL
order by EXTRACT(month FROM CUSTOMER_SALE_DATE);