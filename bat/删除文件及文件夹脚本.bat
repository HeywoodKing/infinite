@echo off

rem ���ɾ���ļ����ļ��е���������������Ҫ�޸�
rem ���ɾ���ļ����ļ��е���������������Ҫ�޸�
rem ���ɾ���ļ����ļ��е���������������Ҫ�޸�

set del_path=D:\Backup\

:loop
del /f /s /q %del_path%*.*

cd %del_path%

rd /s /q %del_path%

rem @ping 127.0.0.1 -n 5000 >nul

goto loop

pause