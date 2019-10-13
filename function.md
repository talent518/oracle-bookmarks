# Oracle SQL常用内置系统函数总结

## 1. 数学函数
  * abs(n)：返回数字n的绝对值
  * ceil(n)：返回>=数字n的最小整数
  * floor(n)：返回<=数字n的最大整数
  * round(n,[m])：做四舍五入运算,如果m缺省则四舍五入到整数位
    m<0,四舍五入到小数点的前m位,m>0四舍五入到小数点的后m位
  * trunc(n,[m])：截取数字,如果m缺省则将小数位截去
    m<0,截取到小数点的前m位,m>0截取到小数点的后m位
```SQL
SELECT
    abs(-2.3), --结果为：2.3
    ceil(-2.6), --结果为：-2, 
    ceil(2.6), --结果为：3
    floor(-2.6), --结果为：-3, 
    floor(2.6), --结果为：2
    round(-666.588), --结果为：-667
    round(-666.588,2), --结果为：-666.59
    round(-666.588,-2), --结果为：-700
    trunc(-666.588), --结果为：-666
    trunc(-666.588,2), --结果为：-666.58
    trunc(-666.588,-2) --结果为：-600
FROM dual;
```

  * sqrt(x)：返回数字x(x必须大于0)的平方根
  * power(x,y)：返回数字x的y次幂，底数x和指数y都可以是任意数字,但是如果底数x为负数则指数y必须为正数
  * exp(x)：返回常量e(2.71828183....)的x次幂
  * ln(x)：返回数字x(x必须大于0)的自然对数
  * log(x,y)：返回以x为底(除0及1的正整数)m的(任何正整数)对数
  * mod(x,y)：返回x除以y的余数,如果数字m=0则返回n
```SQL
SELECT
    sqrt(4), --结果为：2
    power(2,3), --结果为：8
    exp(1), --结果为：2.71828183
    ln(10), --结果为：2.30258509
    log(2,8), --结果为：3
    mod(5,2) --结果为：1
FROM dual;
```
  * cos(n)：返回数字n(弧度单位表示的角度值)的余弦值
  * cosh(n)：返回数字n的双曲余弦值
  * acos(n)：返回数字n的反余弦值，求的结果单位为弧度，n的范围为 -1 < n < 1
  * sin(n)：返回数字n(弧度单位表示的角度值)的正弦值
  * sinh(n,m)：返回数字n的双曲正弦值
  * asin(n,m)：返回数字n的反正弦值，求的结果单位为弧度，n的范围为 -1 < n < 1
  * tan(n)：返回数字n(弧度表示的角度值)的正切值
  * tanh(n)：返回数字n的双曲正切值
  * atan(n)：返回数字n的反正切值，求的结果单位为弧度，n的范围任意数值
  * atan(n,m)：返回数字n/m的反正切值，求的结果单位为弧度，你可以为任意数值，m不可为0
```SQL
SELECT
    cos(0.5), --结果为：.877582562
    cosh(2), --结果为：3.76219569
    acos(1), --结果为：0
    sin(0.5), --结果为：.479425539
    sinh(2), --结果为：3.62686041
    asin(0), --结果为：0
    tan(0.5), --结果为：.54630249
    tanh(2), --结果为：.96402758
    atan(8), --结果为：1.44644133
    atan(16/2) --结果为：1.44644133
FROM dual;
```

## 2. 字符串函数
  * ascii(n)：返回字符c的ascii值
  * chr(n)：将ascii值转换为对应的字符
  * initcap(s)：将字符串s所有的单词(单词是用.空格或给字母数字字符由空格,控制字符,标点符号进行分隔)的首字母大写,其余小写
  * lower(s)：将字符串s中所有的字符转换为小写
  * upper(s)：将字符串s中所有的字符转换为大写
  * concat(s1,s2)：将字符串s2连接在s1后面，等同于操作符||
  * length(s)：将返回字串s的长度，返回的长度包括其中的所有空格(尾部空格也算)；如果s为null，则返回null
