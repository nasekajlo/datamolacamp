alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_pizza
AS  
   PROCEDURE LOAD_CLEAN_PIZZA;
END pkg_etl_cl_pizza;

--drop package pkg_etl_cl_customers;