--drop index i_stu_sname;
--create index i_stu_sname on student(sname asc);

alter table student drop constraint uk_sname;
alter table student add constraint uk_sname unique(sname);

-- 查看SQL的索引使用情况
explain plan for select * from student where sname in('seq910100','seq2342','seq323234','seq634343','seq532343','seq2340','seq232','seq999999');
select * from table(dbms_xplan.display);

explain plan for select sname from student order by sname desc;
select * from table(dbms_xplan.display);

explain plan for select * from student order by sname asc;
select * from table(dbms_xplan.display);

explain plan for select a.* from student a inner join (select sname,ROWNUM RN from student where ROWNUM <= 100 order by sname desc) b on a.sname=b.sname order by b.RN;
select * from table(dbms_xplan.display);

-- 不会使用索引
select * from student order by sname asc;

-- 可以使用到索引uk_sname进行排序
select * from student where sname in('seq910100','seq2342','seq323234','seq634343','seq532343','seq2340','seq232','seq999999');
select * from student a, (select sname,ROWNUM RN from student where ROWNUM <= 200 order by sname desc) b where a.sname=b.sname and b.RN>100 order by b.RN;
select * from (select sname,ROWNUM RN from student where ROWNUM<=200 order by sname desc) a where RN>100;
