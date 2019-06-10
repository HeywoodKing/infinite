
--update CPMS_CUSINTEGRALCHANGE set integraltype=null;
-- Add/modify columns 
alter table CPMS_CUSINTEGRALCHANGE modify integraltype NVARCHAR2(20);
alter table CPMS_CUSINTEGRALCHANGE add integraltypename NVARCHAR2(40);
-- Add comments to the columns 
comment on column CPMS_CUSINTEGRALCHANGE.integraltype
  is '积分类型 ：0 初始化积分， 1 赠送，2 加油消费累计，3 积分兑换， 4 系统清零，5 冻结';
comment on column CPMS_CUSINTEGRALCHANGE.integraltypename
  is '积分类型名称';
--  update CPMS_CUSINTEGRALCHANGE set integraltype=2;
