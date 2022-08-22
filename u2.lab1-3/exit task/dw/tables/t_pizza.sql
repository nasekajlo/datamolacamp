alter session set current_schema=DW_DATA;


drop table t_dw_pizza CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_PIZZA;
--ALTER TABLE T_DW_PIZZA DROP CONSTRAINT PK_T_DW_PIZZA;

CREATE SEQUENCE SEQ_PIZZA
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE TABLE T_DW_PIZZA( 
    pizza_id      NUMBER ,
    PIZZA_NAME    VARCHAR (20),
    PIZZA_SIZE    NUMBER,
    PIZZA_COST    NUMBER,
    PIZZA_RANK    NUMBER,
    constraint PK_T_DW_PIZZA primary key (pizza_id)
);

select * from T_DW_PIZZA;