```SQL
SELECT
    ascii('A'), --结果为：65
    chr(65), --结果为：A
    concat('Hello','World'), --结果为：HelloWorld
    initcap('hello woRld'), --结果为：Hello World
    lower('HeLLo woRld'), --结果为：hello world
    upper('HeLLo woRld'), --结果为：HELLO WORLD
    length('HeLLo woRld'), --结果为：11
    length('天下英雄出我辈') --结果为：7
FROM dual;
```
**注意：**
> 如果中文乱码或者报“ORA-01756: quoted string not properly terminated”错误，需要设置环境变量：
>
>   * unix系统：export NLS_LANG=AMERICAN_AMERICA.UTF8
>   * win32位系统：修改注册表 HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\KEY_OraClient11g_home1 下的 NLS_LANG值为 AMERICAN_AMERICA.UTF8
>   * win64位系统：修改注册表 HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\ORACLE\KEY_OraClient11g_home1 下的 NLS_LANG值为 AMERICAN_AMERICA.UTF8

  * lpad(str1,n,str2)：在字串str1的左端填充字串str2，直至填充后的str1的总长度为n
    如果不指定str2则默认为空格
    如果s1的长度>n，则直接返回s1左端的n个字符
  * rpad(str1,n,str2)：在字串str1的右端填充字串str2，直至填充后的str1的总长度为n
    如果不指定str2则默认为空格
    如果str1的长度>n，则直接返回str1左端的n个字符
```SQL
SELECT
    lpad('a',10,'8'), --结果为：888888888a
    lpad('SnnnnnnnnR',6,'8'), --结果为：Snnnnn
    rpad('a',10,'8'), --结果为：a888888888
    rpad('SnnnnnnnnR',6,'8') --结果为：Snnnnn
FROM dual;
```

  * instr(str1,str2,n,m)：取得子串str2在字串str1中的位置
    n表示在str1中开始搜索的位置，m表示字串str2出现的次数
    如果n为负数，则表示从尾部开始搜索，n与m默认为1
  * substr(str, m, n): 字符串截取函数,str需要截取的字符串,从str的m开始，截取长度为n的子串
    m截取字符串的开始位置(注当m等于0或1时，都是从第一位开始截取),m>0表示从头开始搜索，m<0表示从尾开始,
    n要截取的字符串的长度。
  * substr(str, m): 字符串截取函数,从第m个字符开始截取后面所有的字符串，str需要截取的字符串,
    m截取字符串的开始位置(注当m等于0或1时，都是从第一位开始截取)。
```SQL
SELECT
    substr('helloworld',5), --结果为：oworld
    substr('helloworld',1) --结果为：helloworld
FROM dual;
```

  * ltrim(s1,str)：从左端开始逐一取得字串s1左端包含的str中的任何字符
    当遇到不是str中的字符是，则结束并返回剩余结果
  * rtrim(s1,str)：从右端开始逐一取得字串s1右端包含的str中的任何字符
    当遇到不是str中的字符是，则结束并返回剩余结果
  * trim(c FROM str)：从字串str的头部、尾部、或两端截去字符c（c只能够是一个字符）
    当遇到不是str中的字符是，则结束并返回剩余结果
```SQL
SELECT
    ltrim('terry','t'), --结果为：erry
    ltrim('terry','ter'), --结果为：y
    ltrim('terry','e'), --结果为：terry
    rtrim('terry','y'), --结果为：terr
    rtrim('terry','ry'), --结果为：te
    rtrim('terry','yre'), --结果为：t
    trim('e' from 'terry'), --结果为：terry
    trim('t' from 'terry'), --结果为：erry
    trim('y' from 'terryy') --结果为：terr
FROM dual;
```

  * replace(s1,s2,s3)：将s1字串中的子串s2用s3替代，如果s2为null则返回原来的字串s1
    注意：如果s3为null，则会去掉子串s2
  * translate(s1,froms,tos)：将字符串s1按照froms和tos的对应关系进行转换
