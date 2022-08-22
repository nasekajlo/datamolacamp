--alter session set current_schema=SA_CUSTOMERS;
--GRANT SELECT ON SA_TRANSACTIONS.sa_transactions TO DW_CL; 
GRANT SELECT ON sa_date.t_sa_financial_calendar TO DW_CL;
GRANT SELECT ON SA_LOCATION.t_sa_regions TO DW_CL;
--drop PACKAGE body pkg_etl_cl_sales;

purge recyclebin;

alter session set current_schema=DW_CL;


select * from sa_date.t_sa_financial_calendar,SA_LOCATION.t_sa_regions,SA_TRANSACTIONS.sa_transactions;

select * from SA_LOCATION.t_sa_regions;

CREATE OR REPLACE PACKAGE body pkg_etl_cl_sales
AS  
  PROCEDURE LOAD_CLEAN_SALES
   AS
      CURSOR curs_cl_sales
      IS
         SELECT DISTINCT
                COUNTRY_CITY_CUSTOMER
                ,FIRST_NAME_CUSTOMER
                ,LAST_NAME_CUSTOMER
                , pizza_name
                , pizza_cost
                ,date_id
                ,region_id
           FROM SA_TRANSACTIONS.sa_transactions, SA_DATE.t_sa_financial_calendar, SA_LOCATION.t_sa_regions
           WHERE COUNTRY_CITY_CUSTOMER IS NOT NULL 
           AND FIRST_NAME_CUSTOMER IS NOT NULL
           AND LAST_NAME_CUSTOMER IS NOT NULL
           AND pizza_name IS NOT NULL
           AND pizza_cost IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_sales';
      FOR i IN curs_cl_sales LOOP
         INSERT INTO DW_CL.t_cl_sales( 
                         COUNTRY_CITY_CUSTOMER
                ,FIRST_NAME_CUSTOMER
                ,LAST_NAME_CUSTOMER
                , pizza_name
                , pizza_cost
                ,date_id
                ,region_id)
              VALUES ( i.COUNTRY_CITY_CUSTOMER
                     , i.FIRST_NAME_CUSTOMER
                     , i.LAST_NAME_CUSTOMER
                     , i.pizza_name 
                     , i.pizza_cost
                     , i.date_id
                     , i.region_id);

         EXIT WHEN curs_cl_sales%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_SALES;
END pkg_etl_cl_sales;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_sales.LOAD_CLEAN_SALES;
select * from t_cl_sales;

commit;