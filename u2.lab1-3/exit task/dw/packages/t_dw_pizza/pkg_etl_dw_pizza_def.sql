alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_pizza
AS  
   PROCEDURE LOAD_DW_PIZZA;
END pkg_etl_dw_pizza;

--drop package pkg_etl_dw_financial_calendar;