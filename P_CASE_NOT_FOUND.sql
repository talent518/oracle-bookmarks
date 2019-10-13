--/
CREATE PROCEDURE P_CASE_NOT_FOUND
(v_case IN integer)
AS
BEGIN
    CASE
    WHEN v_case>300 then
        DBMS_OUTPUT.PUT_LINE('>300');
    when v_case>100 then
        DBMS_OUTPUT.PUT_LINE('>100');
    end case;
exception
    when case_not_found then
        DBMS_OUTPUT.PUT_LINE('Case no found');
END;
/
