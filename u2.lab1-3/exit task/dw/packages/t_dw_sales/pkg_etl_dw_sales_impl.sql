alter session set current_schema=DW_CL;

--select * from t_dw_regions;
GRANT SELECT ON DW_CL.t_cl_sales TO DW_DATA;
GRANT SELECT ON DW_CL.t_cl_sales TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_sales
AS  
  PROCEDURE LOAD_DW_SALES
   AS
     BEGIN
      DECLARE
      
       TYPE CURSOR_INT IS TABLE OF int;
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(20);
       TYPE CURSOR_DATE IS TABLE OF date;
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   sale_id CURSOR_INT;
       customer_id CURSOR_INT;
       FIRST_NAME_CUSTOMER CURSOR_VARCHAR;
       LAST_NAME_CUSTOMER CURSOR_VARCHAR;
       COUNTRY_CITY_CUSTOMER CURSOR_VARCHAR;
       region_id CURSOR_INT;
       date_id CURSOR_DATE;
       pizza_id CURSOR_INT;
       pizza_name CURSOR_VARCHAR;
       pizza_cost CURSOR_INT;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT
                dw_ord.sale_id
              , cl.customer_id
              , cl.FIRST_NAME_CUSTOMER
              , cl.LAST_NAME_CUSTOMER
              , cl.COUNTRY_CITY_CUSTOMER
              , reg.region_id
              , calen.date_id
              , p.pizza_id
              , p.pizza_name
              , p.pizza_cost
	          FROM (SELECT DISTINCT *
                           FROM DW_CL.t_cl_sales) source_cl
                    INNER JOIN 
                        DW_DATA.t_dw_customers cl
                     ON (source_cl.customer_id=cl.customer_id)
                     INNER JOIN 
                        DW_DATA.t_dw_pizza p
                     ON (source_cl.pizza_id=p.pizza_id)
                     INNER JOIN 
                        DW_DATA.t_dw_financial_calendar calen
                     ON (source_cl.date_id=calen.date_id)
                     INNER JOIN 
                       DW_DATA.t_dw_regions reg
                     ON (source_cl.region_id=reg.region_id)
                     LEFT JOIN 
                        DW_DATA.t_dw_fct_sales dw_ord
                     ON (cl.customer_id=dw_ord.customer_id AND calen.date_id=dw_ord.date_id AND
                         p.pizza_id=dw_ord.pizza_id and reg.region_id=dw_ord.region_id);
	   FETCH ALL_INF
	   BULK COLLECT INTO
                sale_id
              , customer_id
              , FIRST_NAME_CUSTOMER
              , LAST_NAME_CUSTOMER
              , COUNTRY_CITY_CUSTOMER
              , region_id
              , date_id
              , pizza_id
              , pizza_name
              , pizza_cost; 
                
	   CLOSE ALL_INF;
	
	   FOR i IN SALE_ID.FIRST .. SALE_ID.LAST LOOP 
       
	      IF ( SALE_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.t_dw_fct_sales (sale_id ,
                                                    customer_id ,                
                                                    FIRST_NAME_CUSTOMER         ,
                                                    LAST_NAME_CUSTOMER          ,
                                                    COUNTRY_CITY_CUSTOMER       ,
                                                    region_id                   ,
                                                    date_id                     ,
                                                    pizza_id                    ,
                                                    pizza_name                  ,
                                                    pizza_cost)
	              VALUES ( SEQ_FCT_ORDERS.NEXTVAL
	                     , customer_id (i)
                         , FIRST_NAME_CUSTOMER (i)
                         , LAST_NAME_CUSTOMER (i)
                         , COUNTRY_CITY_CUSTOMER (i)
                         , region_id (i)
                         , date_id (i)
                         , pizza_id (i)
                         , pizza_name (i)
                         , pizza_cost (i));      
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END LOAD_DW_SALES;
END pkg_etl_dw_sales;

alter session set current_schema=DW_DATA;

exec pkg_etl_dw_sales.LOAD_DW_SALES;


select * from t_dw_fct_sales;

commit;