create or replace procedure output_date is
begin
     dbms_output.put_line(sysdate);
end output_date;

create or replace procedure get_username(v_id in number,v_username out varchar2)
as
begin
     select username into v_username from table_user where id=v_id;
     exception
              when no_data_found then
              raise_application_error(-20001,'ID�����ڣ�');
end get_username;