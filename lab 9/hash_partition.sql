--create tablespace ts_references_data_01;
--create tablespace ts_ext_references_data_01;
alter user dw_stuff quota unlimited on ts_references_data_01;
CREATE TABLE HASH_EXAMPLE
    ( hash_key_column date,data varchar2(20))
PARTITION BY HASH (hash_key_column)
    ( partition part_1 tablespace ts_references_data_01,
    partition part_2 tablespace TS_STUFF
    )
/
--drop table HASH_EXAMPLE;
INSERT INTO HASH_EXAMPLE
(hash_key_column, data)
    VALUES(to_date('25-06-2014'),'application data ...');

INSERT INTO HASH_EXAMPLE
(hash_key_column, data)
    VALUES(to_date('27-02-2015'),'application data ...');
  
alter user dw_stuff quota unlimited on ts_ext_references_data_01;  
ALTER TABLE HASH_EXAMPLE
    ADD PARTITION part_3 tablespace ts_ext_references_data_01;
    
SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

ALTER TABLE HASH_EXAMPLE COALESCE PARTITION;

ALTER TABLE HASH_EXAMPLE MOVE PARTITION part_1 TABLESPACE ts_stuff;

ALTER TABLE HASH_EXAMPLE TRUNCATE PARTITION part_2;

