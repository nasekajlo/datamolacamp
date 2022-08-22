alter session set current_schema=DW_CL;
drop table t_cl_sales;


Create table t_cl_sales (
FIRST_NAME_CUSTOMER         CHAR(20),
LAST_NAME_CUSTOMER          CHAR(20),
COUNTRY_CITY_CUSTOMER       CHAR(20),
region_id                   int,
date_id                     DATE,
pizza_id                    int,
pizza_name                  VARCHAR2(20)    ,
pizza_cost                  INT   
);

select * from t_cl_sales;
