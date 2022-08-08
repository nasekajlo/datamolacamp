SELECT * from dba_data_files ;


CREATE TABLESPACE ts_sa_pizzerias_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sa_pizzerias_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_sa_sold_number_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sa_sold_number_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_pizza_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sa_pizza_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE ts_sa_sales_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sa_sales_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_countries_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sa_currencies_data_01.dat'
SIZE 50M reuse
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;


CREATE TABLESPACE ts_dw_cl_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dw_cl_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dw_data_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 

CREATE TABLESPACE ts_dw_star_cls_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dw_star_cls_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
-- STAR Cleansing
CREATE TABLESPACE ts_sal_cl_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_sal_cl_01.dat'
SIZE 150M reuse
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 

CREATE TABLESPACE ts_sa_dim_date_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dm_date_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_sa_dim_location_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dm_location_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_sa_dim_pizzerias_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dm_currency_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 
CREATE TABLESPACE ts_sa_dim_owner_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dm_movie_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 
 
 
CREATE TABLESPACE ts_sa_dim_period_01
DATAFILE '/oracle/u02/oradata/SNasekajlodb/db_qpt_dm_period_01.dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 10M
 SEGMENT SPACE MANAGEMENT AUTO; 

