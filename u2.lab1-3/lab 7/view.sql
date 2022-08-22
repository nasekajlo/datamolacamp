alter session set current_schema=DW_CL;
GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO DW_DATA;



CREATE MATERIALIZED VIEW daily_profit
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT pizza_name, COUNTRY_CITY_CUSTOMER, date_id,  sum(pizza_cost) profit,

   GROUPING(pizza_name) name_,
   GROUPING(COUNTRY_CITY_CUSTOMER) address_,
   GROUPING(date_id) date_,
   
   GROUPING_ID(pizza_name, COUNTRY_CITY_CUSTOMER) name_address,
   GROUPING_ID(COUNTRY_CITY_CUSTOMER, pizza_name) address_name,
   GROUPING_ID(pizza_name, date_id) name_date,
   GROUPING_ID(COUNTRY_CITY_CUSTOMER, date_id) address_date,
   
   GROUPING_ID(COUNTRY_CITY_CUSTOMER, pizza_name, date_id) address_name_date,
   GROUPING_ID(COUNTRY_CITY_CUSTOMER, date_id, pizza_name) address_date_name,
   GROUPING_ID(date_id, pizza_name, COUNTRY_CITY_CUSTOMER) date_name_address
   
   FROM DW_CL.t_cl_sales cl_sale
   LEFT JOIN DW_DATA.T_DW_PIZZA  cust ON cust.pizza_id = cl_sale.pizza_id
   WHERE date_id  >= TO_DATE( '03.01.20', 'MM/DD/YY' ) AND date_id  < TO_DATE( '04.01.20', 'MM/DD/YY' )
   GROUP BY CUBE(pizza_name, COUNTRY_CITY_CUSTOMER, date_id);
   
EXECUTE DBMS_MVIEW.REFRESH('daily_profit');