--�Ѳ�ѯ�������Ϊtxt�ı��Ĵ洢����
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
--�������
as
	declare @sqlstr nvarchar(4000)  --��ѯ���
	declare @path nvarchar(1000)    --�ļ������ļ���
	declare @fname nvarchar(250)	  --�ļ���������
	declare @strPath varchar(300)
	declare @colsCount int
	declare @hr int
	declare @object int
	declare @src varchar(255),@desc varchar(255)
	declare @file int
	declare @sql varchar(1000)
	declare @tbname sysname
	--��ʼ������

	set @tbname = 'tb_' + convert(varchar(40),newid())			--����Ҫ����convert���÷�
	set @sql = replace(@sqlstr,'from','into['+ @tbname +'] from')  --����Ҫ����replace���÷�
	set @strPath = ''
	print @sql
	exec(@sql)
--����Ŀ¼��׺��������ڡ�����Ȼ�������
	if right(@path,1) <> ''			--����Ҫ����right���÷�
		set @path = @path + ''
		set @strPath = @path + @fname
		print @strPath
	--Ϊ�ļ������ⲿ�������
	exec @hr = sp_OACreate 'Scripting FileSystemObject',@object out
	if @hr <> 0
	begin
		exec sp_OAGetErrorInfo @object,@src out,@desc out
		select hr = convert(varbinary(4),@hr),Source = @src,Description = @desc
		return
	end
	--�����ļ�������ļ����ھ͸���
	exec @hr = sp_OAMethod @object,'CreateTextFile',@file output,@strPath
	if @hr <> 0
	begin
		exec sp_OAGetErrorInfo @object
		return
	end
	set @sql = 'select * from syscolumns where id = object_id('''+ @tbname +''')'
	print object_id(@tbname)
	--������ʼ�ļ�����ÿһ��
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







