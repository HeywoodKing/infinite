--PROMPT
--PROMPT CREATING TABLE FEEL_TEST
--PROMPT ========================
--PROMPT
CREATE TABLE FLACK.FEEL_TEST
(
  ID NVARCHAR2(50) NOT NULL,
  A  NUMBER DEFAULT 0,
  B  NUMBER DEFAULT 0,
  C  NUMBER DEFAULT 0
)
TABLESPACE USERS
  PCTFREE 10
  INITRANS 1
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
  
  

--PROMPT
--PROMPT CREATING SEQUENCE SEQ_FEEL_TEST_ID
--PROMPT ==================================
--PROMPT
CREATE SEQUENCE FLACK.SEQ_FEEL_TEST
MINVALUE 1
MAXVALUE 999999999999999999999999999
START WITH 1
INCREMENT BY 1
CACHE 20
ORDER;
  
  
--PROMPT
--PROMPT CREATING TRIGGER TRG_CUSINTEGRALCHANGE
--PROMPT ======================================
--PROMPT
CREATE OR REPLACE TRIGGER FLACK.TRG_FEEL_TEST
BEFORE INSERT ON FEEL_TEST
FOR EACH ROW
BEGIN
SELECT SEQ_FEEL_TEST.NEXTVAL INTO :NEW.ID FROM DUAL;
END;

  

----PROMPT
----PROMPT CREATING PROCEDURE PRO_ADD_FEEL_TEST
----PROMPT ===============================
----PROMPT
CREATE OR REPLACE PROCEDURE FLACK.PRO_ADD_FEEL_TEST(IN_A IN NUMBER, IN_B IN NUMBER)
AS
  V_A NUMBER;
  V_B NUMBER;
BEGIN
  V_A := IN_A;
  V_B := IN_B;
  INSERT INTO FEEL_TEST(A,B,C) VALUES(V_A, V_B, V_A + V_B);
  COMMIT;
END;

----PROMPT
----PROMPT CREATING JOB PRO_ADD_FEEL_TEST
----PROMPT ===============================
----PROMPT
declare
  job number;
begin
  dbms_job.submit(
    job => job,  /*自动生成JOB_ID*/ 
    what => 'begin PRO_ADD_FEEL_TEST(10, 10); end;',  /*需要执行的存储过程名称或SQL语句*/ 
    next_date => sysdate + 3/(24*60),  /*初次执行时间-3分钟后*/ 
    interval => 'trunc(sysdate,''mi'') + 1/(24*60)' /*每隔1分钟执行一次*/
  );
  commit;
end;

--手动sql调用job
begin
  dbms_job.run(21);
end;

--删除任务
begin
  /*删除自动执行的job*/
  dbms_job.remove(21);
end;

--停止job
/*停止一个job,里面参数true也可是false，next_date（某一时刻停止）也可是sysdate（立刻停止）。   */
begin
  dbms_job.broken(21,true,sysdate);
end;

--修改job时间
begin
  dbms_job.interval(21, 'trunc(sysdate) + 1');
end;

--修改下次执行时间
begin
  dbms_job.next_date(21, sysdate + 60/(24*60));
end;

--修改要执行的操作
begin
  dbms_job.what（21，'pro_add_test;'）；  --修改某个job名的what操作任务
end;



SELECT * FROM FEEL_TEST;

-- 正在运行job 正在执行的job
select * from dba_jobs_running;














