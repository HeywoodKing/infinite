create database orcl
datafile 'D:\Oracle\app\oracle\oradata\orcl\system01.dbf' size 300m 
		autoextend on next 10m maxsize unlimited
sysaux datafile 'D:\Oracle\app\oracle\oradata\orcl\sysaux01.dbf' size 300m 
		autoextend on next 10m maxsize unlimited
undo tablespace UNDOTBS1 datafile 'D:\Oracle\app\oracle\oradata\orcl\undotbs01.dbf' size 50m
default temporary tablespace temp tempfile 'D:\Oracle\app\oracle\oradata\orcl\temp01.dbf' size 30m
logfile
group 1 ('D:\Oracle\app\oracle\oradata\orcl\redo01.log') size 10240k,
group 2 ('D:\Oracle\app\oracle\oradata\orcl\redo02.log') size 10240k,
group 3 ('D:\Oracle\app\oracle\oradata\orcl\redo03.log') size 10240k
character set zhs16gbk;
