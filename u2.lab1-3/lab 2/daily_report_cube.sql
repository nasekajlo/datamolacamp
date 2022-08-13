alter session set current_schema = SA_TRANSACTIONS;

--daily pizza orders by pizza_name CUBE
SELECT  CUSTOMER_SALE_DATE,GROUPING(CUSTOMER_SALE_DATE) as grouping_day, PIZZA_NAME, GROUPING(PIZZA_NAME) as grouping_name,COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY CUBE(CUSTOMER_SALE_DATE, PIZZA_NAME)
HAVING CUSTOMER_SALE_DATE IS NOT NULL AND PIZZA_NAME IS NOT NULL 
ORDER BY CUSTOMER_SALE_DATE, PIZZA_NAME DESC;


-- daily report for the country CUBE
SELECT  CUSTOMER_SALE_DATE,COUNTRY_CITY_CUSTOMER,COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY CUBE(CUSTOMER_SALE_DATE,COUNTRY_CITY_CUSTOMER)
HAVING CUSTOMER_SALE_DATE IS NOT NULL
ORDER BY CUSTOMER_SALE_DATE,COUNTRY_CITY_CUSTOMER DESC;

-- daily report for the pizza_size CUBE
SELECT  CUSTOMER_SALE_DATE,PIZZA_SIZE,COUNT(*) AS pizza_order
FROM sa_transactions
GROUP BY CUBE(CUSTOMER_SALE_DATE,PIZZA_SIZE)
HAVING CUSTOMER_SALE_DATE IS NOT NULL
ORDER BY CUSTOMER_SALE_DATE,PIZZA_SIZE DESC;

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
