
@echo off
@echo off

set Frameworkdc=%SystemRoot%\Microsoft.NET\Framework64\v4.0.30319

echo ----------------------------------------------------------
echo                         ����ж��
echo ----------------------------------------------------------

echo ����ֹͣ...

net stop BIM�ڰ���-����ƽ̨����

echo ������ֹͣ...

echo ��ʼж��...

%Frameworkdc%\installutil.exe /u hc.Plat.WindowsServer.exe

echo ----------------------------------------------------------
echo                       ����ж�سɹ�
echo ----------------------------------------------------------

pause
