# SCOTT用户中的表结构说明
包括DEPT、EMP、SALGRADE和BONUS共4张表。

## DEPT: 部门表
  * DEPTNO
    * 类型：NUMBER(2)
    * 描述：表示部门编号，由两位数字所组成
    * 主键名：PK_DEPT
  * DNAME
    * 类型：VARCHAR2(14)
    * 描述：部门名称，最多由14个字符所组成
  * LOC
    * 类型：VARCHAR2(13)
    * 描述：部门所在的位置
```
SQL> desc SCOTT.DEPT;
 Name              Null?    Type
 ----------------- -------- ------------
 DEPTNO            NOT NULL NUMBER(2)
 DNAME                      VARCHAR2(14)
 LOC                        VARCHAR2(13)
```

## EMP: 雇员表/员工表
  * EMPNO
    * 类型：NUMBER(4)
    * 描述：雇员的编号，由四位数字所组成
    * 主键名：PK_EMP
  * ENAME
    * 类型：VARCHAR2(10)
    * 描述：雇员的姓名，由10位字符所组成
  * JOB
    * 类型：VARCHAR2(9)
    * 描述：雇员的职位
  * MGR
    * 类型：NUMBER(4)
    * 描述：雇员对应的领导编号，领导也是雇员
  * HIREDATE
    * 类型：DATE
    * 描述：雇员的雇佣日期
  * SAL
    * 类型：NUMBER(7,2)
    * 描述：基本工资，其中有两位小数，五倍整数，一共是七位
  * COMM
    * 类型：NUMBER(7,2)
    * 描述：奖金，佣金
  * DEPTNO
    * 类型：NUMBER(2)
    * 描述：雇员所在的部门编号
    * 外键名：FK_DEPTNO
    * 引用列：DEPT.DEPTNO
```
SQL> desc SCOTT.EMP;
 Name              Null?    Type
 ----------------- -------- ------------
 EMPNO             NOT NULL NUMBER(4)
 ENAME                      VARCHAR2(10)
 JOB                        VARCHAR2(9)
 MGR                        NUMBER(4)
 HIREDATE                   DATE
 SAL                        NUMBER(7,2)
 COMM                       NUMBER(7,2)
 DEPTNO                     NUMBER(2)
```

## SALGRADE: 工资等级表
  * GRADE
    * 类型：NUMBER
    * 描述：工资的等级
  * LOSAL
    * 类型：NUMBER
    * 描述：此等级的最低工资
  * HISAL
    * 类型：NUMBER
    * 描述：此等级的最高工资
```
SQL> desc SCOTT.SALGRADE;
 Name              Null?    Type
 ----------------- -------- ------------
 GRADE                      NUMBER
 LOSAL                      NUMBER
 HISAL                      NUMBER
```

## BONUS: 工资表
  * ENAME
    * 类型：VARCHAR2(10)
    * 描述：雇员姓名
  * JOB
    * 类型：VARCHAR2(9)
    * 描述：雇员职位
  * SAL
    * 类型：NUMBER
    * 描述：雇员的工资
  * COMM
    * 类型：NUMBER
    * 描述：雇员的奖金
```
SQL> desc SCOTT.BONUS;
 Name              Null?    Type
 ----------------- -------- ------------
 ENAME                      VARCHAR2(10)
 JOB                        VARCHAR2(9)
 SAL                        NUMBER
 COMM                       NUMBER
```