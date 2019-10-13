-- 流程控制：IF,WHILE,LOOP

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(1) INTO v_count FROM EMP;
    DBMS_OUTPUT.PUT_LINE('COUNT: ' || v_count);
    IF v_count>20 THEN
        DBMS_OUTPUT.PUT_LINE('EMP记录数大于20');
    ELSIF v_count>10 THEN
        DBMS_OUTPUT.PUT_LINE('EMP记录数大于10且小于等于20');
    ELSE
        DBMS_OUTPUT.PUT_LINE('EMP记录数小于等于10');
    END IF;
END;
