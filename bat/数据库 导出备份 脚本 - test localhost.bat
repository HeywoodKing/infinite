@echo off


title ����ʱ���ǣ�%date% %time%

set back_path=D:\Backup\

if not exist %back_path% md %back_path%

set db_file=Cpms_Db_%date:~0,4%_%date:~5,2%_%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.dmp


echo ׼���������ݿ�...

echo ��ʼ����...

exp flack/123456@orcl file=%back_path%%db_file% owner=flack compress=y

echo ���ݿⱸ�����...

pause


