alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_customer
AS  
   PROCEDURE LOAD_DW_CUSTOMER;
END pkg_etl_dw_customer;

--drop package pkg_etl_dw_financial_calendar;