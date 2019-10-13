select dbms_metadata.get_ddl('TABLE','EMP','TEST') from dual;

select ename,initcap(ename),substr(ename,1,1)||lower(substr(ename,2)) from emp;
select * from emp where hiredate > to_date('1982-01-01','yyyy-mm-dd');

select * from (select a.*,ROWNUM RN from (select * from emp order by sal desc) a) b where RN = 2;

SELECT
    ascii('A'), --结果为：65
    chr(65), --结果为：A
    concat('Hello','World'), --结果为：HelloWorld
    initcap('hello woRld'), --结果为：Hello World
    lower('HeLLo woRld'), --结果为：hello world
    upper('HeLLo woRld'), --结果为：HELLO WORLD
    length('HeLLo woRld'), --结果为：11
    length('天下英雄出我辈') --结果为：21
FROM dual;

SELECT
    sysdate, --结果为：13-OCT-19
    systimestamp, --结果为：13-OCT-19 05.52.10.670774 PM +08:00
    current_date, --结果为：13-OCT-19
    current_timestamp, --结果为：13-OCT-19 05.52.10.000000 PM +08:00
    localtimestamp, --结果为：13-OCT-19 05.52.10.000000 PM
    sessiontimezone, --结果为：+08:00
    dbtimezone --结果为：+00:00
FROM dual;

SELECT
    sysdate, --结果为：2019-10-13 18:03:08
    add_months(sysdate,4), --结果为：2020-02-13 18:03:08
    add_months(sysdate,-4), --结果为：2019-06-13 18:03:08
    extract(MONTH from sysdate), --结果为：10
    last_day(sysdate), --结果为：2019-10-31 18:03:08
    next_day(sysdate,'sunday'), --结果为：2019-10-20 18:03:08
    round(sysdate,'YEAR'), --结果为：2020-01-01 00:00:00
    round(sysdate,'MONTH'), --结果为：2019-10-01 00:00:00
    round(sysdate,'DAY'), --结果为：2019-10-13 00:00:00
    round(sysdate), --结果为：2019-10-14 00:00:00
    trunc(sysdate,'YEAR'), --结果为：2019-01-01 00:00:00
    trunc(sysdate,'MONTH'), --结果为：2019-10-01 00:00:00
    trunc(sysdate,'DAY'), --结果为：2019-10-13 00:00:00
    trunc(sysdate) --结果为：2019-10-13 00:00:00
FROM dual;

SELECT
to_timestamp('2015-03-25 11:30:00','YYYY-MM-DD HH24:MI:SS'), --结果为：2015-03-25 11:30:00
sysdate, --结果为：2019-10-13 18:17:34
months_between(sysdate,to_date('2012/06/30','YYYY/MM/DD')) --结果为：87.47619997013142174432497013142174432497
FROM dual;

SELECT
    count(distinct ename), --结果为：14
    count(*), --结果为：14
    min(sal), --结果为：800
    max(sal), --结果为：5000
    sum(sal), --结果为：29025
    avg(sal) --结果为：2073.214285714285714285714285714285714286
FROM emp;

SELECT
    rank(1530) within group(order by sal asc) rank_level --结果为：8
FROM emp;

SELECT
    rank() over(ORDER BY sal ASC) AS rank_level,
    ename
FROM emp
WHERE deptno = 30;

SELECT
    dense_rank() over(ORDER BY sal ASC) AS rank_level,
    ename
FROM emp
WHERE deptno = 30;

SELECT
    row_number() over(partition by deptno order by sal)
FROM emp
WHERE deptno < 30;

SELECT
    ename,
    percent_rank() over(ORDER BY sal) percent,
    rank() over(ORDER BY sal) ,
    sal
FROM emp;

SELECT percentile_cont(0.25)within GROUP(ORDER BY sal)
FROM emp;

SELECT percentile_disc(0.25)within GROUP(ORDER BY sal)
FROM emp;

SELECT
    MAX(sal)keep(dense_rank FIRST ORDER BY sal),
    deptno
FROM emp
GROUP BY deptno;

SELECT
    MAX(sal)keep(dense_rank last ORDER BY sal),
    deptno
FROM emp
GROUP BY deptno;

SELECT
    ename,
    deptno,
    sal,
    SUM(sal) over(partition BY deptno ORDER BY sal) sum1,
    SUM(sal) over(partition BY deptno) sum2,
    SUM(sal) over(ORDER BY sal) sum3,
    SUM(sal) over() sum4
FROM emp;

SELECT
    ename,
    deptno,
    sal,
    salary_order
FROM (
    SELECT
        ename,
        deptno,
        sal,
        row_number() over(partition BY deptno ORDER BY sal DESC) salary_order
    FROM emp
) emp_temp;


