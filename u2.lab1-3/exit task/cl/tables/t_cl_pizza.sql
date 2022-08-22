alter session set current_schema=DW_CL;
--drop table t_cl_pizza;


Create table t_cl_pizza (
    PIZZA_NAME       VARCHAR (20),
    PIZZA_SIZE      NUMBER,
    PIZZA_COST    NUMBER,
    PIZZA_RANK    NUMBER
);