@echo on
set curpath=%cd%
c:
cd %systemroot%
schtasks /create /tn WindowsTimeSync_task /sc hourly /mo 1 /st 00:00:00 /ru "System" /tr %curpath%\WindowsTimeSync.bat
schtasks /run /tn WindowsTimeSync_task
start %systemroot%\tasks
pause