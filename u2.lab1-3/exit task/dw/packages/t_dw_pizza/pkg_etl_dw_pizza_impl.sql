alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.t_cl_PIZZA TO DW_DATA;

alter session set current_schema=DW_DATA;

select * FROM DW_CL.T_CL_PIZZA;
select * from DW_DATA.T_DW_PIZZA;

DROP PACKAGE body pkg_etl_dw_pizza;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_pizza
AS  
  PROCEDURE LOAD_DW_PIZZA
   AS
     BEGIN
     MERGE INTO DW_DATA.T_DW_PIZZA A
     USING ( SELECT 
                PIZZA_NAME  ,
                PIZZA_SIZE  ,
                PIZZA_COST  ,
                PIZZA_RANK  
             FROM DW_CL.T_CL_PIZZA) B
             ON (a.PIZZA_NAME = b.PIZZA_NAME) 
             WHEN MATCHED THEN 
                UPDATE SET a.pizza_cost = b.pizza_cost
             WHEN NOT MATCHED THEN 
                INSERT (a.PIZZA_ID,a.PIZZA_NAME, a.PIZZA_SIZE, a.PIZZA_COST, a.PIZZA_RANK)
                VALUES (SEQ_PIZZA.NEXTVAL,b.PIZZA_NAME, b.PIZZA_SIZE, b.PIZZA_COST, b.PIZZA_RANK);
     COMMIT;
   END LOAD_DW_PIZZA;
END pkg_etl_dw_pizza;

exec pkg_etl_dw_pizza.LOAD_DW_PIZZA;
select * from t_dw_pizza;

commit;