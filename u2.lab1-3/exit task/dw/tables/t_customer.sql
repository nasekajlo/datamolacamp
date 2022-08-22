alter session set current_schema=DW_DATA;
drop table t_dw_customers;

CREATE SEQUENCE SEQ_CUSTOMERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


Create table t_dw_customers (
   customer_id        int not null,
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE,
constraint PK_T_DW_CUSTOMERS primary key (customer_id)
);