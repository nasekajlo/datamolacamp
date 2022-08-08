alter session set current_schema = SA_FACT_SALES;
alter user SA_FACT_SALES quota unlimited on ts_sa_fact_sales_data_01;

create table sa_fact_sales as
select * from SA_SALES.pizza_sales
cross join SA_LOCATION.t_sa_location;