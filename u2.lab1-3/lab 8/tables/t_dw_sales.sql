alter session set current_schema=DW_DATA;
--drop table t_dw_fct_sales;

--DROP SEQUENCE SEQ_FCT_ORDERS;
/*CREATE SEQUENCE SEQ_FCT_ORDERS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;*/
 
create table t_dw_fct_sales (
sale_id int,
customer_id                 int, 
FIRST_NAME_CUSTOMER         CHAR(20),
LAST_NAME_CUSTOMER          CHAR(20),
COUNTRY_CITY_CUSTOMER       CHAR(20),
region_id                   int,
date_id                     DATE,
pizza_id                    int,
pizza_name                  VARCHAR2(20)    ,
pizza_cost                  INT,            
CONSTRAINT PK_T_DW_SALES primary key (sale_id),
CONSTRAINT fk_t_dw_customers_t_dw_fct_sales FOREIGN KEY (customer_id)
      REFERENCES DW_DATA.t_dw_customers (customer_id),
CONSTRAINT fk_t_dw_regions_t_dw_fct_sales FOREIGN KEY (region_id)
      REFERENCES DW_DATA.t_dw_regions (region_id),
CONSTRAINT fk_t_dw_financial_calendar_t_dw_fct_sales FOREIGN KEY (date_id)
      REFERENCES DW_DATA.t_dw_financial_calendar (date_id),
CONSTRAINT fk_t_dw_pizza_t_dw_fct_sales FOREIGN KEY (pizza_id)
      REFERENCES DW_DATA.T_DW_PIZZA (pizza_id)
      )      
PARTITION BY RANGE (date_id)
    subpartition by hash(customer_id) subpartitions 4
(
    PARTITION FST_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('19-02-2022','dd-mm-yy'))
    (
      subpartition FST_ADVERTISING_PERIOD_sub_1,
      subpartition FST_ADVERTISING_PERIOD_sub_2,
      subpartition FST_ADVERTISING_PERIOD_sub_3,
      subpartition FST_ADVERTISING_PERIOD_sub_4
    ),
    PARTITION SND_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('10-04-2022','dd-mm-yy'))
    (
      subpartition SND_ADVERTISING_PERIOD_sub_1,
      subpartition SND_ADVERTISING_PERIOD_sub_2,
      subpartition SND_ADVERTISING_PERIOD_sub_3,
      subpartition SND_ADVERTISING_PERIOD_sub_4
     ),
     PARTITION TRD_ADVERTISING_PERIOD VALUES LESS THAN(TO_DATE('30-05-2022','dd-mm-yy'))
    (
      subpartition TRD_ADVERTISING_PERIOD_sub_1,
      subpartition TRD_ADVERTISING_PERIOD_sub_2,
      subpartition TRD_ADVERTISING_PERIOD_sub_3,
      subpartition TRD_ADVERTISING_PERIOD_sub_4
    ),
     PARTITION FTH_ADVERTISING_PERIOD VALUES LESS THAN(MAXVALUE)
    (
      subpartition FTH_ADVERTISING_PERIOD_sub_1,
      subpartition FTH_ADVERTISING_PERIOD_sub_2,
      subpartition FTH_ADVERTISING_PERIOD_sub_3,
      subpartition FTH_ADVERTISING_PERIOD_sub_4
    )
);