drop table if exists student;
drop table if exists clazz;

-- 班级表
create table clazz(
    cno int(10) unsigned not null auto_increment,
    cname varchar(100) not null,
    cdesc varchar(300),
    primary key(cno),
    unique index(cname)
) engine=innodb default charset=utf8;

-- 向班级表添加数据
insert into clazz values(1,'PHP高级班','PHP构架的架构与实例讲解');
insert into clazz values(2,'PHP基础班','PHP语言的基本语法与函数和类库讲解');
insert into clazz values(3,'Java高级班','Java的SpringBoot框架讲解');
insert into clazz values(4,'Oracle班','Oracle从入门到精通班');

-- 学生表
create table student (
    sno int(10) unsigned not null auto_increment,
    sname varchar(100) not null,
    sage smallint(3) not null check(sage>0 and sage<150),
    ssex enum('男','女') not null,
    sfav varchar(500),
    sqq varchar(30),
    cno int(10) unsigned,
    primary key (sno),
    unique index(sname),
    unique index(sqq),
    foreign key(cno) references clazz(cno)
) engine=innodb default charset=utf8;
-- 上面student表的创建SQL中的check需要MariaDB 10.2+才会支持，其他

-- 向学生表添加数据
insert into student values(1,'张三',23,'男','唱歌','123456',1);
insert into student values(2,'李四',19,'男','跳舞','321124',1);
insert into student values(3,'王五',21,'男','画画','1247831',2);
insert into student values(4,'春花',33,'女','书法','3214551',2);
insert into student values(5,'小白',23,'女','看门','1001001',3);

--/ 随机生成学生记录100万，用于有无索引的测试

@delimiter $$;
drop function if exists random$$
create function random (start_num integer, end_num integer) returns integer
begin
    return floor(start_num + rand() * (end_num - start_num + 1));
end$$

drop procedure if exists batch_random_insert_student$$

create procedure batch_random_insert_student(v_records int)
begin
    declare v_i integer default 0;
    declare v_fav varchar(10) character set utf8;
    start transaction;
    while  v_i < v_records do
        set v_i = v_i + 1;
        set v_fav = case random(0,4)
            when 1 then '唱歌'
            when 2 then '跳舞'
            when 3 then '画画'
            when 4 then '书法'
            else '看门'
        end;
        insert into student values(
            null, -- sno
            concat('seq', v_i), -- sname
            random(18,35), -- sage
            if(random(0,1), '男', '女'), -- ssex
            v_fav, -- sfav
            4000000+v_i, -- sqq
            random(1,4) -- cno
        );
        -- 每10000条提交一次事务
        if v_i%10000 = 0 then
            commit;
        end if;
    end while;
end;
$$
@delimiter ;
$$

call batch_random_insert_student(1000000);

select * from student where sname in('seq910100','seq2342','seq323234','seq634343');
select * from student where sname in('seq323234','seq634343','seq532343','seq2340','seq232');
select * from student where sname in('seq532343','seq2340','seq232','seq999999');
select * from student where sname in('seq910100','seq2342','seq2340','seq232','seq999999');
select * from student where sname in('seq910100','seq2342','seq323234','seq634343','seq532343','seq2340','seq232','seq999999');
