@echo off


title 现在时间是：%date% %time%

set back_path=d:\Backup\

if not exist %back_path% md %back_path%

set db_file=Cpms_Db_%date:~0,4%_%date:~5,2%_%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.dmp

echo 准备开始拷贝...

echo 开始备份...

copy E:\中油湖北零售积分管理系统\Oracle\Oracle备份\a.dmp %back_path%%db_file%

echo 文件以及文件夹拷贝结束...

rem pause

exit


