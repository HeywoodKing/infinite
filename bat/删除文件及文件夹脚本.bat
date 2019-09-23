@echo off

rem 这个删除文件及文件夹的批处理还有问题需要修改
rem 这个删除文件及文件夹的批处理还有问题需要修改
rem 这个删除文件及文件夹的批处理还有问题需要修改

set del_path=D:\Backup\

:loop
del /f /s /q %del_path%*.*

cd %del_path%

rd /s /q %del_path%

rem @ping 127.0.0.1 -n 5000 >nul

goto loop

pause