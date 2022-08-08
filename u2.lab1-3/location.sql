alter session set current_schema = SA_LOCATION;
alter user SA_LOCATION quota unlimited on ts_sa_dim_location_01;
drop table t_sa_location;
--
--
CREATE TABLE t_sa_location (
   location_id         NUMBER
    , house number
   ,street varchar(20)
    , city varchar(20)
); 
--drop table t_sa_location;
--
INSERT INTO t_sa_location
    WITH cte_street AS (
        SELECT
            1      AS id
          , 'Bochdanowicha'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Niekrasowa'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Surhanowa'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Uljanowskaja'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Nemiga'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'Bedy'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Kalinina'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Kalinowskogo'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Haruzaj'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Sablina'  AS a
        FROM
            dual
    ), cte_city AS (
        SELECT
            1      AS id
          , 'Minsk'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Hrodno'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'New York'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Warsaw'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Moscow'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'Vilno'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Talin'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Kiew'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Bratislawa'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Achen'  AS a
        FROM
            dual
    ),
    cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 150))           AS id_n
          , trunc(dbms_random.value(1, 10))          AS id_sn
          , trunc(dbms_random.value(1, 10))         AS id_cn
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 300000
            ) a
    )
    SELECT
       g.rn
      , g.id_n 
      , sn.a
      , cn.a
      
    FROM
        cte_gen  g
        LEFT OUTER JOIN cte_street  sn ON g.id_sn = sn.id
        LEFT OUTER JOIN cte_city  cn ON g.id_sn = cn.id;  
--
SELECT
    *
FROM
    t_sa_location
ORDER BY
    1; 