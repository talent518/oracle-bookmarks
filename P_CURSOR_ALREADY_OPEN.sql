--/
CREATE PROCEDURE P_CURSOR_ALREADY_OPEN

AS
cursor c_test is select name,passwd from mytest;
v_row mytest%rowtype;
BEGIN
    open c_test;
    for v_row in c_test loop
      dbms_output.put_line('name: ' || v_row.name || ', password: ' || v_row.passwd);
    end loop;
exception
    when cursor_already_open then
        dbms_output.put_line('Cursor already open');
END;
/
