@echo off

set del_path=D:\Backup\

forfiles /p %del_path% /s /m *.dmp /d -90 /c "cmd /c echo deleting @file ... && del /f @path"

pause