-- 流程控制：IF,WHILE,LOOP

DECLARE
    i NUMBER;
    j NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('----LOOP----');
    i := -5;
    LOOP EXIT WHEN i > 5;
        j := ABS(i);
        LOOP EXIT WHEN j <= 0;
            DBMS_OUTPUT.PUT(' ');
            j := j-1;
        END LOOP;
        j := (6-ABS(i))*2-1;
        LOOP EXIT WHEN j <= 0;
            DBMS_OUTPUT.PUT('*');
            j := j-1;
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        i := i+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('--END-LOOP--');
END;
