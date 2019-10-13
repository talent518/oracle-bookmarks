-- 变量的类型：普通型、引用型和记录型三种

DECLARE
    v_i integer := 0;
    v_name varchar2(20) := '张三';
    v_age number := 23;
    v_money float := 123.23;
    v_sal EMP.SAL%TYPE; -- 引用型变量之引用表字段类型
    v_row EMP%ROWTYPE; -- 引用型变量之引用表行类型
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello world');
    DBMS_OUTPUT.PUT_LINE('Variables default value, v_i: '||v_i||', v_name: '||v_name||', v_age: '||v_age||', v_money: '||v_money);
    
    -- 使用SELECT...INTO方式给变量赋值
    SELECT ENAME,SAL INTO v_name,v_sal FROM EMP WHERE EMPNO=7369;
    DBMS_OUTPUT.PUT_LINE('Ref field type, ENAME: ' || v_name || ', SAL: ' || v_sal);
    
    -- 这个只有使用*否则会报错
    SELECT * INTO v_row FROM EMP WHERE EMPNO=7369;
    DBMS_OUTPUT.PUT_LINE('Ref row type, ENAME: ' || v_row.ENAME || ', SAL: ' || v_row.SAL);
END;
