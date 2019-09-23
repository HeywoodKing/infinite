@echo off


title 现在时间是：%date% %time%

set back_path=E:\Git 255 中油湖北\中油湖北零售积分管理系统\CPMS数据库脚本\Cpms_Db_2019_01_18.DMP

if not exist %back_path% goto last else goto task

:task

echo 准备导入数据库...

echo 开始导入...

rem imp hccpms/123456@orcl file=%back_path% full=y ignore=y

imp hccpms/123456@orcl fromuser=hccpms touser=hccpms file=%back_path% tables=(dsj_xods_bosdb_tillitem_day,dsj_xods_bosdb_tillpmnt_crdt_d,dsj_xods_bosdb_tillpmnt_day) commit=y feedback=10000 buffer=10240000 ignore=y rows=y indexes=n

imp hccpms/123456@orcl fromuser=hccpms touser=hccpms file=%back_path% tables=(dsj_xods_bosdb_tillitem_day,dsj_xods_bosdb_tillpmnt_crdt_d,dsj_xods_bosdb_tillpmnt_day) commit=y feedback=10000 buffer=10240000 ignore=y rows=n indexes=y


echo 数据库导入完毕...

pause


:last

echo 导入文件未找到，请查找路径是否正确

pause