```SQL
SELECT
    replace('风清扬_array','风清扬','令狐冲'), --结果为：令狐冲_array
    replace('风清扬_array','风清扬'), --结果为：_array
    translate('aerry','abcdefgxyz','888888666') --结果为：88rr6
FROM dual;
```

  * regexp_substr(s1,pattern,position,occurrence,match_parameter)：
    按照正则表达式pattern从s1字串中的position位置开始
    截取第occurrence次出现的匹配pattern的字串，matche_parameter为默认匹配的文本
    position，occurrence，matche_parameter 默认为1,1," "
  * regexp_replace(s1,pattern,position,occurrence,match_parameter)：
    正则表达式扩展replace的功能,用于按照特定的表达式pattern的规则替换字串串s1
    s1指定替换字符串，position指定起始搜索位置
    occurrence指定替换出现的第n个字符串
    matche_parameter指定默认匹配操作的文本串
  * regexp_like()：用正则表达式扩展后的like
  * regexp_instr()：用正则表达式扩展后的instr
```SQL
SELECT
    regexp_substr('我的箱helloword@126.com','[[:lower:]]{1,}+@{1}+[[:alnum:]]{1,}+\.{1}+[[:alpha:]]{1,}'), --结果为：helloword@126.com
    regexp_replace('这是什么http://www.space.com.tw/product','http://([[:alnum:]]+\.?){3,4}+[[:print:]]{1,}','www.terry.com') --结果为：这是什么www.terry.com
FROM dual;
```

## 3. 日期函数
  * sysdate：返回系统当前日期时间
  * systimestamp：返回系统当前日期时间和时区
  * current_date：返回当前回话时区所对应的日期和时间
  * current_timestamp：返回当前回话时区所对应的日期时间
  * localtimestamp：返回当前回话时区所对应的日期时间
  * systimestamp：返回系统当前日期时间和时区
  * sessiontimezone：返回当前回话所在的时区
  * dbtimezone：返回资料库所在的时区
```SQL
SELECT
    sysdate, --结果为：13-OCT-19
    systimestamp, --结果为：13-OCT-19 05.52.10.670774 PM +08:00
    current_date, --结果为：13-OCT-19
    current_timestamp, --结果为：13-OCT-19 05.52.10.000000 PM +08:00
    localtimestamp, --结果为：13-OCT-19 05.52.10.000000 PM
    sessiontimezone, --结果为：+08:00
    dbtimezone --结果为：+00:00
FROM dual;
```

  * add_months(d,n)：返回指定日期d之后(或前)的n个月所对应的日期时间;n>0：之后，n<0：之前
  * extract()：用于从特定的日期时间值里取出所需要的特定数据(如日期、月份、日、时间等)
  * last_day(d):用于返回指定日期所在月份的最后一天
  * next_day(d,char)：返回指定日期后的一个工作日(由char指定)所对应的日前
  * round(d[,fmt])：返回日期时间的四舍五如结果，如果fmt指定年度則7月1日为分界线
    如果fmt指定月則16日为分界线，如果fmt指定天則中午12:00为分界线
  * trunc(d[,fmt])：用于截断日期时间数据，如果fmt指定年度则结果为本年的1月1日
    如果fmt指定月则结果为本月1日，如果fmt空则结果为为截取日期时间数据中的日期
```SQL
SELECT
    sysdate, --结果为：13-OCT-19
    add_months(sysdate,4), --结果为：13-FEB-20
    add_months(sysdate,-4), --结果为：13-JUN-19
    extract(MONTH from sysdate), --结果为：10
    last_day(sysdate), --结果为：31-OCT-19
    next_day(sysdate,'sunday'), --结果为：20-OCT-19
    round(sysdate,'YEAR'), --结果为：01-JAN-20
    round(sysdate,'MONTH'), --结果为：01-OCT-19
    round(sysdate,'DAY'), --结果为：13-OCT-19
    round(sysdate), --结果为：14-OCT-19
    trunc(sysdate,'YEAR'), --结果为：01-JAN-19
    trunc(sysdate,'MONTH'), --结果为：01-OCT-19
    trunc(sysdate,'DAY'), --结果为：13-OCT-19
    trunc(sysdate) --结果为：13-OCT-19
FROM dual;
```

  * to_timestamp(s1,fmt)：将符合特定日期和时间按格式的字符串转变为 timestamp 类型
  * month_between(d1,d2)：返回日期d1和d2之间相差的月份数，如果d1<d2则返回负数，如果d1和d2的天数相同或都是月底则返回整数,否则oracle以每月31天为准来计算结果的小数部份
