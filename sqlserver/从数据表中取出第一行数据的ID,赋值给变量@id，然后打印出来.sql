--从数据表中取出第一行数据的ID,赋值给变量@id，然后打印出来

declare @id int
set @id = (select top 1 id from A)
print @id
--在SQL中，我们不能像代码那样直接给变量赋值，例如@id = 1，如果要达到这样的功能，可以这样写
declare @id int
set @id = (select 1)  --类似@id = 1
select @id = 1 --类似@id = 1
set @id = (select 1 + 5)  --类似@id = 1+5
set @id = (select 1 - @id) --类似@id = 1- @id
print @id



