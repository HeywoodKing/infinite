create or replace 
PACKAGE body CatchTask
IS
  Procedure retrieveUnfinishedTaskForUser( 
  return_list out type_weakcursor,
  --catchSqls
  catchSql in clob,
  --username
  userName in lsw_usr_xref.user_name%type,
  --the number of task needed
  catchRowsNumber in number)
AS
  countt number(10);
  --装sqls的临时Stirng
   v_temp_sqls clob;
  --装sqls的游标
  v_cath_sqls type_weakcursor;
  --装一句sql的String
  v_one_sql varchar2(32000);
  --装入temp表数据条数
  v_temp_count number(20);
   
  v_own_count NUMBER(10);
  v_count NUMBER(10);
  v_catched_tasks type_weakcursor;
  v_basesql_part1 varchar2(200);
  v_basesql_part2 varchar2(200);
  v_basesql_part3 varchar2(5000);
  v_basesql varchar2(5000);
  v_catchsql varchar2(5000);
  v_searchsql varchar2(5000);
BEGIN
 
   
  --count the amount 'v_reallycatch_count'  that the amount of task what still need to be catched after minusing the already owned tasks 
  SELECT COUNT(*) INTO v_own_count FROM lsw_task t LEFT JOIN lsw_usr_xref u ON t.user_id=u.user_id WHERE status in (11,12) and u.user_name = userName;
    --SYS.dbms_output.put_line(v_own_count||' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  --the  really amount of tasks need to be caught 
   
  v_count := (catchRowsNumber - v_own_count);
  --SYS.dbms_output.put_line(v_count||' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  v_basesql_part1 := '';
  v_basesql_part3 := 'SELECT * FROM  
  (SELECT 0+0 catched, taskDetail.* , LSW_USR_XREF.USER_NAME AS taskDealPerson FROM 
    (SELECT to_char(lt.due_date,''YYYY-MM-DD HH24:MI:SS'') taskDueDate,       
    lt.task_id taskId,  lt.user_id,
    to_char(lt.read_datetime,''YYYY-MM-DD HH24:MI:SS'') readDate,       
    to_char(lt.rcvd_datetime,''YYYY-MM-DD HH24:MI:SS'') createDate,     
    lt.status,
    (CASE WHEN lt.user_id<0 AND lt.status IN (''11'',''12'') THEN ''TSA001''  
          WHEN lt.user_id>0 AND lt.status IN (''11'',''12'') THEN ''TSA002''       
          WHEN lt.user_id>0 AND lt.status IN (''32'')      THEN ''TSA003'' END )AS taskStatus,    
    liv.*     FROM LSW_TASK lt     LEFT JOIN     
      (SELECT LSW_BPD_INSTANCE_VARIABLES.BPD_INSTANCE_ID AS bpdInstanceId,       
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''businessNo'', STRING_VALUE,NULL)) businessNo,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''taskType'', STRING_VALUE,NULL)) taskType,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''carNo'', STRING_VALUE,NULL)) carNo,       
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''policyHolder'', STRING_VALUE,NULL)) policyHolder,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''insuredPerson'', STRING_VALUE,NULL)) insuredPerson,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''riskClass'', STRING_VALUE,NULL)) riskClass,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''risk'', STRING_VALUE,NULL)) risk,  
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''organization'', STRING_VALUE,NULL)) organization,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''submitTime'', STRING_VALUE,NULL)) submitTime ,       
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''submitPosition'', STRING_VALUE,NULL)) submitPosition ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''limitTimeInterval'', INT_VALUE,NULL)) limitTimeInterval,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''caseDueDate'', STRING_VALUE,NULL)) caseDueDate ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''priority'', STRING_VALUE,NULL)) priority ,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''customerType'', STRING_VALUE,NULL)) customerType ,  
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''reInsurancedStatus'', STRING_VALUE,NULL)) reInsurancedStatus ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''taskTypeCode'', STRING_VALUE,NULL)) taskTypeCode ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''riskClassCode'', STRING_VALUE,NULL)) riskClassCode ,   
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''riskCode'', STRING_VALUE,NULL)) riskCode ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''organizationCode'', STRING_VALUE,NULL)) organizationCode ,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''submitPositionCode'', STRING_VALUE,NULL)) submitPositionCode ,  
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''priorityCode'', STRING_VALUE,NULL)) priorityCode ,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''customerTypeCode'', STRING_VALUE,NULL)) customerTypeCode,   
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''reInsurancedStatusCode'', STRING_VALUE,NULL)) reInsurancedStatusCode,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''taskLevelCode'', STRING_VALUE,NULL)) taskLevelCode,       
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''taskLabel'', STRING_VALUE,NULL)) taskLabel,        
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''taskLabelCode'', STRING_VALUE,NULL)) taskLabelCode,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''channel'', STRING_VALUE,NULL)) channel,       
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''channelCode'', STRING_VALUE,NULL)) channelCode,      
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''urgentDegreeCode'', STRING_VALUE,NULL)) urgentDegreeCode,   
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''bizTypeCode'', STRING_VALUE,NULL)) bizTypeCode,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''businessType'', STRING_VALUE,NULL)) businessType,    
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''submitTimes'', INT_VALUE,NULL)) submitTimes,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''lastReturnUserId'', STRING_VALUE,NULL)) lastReturnUserId,     
              MAX( DECODE(LSW_BPD_INSTANCE_VARIABLES.ALIAS,''orderValue'', INT_VALUE,NULL)) orderValue  
                FROM lsw_bpd_instance_variables  GROUP BY LSW_BPD_INSTANCE_VARIABLES.BPD_INSTANCE_ID) liv    
                ON liv.bpdInstanceId = lt.bpd_instance_id  ) taskdetail  
                LEFT JOIN LSW_USR_XREF  ON
                taskdetail.USER_ID = LSW_USR_XREF.USER_ID   ) WHERE 1 = 1 '||' and status in (''11'',''12'')';
    v_searchsql := v_basesql_part1 || v_basesql_part3|| ' and taskdealPerson = '''|| userName||'''';
 
  IF  v_count>0 THEN 
 
     -- v_temp_sqls := catchSql;
     -- v_temp_sqls := 'select * from lsw_user_xref where user_id = 1 # select * from lsw_user_xref where user_id = 1 # select * from lsw_user_xref where user_id = 1';
      open v_cath_sqls for SELECT REGEXP_SUBSTR (catchSql, '[^#]+', 1,rownum)
      FROM DUAL
      CONNECT BY ROWNUM <= LENGTH (catchSql) - LENGTH (REPLACE (catchSql, '#',''))+1;
 
        <span style="color: #FFFF00;">fetch v_cath_sqls into v_one_sql;
        while v_cath_sqls%found loop
        dbms_output.put_line('sqls : '||v_one_sql);
        execute immediate 'insert into temptask'|| v_one_sql;
        select count(*) into countt from temptask;
        SYS.dbms_output.put_line(countt);</span>
        select count(*) into v_temp_count from  temptask;
        v_count := v_count-v_temp_count;
        exit when v_count<=0;
        --dbms_output.put_line(v_one_sql);
        fetch v_cath_sqls into v_one_sql;
        end loop;
 
        close v_cath_sqls;
        --返回结果（已有任务和抓取的任务）
        --dbms_output.put_line('bbbb : '||v_searchsql || ' union select * from temptask where rownum <='||v_count);
        open return_list for v_searchsql || 'union select * from temptask where rownum <='||v_count;
 
   ------------------------------------------------------------------------------------------------------------
  ELSE
     -- OPEN return_list FOR 
        open return_list for v_searchsql;
  END IF;
END;
END CatchTask;