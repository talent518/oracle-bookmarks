drop table student;
drop table clazz;

-- 班级表
create table clazz(
    cno number(10) constraint pk_cno primary key,
    cname varchar2(100) constraint uk_cname unique not null,
    cdesc varchar2(300)
);

-- 向班级表添加数据
insert into clazz values(1,'PHP高级班','PHP构架的架构与实例讲解');
insert into clazz values(2,'PHP基础班','PHP语言的基本语法与函数和类库讲解');
insert into clazz values(3,'Java高级班','Java的SpringBoot框架讲解');
insert into clazz values(4,'Oracle班','Oracle从入门到精通班');

-- 学生表
create table student (
    sno number(10) constraint pk_sno primary key,
    sname varchar2(100) constraint nn_sname not null,
    sage number(3) constraint chk_sage check(sage>0 and sage < 150),
    ssex char(4) constraint chk_ssex check(ssex='男' or ssex='女'),
    sfav varchar2(500),
    sqq varchar2(30) constraint uk_sqq unique,
    -- cno number(10) references clazz(cno)
    cno number(10) constraint fk_cno references clazz(cno) -- on delete cascade
    -- cno number(10),
    -- constraint fk_cno foreign key (cno) references clazz (cno)
);

-- 为student表添加cno外键约束
--alter table student add CONSTRAINT FK_cno FOREIGN KEY (CNO) REFERENCES "CLAZZ" ("CNO");
-- 禁用外键/检查约束
--alter table student disable constraint fk_cno;
-- 启用外键/检查约束
--alter table student enable constraint fk_cno;
-- 删除外键/检查约束
--alter table student drop constraint fk_cno;
-- 添加check结束语法：ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (column_name condition) [DISABLE];
-- 修改check约束
--alter table student drop constraint chk_ssex;
--alter table student add constraint chk_ssex check(ssex='男' or ssex='女' or ssex='保密');

-- 向学生表添加数据
insert into student values(1,'张三',23,'男','唱歌','123456',1);
insert into student values(2,'李四',19,'男','跳舞','321124',1);
insert into student values(3,'王五',21,'男','画画','1247831',2);
insert into student values(4,'春花',33,'女','书法','3214551',2);
insert into student values(5,'小白',23,'女','看门','1001001',3);

-- 需在外键约束中添加 on delete cascade 关键字方可做到级联删除
-- delete from clazz where cno=1;

-- 级联删除表：drop table table_name cascade constraints
-- 添加字段的语法：alter table table_name add (column datatype [default value][null/not null],….);
-- 修改字段的语法：alter table table_name modify (column datatype [default value][null/not null],….);
-- 删除字段的语法：alter table table_name drop (column);
-- 重命名字段的语法：alter table table_name rename column src_field_name to dest_field_name;
-- 表重命名语法：alter table table_name rename to new_table_name;

-- 添加自增字段之序列的使用
DROP sequence seq_student_sno;
CREATE sequence seq_student_sno START WITH 6 increment BY 1 nomaxvalue nominvalue cache 20 ORDER;
--随机生成学生记录100万，用于有无索引的测试
--/
declare
    v_i integer default 0;
    v_r integer;
    v_sex student.ssex%type;
    v_fav student.sfav%type;
    v_cno student.cno%type;
    l_start_time PLS_INTEGER;
    l_end_time PLS_INTEGER;
begin
    commit; -- 首先进行一个可选的commit提交  确保set transaction 为事物中第一条语句
    set transaction read write name 'random_student'; -- 使用name为事物命名    设置只读状态
    l_start_time := dbms_utility.get_time();
    loop
        v_i := v_i + 1;
        exit when v_i > 1000000; -- 随机生成的记录数
        v_r := dbms_random.value(1,2);
        if v_r = 1 then
            v_sex := '男';
        else
            v_sex := '女';
        end if;
        v_r := dbms_random.value(1,5);
        v_fav := case v_r
            when 1 then '唱歌'
            when 2 then '跳舞'
            when 3 then '画画'
            when 4 then '书法'
            else '看门'
        end;
        v_cno := dbms_random.value(1,4);
        insert into student values(
            seq_student_sno.nextval, -- sno
            'seq'||seq_student_sno.currval, -- sname
            dbms_random.value(18,35), -- sage
            v_sex, -- ssex
            v_fav, -- sfav
            to_char(4000000+seq_student_sno.currval), -- sqq
            v_cno -- cno
        );
        -- 每10000条提交一次事务
        if mod(v_i, 10000) = 0 then
            commit;
            l_end_time := dbms_utility.get_time();
            
            dbms_output.put_line(v_i || ', run time: ' || (l_end_time-l_start_time)/100 || ' seconds');
            
            l_start_time := l_end_time;
        end if;
    end loop;
end;
/
--select seq_student_sno.currval from dual;

-- 删除索引
--drop index i_stu_sname;
-- 创建索引
--create index i_stu_sname on student(sname asc);
alter table student drop constraint uk_sname;
alter table student add constraint uk_sname unique(sname);

select * from student where sname in('seq910100','seq2342','seq323234','seq634343');
select * from student where sname in('seq323234','seq634343','seq532343','seq2340','seq232');
select * from student where sname in('seq532343','seq2340','seq232','seq999999');
select * from student where sname in('seq910100','seq2342','seq2340','seq232','seq999999');
select * from student where sname in('seq910100','seq2342','seq323234','seq634343','seq532343','seq2340','seq232','seq999999');
