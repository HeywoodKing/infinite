@echo off
@echo off

set Frameworkdc=%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319

echo ----------------------------------------------------------
echo                          ����װ
echo ----------------------------------------------------------

if exist "%Frameworkdc%" goto netOld

:Error
echo ���Ļ�����û�а�װ .net Framework 4.0,��װ������ֹ.
echo ���Ļ�����û�а�װ .net Framework 4.0,��װ������ֹ  >InstallService.log
goto LastEnd


:netOld
cd "%Frameworkdc%"
echo ���Ļ����ϰ�װ����Ӧ��.net Framework 4.0,���԰�װ������. 
echo ���Ļ����ϰ�װ����Ӧ��.net Framework 4.0,���԰�װ������ >InstallService.log
echo.
echo. >>InstallService.log

%Frameworkdc%\installutil.exe hc.Plat.WindowsServer.exe

echo ----------------------------------------------------------
echo                        ����װ�ɹ�
echo ----------------------------------------------------------

echo ������������...

net start BIM�ڰ���-����ƽ̨����

echo �����������...


sc config BIM�ڰ���-����ƽ̨���� start= auto

:LastEnd
pause