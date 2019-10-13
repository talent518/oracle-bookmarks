--/
CREATE PROCEDURE P_INVALID_CURSOR

AS
cursor c_test is select name,passwd from mytest;
v_name mytest.name%type;
v_passwd mytest.passwd%type;
BEGIN
    -- open c_test;
    loop
        fetch c_test into v_name,v_passwd;
        exit when c_test%notfound;
        dbms_output.put_line('name: ' || v_name || ', password: ' || v_passwd);
    end loop;
exception
    when invalid_cursor then
        dbms_output.put_line('Invalid cursor');
END;
/
