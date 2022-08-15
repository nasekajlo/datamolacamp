alter session set current_schema=SA_CUSTOMER;
GRANT SELECT ON SA_CUSTOMER.sa_customers TO DW_CL; 

--drop package body pkg_etl_cl_customers;
alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_customers
AS  
  PROCEDURE LOAD_CLEAN_CUSTOMERS
   AS   
      CURSOR curs_cl_customers
      IS
         SELECT DISTINCT 
                  FIRST_NAME_CUSTOMER
                , LAST_NAME_CUSTOMER 
                , COUNTRY_CITY_CUSTOMER
                , ADRESS_CUSTOMER
                , EMAIL
                , PHONE_CUSTOMER
                ,AGE
                ,IS_ACTIVE
                ,CUSTOMER_SALE_DATE
           FROM SA_CUSTOMER.SA_CUSTOMERS
           WHERE FIRST_NAME_CUSTOMER IS NOT NULL 
           AND LAST_NAME_CUSTOMER IS NOT NULL
           AND COUNTRY_CITY_CUSTOMER IS NOT NULL
           AND ADRESS_CUSTOMER IS NOT NULL
           AND EMAIL IS NOT NULL
           AND PHONE_CUSTOMER IS NOT NULL
           AND AGE IS NOT NULL
           AND IS_ACTIVE IS NOT NULL
           AND CUSTOMER_SALE_DATE IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_customers';
      FOR i IN curs_cl_customers LOOP
         INSERT INTO DW_CL.t_cl_customers( 
                         FIRST_NAME_CUSTOMER
                       , LAST_NAME_CUSTOMER 
                       , COUNTRY_CITY_CUSTOMER
                       , ADRESS_CUSTOMER
                       , EMAIL
                       , PHONE_CUSTOMER
                       , AGE
                       , IS_ACTIVE
                       , CUSTOMER_SALE_DATE)
              VALUES ( i.FIRST_NAME_CUSTOMER
                     , i.LAST_NAME_CUSTOMER 
                     , i.COUNTRY_CITY_CUSTOMER
                     , i.ADRESS_CUSTOMER
                     , i.EMAIL
                     , i.PHONE_CUSTOMER
                     , i.AGE
                     , i.IS_ACTIVE
                     , i.CUSTOMER_SALE_DATE);

         EXIT WHEN curs_cl_customers%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_CUSTOMERS;
END pkg_etl_cl_customers;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_customers.LOAD_CLEAN_CUSTOMERS;
select * from t_cl_customers;

commit;