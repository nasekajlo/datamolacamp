alter session set current_schema = SA_TRANSACTIONS;

SELECT  CUSTOMER_SALE_DATE, COUNT(*) AS pizza_order
FROM SA_TRANSACTIONS.sa_transactions
where CUSTOMER_SALE_DATE between to_date('05.04.20', 'DD/MM/YY') AND to_date('10.04.20', 'DD/MM/YY')
GROUP BY (CUSTOMER_SALE_DATE) 
HAVING CUSTOMER_SALE_DATE IS NOT NULL
ORDER BY CUSTOMER_SALE_DATE asc;

select count (*),sum(pizza_cost) as total_revenue  from sa_transactions 
where CUSTOMER_SALE_DATE between to_date('01.04.20', 'DD/MM/YY') AND to_date('30.04.20', 'DD/MM/YY');