alter session set current_schema = SA_PIZZA;

SELECT transaction_date, PIZZA_NAME, COUNT(*) AS pizza_order, SUM(transaction_num) AS pizzas
FROM sa_sales.pizza_sales, sa_pizza.t_sa_pizza
GROUP BY CUBE(transaction_date, pizza_name)
HAVING transaction_date IS NOT NULL AND PIZZA_NAME IS NOT NULL 
ORDER BY transaction_date, pizzas DESC;

SELECT transaction_date, pizzeria_name, COUNT(*) AS orders, SUM(transaction_num) AS pizzas
FROM sa_sales.pizza_sales,SA_PIZZERIAS.sa_pizzeria
GROUP BY CUBE(transaction_date,pizzeria_name)
HAVING transaction_date IS NOT NULL AND pizza_name IS NOT NULL 
ORDER BY transaction_date, pizzas DESC;