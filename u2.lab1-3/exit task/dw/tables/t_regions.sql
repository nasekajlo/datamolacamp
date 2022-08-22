alter session set current_schema=DW_DATA;
drop table t_dw_regions CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_REGIONS;
--ALTER TABLE T_DW_PIZZA DROP CONSTRAINT PK_T_DW_PIZZA;

CREATE SEQUENCE SEQ_REGIONS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;


Create table t_dw_regions (
region_id                     INT              ,
region_name                   VARCHAR2(15)     not null,
country                       VARCHAR2(15)     not null,
city                          VARCHAR2(15)     not null,
use_language                  VARCHAR2(5)      not null,
VAT_rate                      FLOAT            not null,
timezone                      VARCHAR2(4)      not null,
constraint PK_T_DW_REGIONS primary key (region_id)
)