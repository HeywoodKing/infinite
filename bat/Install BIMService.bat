@echo off
@echo off

set Frameworkdc=%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319

echo ----------------------------------------------------------
echo                          服务安装
echo ----------------------------------------------------------

if exist "%Frameworkdc%" goto netOld

:Error
echo 您的机器上没有安装 .net Framework 4.0,安装即将终止.
echo 您的机器上没有安装 .net Framework 4.0,安装即将终止  >InstallService.log
goto LastEnd


:netOld
cd "%Frameworkdc%"
echo 您的机器上安装了相应的.net Framework 4.0,可以安装本服务. 
echo 您的机器上安装了相应的.net Framework 4.0,可以安装本服务 >InstallService.log
echo.
echo. >>InstallService.log

%Frameworkdc%\installutil.exe hc.Plat.WindowsServer.exe

echo ----------------------------------------------------------
echo                        服务安装成功
echo ----------------------------------------------------------

echo 正在启动服务...

net start BIM众包网-核心平台服务

echo 服务启动完毕...


sc config BIM众包网-核心平台服务 start= auto

:LastEnd
pause