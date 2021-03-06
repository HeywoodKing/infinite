SELECT
DB_NAME(dbid) as DBName,
COUNT(dbid) as NumberOfConnections,
loginame as LoginName 
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame;

--此命令可以看到有多少人在连
Select * from sys.dm_exec_connections


--要看那些用户已连接到sqlserver服务器：
select distinct login_name from sys.dm_exec_Sessions
SELECT * FROM sys.dm_exec_sessions WHERE host_name IS NOT NULL


DECLARE @temp NVARCHAR(20)
 
DECLARE myCurse CURSOR
FOR
  SELECT  spid
  FROM    sys.sysprocesses
  WHERE   dbid = DB_ID('YourDatabaseName')
OPEN myCurse
FETCH NEXT FROM myCurse INTO @temp
WHILE @@FETCH_STATUS = 0 
  BEGIN
    EXEC ('kill '+@temp)
    FETCH NEXT FROM myCurse INTO @temp
  END
CLOSE myCurse
DEALLOCATE myCurse




--SYSPROCESSES视图中主要的字段：
--1. Spid：Sql Servr 会话ID
--2. Kpid：Windows  线程ID 
--3. Blocked：正在阻塞求情的会话 ID。如果此列为 Null，则标识请求未被阻塞
--4. Waittype：当前连接的等待资源编号，标示是否等待资源，0 或 Null表示不需要等待任何资源
--5. Waittime：当前等待时间，单位为毫秒，0 表示没有等待
--6. DBID：当前正由进程使用的数据库ID
--7. UID：执行命令的用户ID
--8. Login_time：客户端进程登录到服务器的时间。
--9. Last_batch：上次执行存储过程或Execute语句的时间。对于系统进程，将存储Sql Server 的启动时间
--10.Open_tran：进程的打开事务个数。如果有嵌套事务，就会大于1
--11.Status：进程ID 状态，dormant = 正在重置回话 ; running = 回话正在运行一个或多个批处理 ; background = 回话正在运行一个后台任务 ; rollback = 会话正在处理事务回滚 ; pending = 回话正在等待工作现成变为可用 ; runnable = 会话中的任务在等待获取 Scheduler 来运行的可执行队列中 ; spinloop = 会话中的任务正在等待自旋锁变为可用 ; suspended = 会话正在等待事件完成
--12.Hostname：建立链接的客户端工作站的名称
--13.Program_name：应用程序的名称，就是 连接字符串中配的 Application Name
--14.Hostprocess：建立连接的应用程序在客户端工作站里的进程ID号
--15.Cmd：当前正在执行的命令
--16.Loginame：登录名

SELECT spid,
       kpid,
       waittype,
       waittime,
       lastwaittype,
       cpu,
       dbid,
sql_handle FROM [Master].[dbo].[SYSPROCESSES]
where dbid=DB_ID('master')  


SELECT * FROM ::FN_GET_SQL(0x0300110052CE3F241F3209013FA1000001000000) 

