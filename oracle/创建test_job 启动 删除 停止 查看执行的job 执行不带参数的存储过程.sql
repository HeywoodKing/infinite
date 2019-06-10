
--创建存储过程
create or replace procedure pro_add_test as
begin
  insert into cpms_test(a,b) values(1,1);
  commit;
end;

--创建存储过程job  方便调用
create or replace procedure pro_test_job
as
  job number;
begin
  dbms_job.submit(
    job => job,  /*自动生成JOB_ID*/ 
    what => 'pro_add_test;',  /*需要执行的存储过程名称或SQL语句*/ 
    next_date => sysdate + 3/(24*60),  /*初次执行时间-下一个3分钟*/ 
    interval => 'trunc(sysdate,''mi'')+1/(24*60)'  /*每隔1分钟执行一次*/
  );
  commit;
end;

--创建job
declare
  job number;
begin
  dbms_job.submit(
    job => job,  /*自动生成JOB_ID*/ 
    what => 'pro_add_test;',  /*需要执行的存储过程名称或SQL语句*/ 
    next_date => sysdate + 3/(24*60),  /*初次执行时间-下一个3分钟*/ 
    interval => 'trunc(sysdate,''mi'')+1/(24*60)' /*每隔1分钟执行一次*/
  );
  commit;
end;


--执行带参数的存储过程
declare
  job_use_daily number;
begin
  dbms_job.submit(job_use_daily,
  'declare retCode  number; retMsg varchar2(200); begin  pro_test (retCode,retMsg); end;',
  sysdate,
  'trunc(sysdate)+1');
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
  dbms_job.what（21，'pro_add_test;'）；  --修改某个job名
end;
 



select * from cpms_test;
--truncate table cpms_test;
