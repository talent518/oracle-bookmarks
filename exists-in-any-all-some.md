# Oracle中exists、in、any、all、some的用法

## 1. exists的用法（可代替in）
  * 注意：exists首先执行外层查询，再执行内层查询，与IN相反
  * 语法： EXISTS subquery
  * 参数： subquery 是一个受限的 SELECT 语句 (不允许有 COMPUTE 子句和 INTO 关键字)。
  * 结果类型： Boolean 如果子查询包含行，则返回 TRUE ，否则返回 FLASE 。
  * 通俗讲：外查询的每一条记录，都代入到内查询中进行检验，如果内查询中有结果，返回true，保存该条记录；如果内查询中没有结果，返回false，舍弃该条记录。

    例如：
```SQL
SELECT *
FROM emp
WHERE EXISTS (SELECT 1 FROM dept WHERE emp.deptno = dept.deptno);
```

  * **注意：**例子中select 1 ，注意select后面可以加数字会作为表的一个新字段，不能加字符串或者字母，因为他会和表中的字段进行对比，表中没有一样的字段名就会报错。
    
  * exists子句的解析过程：**分析器先找到关键字SELECT，然后跳到FROM关键字将EMP表导入内存**，并通过指针找到第一条记录，接着找到WHERE关键字计算它的条件表达式，如果为真那么把这条记录装到一个虚表当中，指针再指向下一条记录。如果为假那么指针直接指向下一条记录，而不进行其它操作。一直检索完整个表，并把检索出来的虚拟表返回给用户。EXISTS是条件表达式的一部分，它也有一个返回值(true或false)。
    
  * **注意：将表导入内存中时，接着找到where关键字，如果没有找到where就回到select关键字，分析后面的字段。**
    
  * 本质：就是返回一个含有真假的虚表，来决定是否执行该条外查询语句。exists子句是根据where后面的条件判断真假
    
  * **外部查询的项和内部查询项对比时只会看是否为ture，如果为ture则列出结果。**
    例子：
```SQL
SELECT *
FROM dept
WHERE EXISTS (SELECT 1 FROM salgrade);
```
    结果会返回dept表的所有记录，因为exists（）表示都为真。

## 2. in的用法
用于匹配多个定值中的一个，或使用子查询
```SQL
SELECT * FROM emp WHERE deptno IN (10,20);
```

## 3. any的用法
表示子查询中有一个值满足条件即可。
    \> any（单列多行子查询）相当于满足大于最小值的都可以。
    **例子：**查询比10号部门某个员工工资高的员工信息
```SQL
SELECT *
FROM emp
WHERE sal > any (SELECT sal FROM emp WHERE deptno = 10);
```

## 4. some的用法
some的用法和any一样：都是表中其中的一个满足条件即可。

## 5. all的用法
表示子查询中的所有值都满足条件才可以。
    \> all（单列多行子查询）相当于满足大于最大值的都可以（类比any比较学习）
    **例子：**查询比20号部门所有员工工资高的员工信息
```SQL
select * from emp where sal > all ( select sal from emp where deptno = 20);
```
