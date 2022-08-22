alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_customers TO DW_DATA;

alter session set current_schema=DW_DATA;

select * FROM DW_CL.t_cl_customers;
select * from DW_DATA.T_DW_CUSTOMERS;

DROP PACKAGE body pkg_etl_dw_customer;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_customer
AS  
  PROCEDURE LOAD_DW_CUSTOMER
   AS
     BEGIN
     MERGE INTO DW_DATA.T_DW_CUSTOMERS A
     USING ( SELECT 
                   FIRST_NAME_CUSTOMER  ,
                   LAST_NAME_CUSTOMER        ,
                   COUNTRY_CITY_CUSTOMER     ,
                   ADRESS_CUSTOMER           ,
                   EMAIL                     ,
                   PHONE_CUSTOMER                ,
                   AGE                           ,
                   IS_ACTIVE                     ,
                   CUSTOMER_SALE_DATE    
             FROM DW_CL.T_CL_CUSTOMERS) B
             ON (a.PHONE_CUSTOMER = b.PHONE_CUSTOMER) 
             WHEN MATCHED THEN 
                UPDATE SET a.CUSTOMER_SALE_DATE = b.CUSTOMER_SALE_DATE
             WHEN NOT MATCHED THEN 
                INSERT (a.CUSTOMER_ID,a.FIRST_NAME_CUSTOMER, a.LAST_NAME_CUSTOMER, a.COUNTRY_CITY_CUSTOMER, a.ADRESS_CUSTOMER, a.EMAIL,a.PHONE_CUSTOMER,a.AGE,a.IS_ACTIVE,a.CUSTOMER_SALE_DATE)
                VALUES (SEQ_CUSTOMERS.NEXTVAL,b.FIRST_NAME_CUSTOMER, b.LAST_NAME_CUSTOMER, b.COUNTRY_CITY_CUSTOMER, b.ADRESS_CUSTOMER, b.EMAIL,b.PHONE_CUSTOMER,b.AGE,b.IS_ACTIVE,b.CUSTOMER_SALE_DATE);
     COMMIT;
   END LOAD_DW_CUSTOMER;
END pkg_etl_dw_customer;

exec pkg_etl_dw_customer.LOAD_DW_CUSTOMER;
select * from t_dw_customers;

commit;