alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_sales
AS  
   PROCEDURE LOAD_CLEAN_SALES;
END pkg_etl_cl_sales;