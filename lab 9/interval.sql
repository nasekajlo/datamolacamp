create tablespace TS_STUFF;

create user DW_STUFF;
GRANT CONNECT TO DW_STUFF;
alter session set current_schema = DW_STUFF;

ALTER USER DW_STUFF QUOTA UNLIMITED ON TS_STUFF;

create table interval_example
   ( range_key_column date         NOT NULL, data varchar2(20))
  PARTITION BY RANGE (range_key_column)
  INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
 ( 
    PARTITION p0 VALUES LESS THAN (to_date('01/01/2010','dd/mm/yyyy')),
    PARTITION p1 VALUES LESS THAN (to_date('01/01/2011','dd/mm/yyyy'))
 ) tablespace TS_STUFF;
 
--drop table interval_example;
       
ALTER TABLE INTERVAL_EXAMPLE DROP PARTITION P0;
SELECT to_char(range_key_column,'dd-mon-yyyy hh24:mi:ss') FROM interval_example partition (p0);

INSERT INTO INTERVAL_EXAMPLE(range_key_column, data )
  VALUES( to_date( '11/01/2019'),'application data...' );
  
INSERT INTO INTERVAL_EXAMPLE(range_key_column, data )
  VALUES( to_date( '11/01/2021'),'application data...' );
  

alter table INTERVAL_EXAMPLE
      MERGE PARTITIONS FOR(TO_DATE('10/JAN/2010','dd/MON/yyyy')), FOR(TO_DATE('10/JAN/2011','dd/MON/yyyy'));

alter table INTERVAL_EXAMPLE TRUNCATE PARTITION SYS_P962;


select partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;