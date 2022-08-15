alter session set current_schema=DW_CL;
--drop table t_cl_sales;


Create table t_cl_sales (
order_id                      INT              not null,
customer_id                   INT              not null,
pizza_id                      INT              not null,
region_id                     INT              not null,
date_id                       DATE             not null,
pizza_name                  VARCHAR2(15)     not null,
pizza_cost                   FLOAT            not null,
order_status                  VARCHAR2(10)     not null
);