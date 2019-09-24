create sequence seq_test
minvalue 1 
nomaxvalue
start with 1
increment by 1
nocycle
order;

create trigger trg_test
before insert on cpms_test
for each row
begin
select seq_test.nextval into :new.ID from dual;
end;


--´¥·¢Æ÷
create or replace trigger trg_test_update
before insert on cpms_test
for each row
  declare
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  update cpms_test t set t.c = :new.a+:new.b;
  where t.id=:new.id;
  commit;
end;



create or replace trigger trg_test_update
before insert on cpms_test
for each row
begin
  :new.c := :new.a+:new.b;
end;


select * from cpms_test;
truncate table cpms_test;

--²âÊÔ
insert into cpms_test(a,b) values(5,9);
commit;
select * from cpms_test;


