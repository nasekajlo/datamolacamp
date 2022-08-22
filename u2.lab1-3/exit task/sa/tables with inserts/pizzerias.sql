alter session set current_schema = SA_PIZZERIAS;

SELECT df.tablespace_name "Tablespace",
  totalusedspace "Used MB",
  (df.totalspace - tu.totalusedspace) "Free MB",
  df.totalspace "Total MB",
  ROUND(100 * ( (df.totalspace - tu.totalusedspace)/ df.totalspace)) "% Free"
FROM
  (SELECT tablespace_name,
    ROUND(SUM(bytes) / 1048576) TotalSpace
  FROM dba_data_files
  GROUP BY tablespace_name
  ) df,
  (SELECT ROUND(SUM(bytes)/(1024*1024)) totalusedspace,
    tablespace_name
  FROM dba_segments
  GROUP BY tablespace_name
  ) tu
WHERE df.tablespace_name = tu.tablespace_name;
--drop table sa_pizzeria;

alter user SA_PIZZERIAS quota unlimited on ts_sa_pizzerias_data_01;

CREATE TABLE sa_pizzeria (
    pizzeria_id         NUMBER
    ,pizzeria_name     VARCHAR(20)
    ,location_id        NUMBER
    ,menu_name           number
);

INSERT INTO sa_pizzeria
WITH cte_pizzeria AS (
        SELECT
            1      AS id
          , 'Dominos'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Dodo pizza'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Pizza lisicca'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Pizzamania'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Pizza tempo'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'Papa johns'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Tepa'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Garage'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Forno'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Go-go pizza'  AS a
        FROM
            dual
    ),cte_menu AS (
        SELECT
            1      AS id
          , '1'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , '2'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , '3'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , '4'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , '5'  AS a
        FROM
            dual
    ),
    cte_gen AS (
    SELECT
          a.*
          , trunc(dbms_random.value(1, 10))           AS id_fn
          , trunc(dbms_random.value(1, 300000))       as id_loc                              
          , trunc(dbms_random.value(1, 5))           AS id_menu                                                                            
    FROM
        (
            SELECT
               ROWNUM                                   rn
            FROM
                dual
            CONNECT BY
                level <= 300000
        ) a
)
SELECT
   g.rn
       ,pn.a
      , g.id_loc
      , g.id_menu
FROM
    cte_gen  g
    LEFT OUTER JOIN cte_pizzeria  pn ON g.id_fn = pn.id
    LEFT OUTER JOIN SA_LOCATION.t_sa_location  ln ON g.id_loc = ln.location_id;
    
select * from sa_pizzeria;
delete from sa_sold_number;