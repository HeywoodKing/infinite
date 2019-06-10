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
    job => job,  /*�Զ�����JOB_ID*/ 
    what => 'begin PRO_ADD_FEEL_TEST(10, 10); end;',  /*��Ҫִ�еĴ洢�������ƻ�SQL���*/ 
    next_date => sysdate + 3/(24*60),  /*����ִ��ʱ��-3���Ӻ�*/ 
    interval => 'trunc(sysdate,''mi'') + 1/(24*60)' /*ÿ��1����ִ��һ��*/
  );
  commit;
end;

--�ֶ�sql����job
begin
  dbms_job.run(21);
end;

--ɾ������
begin
  /*ɾ���Զ�ִ�е�job*/
  dbms_job.remove(21);
end;

--ֹͣjob
/*ֹͣһ��job,�������trueҲ����false��next_date��ĳһʱ��ֹͣ��Ҳ����sysdate������ֹͣ����   */
begin
  dbms_job.broken(21,true,sysdate);
end;

--�޸�jobʱ��
begin
  dbms_job.interval(21, 'trunc(sysdate) + 1');
end;

--�޸��´�ִ��ʱ��
begin
  dbms_job.next_date(21, sysdate + 60/(24*60));
end;

--�޸�Ҫִ�еĲ���
begin
  dbms_job.what��21��'pro_add_test;'����  --�޸�ĳ��job����what��������
end;



SELECT * FROM FEEL_TEST;

-- ��������job ����ִ�е�job
select * from dba_jobs_running;