```SQL
SELECT
    to_timestamp('2015-03-25 11:30:00','YYYY-MM-DD HH24:MI:SS'), --结果为：2015-03-25 11:30:00
    sysdate, --结果为：2019-10-13 18:17:34
    months_between(sysdate,to_date('2012/06/30','YYYY/MM/DD')) --结果为：87.47619997013142174432497013142174432497
FROM dual;
```

## 4. 转换函数
  * to_date(s1[,fmt[,nlsparams]]):把一个字符串转换为一个DATE类型的变量.
    如果指定了fmt,就按fmt格式转换成一个日期类型.
    如果没有指定fmt,使用的就是该会话的缺省日期格式.
    注：在使用Oracle的to_date函数来做日期转换时，很多Java程序员也许会直接的采用'yyyy-MM-dd HH:mm:ss'的格式作为格式进行转换，但是在Oracle中会引起错误：'ORA 01810 格式代码出现两次',原因是SQL中不区分大小写，MM和mm被认为是相同的格式代码，所以Oracle的SQL采用了mi代替分钟,即: 'yyyy-MM-dd HH24:mi:ss'
```SQL
SELECT
    to_date('2005-01-01 13:14:20','yyyy-MM-dd HH24:mi:ss') --结果为：2005/1/1 13:14:20
FROM dual;
```

  * to_char(num[,fmt])：把日期或数字转换字符串。
    如果指定了格式字符串fmt,则按指定格式转换。
```SQL
SELECT
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), --结果为：2017-10-10 15:53:31
    to_char(sysdate, 'yyyymmddhh24miss'), --结果为：20171010155331
    to_char(258.45) --结果为：258.45
FROM dual;
```

  * cast(expr AS type_name): 用于将某种数据类型的数据显式转换为另一种数据类型的数据。
    函数的参数有两部分，源值expr和目标数据类型type_name，中间用AS关键字分隔。
```SQL
SELECT
    cast('123.4567' AS NUMBER(10,2)), --结果为：123.46
    cast('2323' as char(6)), --结果为：2323
    cast(to_date('20110419010101','yyyy-mm-dd hh24:mi:ss') as date) --结果为：2011/4/19 1:01:01
FROM dual;
```

  * numtodsinterval(num,expr): 将数字按转换单位转换成相应 interval day to second 时间段类型,转换单位expr必须是以下值之一：day,hour,minute 或 second。
  * numtoyminterval(num,expr): 将数字按转换单位转换成相应 interval year to month 时间段类型,转换单位expr必须是以下值之一：day,hour,year 或 month。
```SQL
SELECT
    NUMTOYMINTERVAL(100000000, 'MONTH'), --结果为：+008333333-04
    NUMTOYMINTERVAL(100000, 'YEAR'), --结果为：+000100000-00
    NUMTODSINTERVAL(150, 'DAY'), --结果为：+000000150 00:00:00.000000000
    NUMTODSINTERVAL(1500, 'HOUR'), --结果为：+000000062 12:00:00.000000000
    NUMTODSINTERVAL(15000, 'MINUTE'), --结果为：+000000010 10:00:00.000000000
    NUMTODSINTERVAL(150000, 'SECOND') --结果为：+000000001 17:40:00.000000000
FROM dual;
```

  * to_dsinterval(s1): 将字符串s1转换为interval day TO second类型的数据。
  * to_yminterval(s1): 将字符串s1转换为interval year to month类型的数据。
