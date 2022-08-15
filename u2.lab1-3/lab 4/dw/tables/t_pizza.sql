alter session set current_schema=DW_DATA;

CREATE TABLE T_DW_PIZZA( 
    pizza_id int not null,
    PIZZA_NAME       VARCHAR (20),
    PIZZA_SIZE      NUMBER,
    PIZZA_COST    NUMBER,
    PIZZA_RANK    NUMBER,
    constraint PK_T_DW_PIZZA primary key (pizza_id)
);