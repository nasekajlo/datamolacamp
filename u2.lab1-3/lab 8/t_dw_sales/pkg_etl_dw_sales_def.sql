alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_sales
AS  
   PROCEDURE LOAD_DW_SALES;
END pkg_etl_dw_sales;

--drop package pkg_etl_dw_financial_calendar;