
--update CPMS_CUSINTEGRALCHANGE set integraltype=null;
-- Add/modify columns 
alter table CPMS_CUSINTEGRALCHANGE modify integraltype NVARCHAR2(20);
alter table CPMS_CUSINTEGRALCHANGE add integraltypename NVARCHAR2(40);
-- Add comments to the columns 
comment on column CPMS_CUSINTEGRALCHANGE.integraltype
  is '�������� ��0 ��ʼ�����֣� 1 ���ͣ�2 ���������ۼƣ�3 ���ֶһ��� 4 ϵͳ���㣬5 ����';
comment on column CPMS_CUSINTEGRALCHANGE.integraltypename
  is '������������';
--  update CPMS_CUSINTEGRALCHANGE set integraltype=2;
