@echo off


title ����ʱ���ǣ�%date% %time%

set back_path=D:\Cpms\DbBackup\

if not exist %back_path% md %back_path%

set db_file=Cpms_Db_%date:~0,4%_%date:~5,2%_%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.dmp


echo ׼���������ݿ�...

echo ��ʼ����...

exp hccpms/daWh_cpms201901@orcl file=%back_path%%db_file% tables=(base_config,base_files,base_fileserver,base_log,base_message,base_right,base_role,base_roleright,base_settings,base_typedictionary,base_user,base_userrole,cpms_card,cpms_cardauthaccount,cpms_cardauthaccounthis,cpms_cardauthuser,cpms_cardconsumptionday,cpms_cardpreferstandard,cpms_cusintegral,cpms_cusintegralchange,cpms_cusintegralcycledetail,cpms_cusintegraldaily,cpms_cusintegralgive,cpms_cusintegralmonthly,cpms_cusrating,cpms_cusratingdetail,cpms_cussigninfo,cpms_cussigninfoaudit,cpms_cussigninfoitem,cpms_customer,cpms_integralruleadj,cpms_integralrulehis,cpms_integralrulenow,cpms_integralrulepro,cpms_jdrecord,cpms_jdrecordhis,cpms_order,cpms_orderitem,cpms_rating,cpms_ratingitem,cpms_ratingrule,cpms_test,cpms_userorg) compress=y

echo ���ݿⱸ�����...

exit


