alter session set current_schema = SA_PIZZA;
DROP TABLE T_SA_PIZZA;

ALTER USER SA_PIZZA QUOTA UNLIMITED ON ts_sa_pizza_data_01;
alter session set current_schema = SA_DATA;

alter session set current_schema = SA_PIZZERIAS;

CREATE TABLE T_SA_PIZZA( 
    pizza_id NUMBER,
    PIZZA_NAME       VARCHAR (20),
    PIZZA_SIZE      NUMBER,
    PIZZA_COST    NUMBER,
    PIZZA_RANK    NUMBER
);


SELECT * FROM T_SA_PIZZA; 
--
INSERT INTO T_SA_PIZZA
    WITH cte_pn AS (
        SELECT
            1      AS id
          , 'burger'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'carbonara'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'margarita'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , '4 seasons'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'tasty'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'pineapples'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'mushrooms'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'barbeque chicken'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'classic'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'vegan'  AS a
        FROM
            dual
    ),  cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 10))           AS id_fn
          , trunc(dbms_random.value(30, 45))          AS id_pp
          , trunc(dbms_random.value(10, 50))         AS id_pc
           , trunc(dbms_random.value(1, 10))         AS id_pr
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 15
            ) a
    )
    SELECT
       g.rn
       ,pn.a
      , id_pp
      , id_pc
      , id_pr
      
    FROM
        cte_gen  g
        LEFT OUTER JOIN cte_pn  pn ON g.id_fn = pn.id;
--
SELECT
    *
FROM
    SA_PIZZA.T_SA_PIZZA
ORDER BY
    1; 
    
    
--




