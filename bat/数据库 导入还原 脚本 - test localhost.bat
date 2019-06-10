@echo off


title 现在时间是：%date% %time%

set back_path=D:\Backup\Cpms_Db_2019_01_16171021.dmp

if not exist %back_path% goto last

echo 准备导入数据库...

echo 开始导入...

imp flack/123456@orcl file=%back_path% full=y ignore=y

echo 数据库导入完毕...

pause

:last

echo 导入文件未找到，请查找路径是否正确

pause


