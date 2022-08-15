--alter session set current_schema=SA_CUSTOMERS;
--GRANT SELECT ON SA_TRANSACTIONS.sa_transactions TO DW_CL; 

alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body DW_CL.pkg_etl_cl_sales
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
                , CUSTOMER_SALE_DATE
           FROM SA_TRANSACTIONS.sa_transactions
           WHERE COUNTRY_CITY_CUSTOMER IS NOT NULL 
           AND FIRST_NAME_CUSTOMER IS NOT NULL
           AND LAST_NAME_CUSTOMER IS NOT NULL
           AND pizza_name IS NOT NULL
           AND pizza_cost IS NOT NULL
           AND CUSTOMER_SALE_DATE IS NOT NULl;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_sales';
      FOR i IN curs_cl_sales LOOP
         INSERT INTO DW_CL.t_cl_sales( 
                         COUNTRY_CITY_CUSTOMER
                ,FIRST_NAME_CUSTOMER
                ,LAST_NAME_CUSTOMER
                , pizza_name
                , pizza_cost
                , CUSTOMER_SALE_DATE)
              VALUES ( i.COUNTRY_CITY_CUSTOMER
                     , i.FIRST_NAME_CUSTOMER
                     , i.LAST_NAME_CUSTOMER
                     , i.pizza_name 
                     , i.pizza_cost
                     , i.CUSTOMER_SALE_DATE);

         EXIT WHEN curs_cl_sales%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_SALES;
END pkg_etl_cl_sales;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_orders.LOAD_CLEAN_ORDERS;
select * from t_cl_orders;

commit;