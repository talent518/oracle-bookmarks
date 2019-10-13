-- 流程控制：IF,WHILE,LOOP

DECLARE
    -- 声明从游标授受数据的变量 
    v_name EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
BEGIN
    P_HELLO();
    P_EMP_BY_DEPTNO(10);
    P_EMP_BY_EMPNO(7369, v_name, v_sal);
    
    DBMS_OUTPUT.PUT_LINE('Procedure OUT, v_name: ' || v_name || ', v_sal: ' || v_sal);
END;
