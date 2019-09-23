
@echo off
@echo off

set Frameworkdc=%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319

echo ----------------------------------------------------------
echo                         服务卸载
echo ----------------------------------------------------------

echo 正在停止...

net stop BIM众包网-核心平台服务

echo 服务已停止...

echo 开始卸载...

%Frameworkdc%\installutil.exe /u hc.Plat.WindowsServer.exe

echo ----------------------------------------------------------
echo                       服务卸载成功
echo ----------------------------------------------------------

pause
