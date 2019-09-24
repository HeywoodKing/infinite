通过手动创建oracle数据库，可以了解oracle数据库的结构和数据库运行机制，对理解oracle数据库有帮助。

一、打开命令行工具，创建必要有相关目录
mkdir E:\app\Administrator\admin\sky 
 
mkdir E:\app\Administrator\admin\sky\adump 
 
mkdir E:\app\Administrator\admin\sky\dpdump 
 
mkdir E:\app\Administrator\admin\sky\pfile 
 
mkdir E:\app\Administrator\flash_recovery_area\sky 
 
mkdir E:\app\Administrator\oradata\sky


二、创建初始化参数文件
数据库系统启动时须要用初始化参数文件的设置分配内存、启动必要的后台进程的。
因此，初始化参数文件创建的是否正确、参数设置是否正确关系着整个建库的“命运”。

创建初始化参数文件可以通过拷贝现在的初始化参数文件并将其做适当的修改即可，
从而不必要用手工去一句一句地写出来，因为初始化参数文件的结构体系基本上都是一样的。
在我们安装Oracle的时候，系统已经为我们安装了一个名为orcl的数据库，
于是我们可以从它那里得到一份初始化参数文件。
打开E:\app\Administrator\admin\orcl\pfile，找到init.ora.9132015183757文件，
把它拷贝到E:\app\Administrator\admin\sky\pfile下，并将其改名为initSKY.ora。
接着用记事本的方式打开initSKY.ora，修改以下的内容：

############################################################################## 
# Copyright (c) 1991, 2001, 2002 by Oracle Corporation 
############################################################################## 
   
########################################### 
# Shared Server 
########################################### 
dispatchers="(PROTOCOL=TCP) (SERVICE=ORCLXDB)"
   
########################################### 
# Miscellaneous 
########################################### 
compatible='11.2.0'
diagnostic_dest='E:/app/Administrator/'
memory_target=1G
   
########################################### 
# Security and Auditing 
########################################### 
audit_file_dest='E:/app/Administrator/admin/orcl/adump'
audit_trail=db 
remote_login_passwordfile='EXCLUSIVE' 
   
########################################### 
# Database Identification 
########################################### 
db_domain=""
db_name=orcl 
   
########################################### 
# File Configuration 
########################################### 
control_files=("E:/app/Administrator/oradata/orcl/control01.ctl","E:/app/Administrator/fast_recovery_area/orcl/control02.ctl") 
db_recovery_file_dest='E:/app/Administrator/fast_recovery_area'
db_recovery_file_dest_size=2G 
   
########################################### 
# Cursors and Library Cache 
########################################### 
open_cursors=300 
   
########################################### 
# System Managed Undo and Rollback Segments 
########################################### 
# 注意此处的“UNDOTBS1”要和建库脚步本中对应 
undo_tablespace='UNDOTBS1'
   
########################################### 
# Processes and Sessions 
########################################### 
processes=150 
   
########################################### 
# Cache and I/O 
########################################### 
db_block_size=8192


三、打开命令行，设置环境变量oracle_sid
C:\Users\Administrator>set oracle_sid=sky
设置环境变量的目地是在默认的情况下，指定命令行中所操作的数据库实例是sky。


四、创建实例（即后台控制服务）
C:\Users\Administrator>oradim -new -sid sky
oradim是创建实例的工具程序名称，-new表明执行新建实例，-delete表明执行删掉实例，-sid指定害例的名称。


五、创建口令文件
C:\Users\Administrator>orapwd file=E:\app\Administrator\product\11.2.0\dbhome_1\database\PWDsky.ora password=manager entries=2
orapwd是创建口令文件的工肯程序各称，file参数指定口令文件所在的目录和文件名称，password参数指定sys用户的口令，entries参数指定数据库拥用DBA权限的用户的个数。

口令文件是专门存放sys用户的口令，因为sys用户要负责建库、启动数据库、关闭数据库等特殊任务，
把以sys用户的口令单独存放于口令文件中，这样数据库末打开时也能进行口令验证。


六、启动数据库到nomount(实例)状态
C:\Users\Administrator>sqlplus /nolog
 
SQL*Plus: Release 11.2.0.1.0 Production on 星期三 12月 30 16:13:30 2015
 
Copyright (c) 1982, 2010, Oracle.  All rights reserved.
 
SQL>conn sys/manager as sysdba ---这里是用sys连接数据库
 
已连接到空闲例程
 
SQL> shutdown immediate   ---需要关闭的时候使用
 
SQL> startup pfile='E:\app\Administrator\admin\sky\pfile\initSKY.ora' nomount
ORACLE 例程已经启动。
 
Total System Global Area 1071333376 bytes
Fixed Size                  1375792 bytes
Variable Size             528482768 bytes
Database Buffers          536870912 bytes
Redo Buffers                4603904 bytes
 
SQL>


七、执行建库脚本
create database sky
datafile 'E:\app\Administrator\oradata\sky\system01.dbf' size 300m 
		autoextend on next 10m maxsize unlimited
sysaux datafile 'E:\app\Administrator\oradata\sky\sysaux01.dbf' size 300m 
		autoextend on next 10m maxsize unlimited
undo tablespace UNDOTBS1 datafile 'E:\app\Administrator\oradata\sky\undotbs01.dbf' size 50m
default temporary tablespace temp tempfile 'E:\app\Administrator\oradata\sky\temp01.dbf' size 30m
logfile
group 1 ('E:\app\Administrator\oradata\sky\redo01.log') size 10240k,
group 2 ('E:\app\Administrator\oradata\sky\redo02.log') size 10240k,
group 3 ('E:\app\Administrator\oradata\sky\redo03.log') size 10240k
character set zhs16gbk;


八、执行catalog脚步本创建数据字典
SQL>start E:\app\Administrator\product\11.2.0\dbhome_1\RDBMS\ADMIN\catalog.sql


九、执行catproc创建package包
SQL>start E:\app\Administrator\product\11.2.0\dbhome_1\RDBMS\ADMIN\catproc.sql


十、执行pupbld
在执行pupbld之前要把当前用户（sys）转换成system,即以system账户连接数据库。
因为此数据库是刚建的，所以system的口令是系统默认的口令，即manager。
你可以在数据库建好以后再来重新设置此账户的口令。


SQL>connect system/manager
SQL>start E:\app\Administrator\product\11.2.0\dbhome_1\sqlplus\admin\pupbld.sql


十一、 由初始化参数文件创建spfile文件
SQL>create spfile from pfile='E:\app\Administrator\admin\sky\pfile\initSKY.ora';


十二、 执行scott脚本创建scott模式
SQL>start E:\app\Administrator\product\11.2.0\dbhome_1\RDBMS\ADMIN\scott.sql


十三、 把数据库打开到正常状态
SQL>alter database open;


十四、 以scott连接到数据库（口令为tiger），测试新建数据库是否可以正常运行
至此，整个数据库就已经建好了。接着就可以在此数据库上建立自己的账户和表空间以及数据库对象。