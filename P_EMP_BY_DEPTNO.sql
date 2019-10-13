CREATE OR REPLACE PROCEDURE "SCOTT"."P_EMP_BY_DEPTNO"
(v_deptno IN EMP.DEPTNO%TYPE)
AS
CURSOR c_emp IS SELECT ename,sal FROM EMP WHERE deptNo=v_deptno;
v_name EMP.ENAME%TYPE;
v_sal EMP.SAL%TYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_name,v_sal;
        EXIT WHEN c_emp%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ENAME: ' || v_name || ', SAL: ' || v_sal);
   END LOOP;
END;
/
