@echo off


title ����ʱ���ǣ�%date% %time%

set back_path=D:\Backup\Cpms_Db_2019_01_16171021.dmp

if not exist %back_path% goto last

echo ׼���������ݿ�...

echo ��ʼ����...

imp flack/123456@orcl file=%back_path% full=y ignore=y

echo ���ݿ⵼�����...

pause

:last

echo �����ļ�δ�ҵ��������·���Ƿ���ȷ

pause