SELECT
    ename,
    sal,
    ntile(3) over (ORDER BY sal nulls last)
FROM emp;

SELECT
    grade,
    ntile(4) over(ORDER BY grade DESC)
FROM salgrade;

SELECT
    empno,
    ename,
    mgr,
    sys_connect_by_path(ename,'-->') path
FROM emp START WITH ename = 'KING' CONNECT BY prior empno = mgr;

select deptno,max(sal) from emp group by deptno;

select deptno,job,count(*) counts from emp group by deptno,job order by counts;
select deptno,job,count(*) counts from emp group by deptno,job having count(*)>1 order by counts;
select deptno,job,sum(sal) sums from emp group by deptno,job having sum(sal)>1000 order by sums;

-- SQL92年版本语法
    --笛卡尔积：A(1,2,3) 和 B(a,b,c) 笛卡乐积操作后的结果为 [(1,a),(2,a),(3,a),(1,b),(2,b),(3,b),(1,c),(2,c),(3,c)]
    select * from emp,dept;
    --等值连接：笛卡乐积的结果进行条件筛选
    select * from emp,dept where emp.deptno=dept.deptno;
    --不等值连接
    select * from emp a, salgrade b where a.sal>=b.losal and a.sal<=b.hisal;
    select * from emp a, salgrade b where a.sal between b.losal and b.hisal;
    --自连接
    select a.ename,a.job,b.ename from emp a, emp b where a.mgr=b.empno;
    --外连接
        --左外连接：
        select a.ename "员工姓名",a.job "员工岗位",b.ename "领导姓名" from emp a, emp b where a.mgr=b.empno(+);
        --右外连接
        select a.ename "领导姓名",b.ename "员工姓名",b.job "员工岗位" from emp a, emp b where a.empno(+)=b.mgr;
-- SQL99年版本语法
    --笛卡尔积：A(1,2,3) 和 B(a,b,c) 笛卡乐积操作后的结果为 [(1,a),(2,a),(3,a),(1,b),(2,b),(3,b),(1,c),(2,c),(3,c)]
    select * from emp cross join dept;
    --筛选
        --自然连接：根据所有同名字段作等值连接
            select * from emp natural join dept;
            --指定部分字段作等值连接
            select * from emp join dept using(deptno);
            select * from emp inner join dept using(deptno);
            --不同字段作等值或不等值连接
            select * from emp a join dept b on a.deptno=b.deptno;
            select * from emp a inner join dept b on a.deptno=b.deptno;
            select * from emp a join salgrade b on a.sal>=b.losal and a.sal<=b.hisal;
            select * from emp a inner join salgrade b on a.sal>=b.losal and a.sal<=b.hisal;
    --外连接
        --左外连接
            select a.*,b.dname from emp a left join dept b on a.deptno=b.deptno;
        --右外连接
            select a.*,b.dname from emp a right join dept b on a.deptno=b.deptno;
        --全外连接
            select a.*,b.dname from emp a join dept b on a.deptno=b.deptno;
            select a.*,b.dname from emp a full outer join dept b on a.deptno=b.deptno;
    --自连接
        --左外连接
        select a.ename "员工姓名",a.job "员工岗位",b.ename "领导姓名" from emp a left join emp b on a.mgr=b.empno;
        --右外连接
        select a.ename "领导姓名",b.ename "员工姓名",b.job "员工岗位" from emp a right join emp b on a.empno=b.mgr;
        --全外连接
        select a.ename "领导姓名",b.ename "员工姓名",b.job "员工岗位" from emp a full outer join emp b on a.empno=b.mgr;

-- 查询部门为SCOTT用户所在的部门且工资他低的员工
select * from emp where deptno=(select deptno from emp where ename='SCOTT') and sal < (select sal from emp where ename='SCOTT');
select a.* from emp a inner join emp b on b.ename='SCOTT' and a.deptno=b.deptno and a.sal < b.sal;

-- 查询工资高于任意一个岗位为CLERK的员工工资的员工信息
select * from emp where sal > (select min(sal) from emp where job='CLERK');
select * from emp where sal > any (select sal from emp where job='CLERK');

-- exists的使用，可代替in
SELECT *
FROM emp
WHERE EXISTS (SELECT 1 FROM dept WHERE emp.deptno = dept.deptno);

SELECT *
FROM dept
WHERE EXISTS (SELECT 1 FROM salgrade);

-- in的使用，包括哪些值，多值，子查询
SELECT * FROM emp WHERE deptno IN (10,20);

-- any的使用，与some一样都是满足其中一个条件即可。
SELECT *
FROM emp
WHERE sal > any (SELECT sal FROM emp WHERE deptno = 10);

-- all的使用，表示子查询中的所有值都满足条件才可以。
SELECT *
FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE deptno = 20);
