-- 查询student表，按sname升序，显示第901到1000的记录，共100条
    -- 速度稍慢
    select * from (select a.*,ROWNUM RN from (select * from student order by sname asc) a where ROWNUM <= 1000) b where RN > 900;
    -- 速度稍快
    select * from student c, (select a.*,ROWNUM RN from (select ROWID ID from student order by sname asc) a where ROWNUM <= 1000) b where c.ROWID=b.ID AND RN > 900 order by b.RN;

-- 按sname升序，前100条记录
    -- 速度稍慢
    select * from (select * from student order by sname asc) a where ROWNUM <= 100;
    -- 速度稍快
    select a.* from student a, (select a.ID,ROWNUM RN from (select ROWID ID from student order by sname asc) a where ROWNUM <= 100) b where a.ROWID=b.ID order by b.RN asc;

-- 按sname升级最后100条
    -- 速度稍慢
    select * from (select * from student order by sname desc) a where ROWNUM <= 100 order by ROWNUM desc;
    -- 速度稍快
    select a.* from student a, (select c.ID, ROWNUM RN from (select ROWID ID from student order by sname desc) c where ROWNUM<= 100) b WHERE a.ROWID=b.ID order by b.RN desc;
