-- 数据来源为(employee data)：https://github.com/datacharmer/test_db
-- 数据导入：mysql -hlocalhost -uroot -p密码 < employees.sql

-- 查看索引
SHOW INDEX FROM employees.titles;

alter table employees.titles drop index emp_no;

-- 情况一：全列匹配
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001' AND title='Senior Engineer' AND from_date='1986-06-26';
-- 理论上索引对顺序是敏感的，但是由于MySQL的查询优化器会自动调整where子句的条件顺序以使用适合的索引
EXPLAIN SELECT * FROM employees.titles WHERE from_date='1986-06-26' AND emp_no='10001' AND title='Senior Engineer';

-- 情况二：最左前缀匹配
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001';

-- 情况三：查询条件用到了索引中列的精确匹配，但是中间某个条件未提供
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001' AND from_date='1986-06-26';
-- 增加一个辅助索引
alter table employees.titles add index emp_no(emp_no, from_date);
EXPLAIN SELECT * FROM employees.titles use index(emp_no) WHERE emp_no='10001' AND from_date='1986-06-26';

-- 用IN填补“填坑”，如果查询结果很多，就只能使用辅助索引了
EXPLAIN SELECT * FROM employees.titles
WHERE emp_no='10001'
AND title IN ('Senior Engineer', 'Staff', 'Engineer', 'Senior Staff', 'Assistant Engineer', 'Technique Leader', 'Manager')
AND from_date='1986-06-26';

-- 情况四：查询条件没有指定索引第一列
-- 由于不是最左前缀，索引这样的查询显然用不到索引
EXPLAIN SELECT * FROM employees.titles WHERE from_date='1986-06-26';

-- 情况五：匹配某列的前缀字符串
-- 如果通配符%不出现在开头，则可以用到索引，但根据具体情况不同可能只会用其中一个前缀
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001' AND title LIKE 'Senior%';

-- 情况六：范围查询
-- 范围列可以用到索引（必须是最左前缀），但是范围列后面的列无法用到索引。同时，索引最多用于一个范围列，因此如果查询条件中有两个范围列则无法全用到索引。
EXPLAIN SELECT * FROM employees.titles WHERE emp_no < '10010' and title='Senior Engineer';
EXPLAIN SELECT * FROM employees.titles
WHERE emp_no < '10010'
AND title='Senior Engineer'
AND from_date BETWEEN '1986-01-01' AND '1986-12-31';
-- 可以看到索引对第二个范围索引无能为力。
-- 这里特别要说明MySQL一个有意思的地方，那就是仅用explain可能无法区分范围索引和多值匹配，因为在type中这两者都显示为range。
-- 同时，用了“between”并不意味着就是范围查询
EXPLAIN SELECT * FROM employees.titles
WHERE emp_no BETWEEN '10001' AND '10010'
AND title='Senior Engineer'
AND from_date BETWEEN '1986-01-01' AND '1986-12-31';
-- 看起来是用了两个范围查询，但作用于emp_no上的“BETWEEN”实际上相当于“IN”，也就是说emp_no实际是多值精确匹配。
-- 可以看到这个查询用到了索引全部三个列。
-- 因此在MySQL中要谨慎地区分多值匹配和范围匹配，否则会对MySQL的行为产生困惑。

-- 情况七：查询条件中含有函数或表达式
-- 虽然这个查询和情况五中功能相同，但是由于使用了函数left，则无法为title列应用索引，而情况五中用LIKE则可以。
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001' AND left(title, 6)='Senior';
-- 显然这个查询等价于查询emp_no为10001的函数，但是由于查询条件是一个表达式，MySQL无法为其使用索引。
-- 看来MySQL还没有智能到自动优化常量表达式的程度，因此在写查询语句时尽量避免表达式出现在查询中，而是先手工私下代数运算，转换为无表达式的查询语句。


-- 索引选择性与前缀索引
-- 索引并不是越多越好。一般两种情况下不建议建索引。
-- 第一种情况是表记录比较少
-- 另一种不建议建索引的情况是索引的选择性较低。
SELECT count(DISTINCT(title))/count(*) AS Selectivity FROM employees.titles;
-- title的选择性不足0.0001（精确值为0.00001579），所以实在没有什么必要为其单独建索引。

