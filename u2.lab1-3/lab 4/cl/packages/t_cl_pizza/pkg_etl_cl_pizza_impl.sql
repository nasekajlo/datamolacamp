alter session set current_schema=SA_PIZZA;
GRANT SELECT ON SA_PIZZA.T_SA_PIZZA TO DW_CL; 

--drop package body pkg_etl_cl_pizza;
alter session set current_schema=DW_CL;
CREATE OR REPLACE PACKAGE body pkg_etl_cl_pizza
AS  
  PROCEDURE LOAD_CLEAN_PIZZA
   AS   
      CURSOR curs_cl_pizza
      IS
         SELECT DISTINCT 
                  PIZZA_NAME
                , PIZZA_SIZE 
                , PIZZA_COST
                , PIZZA_RANK
           FROM SA_PIZZA.T_SA_PIZZA
           WHERE pizza_id is not null and
           PIZZA_NAME IS NOT NULL 
           AND PIZZA_SIZE IS NOT NULL
           AND PIZZA_COST IS NOT NULL
           AND PIZZA_RANK IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.t_cl_pizza';
      FOR i IN curs_cl_pizza LOOP
         INSERT INTO DW_CL.t_cl_pizza( 
                         PIZZA_NAME
                       , PIZZA_SIZE 
                       , PIZZA_COST
                       , PIZZA_RANK)
              VALUES ( i.PIZZA_NAME
                     , i.PIZZA_SIZE 
                     , i.PIZZA_COST
                     , i.PIZZA_RANK);

         EXIT WHEN curs_cl_pizza%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_PIZZA;
END pkg_etl_cl_pizza;


alter session set current_schema=DW_CL;
exec pkg_etl_cl_pizza.LOAD_CLEAN_PIZZA;
select * from t_cl_pizza;

commit;