```SQL
SELECT
    to_dsinterval('150 08:30:00'), --结果为：+000000150 08:30:00.000000000
    to_dsinterval('80 12:30:00'), --结果为：+000000080 12:30:00.000000000
    to_yminterval('03-11'), --结果为：+000000003-11
    to_yminterval('01-05') --结果为：+000000001-05
FROM dual;
```

  * chr(code):chr函数将ASCII码code转换为对应字符　　
    chr(9) => 制表符
    chr(10) => 换行符
    chr(13) => 回车符
    chr(32) => 空格符
    chr(34) => 双引号"
  * ascii(char): ascii函数将字符char转换为对应ASCII码
    ascii('\t') => 9
    ascii('\r') => 10
    ascii('\n') => 13
    ascii(' ') => 32
    ascii('"') => 34

## 5. 聚合函数
  * min( [distinct|all] <列名> | * ): 求一列值中的最小值      
  * max( [distinct|all] <列名> ): 求一列值中的最大值      
  * sum( [distinct|all] <列名> ): 计算一列值的总和        
  * count( [distinct|all] <列名> | * ): 统计一列值的中的个数 ，为*时统计记录的条数
  * avg( [distinct|all]< 列名> ): 计算一列值的平均值
```SQL
SELECT
    count(distinct ename), --结果为：14
    count(*), --结果为：14
    min(sal), --结果为：800
    max(sal), --结果为：5000
    sum(sal), --结果为：29025
    avg(sal) --结果为：2073.214285714285714285714285714285714286
FROM emp;
```

## 6. 分析函数
  * rank(expr1,expr2,...) within group(order by col1,col2,...)：
    返回特定数值在统计数值中的排序值,expr1,expr2,...必须为常数
  * rank() over( [query_partition_clause] order_by_clause )：
    从一个查询结果中计算每一行的排序值，排序基于order_by_clause子句中的value_exprs指定的字段
```SQL
SELECT
    rank(1530) within group(order by sal asc) rank_level --结果为：8
FROM emp;

SELECT
    rank() over(ORDER BY sal ASC) AS rank_level,
    ename
FROM emp
WHERE deptno = 30;
/* 结果为：
RANK_LEVEL ENAME
---------- -----------
         1 JAMES
         2 WARD
         2 MARTIN
         4 TURNER
         5 ALLEN
         6 BLAKE
*/
```

  * dense_rank(expr1,expr2,...) within group(order by expr1,expr2,...)：返回特定数值在一组行数据中的等级
  * dense_rank() over( [query_partition_clause] order_by_clause )：
    从一个查询结果中计算每一行的排序值，排序基于order_by_clause子句中的value_exprs指定的字段
> 注：dense_rank与rank()的区别：
> 聚合函数RANK 和 dense_rank 主要的功能是计算一组数值中的排序值。
> dense_rank与rank()用法相当，dence_rank在并列关系中相关等级不会跳过，rank则会跳过.rank()是跳跃排序，有两个第二名时接下来就是第四名（同样是在各个分组内） dense_rank()是连续排序，有两个第二名时仍然跟着第三名。
```SQL
SELECT
    dense_rank(1530) within group(order by sal asc) dense_rank_level --结果为：8
FROM emp;

SELECT
    dense_rank() over(ORDER BY sal ASC) AS rank_level,
    ename
FROM emp
WHERE deptno = 30;
/* 结果为：
RANK_LEVEL ENAME
---------- ------------
         1 JAMES
         2 WARD
         2 MARTIN
         3 TURNER
         4 ALLEN
         5 BLAKE
*/
```

  * row_number() over (partition by col1 order by col2) : 
    表示根据col1分区，在分组内部根据 col2排序，而这个值就表示每组内部排序后的
    顺序编号（组内连续的唯一的） row_number() 返回的主要是“行”的信息，并没有排名.
