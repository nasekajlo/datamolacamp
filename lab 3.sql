create tablespace tbs_lab datafile 'db_lab_002.dat' 
size 5M autoextend ON next 5M MAXSIZE 100M;
create user scott identified by 123456;
grant connect to scott;
grant resource to scott;
GRANT UNLIMITED TABLESPACE TO scott;
grant select on scott.dept to SNasekajlo;
grant select on scott.emp to SNasekajlo;

create table t 

  ( a int, 

    b varchar2(4000) default rpad('*',4000,'*'), 

    c varchar2(3000) default rpad('*',3000,'*') 

   ) 
/ 

insert into t (a) values ( 1); 

insert into t (a) values ( 2); 

insert into t (a) values ( 3); 

commit; 

delete from t where a = 2 ; 

commit; 

insert into t (a) values ( 4); 

commit;

select a from t;

drop table t;

Create table t ( x int primary key, y clob, z blob );
select segment_name, segment_type from user_segments; 
Create table t 
( x int primary key, 

y clob, 

z blob ) 

SEGMENT CREATION IMMEDIATE 
   /
select segment_name, segment_type 2 from user_segments;
SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual ;
drop table t;

CREATE TABLE emp AS 

SELECT 

  object_id empno 

, object_name ename 

, created hiredate 

, owner job 

FROM 
  all_objects  
/ 
alter table emp add constraint emp_pk primary key(empno) ;

begin 
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true ); 
end; 

CREATE TABLE heap_addresses 

  ( 

    empno REFERENCES emp(empno) ON DELETE CASCADE 

  , addr_type VARCHAR2(10) 

  , street    VARCHAR2(20) 

  , city      VARCHAR2(20) 

  , state     VARCHAR2(2) 

  , zip       NUMBER 

  , PRIMARY KEY (empno,addr_type) 

  ) 

/ 

CREATE TABLE iot_addresses 

  ( 

    empno REFERENCES emp(empno) ON DELETE CASCADE 

  , addr_type VARCHAR2(10) 

  , street    VARCHAR2(20) 

  , city      VARCHAR2(20) 

  , state     VARCHAR2(2) 

  , zip       NUMBER 

  , PRIMARY KEY (empno,addr_type) 

  ) 

  ORGANIZATION INDEX 

/ 

INSERT INTO heap_addresses 

SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

   

INSERT INTO iot_addresses 

SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

-- 

INSERT INTO heap_addresses 

SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

   

INSERT INTO iot_addresses 

SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

-- 

INSERT INTO heap_addresses 

SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

   

INSERT INTO iot_addresses 

SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

-- 

INSERT INTO heap_addresses 

SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

   

INSERT INTO iot_addresses 

SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

 

Commit; 

exec dbms_stats.gather_table_stats( $username$, 'HEAP_ADDRESSES' ); 

exec dbms_stats.gather_table_stats( $username$, 'IOT_ADDRESSES' ); 

SELECT * 

   FROM emp , 

        heap_addresses 

  WHERE emp.empno = heap_addresses.empno 

  AND emp.empno   = 42; 
  
SELECT * 

   FROM emp , 

        iot_addresses 

  WHERE emp.empno = iot_addresses.empno 

  AND emp.empno   = 42;  
drop index idxcl_emp_dept;
drop table dept;
drop table emp;
drop cluster emp_dept_cluster;

CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) ) 
    SIZE 1024  
    STORAGE( INITIAL 100K NEXT 50K );
CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;
CREATE TABLE dept 

  ( 

    deptno NUMBER( 2 ) PRIMARY KEY 

  , dname  VARCHAR2( 14 ) 

  , loc    VARCHAR2( 13 ) 

  ) 

  cluster emp_dept_cluster ( deptno ) ; 
CREATE TABLE emp 

  ( 

    empno NUMBER PRIMARY KEY 

  , ename VARCHAR2( 10 ) 

  , job   VARCHAR2( 9 ) 

  , mgr   NUMBER 

  , hiredate DATE 

  , sal    NUMBER 

  , comm   NUMBER 

  , deptno NUMBER( 2 ) REFERENCES dept( deptno ) 

  ) 

  cluster emp_dept_cluster ( deptno ) ; 
INSERT INTO dept( deptno , dname , loc) 
SELECT deptno , dname , loc 
   FROM scott.dept; 
commit; 
 INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno ) 
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno 
   FROM scott.emp ;
commit; 
SELECT * 
   FROM 
  ( 
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno 
       FROM 
      ( 
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno 
           FROM emp , dept 
          WHERE emp.deptno = dept.deptno 
      ) 
  ) 
ORDER BY deptno ;
 select *
  from (
  select dept_blk, emp_blk,
  case when dept_blk <> emp_blk then '*' end flag,
  deptno
  from (
  select dbms_rowid.rowid_block_number(dept.rowid) dept_blk,
  dbms_rowid.rowid_block_number(emp.rowid) emp_blk,
  dept.deptno
  from emp, dept
  where emp.deptno = dept.deptno
  )
  )
  where flag = '*'
  order by deptno
  / 
  
CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) ) 
    SIZE 1024  
    HASHKEYS 75000
    STORAGE( INITIAL 100K NEXT 50K );
    
    CREATE TABLE dept 

  ( 

    deptno NUMBER( 2 ) PRIMARY KEY 

  , dname  VARCHAR2( 14 ) 

  , loc    VARCHAR2( 13 ) 

  ) 

  cluster emp_dept_cluster ( deptno ) ; 
CREATE TABLE emp 

  ( 

    empno NUMBER PRIMARY KEY 

  , ename VARCHAR2( 10 ) 

  , job   VARCHAR2( 9 ) 

  , mgr   NUMBER 

  , hiredate DATE 

  , sal    NUMBER 

  , comm   NUMBER 

  , deptno NUMBER( 2 ) REFERENCES dept( deptno ) 

  ) 

  cluster emp_dept_cluster ( deptno ) ; 
INSERT INTO dept( deptno , dname , loc) 
SELECT deptno , dname , loc 
   FROM scott.dept; 
commit; 
 INSERT INTO emp ( empno, ename, job, mgr, hiredate, sal, comm, deptno ) 
 SELECT rownum, ename, job, mgr, hiredate, sal, comm, deptno 
   FROM scott.emp ;
commit; 
SELECT * 
   FROM 
  ( 
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno 
       FROM 
      ( 
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno 
           FROM emp , dept 
          WHERE emp.deptno = dept.deptno 
      ) 
  ) 
ORDER BY deptno ;
 select *
  from (
  select dept_blk, emp_blk,
  case when dept_blk <> emp_blk then '*' end flag,
  deptno
  from (
  select dbms_rowid.rowid_block_number(dept.rowid) dept_blk,
  dbms_rowid.rowid_block_number(emp.rowid) emp_blk,
  dept.deptno
  from emp, dept
  where emp.deptno = dept.deptno
  )
  )
  where flag = '*'
  order by deptno
  / 