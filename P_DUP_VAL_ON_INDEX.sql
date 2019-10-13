--/
CREATE PROCEDURE P_DUP_VAL_ON_INDEX(v_name mytest.name%type, v_passwd mytest.name%type)
AS
BEGIN
  INSERT INTO MYTEST (user_id,name,passwd)values(S_MYTEST_UID.nextval,v_name,v_passwd);
exception
    when dup_val_on_index then
        dbms_output.put_line('Name "' || v_name || '" duplicate');
END;
/
