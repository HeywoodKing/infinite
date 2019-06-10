create sequence seq_cardconsumptionday_temp
minvalue 1 
nomaxvalue
start with 1
increment by 1
nocycle
order;


create trigger trg_cardconsumptionday_temp
before insert on seq_cardconsumptionday_temp
for each row
begin
select seq_cardconsumptionday_temp.nextval into :new.ID from dual;
end;
