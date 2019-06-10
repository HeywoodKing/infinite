@echo 卸载服务
%SystemRoot%\Microsoft.NET\Framework\v4.0.30319\installutil.exe /u WindowsServiceTest.exe
pause

@echo off
net stop SendSms
C:\Windows\Microsoft.NET\Framework\v4.0.30319\installutil.exe E:\Debug\SendSmsService.exe /u
echo -----------------------------
echo         服务卸载成功
echo -----------------------------
pause


@echo off
net stop 服务名称
c:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\installutil.exe E:\abc\abc.exe /u
echo -----------------------------
echo         服务卸载成功
echo -----------------------------
pause


@echo.服务关闭  
@echo off  
@net stop test3  
@echo off  
@echo.关闭结束！
@pause  



@删除服务
@sc delete test3


@echo.服务删除  
@echo off  
@sc delete test3  
@echo off  
@echo.删除结束！  
@pause  