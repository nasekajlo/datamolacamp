set autotrace on explain statistics
SELECT  * 
     FROM scott.emp e, scott.dept d 
     WHERE e.deptno = d.deptno 
     AND d.deptno   = 10 ;*/
 
-- sort-merge    
SELECT *
FROM   scott.emp e, scott.dept d
WHERE  e.deptno = d.deptno
ORDER BY e.deptno;
     
--Hash Joins
SELECT /*+ USE_HASH(e d) */ *
  FROM scott.emp e, scott.dept d
  WHERE e.deptno = d.deptno;
     
--cARTESIAN Join
SELECT  * 
     FROM scott.emp e, scott.dept d;
     
-- full outer join
SELECT   *
     FROM scott.emp e full outer join scott.dept d
     on e.deptno = d.deptno;
     
--left join
SELECT  * 
     FROM scott.emp e left outer join scott.dept d
     on e.deptno = d.deptno;
     
--right join
SELECT  * 
     FROM scott.emp e right outer join scott.dept d
     on e.deptno = d.deptno;
     
--semi join
SELECT  * 
     FROM scott.emp e where exists (select 1 from scott.dept d 
     where e.deptno = d.deptno)
 
--anti join    
SELECT  * 
     FROM scott.emp e where e.deptno not in (select d.deptno from scott.dept d);   
     


