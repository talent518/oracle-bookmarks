-- 流程控制：IF,WHILE,LOOP

DECLARE
    -- 声明游标
    CURSOR c_all_cur IS SELECT ename,sal FROM EMP;
    
    -- 声明从游标授受数据的变量 
    v_name EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
    v_i INTEGER := 0;
BEGIN
    OPEN c_all_cur;
    LOOP
        FETCH c_all_cur INTO v_name,v_sal;
        EXIT WHEN c_all_cur%NOTFOUND;
        
        v_i := v_i + 1;
        DBMS_OUTPUT.PUT_LINE(v_i || ', ENAME: ' || v_name || ', SAL: ' || v_sal);
    END LOOP;
    CLOSE c_all_cur;
END;
