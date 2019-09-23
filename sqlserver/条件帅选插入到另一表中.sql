create table A
(
id int primary key,
num nvarchar(100),
name varchar(100),
cardID nvarchar(100),
memo nvarchar(1000),
)
--drop table B

create table B
(
id int primary key,
num nvarchar(100),
name varchar(100),
cardID nvarchar(100),
memo_1 nvarchar(1000),
memo_2 nvarchar(1000),
memo_3 nvarchar(1000),
memo_4 nvarchar(1000),
)

insert into A values(1,'000004100013','刘花','321121198885003324','111')
insert into A values(2,'000004100013','刘花','321121198885003324','15')
insert into A values(3,'000008200025','王虎','399927998907909536','111')
insert into A values(4,'000008200025','王虎','399927998907909536','112')
insert into A values(5,'000008200025','王虎','399927998907909536','15')
insert into A values(6,'000008200025','王虎','399927998907909536','110')

select * from A
--把A表的数据插入到B表中
use infor
go
create proc proc_UpdateInsertData_A
as
	declare @return_value int
	declare @begin_value int
	declare @id_value int
	declare @count_value int
	declare @num_value nvarchar(100)
	declare @name_value varchar(100)
	declare @cardID_value nvarchar(100)
	declare @memo_value nvarchar(1000)
	declare @memo1_value nvarchar(1000)
	declare @memo2_value nvarchar(1000)
	declare @memo3_value nvarchar(1000)
	declare @memo4_value nvarchar(1000)

set @begin_value = 0
set @return_value = 0
if exists(select distinct(num) from A)
	set @begin_value = 1
	set @num_value = (select memo from A)
	set @count_value = (select count(*) 记录数 from A)
	




else
	set @begin_value = 0
while(@begin_value)
begin
	if exists(@num_value)
--		set @begin_value = 1
		update B(memo_1,memo_2,memo_3,memo_4) set @memo1_value = '',@memo2_value = '',@memo3_value = '',@memo4_value = ''
		where   
	else 
		insert into B values(@id_value,@num_value,@name_value,@cardID_value,@memo1_value,@memo2_value,@memo3_value,@memo4_value)
end
--	update B set memo 


select num from A 
group by num

/*
insert into B(id,num,name,cardID,memo_1,memo_2,memo_3,memo_4)
select num,substring(A.memo,1,10) from A
where num = '000004100013'
group by num,substring(A.memo,1,10)
*/

