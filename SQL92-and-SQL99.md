# SQL92和SQL99多表查询

## SQL1992
  * 笛卡尔积 （表乘表）
  * 等值连接 表的连接条件使用“=”
  * 非等值连接 表的连接条件使用“>、>=、 <、<=、!=、any等”
  * 自连接 自己连接自己
  * 外连接
    * 左外连接，“(+)”在等号右边
    * 右外连接，“(+)”在等号左边
    * “(+)”在哪一边的列，该表就补充null

## SQL1999
  * cross join 交叉连接 （笛卡尔积） ，不需要on关键字
  * natural join 自然连接 （找两个表中相同的列，进行等值匹配），不需要on关键字
  * inner join 内连接
    * 必须有on关键字，on表示连接条件
    * inner关键字可以省略
  * outer join 外连接，outer关键字可以省略
    * left outer join
    * right outer join
    * full outer join