-- 有一种与索引选择性有关的索引优化策略叫做前缀索引，就是用列的前缀代替整个列作为索引key，
-- 当前缀长度合适时，可以做到既使得前缀索引的选择性接近全列索引，同时因为索引key变短而减少了索引文件的大小和维护开销。
-- 只有一个索引<emp_no>，那么如果我们想按名字搜索一个人，就只能全表扫描了
EXPLAIN SELECT * FROM employees.employees WHERE first_name='Eric' AND last_name='Anido';
-- 如果频繁按名字搜索员工，这样显然效率很低，因此我们可以考虑建索引。
-- 有两种选择，建<first_name>或<first_name, last_name>，看下两个索引的选择性：
SELECT count(DISTINCT(first_name))/count(*) AS Selectivity FROM employees.employees;
SELECT count(DISTINCT(concat(first_name, last_name)))/count(*) AS Selectivity FROM employees.employees;
SELECT count(DISTINCT(concat(first_name, left(last_name,3))))/count(*) AS Selectivity FROM employees.employees;
-- 选择性还不错，但离0.9313还是有点距离，那么把last_name前缀加到4
SELECT count(DISTINCT(concat(first_name, left(last_name,4))))/count(*) AS Selectivity FROM employees.employees;
-- 这时选择性已经很理想了，而这个索引的长度只有18*4，这里的乘以4是因为utf8一个字占用的字节数
ALTER TABLE employees.employees ADD INDEX `first_name_last_name4` (first_name, last_name(4));
SELECT * FROM employees.employees WHERE first_name='Eric' AND last_name='Anido';
-- 加这个索引前0.3秒，后不足1毫秒，速度已经很好了
-- 前缀索引兼顾索引大小和查询速度，但是其缺点是不能用于ORDER BY和GROUP BY操作，也不能用于Covering index（即当索引本身包含查询所需全部数据时，不再访问数据文件本身）。

-- InnoDB的主键选择与插入优化
-- 如果表使用自增主键，那么每次插入新的记录，记录就会顺序添加到当前索引节点的后续位置，当一页写满，就会自动开辟一个新的页。
-- 这样就会形成一个紧凑的索引结构，近似顺序填满。由于每次插入时也不需要移动已有数据，因此效率很高，也不会增加很多开销在维护索引上。
--
-- 如果使用非自增主键（如果身份证号或学号等），由于每次插入主键的值近似于随机，因此每次新纪录都要被插到现有索引页得中间某个位置
-- 此时MySQL不得不为了将新记录插到合适位置而移动数据，甚至目标页面可能已经被回写到磁盘上而从缓存中清掉，此时又要从磁盘上读回来，
-- 这增加了很多开销，同时频繁的移动、分页操作造成了大量的碎片，得到了不够紧凑的索引结构，后续不得不通过OPTIMIZE TABLE来重建表并优化填充页面。
-- 
-- 因此，只要可以，请尽量在InnoDB上采用自增字段做主键。

-- ================================================
-- 总结：InnoDB默认使用B+Tree索引，B-Tree对磁盘IO操作过于频繁，而B+Tree是按磁盘的页存取的减少磁盘IO的访问，所以B+Tree是首选
  -- 数据行存储在主键索引的叶子节点上，
  -- 如果无主键索引，mysql自动选择并存储在有唯一索引的叶子节点上
  -- 如果也无一个唯一索引，mysql会自动创建一个隐藏的自增主键用来将数据行保存其B+Tree的叶子节点上
  -- 
  -- 索引应用方式有：全列匹配或最左前缀匹配，理论上mysql索引是顺序敏感的，但mysql会自动调整where子句的顺序以做到与索引顺序一致
  -- 为了减小索引大小，可以对字段做前缀索引，缺点：不能应用于group by、order by和Covering index(explain中extra里出现了using index就说明使用了，中文意思是：覆盖索引扫描)上
  -- 当索引有查询所需全部数据时就不需要访问数据文件本身了，性能自然就高了
  -- 
  -- 添加索引的条件：不重复数/记录总数 >= 0.9 为好

select count(1) from employees.titles;

SET profiling = 1;
SHOW PROFILES;
SHOW PROFILE;
