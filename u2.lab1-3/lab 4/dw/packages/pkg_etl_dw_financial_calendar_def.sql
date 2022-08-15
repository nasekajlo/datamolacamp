alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_financial_calendar
AS  
   PROCEDURE LOAD_DW_FINANCIAL_CALENDAR;
END pkg_etl_dw_financial_calendar;

--drop package pkg_etl_dw_financial_calendar;