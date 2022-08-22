alter session set current_schema=DW_DATA;


SELECT DISTINCT pizza_name, FIRST_VALUE(pizza_cost) 
        OVER (PARTITION BY pizza_name ORDER BY pizza_cost DESC)
        AS highest_pizza_cost
FROM t_dw_pizza
WHERE pizza_name LIKE 'tasty'
ORDER BY pizza_name;


---------------------------
SELECT DISTINCT pizza_name, LAST_VALUE(pizza_cost) 
        OVER (PARTITION BY pizza_name ORDER BY pizza_cost ASC)
        AS lowest_pizza_cost
FROM t_dw_pizza
WHERE pizza_name LIKE 'tasty'
ORDER BY pizza_name;


alter session set current_schema=DW_DATA;

SELECT pizza_id,pizza_name, pizza_cost, rank() OVER(ORDER BY pizza_cost ASC) AS pizza_cost_rank
FROM t_dw_pizza;

SELECT pizza_id,pizza_name, pizza_cost, dense_rank() OVER(ORDER BY pizza_cost ASC) AS pizza_cost_rank
FROM t_dw_pizza;


SELECT pizza_id, pizza_name, pizza_cost, 
    ROW_NUMBER() OVER(ORDER BY pizza_cost ASC) AS pizza_cost_num
FROM t_dw_pizza;

---------------------------

SELECT SUM(pizza_cost) AS total_pizza_cost
FROM t_dw_pizza;

SELECT trunc(AVG(pizza_cost)) AS average_pizza_cost
FROM t_dw_pizza;

SELECT trunc(MIN(pizza_cost)) AS min_pizza_cost
FROM t_dw_pizza;

SELECT trunc(MAX(pizza_cost)) AS max_pizza_cost
FROM t_dw_pizza;