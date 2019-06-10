--把查询结果导出为txt文本的存储过程
set quoted_identifier on
go

set ansi_nulls on
go

--create procedure stp_ExportDataToTxt
alter procedure stp_ExportDataToTxt
/***************************************************************************
*           powered by chen yun(R)

*           2011-11-16

****************************************************************************/
--定义变量
as
	declare @sqlstr nvarchar(4000)  --查询语句
	declare @path nvarchar(1000)    --文件保存文件夹
	declare @fname nvarchar(250)	  --文件保存名字
	declare @strPath varchar(300)
	declare @colsCount int
	declare @hr int
	declare @object int
	declare @src varchar(255),@desc varchar(255)
	declare @file int
	declare @sql varchar(1000)
	declare @tbname sysname
	--初始化变量

	set @tbname = 'tb_' + convert(varchar(40),newid())			--这里要查明convert的用法
	set @sql = replace(@sqlstr,'from','into['+ @tbname +'] from')  --这里要查明replace的用法
	set @strPath = ''
	print @sql
	exec(@sql)
--估计目录后缀，如果不在‘’，然后添加上
	if right(@path,1) <> ''			--这里要查明right的用法
		set @path = @path + ''
		set @strPath = @path + @fname
		print @strPath
	--为文件创建外部服务对象
	exec @hr = sp_OACreate 'Scripting FileSystemObject',@object out
	if @hr <> 0
	begin
		exec sp_OAGetErrorInfo @object,@src out,@desc out
		select hr = convert(varbinary(4),@hr),Source = @src,Description = @desc
		return
	end
	--创建文件，如果文件存在就覆盖
	exec @hr = sp_OAMethod @object,'CreateTextFile',@file output,@strPath
	if @hr <> 0
	begin
		exec sp_OAGetErrorInfo @object
		return
	end
	set @sql = 'select * from syscolumns where id = object_id('''+ @tbname +''')'
	print object_id(@tbname)
	--创建初始文件名和每一列
	declare @name varchar(1000)
	declare @flag int
	set @name = ''
	set @flag = 0
	declare cur_data cursor for
	select name from syscolumns where id = object_id(@tbname)
	open cur_data
	fetch next from cur_data into @name
	while @@fetch_status = 0
	begin
		if @flag = 1
		exec sp_OAMethod @file,'Write',null,','
	exec sp_OAMethod @file,'Write',null,@name
	set @flag = 1
	fetch next from cur_data into @name
	end
	close cur_data
	deallocate cur_data
	exec @hr = sp_OAMethod @file,'close',null
	if @hr <> 0
	begin
		exec sp_OAGetErrorInfo @object
		return
	end
	set @sql = 'insert into openrowset(''microsoft.jet.oledb.4.0'',''text;hdr = no;database = '+ @path +''',''select * from['+ @fname +']'')' + @sqlstr
	print @sql
	exec(@sql)
	set @sql = 'drop table['+ @tbname +']'
	print @sql
	exec(@sql)
go
set quoted_identifier off
go
set ansi_nulls on
go







