alter session set current_schema = SA_PIZZA;


SELECT TRUNC(TRANSACTION_DATE, 'MM') as month,DECODE(GROUPING(pizzeria_name), 1, 'All theaters', pizzeria_name) AS pizzeria_name, 
    COUNT(*) AS transactions, SUM(transaction_num) AS pizzas
FROM sa_sales.pizza_sales, sa_pizzerias.sa_pizzeria
GROUP BY TRUNC(transaction_date, 'MM'), GROUPING SETS(
    (pizzeria_name),
    (TRUNC(TRANSACTION_DATE, 'MM')))
ORDER BY month,SUM(transaction_num) DESC;

SELECT TRUNC(transaction_date, 'MM') AS month, DECODE(GROUPING(pizza_name), 1, 'All movies', pizza_name) AS pizza_name, 
    COUNT(*) AS pizza_order, SUM(transaction_num) AS pizzas
FROM sa_sales.pizza_sales, sa_pizza.t_sa_pizza
GROUP BY GROUPING SETS(
    (TRUNC(transaction_date, 'MM'), pizza_name),
    (TRUNC(transaction_date, 'MM')))
ORDER BY month, SUM(transaction_num) DESC;