```SQL
SELECT
    row_number() over(partition by deptno order by sal)
FROM emp
WHERE deptno < 30;
/* 结果为：
ROW_NUMBER()OVER(PARTITIONBYDEPTNOORDERBYSAL)
---------------------------------------------
                                            1
                                            2
                                            3
                                            1
                                            2
                                            3
                                            4
                                            5
*/
```

  * percent_rank(expr1,expr2,...) within group(order by expr1,expr2,...)：
    返回特定数值的统计数值在统计级别中所占的比例
```SQL
SELECT
    ename,
    percent_rank() over(ORDER BY sal) percent,
    rank() over(ORDER BY sal) ,
    sal
FROM emp;
/* 结果为：
ENAME        PERCENT RANK()OVER(ORDERBYSAL)        SAL
--------- ---------- ---------------------- ----------
SMITH              0                      1        800
JAMES     .076923077                      2        950
ADAMS     .153846154                      3       1100
WARD      .230769231                      4       1250
MARTIN    .230769231                      4       1250
MILLER    .384615385                      6       1300
TURNER    .461538462                      7       1500
ALLEN     .538461538                      8       1600
CLARK     .615384615                      9       2450
BLAKE     .692307692                     10       2850
JONES     .769230769                     11       2975
SCOTT     .846153846                     12       3000
FORD      .846153846                     12       3000
KING               1                     14       5000
*/
```

  * percentile_cont(percent_expr)within group(order by expr)：
    返回在统计级别中处于某个百分点的特定数值(按照连续分布模型确定)
  * percentile_disc(percent_expr)within group(order by expr)：
     返回在统计级别中处于某个百分点的特定数值(按照离散分布模型确定)
```SQL
SELECT
    percentile_cont(0.25)within GROUP(ORDER BY sal) --结果为：1250
FROM emp;

SELECT percentile_disc(0.25)within GROUP(ORDER BY sal) --结果为：1250
FROM emp;
```

  * first：取得排序等级的第一级，然后使用分组函数汇总该等级的数据，该函数不能够单独使用，必须与其它分组函数结合使用。
  * last：取得排序等级的最后一级，然后使用分组函数汇总该等级的数据，该函数不能够单独使用，必须与其它分组函数结合使用。
```SQL
SELECT
    MAX(sal)keep(dense_rank FIRST ORDER BY sal),
    deptno
FROM emp
GROUP BY deptno;
/* 结果为：
MAX(SAL)KEEP(DENSE_RANKFIRSTORDERBYSAL)     DEPTNO
--------------------------------------- ----------
                                   1300         10
                                    800         20
                                    950         30
*/

SELECT
    MAX(sal)keep(dense_rank last ORDER BY sal),
    deptno
FROM emp
GROUP BY deptno;
/* 结果为：
MAX(SAL)KEEP(DENSE_RANKLASTORDERBYSAL)     DEPTNO
-------------------------------------- ----------
                                  5000         10
                                  3000         20
                                  2850         30
*/
```

  * over ([partition by col1] order by col2) ) ：
    开窗函数，表示依col1分组，依col2在分组类排序，over函数不能够单独使用，必须和其它的分组/分析函数配合使用，over函数不可用在where子句中。
```SQL
SELECT
    ename,
    deptno,
    sal,
    SUM(sal) over(partition BY deptno ORDER BY sal) sum1,
    SUM(sal) over(partition BY deptno) sum2,
    SUM(sal) over(ORDER BY sal) sum3,
    SUM(sal) over() sum4
FROM emp;
/* 结果为：
ENAME      DEPTNO   SAL    SUM1   SUM2   SUM3   SUM4
--------- ------- ----- ------- ------ ------ ------
SMITH          20   800     800  10875    800  29025
JAMES          30   950     950   9400   1750  29025
ADAMS          20  1100    1900  10875   2850  29025
MARTIN         30  1250    3450   9400   5350  29025
WARD           30  1250    3450   9400   5350  29025
MILLER         10  1300    1300   8750   6650  29025
TURNER         30  1500    4950   9400   8150  29025
ALLEN          30  1600    6550   9400   9750  29025
CLARK          10  2450    3750   8750  12200  29025
BLAKE          30  2850    9400   9400  15050  29025
JONES          20  2975    4875  10875  18025  29025
FORD           20  3000   10875  10875  24025  29025
SCOTT          20  3000   10875  10875  24025  29025
KING           10  5000    8750   8750  29025  29025
*/

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
/* 结果为：
ENAME          DEPTNO         SAL SALARY_ORDER
---------- ---------- ---------- -------------
KING               10       5000             1
CLARK              10       2450             2
MILLER             10       1300             3
SCOTT              20       3000             1
FORD               20       3000             2
JONES              20       2975             3
ADAMS              20       1100             4
SMITH              20        800             5
BLAKE              30       2850             1
ALLEN              30       1600             2
TURNER             30       1500             3
MARTIN             30       1250             4
WARD               30       1250             5
JAMES              30        950             6
*/
```

  * ntile(n) over(order by col1 ASC| DESC) :
    对一个数据分区中的有序结果集进行划分组，将其分组为各个桶，并为每个组分配一个唯一的组编号
