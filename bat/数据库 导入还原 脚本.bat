@echo off


title ����ʱ���ǣ�%date% %time%

set back_path=E:\Git 255 ���ͺ���\���ͺ������ۻ��ֹ���ϵͳ\CPMS���ݿ�ű�\Cpms_Db_2019_01_18.DMP

if not exist %back_path% goto last else goto task

:task

echo ׼���������ݿ�...

echo ��ʼ����...

rem imp hccpms/123456@orcl file=%back_path% full=y ignore=y

imp hccpms/123456@orcl fromuser=hccpms touser=hccpms file=%back_path% tables=(dsj_xods_bosdb_tillitem_day,dsj_xods_bosdb_tillpmnt_crdt_d,dsj_xods_bosdb_tillpmnt_day) commit=y feedback=10000 buffer=10240000 ignore=y rows=y indexes=n

imp hccpms/123456@orcl fromuser=hccpms touser=hccpms file=%back_path% tables=(dsj_xods_bosdb_tillitem_day,dsj_xods_bosdb_tillpmnt_crdt_d,dsj_xods_bosdb_tillpmnt_day) commit=y feedback=10000 buffer=10240000 ignore=y rows=n indexes=y


echo ���ݿ⵼�����...

pause


:last

echo �����ļ�δ�ҵ��������·���Ƿ���ȷ

pause


