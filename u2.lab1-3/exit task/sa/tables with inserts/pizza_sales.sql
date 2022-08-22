alter session set current_schema = SA_SALES;
drop table pizza_sales;
--
--
CREATE TABLE pizza_sales (
    pizza_id         NUMBER
    , transaction_date  DATE
    , transaction_num   NUMBER
    , transaction_sum   FLOAT
); 
--
INSERT INTO pizza_sales
WITH cte_gen AS (
    SELECT
        a.*
      , a.sd + trunc(dbms_random.value(- 100, 300))              AS date_rnd
      , trunc(dbms_random.value(1, 15))                         AS id_pp
      , trunc(dbms_random.value(1, 1200))                       AS s_sum
    FROM
        (
            SELECT
                TO_DATE('12/31/2021', 'MM/DD/YYYY')      sd
              , ROWNUM                                   rn
            FROM
                dual
            CONNECT BY
                level <= 299000
        ) a
)
SELECT
    p.pizza_id
  , g.date_rnd    AS transaction_date
  , g.rn          AS transaction_num
  , g.s_sum       AS transaction_sum
FROM
    cte_gen  g
    LEFT OUTER JOIN SA_PIZZA.T_SA_PIZZA   p ON g.id_pp = p.pizza_id;
    
select * from sa_sales.pizza_sales;