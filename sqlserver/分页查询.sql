/*
分页查询
*/
create PROCEDURE [sp_Page]
    @PageCurrent int, --要显示的页码
    @PageSize int,--每页的大小
    @ifelse nvarchar(1000),--返回的字段
    @where nvarchar(1000),--条件
    @order nvarchar(1000)--排序
AS
BEGIN
    BEGIN TRY
        DECLARE @strSQL nvarchar(500),@strSQLcount nvarchar(500),@countPage int
        if ISNULL(@PageSize,0)<1 
            set @PageSize=20
        set @strSQL='select * from
                    (
                    select '+@ifelse+',ROW_NUMBER() OVER('+@order+') as row from '+@where+'
                    ) a 
                    where row between '+CONVERT(nvarchar(10), @PageCurrent*@PageSize-@PageSize+1)+' and '+CONVERT(nvarchar(10), @PageCurrent*@PageSize)+''
        set @strSQLcount='select count(1) as count from '+@where
        EXECUTE sp_executesql @strSQL;
        EXECUTE sp_executesql @strSQLcount;
    END TRY 
    BEGIN CATCH
        print ERROR_MESSAGE()
    END CATCH
END
--    例：
--    declare @where nvarchar(1000);
--    set @where='gongqiu where ...';
--    exec [sp_Page] @Page,@Size,'*',@where, 'order by date desc'

