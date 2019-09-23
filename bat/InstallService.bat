installutil

下面的命令執行 myAssembly.exe 程序集中的安裝程序組件。
installutil myAssembly.exe

下面的命令執行 myAssembly.exe 程序集中的卸載程序組件。
installutil /u myAssembly.exe 

下面的命令執行 myAssembly.exe 程序集中的安裝程序並指定將進度信息寫入 myLog.InstallLog 中。
installutil /LogFile=myLog.InstallLog myAssembly.exe 

下面的命令將 myAssembly.exe 的安裝進度寫入 myLog.InstallLog 中，並將 myTestAssembly.exe 的進度寫入 myTestLog.InstallLog 中。
installutil /LogFile=myLog.InstallLog myAssembly.exe /LogFile = myTestLog.InstallLog myTestAssembly.



@echo 安装服务
%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\installutil.exe WindowsServiceTest.exe
@echo 启动服务
Net Start Service1
@配置服务启动方式
sc config Service1 start= auto
@sc config 服务名 start= DEMAND  (手动)
@sc config 服务名 start= DISABLED(禁用)
pause



@ECHO OFF
echo 准备安装服务
pause
REM The following directory is for .NET 4.0
set DOTNETFX2=%SystemRoot%\Microsoft.NET\Framework\v4.0.30319
set PATH=%PATH%;%DOTNETFX2%
echo 安装服务...
echo ---------------------------------------------------
InstallUtil /i Service.exe （这次是你的服务）
echo ---------------------------------------------------
echo 安装服务成功！
pause


@echo off
c:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\installutil.exe E:\abc\abc.exe
net start 服务名称
echo -----------------------------
echo         服务安装成功
echo -----------------------------
pause



@echo.服务启动......  
@echo off  
@sc create test3 binPath= "C:\Users\Administrator\Desktop\win32srvdemo\win32srvdemo\Debug\win32srvdemo.exe"  
@net start test3  
@sc config test3 start= AUTO  
@echo off  
@echo.启动完毕！  
@pause


@echo off
@echo off
set filename=LXServer.exe
set servicename=Service1
set Frameworkdc=%SystemRoot%\Microsoft.NET\Framework\v4.0.30319
 
if exist "%Frameworkdc%" goto netOld 
:DispError 
echo 您的机器上没有安装 .net Framework 4.0,安装即将终止.
echo 您的机器上没有安装 .net Framework 4.0,安装即将终止  >InstallService.log
goto LastEnd 
:netOld 
cd %Frameworkdc%
echo 您的机器上安装了相应的.net Framework 4.0,可以安装本服务. 
echo 您的机器上安装了相应的.net Framework 4.0,可以安装本服务 >InstallService.log
echo.
echo. >>InstallService.log

C:\Windows\Microsoft.NET\Framework\v4.0.30319\installutil.exe E:\Debug\SendSmsService.exe
net start SendSms
echo -----------------------------
echo         服务安装成功
echo -----------------------------
pause