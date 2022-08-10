alter session set current_schema = SA_TRANSACTIONS;
ALTER USER SA_TRANSACTIONS QUOTA UNLIMITED ON ts_sa_fact_sales_data_01;

SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;


--drop table sa_transactions;

alter session set current_schema=SA_CUSTOMERS;
    create table sa_transactions(
    --CUSTOMER
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE,
    pizza_id NUMBER,
    PIZZA_NAME       VARCHAR (20),
    PIZZA_SIZE      NUMBER,
    PIZZA_COST    NUMBER,
    PIZZA_RANK    NUMBER      
    );
                                
     INSERT INTO SA_TRANSACTIONS (
        SELECT /*+ parallel(SA_CUSTOMER.SA_CUSTOMERS, 4)*/ C.*, P.*
             FROM SA_CUSTOMER.SA_CUSTOMERS C 
                CROSS JOIN SA_PIZZA.T_SA_PIZZA P  
        WHERE C.CUSTOMER_SALE_DATE > TO_DATE( '01.01.20', 'MM/DD/YY' ) AND C.CUSTOMER_SALE_DATE < TO_DATE( '02.01.22', 'MM/DD/YY' )
     );

    
    SELECT * FROM SA_TRANSACTIONS;
    
    
    commit;