alter session set current_schema = SA_TRANSACTIONS;

SELECT CUSTOMER_SALE_DATE as day,GROUPING(CUSTOMER_SALE_DATE) as grouping_day, COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY rollup(+CUSTOMER_SALE_DATE)
HAVING CUSTOMER_SALE_DATE IS NOT NULL 
order by CUSTOMER_SALE_DATE;
