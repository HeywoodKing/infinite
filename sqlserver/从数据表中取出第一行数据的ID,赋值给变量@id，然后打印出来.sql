--�����ݱ���ȡ����һ�����ݵ�ID,��ֵ������@id��Ȼ���ӡ����

declare @id int
set @id = (select top 1 id from A)
print @id
--��SQL�У����ǲ������������ֱ�Ӹ�������ֵ������@id = 1�����Ҫ�ﵽ�����Ĺ��ܣ���������д
declare @id int
set @id = (select 1)  --����@id = 1
select @id = 1 --����@id = 1
set @id = (select 1 + 5)  --����@id = 1+5
set @id = (select 1 - @id) --����@id = 1- @id
print @id



