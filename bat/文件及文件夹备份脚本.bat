@echo off


title ����ʱ���ǣ�%date% %time%

set back_path=d:\Backup\

if not exist %back_path% md %back_path%

set db_file=Cpms_Db_%date:~0,4%_%date:~5,2%_%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.dmp

echo ׼����ʼ����...

echo ��ʼ����...

copy E:\���ͺ������ۻ��ֹ���ϵͳ\Oracle\Oracle����\a.dmp %back_path%%db_file%

echo �ļ��Լ��ļ��п�������...

rem pause

exit