```SQL
SELECT
    ename,
    sal,
    ntile(3) over (ORDER BY sal nulls last)
FROM emp;
/* 结果为：
ENAME           SAL NTILE(3)OVER(ORDERBYSALNULLSLAST)
-------- ---------- ---------------------------------
SMITH           800                                 1
JAMES           950                                 1
ADAMS          1100                                 1
WARD           1250                                 1
MARTIN         1250                                 1
MILLER         1300                                 2
TURNER         1500                                 2
ALLEN          1600                                 2
CLARK          2450                                 2
BLAKE          2850                                 2
JONES          2975                                 3
SCOTT          3000                                 3
FORD           3000                                 3
KING           5000                                 3
*/

SELECT
    grade,
    ntile(4) over(ORDER BY grade DESC)
FROM salgrade;
/* 结果为：
     GRADE NTILE(4)OVER(ORDERBYGRADEDESC)
---------- ------------------------------
         5                              1
         4                              1
         3                              2
         2                              3
         1                              4
*/

```

  * group_id()：区分分组结果中的重复行
  * grouping(expr)：用于确定分组结果是否用到了特定的运算式
    返回值0表示用到了该运算式，返回值1表死未用到该运算式
  * grouping_id(expr1[,expr2],,,)：用于返回对应于特定行的分组位向量的值

## 7. 其他特殊函数
  * SYS_CONNECT_BY_PATH(col1,str)：oracle 的递归查询函数，该函数是oracle9i新提出的，这个函数要和：START WITH（非必须） 和 CONNECT BY  PRIOR（必须）联合使用，其中 START WITH 表示开始遍历的的节点，CONNECT BY PRIOR 标识父子关系的对应。该函数的两个参数分别是（形成树的字段名，层级分隔符）
```SQL
SELECT
    empno,
    ename,
    mgr,
    sys_connect_by_path(ename,'-->') path
FROM emp START WITH ename = 'KING' CONNECT BY prior empno = mgr;
/* 结果为：
EMPNO  ENAME   MGR     PATH
-----  ------  ------  -------------------------------
7839   KING    (null)  -->KING
7566   JONES   7839    -->KING-->JONES
7788   SCOTT   7566    -->KING-->JONES-->SCOTT
7876   ADAMS   7788    -->KING-->JONES-->SCOTT-->ADAMS
7902   FORD    7566    -->KING-->JONES-->FORD
7369   SMITH   7902    -->KING-->JONES-->FORD-->SMITH
7698   BLAKE   7839    -->KING-->BLAKE
7499   ALLEN   7698    -->KING-->BLAKE-->ALLEN
7521   WARD    7698    -->KING-->BLAKE-->WARD
7654   MARTIN  7698    -->KING-->BLAKE-->MARTIN
7844   TURNER  7698    -->KING-->BLAKE-->TURNER
7900   JAMES   7698    -->KING-->BLAKE-->JAMES
7782   CLARK   7839    -->KING-->CLARK
7934   MILLER  7782    -->KING-->CLARK-->MILLER
*/
```
