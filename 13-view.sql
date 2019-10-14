drop view v$student;
create view v$student as select * from student natural join clazz;
drop view v$student2;
create view v$student2 as select * from student natural join clazz with read only;

select * from v$student;
select * from v$student2;
