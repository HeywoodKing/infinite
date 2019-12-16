# MYSQL

### 安装mysql
1. windows安装
[下载MySQL]( "下载MySQL") 安装即可

2. linux(ubuntu18.04)

>安装与初始化

>在 Download MySQL Yum Repository 页面获取 MySQL 8 Community Yum 仓库文件的链接，例如：
>`https://repo.mysql.com//mysql80-community-release-el7-2.noarch.rpm`

>通过 SSH 远程连接服务器实例，执行下面命令切换到其它拥有 root 权限的用户，阿里云服务器实例默认有一个拥有 root 权限的 admin 用户，这里以切换到 admin 用户为例子：
>`$ su admin`

>执行下面命令，下载 MySQL 8 Community Yum 仓库文件：
>$ wget https://repo.mysql.com//mysql80-community-release-el7-2.noarch.rpm

>执行下面命令，安装 MySQL 8 Community Yum 仓库文件：
>$ sudo yum localinstall mysql80-community-release-el7-2.noarch.rpm

>执行下面命令，检查 MySQL 8 Community Yum 仓库文件是否正确安装 ：
>$ yum repolist enabled | grep "mysql.*-community.*"

>执行下面命令，安装 MySQL 8 Community ：
>$ sudo yum install mysql-community-server

>使用 service 命令管理 MySQL 服务：
>$ sudo service mysqld start          # 启动 MySQL 服务
>$ sudo service mysqld stop           # 停止 MySQL 服务
>$ sudo service mysqld restart        # 重启 MySQL 服务
>$ sudo service mysqld status         # 查看 MySQL 服务状态

>使用 systemctl 命令管理 MySQL 服务：
>$ sudo systemctl start mysqld   # 启动 MySQL 服务
>$ sudo systemctl stop mysqld    # 停止 MySQL 服务
>$ sudo systemctl restart mysqld # 重启 MySQL 服务
>$ sudo systemctl status mysqld  # 查看 MySQL 服务状态
>$ sudo systemctl enable mysqld  # 设置 MySQL 服务开机自启动
>$ sudo systemctl disable mysqld # 关闭 MySQL 服务开机自启动

>首次启动 MySQL 服务，会自动初始化数据目录、生成 SSL 证书和密钥文件、创建超级用户 ' root'@'localhost' ，超级用户的密码被设置并存储在错误日志文件中。可以使用以下命令查询临时密码：
>$ sudo grep 'temporary password' /var/log/mysqld.log

>现在你可以用你查询到的临时密码连接数据库服务器了。


### 基本操作

MySQL数据库本地和远程访问
```
本地访问
mysql -u root -p123456
mysql -h 127.0.0.1 -u root -p123456

远程访问
mysql -h 192.168.10.38 -u root -p123456
mysql -h 192.168.10.38 -u root -p
mysql -h 30.158.59.78 -uroot -pabc123
mysql -h tom.xicp.net -uroot -pabc123

查看所有数据库
show databases;

查看所有支持的引擎
show engines;
MySQL [(none)]> show engines;
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
| FEDERATED          | YES     | Federated MySQL storage engine                                 | NO           | NO   | NO         |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+

使用某个数据库
use mysql;
查看选中数据库下的所有表
show tables;
```

创建数据库
```
create database test charset=utf8;
create database test default character set utf8;
create database test DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
create database test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

查看到用户和密码
```
select host,user,password from mysql.user;
select * from mysql.user;
```

修改密码
```
update mysql.user set password='123456' where user='root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
```

修改root用户密码永不过期
```
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456' PASSWORD EXPIRE NEVER;
```

创建表
```
create table students(
    id int not null auto_increment primary key,
    name varchar(100) not null comment '学生姓名',
    gender bit default 0 comment '性别',,
    birthday datetime comment '生日',
    remark varchar(300) comment '备注',
    --primary key (id),
    --unique key id(id),
    --foreign key(subid) references subjects(id),
    KEY `students_name` (`name`) USING BTREE
) engine=InnoDB default charset=utf8;
```

查看创建库脚本
```
show create database test;
```

删除数据库
```
drop database test;
```

查看创建表结构
```
查看创建表结构
show create table students;
查看外键
show create table students;
```

查看当前选中的数据库
```
select database();
```

查看表结构
```
desc students;
```

修改表名
```
alter table students rename to|as student;
rename table students to|as student;
```

增加列字段
```
alter table students add is_delete bit default;
alter table students add column aa bool default true;
alter table students add id int auto_increment primary key;  #将自增字段设置为primary key

增加多列字段
alter table students add column(aa bool default true, bb varchar(256) default '');
```

修改列字段
```
修改列字段类型 指定为空或者非空
alter table students modify 字段名称 字段类型 [是否允许非空];
alter table students modify id int auto_increment unique;
alter table students modify column id int auto_increment unique;

增加 binary 则表示区分大小写，默认不加是不区分大小写的
alter table fk_teacher modify column name varchar(256) binary;

修改多列字段 指定为空或者非空
alter table students modify column(id int auto_increment unique,name varchar(100) not null);

修改字段列名（修改列名）修改某个表的字段名称及指定为空或非空
alter table students change 字段名称 字段名称 字段类型 [是否允许非空];
alter table students change name zh_name varchar(200) not null;
```

修改字符顺序
```
ALTER TABLE 表名 MODIFY 字段名1 数据类型 FIRST ｜ AFTER 字段名2;
alter table student modify id int(10) unsigned auto_increment first;

如果要把name放到id之后呢？这样写就可以了（first 换成 after即可）：
alter table student modify name varchar(10) after id;
alter table tb_electron_factory_online modify extra_data json default null AFTER source_type;

alter table 表名  change 字段名 新字段名 字段类型 默认值 after 字段名(跳到哪个字段之后)
alter table students  change name new_name varchar(50) default null AFTER z5
```

删除列字段
```
alter table students drop aa;
alter table students drop column aa;
```

修改表引擎
```
alter table students engine=innodb|bdb;
```

添加表外键约束
```
alter table students add constraint students foreign key(subid) references subjects(id);
```

添加唯一性约束
```
ALTER TABLE `t_user` ADD unique(`username`);
```

结构化查看数据
```
select * from students\G;
```

查看自己当前的数据库是否开启了自动提交事务
```
show variables like '%autocommit%'
select @@autocommit;

如果是1，设置了自动提交事物，那么运行命令：set autocommit = 0;设置为不开启自动提交
```

查看有木有未提交的事物（查询事务情况）
```
select * from information_schema.innodb_trx\G;
```
MySQL 5.5 版本以后，information_schema（ski:mə） 库中新增了三个关于锁的表，亦即 innodb_trx 、innodb_locks 和 innodb_lock_waits 。其中 innodb_trx 表记录当前运行的所有事务，innodb_locks 表记录当前出现的锁，innodb_lock_waits 表记录锁等待的对应关系
```
trx_id：事务ID。
trx_state：事务状态，有以下几种状态：RUNNING、LOCK WAIT、ROLLING BACK 和 COMMITTING。
trx_started：事务开始时间。
trx_requested_lock_id：事务当前正在等待锁的标识，可以和 INNODB_LOCKS 表 JOIN 以得到更多详细信息。
trx_wait_started：事务开始等待的时间。
trx_weight：事务的权重。
trx_mysql_thread_id：事务线程 ID，可以和 PROCESSLIST 表 JOIN。
trx_query：事务正在执行的 SQL 语句。
trx_operation_state：事务当前操作状态。
trx_tables_in_use：当前事务执行的 SQL 中使用的表的个数。
trx_tables_locked：当前执行 SQL 的行锁数量。
trx_lock_structs：事务保留的锁数量。
trx_lock_memory_bytes：事务锁住的内存大小，单位为 BYTES。
trx_rows_locked：事务锁住的记录数。包含标记为 DELETED，并且已经保存到磁盘但对事务不可见的行。
trx_rows_modified：事务更改的行数。
trx_concurrency_tickets：事务并发票数。
trx_isolation_level：当前事务的隔离级别。
trx_unique_checks：是否打开唯一性检查的标识。
trx_foreign_key_checks：是否打开外键检查的标识。
trx_last_foreign_key_error：最后一次的外键错误信息。
trx_adaptive_hash_latched：自适应散列索引是否被当前事务锁住的标识。
trx_adaptive_hash_timeout：是否立刻放弃为自适应散列索引搜索 LATCH 的标识
```

```
select * from information_schema.innodb_locks\G;

lock_id：锁 ID。
lock_trx_id：拥有锁的事务 ID。可以和 INNODB_TRX 表 JOIN 得到事务的详细信息。
lock_mode：锁的模式。有如下锁类型：行级锁包括：S、X、IS、IX，分别代表：共享锁、排它锁、意向共享锁、意向排它锁。表级锁包括：S_GAP、X_GAP、IS_GAP、IX_GAP 和 AUTO_INC，分别代表共享间隙锁、排它间隙锁、意向共享间隙锁、意向排它间隙锁和自动递增锁。
lock_type：锁的类型。RECORD 代表行级锁，TABLE 代表表级锁。
lock_table：被锁定的或者包含锁定记录的表的名称。
lock_index：当 LOCK_TYPE=’RECORD’ 时，表示索引的名称；否则为 NULL。
lock_space：当 LOCK_TYPE=’RECORD’ 时，表示锁定行的表空间 ID；否则为 NULL。
lock_page：当 LOCK_TYPE=’RECORD’ 时，表示锁定行的页号；否则为 NULL。
lock_rec：当 LOCK_TYPE=’RECORD’ 时，表示一堆页面中锁定行的数量，亦即被锁定的记录号；否则为 NULL。
lock_data：当 LOCK_TYPE=’RECORD’ 时，表示锁定行的主键；否则为NULL
```

```
select * from information_schema.innodb_lock_waits;

requesting_trx_id：请求事务的 ID。
requested_lock_id：事务所等待的锁定的 ID。可以和 INNODB_LOCKS 表 JOIN。
blocking_trx_id：阻塞事务的 ID。
blocking_lock_id：某一事务的锁的 ID，该事务阻塞了另一事务的运行。可以和 INNODB_LOCKS 表 JOIN。
```


手动提交未提交的事物
```
select connection_id() from dual;

set session autocommit=0;

delete from kkk where id =1;

SELECT t.trx_mysql_thread_id
 ,t.trx_state
 ,t.trx_tables_in_use
 ,t.trx_tables_locked
 ,t.trx_query
 ,t.trx_rows_locked 
 ,t.trx_rows_modified
 ,t.trx_lock_structs
 ,t.trx_started
 ,t.trx_isolation_level
 ,p.time
 ,p.user
 ,p.host
 ,p.db
 ,p.command
FROM information_schema.innodb_trx t 
 INNER JOIN information_schema.processlist p 
  ON t.trx_mysql_thread_id = p.id 
WHERE t.trx_state = 'RUNNING'
 AND p.time > 10 
 AND p.command = 'Sleep'\G
```

查看表锁信息
```
查看正在锁的事务
SELECT * FROM information_schema.INNODB_LOCKS;
查看等待锁的事务
SELECT * FROM information_schema.INNODB_LOCK_waits;
```

创建存储过程
```
删除存储过程命令：
DROP {PROCEDURE | FUNCTION} [IF EXISTS] 名称；

drop procedure pro_update_auto_increment_to_max;

创建更新auto_increment存储过程
DELIMITER $$
create procedure pro_update_auto_increment_to_max(in inout_table_name VARCHAR(200), in field_id VARCHAR(20))
begin
  # 拼接赋值 INTO 必须要用全局变量不然语句会报错
  set @auto_id = concat("select max(", field_id, ") + 1 as max_id into @max_id from ", inout_table_name);
  # 预处理需要执行的动态SQL，其中 ex_auto_id 是一个变量
  PREPARE ex_auto_id FROM @auto_id;
  # 执行SQL语句
  EXECUTE ex_auto_id;
  # 释放掉预处理段
  deallocate prepare ex_auto_id;

  set @alter_id = concat("alter table ", inout_table_name, " AUTO_INCREMENT=", @max_id);
  PREPARE ex_alter_id FROM @alter_id;
  EXECUTE ex_alter_id;
  # 释放掉预处理段
  deallocate prepare ex_alter_id;

  -- set @result = concat("select concat(", inout_table_name, "' 表的 auto_increment=@max_id 更新完成!')");
  set @result = concat("select concat('", inout_table_name, " 表的 auto_increment=',@max_id,' 更新完成！') as comment");
  PREPARE ex_result FROM @result;
  EXECUTE ex_result;
  # 释放掉预处理段
  deallocate prepare ex_result;

end $$

切换回来结束符为;
DELIMITER ;

call pro_update_auto_increment_to_max('db_electron_property_online.tb_electron_area', 'id');


```


desc information_schema.INNODB_LOCKS;
+————-+———————+——+—–+———+——-+
| Field       | Type                | Null | Key | Default | Extra |
+————-+———————+——+—–+———+——-+
| lock_id     | varchar(81)         | NO   |     |         |       |#锁ID
| lock_trx_id | varchar(18)         | NO   |     |         |       |#拥有锁的事务ID
| lock_mode   | varchar(32)         | NO   |     |         |       |#锁模式
| lock_type   | varchar(32)         | NO   |     |         |       |#锁类型
| lock_table  | varchar(1024)       | NO   |     |         |       |#被锁的表
| lock_index  | varchar(1024)       | YES  |     | NULL    |       |#被锁的索引
| lock_space  | bigint(21) unsigned | YES  |     | NULL    |       |#被锁的表空间号
| lock_page   | bigint(21) unsigned | YES  |     | NULL    |       |#被锁的页号
| lock_rec    | bigint(21) unsigned | YES  |     | NULL    |       |#被锁的记录号
| lock_data   | varchar(8192)       | YES  |     | NULL    |       |#被锁的数据
+————-+———————+——+—–+———+——-+


desc information_schema.INNODB_LOCK_waits;
+——————-+————-+——+—–+———+——-+
| Field             | Type        | Null | Key | Default | Extra |
+——————-+————-+——+—–+———+——-+
| requesting_trx_id | varchar(18) | NO   |     |         |       |#请求锁的事务ID
| requested_lock_id | varchar(81) | NO   |     |         |       |#请求锁的锁ID
| blocking_trx_id   | varchar(18) | NO   |     |         |       |#当前拥有锁的事务ID
| blocking_lock_id  | varchar(81) | NO   |     |         |       |#当前拥有锁的锁ID
+——————-+————-+——+—–+———+——-+

   
desc information_schema.innodb_trx ;
+—————————-+———————+——+—–+———————+——-+
| Field                      | Type                | Null | Key | Default             | Extra |
+—————————-+———————+——+—–+———————+——-+
| trx_id                     | varchar(18)         | NO   |     |                     |       |#事务ID
| trx_state                  | varchar(13)         | NO   |     |                     |       |#事务状态：
| trx_started                | datetime            | NO   |     | 0000-00-00 00:00:00 |       |#事务开始时间；
| trx_requested_lock_id      | varchar(81)         | YES  |     | NULL                |       |#innodb_locks.lock_id
| trx_wait_started           | datetime            | YES  |     | NULL                |       |#事务开始等待的时间
| trx_weight                 | bigint(21) unsigned | NO   |     | 0                   |       |#
| trx_mysql_thread_id        | bigint(21) unsigned | NO   |     | 0                   |       |#事务线程ID
| trx_query                  | varchar(1024)       | YES  |     | NULL                |       |#具体SQL语句
| trx_operation_state        | varchar(64)         | YES  |     | NULL                |       |#事务当前操作状态
| trx_tables_in_use          | bigint(21) unsigned | NO   |     | 0                   |       |#事务中有多少个表被使用
| trx_tables_locked          | bigint(21) unsigned | NO   |     | 0                   |       |#事务拥有多少个锁
| trx_lock_structs           | bigint(21) unsigned | NO   |     | 0                   |       |#
| trx_lock_memory_bytes      | bigint(21) unsigned | NO   |     | 0                   |       |#事务锁住的内存大小（B）
| trx_rows_locked            | bigint(21) unsigned | NO   |     | 0                   |       |#事务锁住的行数
| trx_rows_modified          | bigint(21) unsigned | NO   |     | 0                   |       |#事务更改的行数
| trx_concurrency_tickets    | bigint(21) unsigned | NO   |     | 0                   |       |#事务并发票数
| trx_isolation_level        | varchar(16)         | NO   |     |                     |       |#事务隔离级别
| trx_unique_checks          | int(1)              | NO   |     | 0                   |       |#是否唯一性检查
| trx_foreign_key_checks     | int(1)              | NO   |     | 0                   |       |#是否外键检查
| trx_last_foreign_key_error | varchar(256)        | YES  |     | NULL                |       |#最后的外键错误
| trx_adaptive_hash_latched  | int(1)              | NO   |     | 0                   |       |#
| trx_adaptive_hash_timeout  | bigint(21) unsigned | NO   |     | 0                   |       |#
+—————————-+———————+——+—–+———————+——-+


插入表数据
```
insert into students(name, gender, birthday) values('zhangsan', 1, '1990-7-8');

insert into students(name, gender, birthday) value
('zhangsan1', 1, '1990-7-8'),
('zhangsan2', 2, '1990-7-9'),
('zhangsan3', 3, '1990-7-10'),
('zhangsan4', 4, '1990-7-11');


replace into:
插入的数据的唯一索引或者主键索引与之前的数据有重复的情况，将会删除原先的数据，然后再进行添加
语法：replace into table( col1, col2, col3 ) values ( val1, val2, val3 ) 
语义：向table表中col1, col2, col3列replace数据val1，val2，val3
实例：REPLACE INTO students (id,name,age) VALUES(123, 'chao', 50);

REPLACE INTO students(name, gender, birthday) VALUES ('zhangsan2', 2, '1990-7-18');
```
eg:
```
CREATE TABLE `test` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) DEFAULT NULL COMMENT '标题',
  `uid` int(11) DEFAULT NULL COMMENT 'uid',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into  test(title,uid) VALUES ('你好','1');
insert into  test(title,uid) VALUES ('国庆节','2');
REPLACE INTO test(title,uid) VALUES ('这次是8天假哦','3');

当uid存在时，使用replace into 语句
REPLACE INTO test(title,uid) VALUES ('这是Uid=1的第一条数据哦','1');

replace into t(id, update_time) values(1, now());
或
replace into t(id, update_time) select 1, now();

replace into 跟 insert 功能类似，不同点在于：replace into 首先尝试插入数据到表中， 1. 如果发现表中已经有此行数据（根据主键或者唯一索引判断）则先删除此行数据，然后插入新的数据。 2. 否则，直接插入新数据。

要注意的是：插入数据的表必须有主键或者是唯一索引！否则的话，replace into 会直接插入数据，这将导致表中出现重复的数据

MySQL replace into 有三种形式：
1. replace into tbl_name(col_name, ...) values(...)
第一种形式类似于insert into的用法，

2. replace into tbl_name(col_name, ...) select ...
replace into tb1( name, title, mood) select rname, rtitle, rmood from tb2;
replace select的用法也类似于insert select，这种用法并不一定要求列名匹配，事实上，MYSQL甚至不关心select返回的列名，它需要的是列的位置。例如，replace into tb1( name, title, mood) select rname, rtitle, rmood from tb2;?这个例子使用replace into从?tb2中将所有数据导入tb1中。

3. replace into tbl_name set col_name=value, ...
第三种replace set用法类似于update set用法,使用一个例如“SET col_name = col_name + 1”的赋值，则对位于右侧的列名称的引用会被作为DEFAULT(col_name)处理。因此，该赋值相当于SET col_name = DEFAULT(col_name) + 1。
前两种形式用的多些。其中 “into” 关键字可以省略，不过最好加上 “into”，这样意思更加直观。另外，对于那些没有给予值的列，MySQL 将自动为这些列赋上默认值
```


mysql大数据量插入
```
INSERT语法
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name [(col_name,...)]
VALUES ({expr | DEFAULT},...),(...),...
[ ON DUPLICATE KEY UPDATE col_name=expr, ... ]

或：
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name
SET col_name={expr | DEFAULT}, ...
[ ON DUPLICATE KEY UPDATE col_name=expr, ... ]

或：
INSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name [(col_name,...)]
SELECT ...
[ ON DUPLICATE KEY UPDATE col_name=expr, ... ]


DELAYED 的使用
使用延迟插入操作DELAYED调节符应用于INSERT和REPLACE语句。当DELAYED插入操作到达的时候，服务器把数据行放入一个队列中，并立即给客户端返回一个状态信息，这样客户端就可以在数据表被真正地插入记录之前继续进行操作了。如果读取者从该数据表中读取数据，队列中的数据就会被保持着，直到没有读取者为止。

接着服务器开始插入延迟数据行（delayed-row）队列中的数据行。在插入操作的同时，服务器还要检查是否有新的读取请求到达和等待。如果有，延迟数据行队列就被挂起，允许读取者继续操作。当没有读取者的时候，服务器再次开始插入延迟的数据行。这个过程一直进行，直到队列空了为止。

INSERT DELAYED应该仅用于指定值清单的INSERT语句。服务器忽略用于INSERT DELAYED…SELECT语句的DELAYED。服务器忽略用于INSERT DELAYED…ON DUPLICATE UPDATE语句的DELAYED。

因为在行被插入前，语句立刻返回，所以您不能使用LAST_INSERT_ID()来获取AUTO_INCREMENT值。AUTO_INCREMENT值可能由语句生成。

对于SELECT语句，DELAYED行不可见，直到这些行确实被插入了为止。

DELAYED在从属复制服务器中被忽略了，因为DELAYED不会在从属服务器中产生与主服务器不一样的数据。注意，目前在队列中的各行只保存在存储器中，直到它们被插入到表中为止。这意味着，如果您强行中止了mysqld(例如，使用kill -9)或者如果mysqld意外停止，则所有没有被写入磁盘的行都会丢失。


IGNORE的使用
IGNORE是MySQL相对于标准SQL的扩展。如果在新表中有重复关键字，或者当STRICT模式启动后出现警告，则使用IGNORE控制ALTER TABLE的运行。

如果没有指定IGNORE，当重复关键字错误发生时，复制操作被放弃，返回前一步骤。

如果指定了IGNORE，则对于有重复关键字的行，只使用第一行，其它有冲突的行被删除。并且，对错误值进行修正，使之尽量接近正确值。insert ignore into tb(…) value(…)这样不用校验是否存在了，有则忽略，无则添加。


ON DUPLICATE KEY UPDATE的使用
如果您指定了ON DUPLICATE KEY UPDATE，并且插入行后会导致在一个UNIQUE索引或PRIMARY KEY中出现重复值，则执行旧行UPDATE。例如，如果列a被定义为UNIQUE，并且包含值1，则以下两个语句具有相同的效果
INSERT INTO table (a,b,c) VALUES (1,2,3)
ON DUPLICATE KEY UPDATE cc=c+1;

UPDATE table SET cc=c+1 WHERE a=1;
如果行作为新记录被插入，则受影响行的值为1；如果原有的记录被更新，则受影响行的值为2。
注释：如果列b也是唯一列，则INSERT与此UPDATE语句相当：

UPDATE table SET cc=c+1 WHERE a=1 OR b=2 LIMIT 1;
如果a=1 OR b=2与多个行向匹配，则只有一个行被更新。通常，您应该尽量避免对带有多个唯一关键字的表使用ON DUPLICATE KEY子句。您可以在UPDATE子句中使用VALUES(col_name)函数从INSERT…UPDATE语句的INSERT部分引用列值。换句话说，如果没有发生重复关键字冲突，则UPDATE子句中的VALUES(col_name)可以引用被插入的col_name的值。本函数特别适用于多行插入。VALUES()函数只在INSERT…UPDATE语句中有意义，其它时候会返回NULL。


示例：
INSERT INTO table (a,b,c) VALUES (1,2,3),(4,5,6)
ON DUPLICATE KEY UPDATE c=VALUES(a)+VALUES(b);

本语句与以下两个语句作用相同：
INSERT INTO table (a,b,c) VALUES (1,2,3)
ON DUPLICATE KEY UPDATE c=3;

INSERT INTO table (a,b,c) VALUES (4,5,6)
ON DUPLICATE KEY UPDATE c=9;

当您使用ON DUPLICATE KEY UPDATE时，DELAYED选项被忽略
```


更新表数据
```
update students set name='lili' where id=1;

UPDATE feifei.student s, feifei.temp t
SET s.name = t.name,
    s.sex = t.sex,
    s.age = t.age
WHERE s.student_id = t.student_id;


update db_electron_property_base.tb_electron_factory b, db_electron_property.tb_electron_factory a 
  set b.zh_name = a.zh_name,b.en_name = a.en_name,b.zh_link = a.link,b.en_link = a.link,b.zh_info = a.info,
  b.en_info = a.info,b.logo = a.logo,b.temp_zh_name = a.temp_zh_name,b.temp_en_name = a.temp_en_name
where b.id = a.id and b.id=11096;


UPDATE feifei.student s
INNER JOIN feifei.temp t ON t.student_id=s.student_id
SET s.name=t.name,
    s.age=t.age,
    s.sex=t.sex;
```

删除表数据
```
delete from students where id=1;

当有外键时删除会报错
truncate table students;
```

查询地在3到5之间的数据
```
select * from subjects where id between 3 and 5;
```

查询id为nul和不为null的数据
```
select * from students where id is null;
select * from students where id is not null;
```

授权
```
GRANT ALL ON *.* TO 'root'@'%';

刷新权限
flush privileges;
```

统计查询
```
select count(*),sum(id),max(id),min(id),floor(avg(id)),ceil(avg(id)) from subjects;
select * from subjects where id=(select min(id) from subjects);

select gender,count(*) from students group by gender;

select gender,count(*) from students group by gender having count(*) > 2;

select * from (
select gender,count(*) from students group by gender having count(*) > 2);

select id,name,gender,birthday from students where gender in 
(select gender from (select gender,count(*) from students group by gender having count(*) > 2) as b);

select * from students order by birthday asc,gender desc;
```

查看表的索引
```
show index from students;
show view from students;
```

创建索引
```
索引的方式有：BTREE、RTREE、HASH、FULLTEXT、SPATIAL
create index idx_students_id on students(id, name(11), gender);

create index idx_name using BTREE on students(name);

create view v_clouse_lg as 
select * from students
inner join
select * from subjects
```

添加索引
```
1.添加PRIMARY KEY（主键索引） 
ALTER TABLE `students` ADD PRIMARY KEY ( `column` ) 

2.添加UNIQUE(唯一索引) 
mysql>ALTER TABLE `students` ADD UNIQUE ( 
`column` 
) 

3.添加INDEX(普通索引) 
ALTER TABLE `students` ADD INDEX index_name ( `column` ) 
ALTER TABLE students ADD INDEX idx_name(NAME);

ALTER TABLE students ADD key idx_name(NAME) using btree;

4.添加FULLTEXT(全文索引) 
ALTER TABLE `students` ADD FULLTEXT ( `column`) 

5.添加多列索引 
ALTER TABLE `students` ADD INDEX index_name ( `column1`, `column2`, `column3` )
```

修改索引名
```
对于MySQL 5.7及以上版本,可以执行以下命令
alter table students rename index old_index_name to new_index_name; 

对于MySQL 5.7以前的版本，可以执行下面两个命令：
ALTER TABLE tbl_name DROP INDEX old_index_name
ALTER TABLE tbl_name ADD INDEX new_index_name(column_name)
```

添加主键约束(添加主键唯一性约束)
```
alter table students add primarykey(id);
```

删除索引
```
drop index idx_students_id on students;
drop index index_name on students ;
alter table students drop index index_name ;
alter table students drop primary key;
```

删除唯一约束
```
DROP INDEX index_name ON students
或ALTER TABLE语法：
ALTER TABLE students DROP INDEX index_name
```


删除主键
```
alter table students drop primary key;
```

解除外键约束
```
alter table students drop foreign key FK1C81D1738DA76;
```

删除外键（删除约束，删除外键约束）
```
alter table students drop user_id
```

修改存储引擎
```
alter table students engine = innodb;
alter table students engine = myisam;
```


开启运行时间检测
```
set profiling=1;
```

<!-- innodb_flush_log_at_trx_commit -->


查看执行时间
```
show profiles;
```

查看当前表的自动增长id是多少
```
select auto_increment from information_schema.tables 
where table_schema = 'db_electron_property' and table_name = 'tb_electron_area';
```

修改表students自动序列值
```
alter table students AUTO_INCREMENT=10000;
```

查看innodb引擎的运行时信息
```
show engine innodb status\G
```

查看服务器状态。
```
show status like 'table_lock%';
show status like '%lock%'
```

查看服务器用运行时长（查看mysql服务器运行时长）
```
show global status like 'uptime';
```

查看哪些表锁死(查询是否锁表)查看表锁定
```
show open tables where in_use > 0;
```

查看慢查询时间(默认10s)
```
show variables like "long_query_time";
```

查看慢查询配置情况
```
show status like "%slow_queries%";
```

查看慢查询日志路径
```
show variables like "%slow%";
```

查询到相对应的进程
```
show processlist;
show full processlist;
```

查看服务器配置参数
```
show variables like '%timeout%';
show variables like '%secure%';
```

查看所有变量
```
show session variables;
```

查看错误连接数
```
show variables like '%max_connect_errors%';

MySQL [db_electron_property]> show variables like '%max_connect_errors%';
+--------------------+---------+
| Variable_name      | Value   |
+--------------------+---------+
| max_connect_errors | 1000000 |
+--------------------+---------+
1 row in set (0.04 sec)

mysql> set global max_connect_errors=3;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like '%max_connect_error%';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| max_connect_errors | 3     |
+--------------------+-------+
1 row in set (0.00 sec)
```

查看服务器字符集
```
show variables like '%character%'

修改my.ini配置文件（mysql配置文件）
character_set_server = utf8 #设置字符集

修改数据库字符集
alter database 数据库名 character set utf8;

修改表字符集:
ALTER TABLE  表名 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

生成所有表修改字符集语句：
SELECT TABLE_NAME,CONCAT('ALTER TABLE  ',TABLE_NAME,' DEFAULT CHARACTER SET ',a.DEFAULT_CHARACTER_SET_NAME,' COLLATE ',a.DEFAULT_COLLATION_NAME,';') executeSQL FROM information_schema.SCHEMATA a,information_schema.TABLES bWHERE a.SCHEMA_NAME=b.TABLE_SCHEMAAND a.DEFAULT_COLLATION_NAME!=b.TABLE_COLLATIONAND b.TABLE_SCHEMA='数据库名'

修改列字符集:
ALTER TABLE  表名 CHANGE  列名  列名  VARCHAR( 100 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

生成所有列修改字符集语句：
select b.table_name,b.column_name,b.character_set_name,b.collation_name
,CONCAT('ALTER TABLE ',b.table_name,' MODIFY ',b.column_name,' ',b.DATA_TYPE,'(',b.CHARACTER_MAXIMUM_LENGTH,') ',CASE WHEN b.COLUMN_DEFAULT IS NULL THEN ''  ELSE CONCAT('DEFAULT \'',b.COLUMN_DEFAULT,'\'') END,' COMMENT \'',b.COLUMN_COMMENT,'\';') executeSQL from information_schema.TABLES a,information_schema.COLUMNS b where  b.character_set_name IS NOT NULL and a.TABLE_SCHEMA=b.TABLE_SCHEMA AND a.TABLE_NAME=b.TABLE_NAMEAND a.TABLE_COLLATION!=b.COLLATION_NAMEand a.TABLE_SCHEMA='数据库名'
```

查看连接超时
```
show global variables like '%timeout';
```

查看mysql最大连接数(查看mysql连接数)
```
SHOW VARIABLES LIKE '%connections%';
SHOW STATUS LIKE 'Thread%';
```

修改MySQL最大连接数
1. 方式一
```
最大连接数:
set global max_connections=1000;

最大错误连接数:
set global max_connect_errors = 100;
```
2. 方式二
MySQL配置文件my.ini 或 my.cnf的参数(通常再默认安装路径下)
在最下面添加：
```
# 修改最大连接数
max_connections=1000;

# 修改最大错误连接数
max_connect_errors = 1000;
```
![my.ini配置图](https://img-blog.csdnimg.cn/20190316165547341.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xpcnVpZG9uZzAx,size_16,color_FFFFFF,t_70 "my.ini配置图")


查看请求链接进程被主动kill
```
show global status like 'com_kill';
```

查看文件大小是否超过 max_allowed_packet ，如果超过则需要调整参数，或者优化语句
```
show global variables like 'max_allowed_packet';
set global max_allowed_packet=1024*1024*16;


show variables like '%max_allowed_packet%';
将修改成 100M
set global max_allowed_packet = 1024*1024*100;
这种修改只会临时生效，MySQL重启后，依旧会变为4M，想要长期生效，需要修改「my.ini」
```

wait_timeout太小，MySQL链接长时间没有新请求，就被Server端关闭了
```
show global variables like '%timeout';
MySQL无操作28800秒后会被自动化关闭
set global wait_time = 28800;
但这不是长久之策，因为长时间不操作，MySQL Server端依旧会将其关闭，这个问题依旧会出现，为了避免这个问题，你需要自己关闭链接，对于一些MySQL操作量不大的情景，建议使用短连接的形式，如果依旧需要用MySQL连接池，以长连接的方式来操作MySQL，就需要实现判断当前链接是否存活的逻辑并在不存活的情况下自动重连
```

```
show open tables from database;
```

单个表锁定：
```
格式： LOCK TABLES tbl_name {READ | WRITE},[ tbl_name {READ | WRITE},……] 
例子： lock tables db_a.tbl_aaa read; 　　// 锁定了db_a库中的tbl_aaa表
解锁： unlock tables; 
```

全局表锁定：
```
命令： FLUSH TABLES WITH READ LOCK; 　　// 所有库所有表都被锁定只读
解锁： unlock tables;
```

查询所有事物
```
select * from information_schema.innodb_trx\G
```

查看正在运行的事物
```
select * from information_schema.innodb_trx where trx_state='RUNNING' \G
```

查看未提交的事务(3秒内未操作的事务)
```
SELECT 
p.ID AS conn_id,
P.USER AS login_user,
P.HOST AS login_host,
p.DB AS database_name,
P.TIME AS trx_sleep_seconds,
TIME_TO_SEC(TIMEDIFF(NOW(),T.trx_started)) AS trx_open_seconds,
T.trx_started,
T.trx_isolation_level,
T.trx_tables_locked,
T.trx_rows_locked,
t.trx_state,
p.COMMAND AS process_state,
(
SELECT GROUP_CONCAT(T1.`SQL_TEXT` SEPARATOR ';
') 
FROM performance_schema.events_statements_history AS T1
INNER JOIN performance_schema.threads AS T2
ON T1.`THREAD_ID`=T2.`THREAD_ID`
WHERE T2.`PROCESSLIST_ID`=P.id
) AS trx_sql_text
FROM `information_schema`.`INNODB_TRX` t
INNER JOIN `information_schema`.`PROCESSLIST` p
ON t.trx_mysql_thread_id=p.id
WHERE t.trx_state='RUNNING'
AND p.COMMAND='Sleep'
AND P.TIME>3
ORDER BY T.trx_started ASC \G
```

查看当前会话连接的事物
```
SELECT tx.trx_id
FROM information_schema.innodb_trx tx
WHERE tx.trx_mysql_thread_id = connection_id()
```

查看数据库的隔离级别
```
select @@tx_isolation;
```

查看正在运行的sql
```
select  *  from information_schema.processlist where info is not null;
```

杀掉事物
```
SELECT  concat('kill ',trx_mysql_thread_id,";")t_sql FROM  information_schema.INNODB_TRX；
```

使用sys.session视图来查看会话最后一次执行的SQL
```
SELECT * 
FROM sys.session 
WHERE CONN_ID = 20036 \G
```




查看创建的索引的CARDINALITY比率
```
--通常cardinality达到表数据的10%左右建索引会有意义
--如果是一个组合索引，索引第一位的cardinality表示第一个列的cardinality大小，第二列表示第一列和第二列共同的cardinality值
SELECT 
    T1.TABLE_SCHEMA,
    T1.TABLE_NAME,
    T2.INDEX_NAME,
    ROUND(T2.CARDINALITY / T1.TABLE_ROWS * 100, 2) AS RATE
FROM
    INFORMATION_SCHEMA.TABLES T1,
    INFORMATION_SCHEMA.STATISTICS T2
WHERE
    T1.TABLE_SCHEMA = T2.TABLE_SCHEMA
        AND T1.TABLE_NAME = T2.TABLE_NAME
        AND T2.SEQ_IN_INDEX = (SELECT 
            MIN(T3.SEQ_IN_INDEX)
        FROM
            INFORMATION_SCHEMA.STATISTICS T3
        WHERE
                T2.TABLE_NAME = T3.TABLE_NAME
                AND T2.TABLE_SCHEMA = T3.TABLE_SCHEMA
                AND T2.INDEX_NAME = T3.INDEX_NAME)
AND T1.TABLE_SCHEMA NOT IN ('MYSQL','PERFORMANCE_SCHEMA','INFORMATION_SCHEMA','SYS')
AND T1.TABLE_ROWS >=100 
ORDER BY RATE;
```

查看锁阻塞
```
-- 查看锁的SQL
SELECT 
    t3.trx_id waiting_trx_id,
    t3.trx_mysql_thread_id waiting_thread,
    t3.trx_query waiting_query,
    t2.trx_id blocking_trx_id,
    t2.trx_mysql_thread_id blocking_thread,
    t2.trx_query blocking_query
FROM
    information_schema.innodb_lock_waits t1,
    information_schema.innodb_trx t2,
    information_schema.innodb_trx t3
WHERE
    t1.blocking_trx_id = t2.trx_id
        AND t1.requesting_trx_id = t3.trx_id;
```


查询出哪些表不是InnoDB引擎的
```
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE,
    ENGINE,
    CREATE_TIME,
    UPDATE_TIME,
    TABLE_COLLATION
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_SCHEMA NOT IN ('information_schema' , 'mysql', 'performance_schema', 'sys')
        AND ENGINE <> 'InnoDB';
```


生成修改存储引擎的语句
```
SELECT 
    -- TABLE_SCHEMA,
    -- TABLE_NAME,
    -- TABLE_TYPE,
    -- ENGINE,
    -- CREATE_TIME,
    -- UPDATE_TIME,
    -- TABLE_COLLATION,
     CONCAT('alter table ', TABLE_SCHEMA,'.',TABLE_NAME, ' engine=InnoDB;') AS alter_sql
  FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_SCHEMA NOT IN
       ('information_schema', 'mysql', 'performance_schema', 'sys')
   AND ENGINE <> 'InnoDB';
```

查看指定数据库的表信息
```
SET @table_schema='employees';
SELECT 
    table_name,
    table_type,
    engine,
    table_rows,
    avg_row_length,
    data_length,
    index_length,
    table_collation,
    create_time
FROM
    information_schema.tables
WHERE
    table_schema = @table_schema
ORDER BY table_name;
```

查看会话连接信息
```
SELECT 
    THREAD_ID,
    name,
    type,
    PROCESSLIST_ID,
    PROCESSLIST_USER AS user,
    PROCESSLIST_HOST AS host,
    PROCESSLIST_DB AS db,
    PROCESSLIST_COMMAND AS cmd,
    PROCESSLIST_TIME AS time,
    PROCESSLIST_STATE AS state,
    PROCESSLIST_INFO AS info,
    CONNECTION_TYPE AS type,
    THREAD_OS_ID AS os_id
FROM
    performance_schema.threads
WHERE
    type = 'FOREGROUND'
ORDER BY THREAD_ID;

```


CHARACTER_SETS 查看数据库支持的字符集
```
SELECT * FROM INFORMATION_SCHEMA.CHARACTER_SETS
WHERE CHARACTER_SET_NAME LIKE 'utf%';

SHOW CHARACTER SET LIKE 'utf%';
```

COLLATIONS  字符序
```
-- 用于指定数据集如何排序，以及字符串的比对规则
SELECT * FROM INFORMATION_SCHEMA.COLLATIONS
WHERE COLLATION_NAME LIKE 'utf%';

SHOW COLLATION LIKE 'utf%';
```

查看表结构定义信息
```
SELECT 
    table_name,
    COLUMN_NAME,
    ordinal_position,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT,
    column_type,
    column_key,
    character_set_name,
    collation_name
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    table_name = 'employees'
        AND table_schema = 'employees';
show columns from employees from employees;


desc employeees.employees;
```


查看支持的引擎
```
SELECT *  FROM INFORMATION_SCHEMA.ENGINES;
show ENGINES;
```

查看数据库的数据文件信息
```
SELECT 
    FILE_ID,
    FILE_NAME,
    FILE_TYPE,
    TABLESPACE_NAME,
    FREE_EXTENTS,
    TOTAL_EXTENTS,
    ((TOTAL_EXTENTS - FREE_EXTENTS) * EXTENT_SIZE) / 1024 / 1024 AS MB_used,
    EXTENT_SIZE,
    INITIAL_SIZE,
    MAXIMUM_SIZE,
    AUTOEXTEND_SIZE,
    DATA_FREE,
    STATUS,
    ENGINE
FROM
    INFORMATION_SCHEMA.FILES;
```


查看指定表的约束
```
SELECT 
    constraint_schema,
    table_name,
    constraint_name,
    column_name,
    ordinal_position,
    CONCAT(table_name,
            '.',
            column_name,
            ' -> ',
            referenced_table_name,
            '.',
            referenced_column_name) AS list_of_fks
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_SCHEMA = 'employees'
        AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME , COLUMN_NAME;
```

查看指定分区表信息
```
SELECT 
    TABLE_SCHEMA,
    table_name,
    partition_name,
    subpartition_name sub_par,
    partition_ordinal_position par_position,
    partition_method method,
    partition_expression expression,
    partition_description description,
    table_rows
FROM information_schema.PARTITIONS
WHERE table_schema = 'test' AND table_name = 't';
```


查看支持的插件
```
SELECT
  PLUGIN_NAME, PLUGIN_STATUS, PLUGIN_TYPE,
  PLUGIN_LIBRARY, PLUGIN_LICENSE
FROM INFORMATION_SCHEMA.PLUGINS;

SHOW PLUGINS;
```
 

查看数据库连接信息
```
SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST;

SHOW FULL PROCESSLIST;
``` 

查看数据库中的存储过程、函数等
```
SELECT 
    ROUTINE_SCHEMA,
    routine_name,
    ROUTINE_TYPE,
    data_type,
    routine_body,
    routine_definition,
    routine_comment
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE' AND ROUTINE_SCHEMA="employees";
```
 

查看存在的数据库及字符集信息
```
SELECT 
    SCHEMA_NAME,
    DEFAULT_CHARACTER_SET_NAME,
    DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA;

SHOW DATABASES;
```
 

查看索引信息
```
SELECT 
    table_schema,
    table_name,
    index_name,
    COLUMN_NAME,
    COLLATION,
    CARDINALITY,
    index_type
FROM INFORMATION_SCHEMA.STATISTICS
WHERE table_name = 'employees' AND table_schema = 'employees';

SHOW INDEX FROM employees FROM employees;
```
 

查看数据库大小
```
SELECT table_schema 'database',
CONCAT(ROUND(SUM(data_length + index_length) / (1024 * 1024), 2), 'MB') mb_size,
CONCAT(ROUND(SUM(data_length + index_length) / (1024 * 1024 * 1024), 2), 'GB') gb_size,
CONCAT(ROUND(SUM(data_length + index_length) / (1024 * 1024 * 1024 * 1024), 4), 'TB') tb_size,
CONCAT(ROUND(SUM(data_length + index_length) / (1024 * 1024 * 1024 * 1024 * 1024), 6), 'PB') pb_size
FROM information_schema.TABLES
WHERE ENGINE in ('MyISAM','InnoDB') and table_schema not in ('information_schema','mysql','sys')
GROUP BY table_schema;
```
 

查看表大小　　
```
SELECT CONCAT(table_schema, '.', table_name) table_name,
CONCAT(ROUND(data_length / (1024 * 1024), 2),'M') data_length,
CONCAT(ROUND(index_length / (1024 * 1024), 2),'M') index_length,
CONCAT(ROUND(ROUND(data_length + index_length) / (1024 * 1024),2),'M') total_size,engine
FROM information_schema.TABLES
WHERE table_schema NOT IN ('information_schema' , 'performance_schema', 'mysql', 'sys')
ORDER BY data_length DESC;
```


查看各个表数据量
```
select table_name,table_rows from information_schema.tables where table_schema = 'db_test' and table_rows > 0 order by table_rows desc;
select table_name,table_rows from information_schema.tables where table_schema = 'db_test' order by table_rows desc;

+------------------------------------+------------+
| table_name                         | table_rows |
+------------------------------------+------------+
| m_electron                         |   13484200 |
| m_electron_category                |        701 |
| auditing_product_video             |          0 |
| merchant_product_scheme            |          0 |
+------------------------------------+------------+
```

查看所有表信息
```
SELECT * FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'db_electron_property_base'
```

查询数据库表数量
```
查询MySQL服务中数据库表数据量
SELECT COUNT(*) TABLES, table_schema FROM information_schema.TABLES    GROUP BY table_schema;

查询指定数据库表数量
SELECT COUNT(*) TABLES, table_schema FROM information_schema.TABLES   WHERE table_schema = 'szdb'
```

查询数据库字段
```
#查询一个表中有多少字段
SELECT COUNT(*) FROM information_schema. COLUMNS WHERE table_schema = 'szdb' AND table_name = 'SystemLog';

#查询一个数据库中有多少字段
SELECT COUNT(column_name) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = 'szdb';

#查询数据库中所以表、字段、字段类型、注释等信息
SELECT TABLE_NAME, column_name, DATA_TYPE, column_comment FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = 'szdb' ;
```

查询数据库中持久化的数据量

MySQL中有一个名为 information_schema 的数据库，在该库中有一个 TABLES 表，这个表主要字段分别：TABLE_SCHEMA : 数据库名，TABLE_NAME：表名，ENGINE：所使用的存储引擎，TABLES_ROWS：记录数，DATA_LENGTH：数据大小，INDEX_LENGTH：索引大小
use information_schema；统计数据主要使用的就是这张表了
```
#统计数据库中每个表保存的数据量
use information_schema;
SELECT TABLE_NAME, (DATA_LENGTH/1024/1024) as DataM ,(INDEX_LENGTH/1024/1024) as IndexM,((DATA_LENGTH+INDEX_LENGTH)/1024/1024) as AllM,TABLE_ROWS FROM TABLES WHERE TABLE_SCHEMA = 'szdb'

#查询每张表数量
select table_name,table_rows from tables where TABLE_SCHEMA = 'szdb' order by table_rows desc;

#数据库总数量
SELECT sum(table_rows) from tables where TABLE_SCHEMA = 'szdb' order by table_rows desc;
```


修改数据库名
```
select concat('rename table sysbench_testdata.',table_name,' to wenyz.',table_name,';') from information_schema.tables where table_schema='sysbench_testdata';

select concat('rename table magic.',table_name,' to magic_backup.',table_name,';') from information_schema.tables where table_schema='magic' into outfile '/data/mysql_export_dir/rename_database.sql' ;


修改数据库名 shell 脚本
old_db_name = 'magic'
new_db_name = 'magic_backup'

mysql -h192.168.1.163 -uroot -pmofang123 -e "create database if not exists $new_db_name default character set utf8"

list_table = $(mysql -h192.168.1.163 -uroot -pmofang123 -Nse "select table_name from information_schema.TABLES where table_schema='$old_db_name'")

for table in $list_table
do
  mysql -h192.168.1.163 -uroot -pmofang123 -e "rename table $old_db_name.$table to $new_db_name.$table"
done

问题：脚本执行报错/bin/bash^M: bad interpreter: No such file or directory
解决方案：
将脚本上传到linux系统之后，使用vi 或 vim 编辑器打开，在命令模式下输入
:set ff回车
查看当前脚本格式，显示为:set ff=dos，将其修改为unix格式
还是在命令模式下输入:set ff=unix回车
:wq保存退出
重新执行脚本就可以了
```


随机数
```
(SELECT floor( RAND() * ((SELECT MAX(id) FROM `table`)-(SELECT MIN(id) FROM `table`)) + (SELECT MIN(id) FROM `table`)))
```

获取某库某表当前自增id的值
```
SELECT auto_increment FROM information_schema.tables where table_schema="db_electron" and students="tb_electron";
```

更新分类id
```
update tb_electron_digikey_category set category_id = (select distinct a.category_id from tb_electron_category_cleaning a where tb_electron_digikey_category.zh_category = a.cname);
```

```
<!-- 取5条记录 -->
select * from students limit 5;
+----+-----------+--------+---------------------+--------+-----------+
| id | name      | gender | birthday            | remark | is_delete |
+----+-----------+--------+---------------------+--------+-----------+
|  1 | 小王      | 女     | 1994-10-11 00:00:00 | NULL   |           |
|  2 | 小小王    | 女     | 1993-10-11 00:00:00 | NULL   |           |
|  3 | 王大锤    | 女     | 1993-10-11 00:00:00 | NULL   |           |
|  4 | 王铁锤    | 男     | 1993-10-11 00:00:00 | NULL   |           |
|  5 | 王铁蛋    | 女     | 1993-10-11 00:00:00 | NULL   |           |
+----+-----------+--------+---------------------+--------+-----------+
5 rows in set (0.00 sec)

<!-- 从第二开始取5条 -->
<!-- n页码，m条数--》limit (n-1)*m, m; -->
select * from students limit 2,5;
+----+--------------+--------+---------------------+--------+-----------+
| id | name         | gender | birthday            | remark | is_delete |
+----+--------------+--------+---------------------+--------+-----------+
|  3 | 王大锤       | 女     | 1993-10-11 00:00:00 | NULL   |           |
|  4 | 王铁锤       | 男     | 1993-10-11 00:00:00 | NULL   |           |
|  5 | 王铁蛋       | 女     | 1993-10-11 00:00:00 | NULL   |           |
|  6 | 隔壁老王     | 保密   | 1993-10-11 00:00:00 | NULL   |           |
|  7 | 隔壁小王     | 其他   | 1993-10-11 00:00:00 | NULL   |           |
+----+--------------+--------+---------------------+--------+-----------+
5 rows in set (0.00 sec)

CREATE TABLE `scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` smallint(6) DEFAULT '0',
  `stuid` int(11) NOT NULL,
  `subid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stuid` (`stuid`),
  KEY `subid` (`subid`),
  CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`stuid`) REFERENCES `students` (`id`),
  CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`subid`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8

mysql> select a.id,name,gender,b.score from students as a inner join scores as b on a.id=b.stuid;
+----+-----------+--------+-------+
| id | name      | gender | score |
+----+-----------+--------+-------+
|  1 | 小王      | 女     |    10 |
|  1 | 小王      | 女     |     9 |
|  1 | 小王      | 女     |     9 |
|  1 | 小王      | 女     |     5 |
|  2 | 小小王    | 女     |     5 |
|  2 | 小小王    | 女     |     6 |
|  2 | 小小王    | 女     |    10 |
|  2 | 小小王    | 女     |    10 |
+----+-----------+--------+-------+
8 rows in set (0.00 sec)

mysql> select a.id,name,gender,b.score,c.title from students as a inner join scores as b on a.id=b.stuid inner join subjects as c on c.id=b.subid;
+----+-----------+--------+-------+---------+
| id | name      | gender | score | title   |
+----+-----------+--------+-------+---------+
|  1 | 小王      | 女     |    10 | mysql   |
|  2 | 小小王    | 女     |     5 | mysql   |
|  1 | 小王      | 女     |     9 | redis   |
|  2 | 小小王    | 女     |     6 | redis   |
|  1 | 小王      | 女     |     9 | mongodb |
|  2 | 小小王    | 女     |    10 | mongodb |
|  1 | 小王      | 女     |     5 | oracle  |
|  2 | 小小王    | 女     |    10 | oracle  |
+----+-----------+--------+-------+---------+
8 rows in set (0.00 sec)

mysql> select a.id,name,gender,b.score,c.title from students as a inner join scores as b on a.id=b.stuid inner join subjects as c on c.id=b.subid
    -> order by a.name desc,c.title desc;
+----+-----------+--------+-------+---------+
| id | name      | gender | score | title   |
+----+-----------+--------+-------+---------+
|  1 | 小王      | 女     |     9 | redis   |
|  1 | 小王      | 女     |     5 | oracle  |
|  1 | 小王      | 女     |    10 | mysql   |
|  1 | 小王      | 女     |     9 | mongodb |
|  2 | 小小王    | 女     |     6 | redis   |
|  2 | 小小王    | 女     |    10 | oracle  |
|  2 | 小小王    | 女     |     5 | mysql   |
|  2 | 小小王    | 女     |    10 | mongodb |
+----+-----------+--------+-------+---------+
8 rows in set (0.00 sec)

mysql> select a.id,a.name as province,b.id as cid,b.name as city,c.id as aid,c.name as county from region as a 
inner join region as b on a.id=b.pid 
inner join region c on b.id=c.pid and a.id=2;
+----+-----------+-----+-----------+-----+--------------+
| id | province  | cid | city      | aid | county       |
+----+-----------+-----+-----------+-----+--------------+
|  2 | 甘肃省    |   3 | 天水市    |  12 | 秦州区       |
|  2 | 甘肃省    |   3 | 天水市    |  13 | 麦积区       |
|  2 | 甘肃省    |   3 | 天水市    |  14 | 武山县       |
|  2 | 甘肃省    |   3 | 天水市    |  15 | 甘谷县       |
|  2 | 甘肃省    |   3 | 天水市    |  16 | 张家川县     |
|  2 | 甘肃省    |   3 | 天水市    |  17 | 清水县       |
|  2 | 甘肃省    |   3 | 天水市    |  18 | 秦安县       |
+----+-----------+-----+-----------+-----+--------------+
7 rows in set (0.00 sec)


mysql> create view v_region as select a.id,a.name as province,b.id as cid,b.name as city,c.id as aid,c.name as county from region as a inner join region as b on a.id=b.pid inner join region c on b.id=c.pid;
Query OK, 0 rows affected (0.05 sec)

mysql> select * from v_region;
+----+-----------+-----+-----------+-----+--------------+
| id | province  | cid | city      | aid | county       |
+----+-----------+-----+-----------+-----+--------------+
|  1 | 北京市    |   5 | 北京市    |   6 | 海淀区       |
|  1 | 北京市    |   5 | 北京市    |   7 | 西城区       |
|  1 | 北京市    |   5 | 北京市    |   8 | 东城区       |
|  1 | 北京市    |   5 | 北京市    |   9 | 朝阳区       |
|  1 | 北京市    |   5 | 北京市    |  10 | 密云县       |
|  1 | 北京市    |   5 | 北京市    |  11 | 大兴区       |
|  2 | 甘肃省    |   3 | 天水市    |  12 | 秦州区       |
|  2 | 甘肃省    |   3 | 天水市    |  13 | 麦积区       |
|  2 | 甘肃省    |   3 | 天水市    |  14 | 武山县       |
|  2 | 甘肃省    |   3 | 天水市    |  15 | 甘谷县       |
|  2 | 甘肃省    |   3 | 天水市    |  16 | 张家川县     |
|  2 | 甘肃省    |   3 | 天水市    |  17 | 清水县       |
|  2 | 甘肃省    |   3 | 天水市    |  18 | 秦安县       |
+----+-----------+-----+-----------+-----+--------------+
13 rows in set (0.00 sec)

begin;
update region set name='北京' where id=1;
commit;
--rollbck;
```



## 进阶操作
```
排序
将pony表中的d 进行排序，可d的定义为varchar，可以这样解决
select * from pony order by (d+0)


数学函数
select abs(-32);
select mod(10/3);
select 10%3;
select floor(2/3);
select ceiling(2/3);


日期时间查询，转换等函数
date_format(date,format), time_format(time,format) 能够把一个日期/时间转换成各种各样的字符串格式。
它是 str_to_date(str,format) 函数的 一个逆转换

select now(),sleet(3),timestamp();
select date_format('2008-08-08 20:00:05','%Y-%m-%d %H:%i:%s');
select time_format('2008-08-08 20:00:05','%Y-%m-%d %H:%i:%s');
select str_to_date('2008-08-08 20:00:05','%Y-%m-%d %H:%i:%s');
select str_to_date('08/09/2008', '%m/%d/%Y'); -- 2008-08-09
select str_to_date('08/09/08' , '%m/%d/%y'); -- 2008-08-09
select str_to_date('08.09.2008', '%m.%d.%Y'); -- 2008-08-09
select str_to_date('08:09:30', '%h:%i:%s'); -- 08:09:30
select str_to_date('08.09.2008 08:09:30', '%m.%d.%Y %h:%i:%s'); -- 2008-08-09 08:09:30

(日期、天数)转换函数：to_days(date), from_days(days)
select to_days('0000-00-00'); -- 0
select to_days('2008-08-08'); -- 733627

(时间、秒)转换函数：time_to_sec(time), sec_to_time(seconds)
select time_to_sec('01:00:05'); -- 3605
select sec_to_time(3605); -- '01:00:05'

拼凑日期、时间函数：makdedate(year,dayofyear), maketime(hour,minute,second)
select makedate(2001,31); -- '2001-01-31'
select makedate(2001,32); -- '2001-02-01'
select maketime(12,15,30); -- '12:15:30'

（Unix 时间戳、日期）转换函数
unix_timestamp(),
unix_timestamp(date),
from_unixtime(unix_timestamp),
from_unixtime(unix_timestamp,format)

select unix_timestamp(); -- 1218290027
select unix_timestamp('2008-08-08'); -- 1218124800
select unix_timestamp('2008-08-08 12:30:00'); -- 1218169800

select from_unixtime(1218290027); -- '2008-08-09 21:53:47'
select from_unixtime(1218124800); -- '2008-08-08 00:00:00'
select from_unixtime(1218169800); -- '2008-08-08 12:30:00'

select from_unixtime(1218169800, '%Y %D %M %h:%i:%s %x'); -- '2008 8th August 12:30:00 2008'


set @dt = now();

select date_add(@dt, interval 1 day); -- add 1 day
select date_add(@dt, interval 1 hour); -- add 1 hour
select date_add(@dt, interval 1 minute); -- ...
select date_add(@dt, interval 1 second);
select date_add(@dt, interval 1 microsecond);
select date_add(@dt, interval 1 week);
select date_add(@dt, interval 1 month);
select date_add(@dt, interval 1 quarter);
select date_add(@dt, interval 1 year);

select date_add(@dt, interval -1 day); -- sub 1 day

adddate(), addtime()函数，可以用 date_add() 来替代。下面是 date_add() 实现 addtime() 功能示例：

set @dt = '2008-08-09 12:12:33';

select date_add(@dt, interval '01:15:30' hour_second);

+------------------------------------------------+
| date_add(@dt, interval '01:15:30' hour_second) |
+------------------------------------------------+
| 2008-08-09 13:28:03 |
+------------------------------------------------+

select date_add(@dt, interval '1 01:15:30' day_second);

+-------------------------------------------------+
| date_add(@dt, interval '1 01:15:30' day_second) |
+-------------------------------------------------+
| 2008-08-10 13:28:03 |
+-------------------------------------------------+


MySQL 为日期减去一个时间间隔：date_sub()
mysql> select date_sub('1998-01-01 00:00:00', interval '1 1:1:1' day_second);

+----------------------------------------------------------------+
| date_sub('1998-01-01 00:00:00', interval '1 1:1:1' day_second) |
+----------------------------------------------------------------+
| 1997-12-30 22:58:59 |
+----------------------------------------------------------------+

MySQL date_sub() 日期时间函数 和 date_add() 用法一致，不再赘述。
 

MySQL 日期、时间相减函数：datediff(date1,date2), timediff(time1,time2)

MySQL datediff(date1,date2)：两个日期相减 date1 - date2，返回天数。
select datediff('2008-08-08', '2008-08-01'); -- 7
select datediff('2008-08-01', '2008-08-08'); -- -7
MySQL timediff(time1,time2)：两个日期相减 time1 - time2，返回 time 差值。

select timediff('2008-08-08 08:08:08', '2008-08-08 00:00:00'); -- 08:08:08
select timediff('08:08:08', '00:00:00'); -- 08:08:08
注意：timediff(time1,time2) 函数的两个参数类型必须相同。

 

MySQL 时间戳（timestamp）转换、增、减函数：

timestamp(date) -- date to timestamp
timestamp(dt,time) -- dt + time
timestampadd(unit,interval,datetime_expr) --
timestampdiff(unit,datetime_expr1,datetime_expr2) --

请看示例部分：
select timestamp('2008-08-08'); -- 2008-08-08 00:00:00
select timestamp('2008-08-08 08:00:00', '01:01:01'); -- 2008-08-08 09:01:01
select timestamp('2008-08-08 08:00:00', '10 01:01:01'); -- 2008-08-18 09:01:01
select timestampadd(day, 1, '2008-08-08 08:00:00'); -- 2008-08-09 08:00:00
select date_add('2008-08-08 08:00:00', interval 1 day); -- 2008-08-09 08:00:00

MySQL timestampadd() 函数类似于 date_add()。
select timestampdiff(year,'2002-05-01','2001-01-01'); -- -1
select timestampdiff(day ,'2002-05-01','2001-01-01'); -- -485
select timestampdiff(hour,'2008-08-08 12:00:00','2008-08-08 00:00:00'); -- -12

select datediff('2008-08-08 12:00:00', '2008-08-01 00:00:00'); -- 7

MySQL timestampdiff() 函数就比 datediff() 功能强多了，datediff() 只能计算两个日期（date）之间相差的天数。

MySQL 时区（timezone）转换函数
convert_tz(dt,from_tz,to_tz)

select convert_tz('2008-08-08 12:00:00', '+08:00', '+00:00'); -- 2008-08-08 04:00:00
时区转换也可以通过 date_add, date_sub, timestampadd 来实现。

select date_add('2008-08-08 12:00:00', interval -8 hour); -- 2008-08-08 04:00:00
select date_sub('2008-08-08 12:00:00', interval 8 hour); -- 2008-08-08 04:00:00
select timestampadd(hour, -8, '2008-08-08 12:00:00'); -- 2008-08-08 04:00:00
```



### mysql json
```
分类  函数  描述
创建json  json_array  创建json数组
  json_object 创建json对象
  json_quote  将json转成json字符串类型

查询json  json_contains 判断是否包含某个json值
  json_contains_path  判断某个路径下是否包json值
  json_extract  提取json值
  column->path  json_extract的简洁写法，MySQL 5.7.9开始支持
  column->>path json_unquote(column -> path)的简洁写法
  json_keys 提取json中的键值为json数组
  json_search 按给定字符串关键字搜索json，返回匹配的路径

修改json  
  json_append 废弃，MySQL 5.7.9开始改名为json_array_append
  json_array_append 末尾添加数组元素，如果原有值是数值或json对象，则转成数组后，再添加元素
  json_array_insert 插入数组元素
  json_insert 插入值（插入新值，但不替换已经存在的旧值）
  json_merge  合并json数组或对象
  json_remove 删除json数据
  json_replace  替换值（只替换已经存在的旧值）
  json_set  设置值（替换旧值，并插入不存在的新值）
  json_unquote  去除json字符串的引号，将值转成string类型

返回json属性  
  json_depth  返回json文档的最大深度
  json_length 返回json文档的长度
  json_type 返回json值得类型
  json_valid  判断是否为合法json文档



创建表
CREATE TABLE teacher_json(id INT PRIMARY KEY, NAME VARCHAR(20) , info  JSON);

插入记录
INSERT INTO teacher_json(id,sname,info) VALUES(1 ,'test','{"time":"2017-01-01 13:00:00","ip":"192.168.1.1","result":"fail"}');
INSERT INTO teacher_json(id,sname,info) VALUES(2 ,'my',JSON_OBJECT("time",NOW(),'ip','192.168.1.1','result','fail'));

查询IP键
SELECT sname,JSON_EXTRACT(info,'$.ip') FROM teacher_json;

查询有多少个键
SELECT id,json_keys(info) AS "keys" FROM teacher_json;


json_keys()


json_set()
设置值（替换旧值，并插入不存在的新值）
update tb_electron_category_mapping_factory set data=JSON_SET(data, '$."aaa"', 1), state=%s, update_at=%s, update_uid=%s where category_id=%s
update tb_electron_label_mapping_factory set data=JSON_SET(data, '$."100"', 1),state=%s,update_at=%s,update_uid=%s where id=%s

增加键
UPDATE teacher_json SET info = json_set(info,'$.ip','192.168.1.1');

变更值
UPDATE teacher_json SET info = json_set(info,'$.ip','192.168.1.2');


json_insert()
插入值（插入新值，但不替换已经存在的旧值）
mysql> SET @j = '{ "a": 1, "b": [2, 3]}';
mysql> SELECT JSON_INSERT(@j, '$.a', 10, '$.c', '[true, false]');
+----------------------------------------------------+
| JSON_INSERT(@j, '$.a', 10, '$.c', '[true, false]') |
+----------------------------------------------------+
| {"a": 1, "b": [2, 3], "c": "[true, false]"}        |
+----------------------------------------------------+


mysql> SELECT JSON_INSERT(@j, '$.a', 10, '$.c', CAST('[true, false]' AS JSON));
+------------------------------------------------------------------+
| JSON_INSERT(@j, '$.a', 10, '$.c', CAST('[true, false]' AS JSON)) |
+------------------------------------------------------------------+
| {"a": 1, "b": [2, 3], "c": [true, false]}                        |
+------------------------------------------------------------------+
1 row in set (0.00 sec)


json_remove()
删除键
UPDATE teacher_json SET info = json_remove(info,'$.ip');
update tb_electron_category_mapping_factory set data=json_remove(data, '$.ip'),update_at=%s,update_uid=%s where category_id=%s


json_object()
update tb_electron_factory set extra_data=json_object(1,1,2,1,"agent_mobile","","agent_area_code","","agent_email","","agent_contacts","","agent_position","","agent_address","");


json_contains()
select * from tb_electron_label_mapping_category where json_contains(data,'{"100":1}')


json_contains_path()
select * from tb_electron_label_mapping_factory where json_contains_path(data, 'one', '$."100"')
select * from tb_electron_label_mapping_factory where json_contains_path(data, 'one', '$.www')

select * from tb_electron_label_mapping_factory where json_contains_path(data, 'all', '$."101"')
select * from tb_electron_label_mapping_factory where json_contains_path(data, 'all', '$.www')


合并函数
JSON_MERGE(json_doc, json_doc[, json_doc] ...)

合并两个或多个JSON文档。同义词 JSON_MERGE_PRESERVE(); 在MySQL 5.7.22中已弃用，并且在将来的版本中将被删除。

mysql> SELECT JSON_MERGE('[1, 2]', '[true, false]');
+---------------------------------------+
| JSON_MERGE('[1, 2]', '[true, false]') |
+---------------------------------------+
| [1, 2, true, false]                   |
+---------------------------------------+
1 row in set, 1 warning (0.00 sec)
 
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
  Level: Warning
   Code: 1287
Message: 'JSON_MERGE' is deprecated and will be removed in a future release. \
 Please use JSON_MERGE_PRESERVE/JSON_MERGE_PATCH instead
1 row in set (0.00 sec)


JSON_MERGE_PRESERVE()
不会将原有值覆盖
update tb_user set data=json_merge_preserve(data,'{"60":1}') where factory_id = 8202;


JSON_MERGE_PATCH()
会将原有值覆盖
update tb_user set data=json_merge_patch(data,'{"60":1}') where factory_id = 8202;



json_array 创建json数组
json_object 创建json对象
json_quote 将json转成json字符串类型
查询json 
json_contains 判断是否包含某个json值
json_contains_path 判断某个路径下是否包json值
json_extract 提取json值
column->path json_extract的简洁写法，MySQL 5.7.9开始支持
column->>path json_unquote(column -> path)的简洁写法
json_keys 提取json中的键值为json数组
json_search 按给定字符串关键字搜索json，返回匹配的路径
修改json 
json_append 废弃，MySQL 5.7.9开始改名为json_array_append
json_array_append 末尾添加数组元素，如果原有值是数值或json对 象，则转成数组后，再添加元素
json_array_insert 插入数组元素
json_insert 插入值（插入新值，但不替换已经存在的旧值）
json_merge 合并json数组或对象
json_remove 删除json数据
json_replace 替换值（只替换已经存在的旧值）
json_set 设置值（替换旧值，并插入不存在的新值）
json_unquote 去除json字符串的引号，将值转成string类型
返回json属性 
json_depth 返回json文档的最大深度
json_length 返回json文档的长度
json_type 返回json值得类型
json_valid 判断是否为合法json文档



一,对记录的操作
1.创建有json字段的表

-- 创建表
CREATE TABLE t_json(id INT PRIMARY KEY, sname VARCHAR(20) , info  JSON);
 

2.插入记录

-- 插入含有json数组的记录
INSERT INTO t_json(id,sname,info) VALUES( 1, 'name1', JSON_ARRAY(1, "abc", NULL, TRUE, CURTIME()));

-- 插入含有json对象的记录
INSERT INTO t_json(id,sname,info) VALUES( 2, 'name2', JSON_OBJECT("age", 20, "time", now()));
INSERT INTO t_json(id,sname,info) VALUES( 3, 'name3', '{"age":20, "time":"2018-07-14 10:52:00"}');
 

3.查询记录

-- 查询记录
SELECT sname,JSON_EXTRACT(info,'$.age') FROM t_json;
SELECT sname,info->'$.age' FROM t_json;
-- 查询key
SELECT id,json_keys(info) FROM t_json;
 

4.修改记录


-- 增加键
UPDATE t_json SET info = json_set(info,'$.ip','192.168.1.1') WHERE id = 2;

-- 变更值
UPDATE t_json SET info = json_set(info,'$.ip','192.168.1.2') WHERE id = 2;

-- 删除键
UPDATE t_json SET info = json_remove(info,'$.ip') WHERE id = 2;

 

二,创建json值函数
1.JSON_ARRAY 生成json数组

-- JSON_ARRAY(val1,val2,val3...)
-- 生成一个包含指定元素的json数组。
SELECT JSON_ARRAY(1, "abc", NULL, TRUE, CURTIME()); -- [1, "abc", null, true, "10:37:08.000000"]
 

2.JSON_OBJECT 生成json对象

-- JSON_OBJECT(key1,val1,key2,val2...)
-- 生成一个包含指定K-V对的json object。如果有key为NULL或参数个数为奇数，则抛错。
SELECT JSON_OBJECT('age', 20, 'time', now()); -- {"id": 87, "name": "carrot"}
 

3.JSON_QUOTE 加"号

-- JSON_QUOTE(json_val)
-- 将json_val用"号括起来。
SELECT JSON_QUOTE('[1,2,3]'); -- "[1,2,3]" 
 

三,搜索json值函数
1.JSON_CONTAINS 指定数据是否存在

set @j = '{"a": 1, "b": 2, "c": {"d": 4}}';
-- JSON_CONTAINS(json_doc, val[, path])
-- 查询json文档是否在指定path包含指定的数据，包含则返回1，否则返回0。如果有参数为NULL或path不存在，则返回NULL。
SELECT JSON_CONTAINS(@j, '4', '$.c.d'); -- 1
 

2.JSON_CONTAINS_PATH 指定路径是否存在

-- JSON_CONTAINS_PATH(json_doc, one_or_all, path[, path] ...)
-- 查询是否存在指定路径，存在则返回1，否则返回0。如果有参数为NULL，则返回NULL。
-- one_or_all只能取值"one"或"all"，one表示只要有一个存在即可；all表示所有的都存在才行。
SELECT JSON_CONTAINS_PATH(@j, 'one', '$.a', '$.e'); -- 1
SELECT JSON_CONTAINS_PATH(@j, 'all', '$.a', '$.c.d'); -- 1
 

3.JSON_EXTRACT 查找所有指定数据

-- JSON_EXTRACT(json_doc, path[, path] ...)
-- 从json文档里抽取数据。如果有参数有NULL或path不存在，则返回NULL。如果抽取出多个path，则返回的数据封闭在一个json array里。
set @j2 = '[10, 20, [30, 40]]';
SELECT JSON_EXTRACT('[10, 20, [30, 40]]', '$[1]'); -- 20
SELECT JSON_EXTRACT('[10, 20, [30, 40]]', '$[1]', '$[0]'); -- [20, 10]
SELECT JSON_EXTRACT('[10, 20, [30, 40]]', '$[2][*]'); -- [30, 40]
 

4.JSON_KEYS 查找所有指定键值

-- JSON_KEYS(json_doc[, path])
-- 获取json文档在指定路径下的所有键值，返回一个json array。如果有参数为NULL或path不存在，则返回NULL。
SELECT JSON_KEYS('{"a": 1, "b": {"c": 30}}'); -- ["a", "b"]
SELECT JSON_KEYS('{"a": 1, "b": {"c": 30}}', '$.b'); -- ["c"]
SELECT id,json_keys(info) FROM t_json;
 

5.JSON_SEARCH 查找所有指定值的位置


-- JSON_SEARCH(json_doc, one_or_all, search_str[, escape_char[, path] ...])
-- 查询包含指定字符串的paths，并作为一个json array返回。如果有参数为NUL或path不存在，则返回NULL。
-- one_or_all："one"表示查询到一个即返回；"all"表示查询所有。
-- search_str：要查询的字符串。 可以用LIKE里的'%'或'_’匹配。
-- path：在指定path下查。
SET @j3 = '["abc", [{"k": "10"}, "def"], {"x":"abc"}, {"y":"bcd"}]';
SELECT JSON_SEARCH(@j3, 'one', 'abc'); -- "$[0]"
SELECT JSON_SEARCH(@j3, 'all', 'abc'); -- ["$[0]", "$[2].x"]
SELECT JSON_SEARCH(@j3, 'all', 'abc', NULL, '$[2]'); -- "$[2].x"
SELECT JSON_SEARCH(@j3, 'all', '10'); -- "$[1][0].k"
SELECT JSON_SEARCH(@j3, 'all', '%b%'); -- ["$[0]", "$[2].x", "$[3].y"]
SELECT JSON_SEARCH(@j3, 'all', '%b%', NULL, '$[2]'); -- "$[2].x"

 

四,修改json值函数
1.JSON_ARRAY_APPEND  指定位置追加数组元素

-- JSON_ARRAY_APPEND(json_doc, path, val[, path, val] ...)
-- 在指定path的json array尾部追加val。如果指定path是一个json object，则将其封装成一个json array再追加。如果有参数为NULL，则返回NULL。
SET @j4 = '["a", ["b", "c"], "d"]';
-- SELECT JSON_ARRAY_APPEND(@j4, '$[1][0]', 3); -- ["a", [["b", 3], "c"], "d"]
SET @j5 = '{"a": 1, "b": [2, 3], "c": 4}';
SELECT JSON_ARRAY_APPEND(@j5, '$.b', 'x'); -- {"a": 1, "b": [2, 3, "x"], "c": 4} 
SELECT JSON_ARRAY_APPEND(@j5, '$.c', 'y'); -- {"a": 1, "b": [2, 3], "c": [4, "y"]}
SELECT JSON_ARRAY_APPEND(@j5, '$', 'z'); -- [{"a": 1, "b": [2, 3], "c": 4}, "z"]



将tags的值设置为字段类型的数组eg:{"1": [], "2": []}
update fk_message set tags=json_object(1,json_array(),2,json_array()) where id=6;

update fk_message set tags = json_set(tags,'$."2"',json_array_append(tags,'$."2"',1)) where id = 6;
update fk_message set tags = json_insert(tags,'$."2"',json_array_append(tags,'$."2"',1)) where id = 6;


update fk_message set tags = json_object(1,json_array_append(tags,'$."1"',1)) where id = 6;
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
| id | name                  | data                                                               | tags                        |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
|  6 | lisi                  | {"1": 1}                                                           | {"1": {"1": [1]}}           |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
6 rows in set (0.00 sec)


update fk_message set tags = json_object(1,json_array_append(tags,'$',1)) where id = 6;
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
| id | name                  | data                                                               | tags                        |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
|  6 | lisi                  | {"1": 1}                                                           | {"1": {"1": [1]}}           |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+


MySQL [db_test]> update fk_message set tags=json_object(1,json_array_append(tags->'$."1"','$',2)) where id = 6;
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MySQL [db_test]> select * from fk_message;
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
| id | name                  | data                                                               | tags                        |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
|  6 | lisi                  | {"1": 1}                                                           | {"1": [1, 2]}               |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
6 rows in set (0.00 sec)


当有键值的时候才可以更新
MySQL [db_test]> update fk_message set tags=json_array_append(tags,'$."1"',2) where id = 6;
Query OK, 1 row affected (1.28 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MySQL [db_test]> select * from fk_message;
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
| id | name                  | data                                                               | tags                        |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
|  6 | lisi                  | {"1": 1}                                                           | {"1": [1, 2]}               |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
6 rows in set (0.02 sec)


当没有键值 "2" 的时候是更新不了的，
MySQL [db_test]> update fk_message set tags=json_array_append(tags,'$."2"',2) where id = 6;
Query OK, 0 rows affected (5.33 sec)
Rows matched: 1  Changed: 0  Warnings: 0

MySQL [db_test]> select * from fk_message;
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
| id | name                  | data                                                               | tags                        |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
|  6 | lisi                  | {"1": 1}                                                           | {"1": [1, 2]}               |
+----+-----------------------+--------------------------------------------------------------------+-----------------------------+
6 rows in set (0.02 sec)


查询某个键的数组值中是否包含某值 
查询data字段里有jack的数据
MySQL [db_test]> select * from fk_message where JSON_CONTAINS(data->'$[*]', '"jack"', '$');
MySQL [db_test]> select * from fk_message where id=6 and json_contains(tags,json_object("1",1));
+----+------+----------+------------+
| id | name | data     | tags       |
+----+------+----------+------------+
|  6 | lisi | {"1": 1} | {"1": [1]} |
+----+------+----------+------------+
1 row in set (0.33 sec)

MySQL [db_test]> select * from fk_message where id = 6 and json_contains(tags,json_object("1",2));
+----+------+----------+---------------+
| id | name | data     | tags          |
+----+------+----------+---------------+
|  6 | lisi | {"1": 1} | {"1": [1, 2]} |
+----+------+----------+---------------+
1 row in set (0.38 sec)




2.JSON_ARRAY_INSERT 指定位置插入数组元素

-- JSON_ARRAY_INSERT(json_doc, path, val[, path, val] ...)
-- 在path指定的json array元素插入val，原位置及以右的元素顺次右移。如果path指定的数据非json array元素，则略过此val；如果指定的元素下标超过json array的长度，则插入尾部。
SET @j6 = '["a", {"b": [1, 2]}, [3, 4]]';
SELECT JSON_ARRAY_INSERT(@j6, '$[1]', 'x'); -- ["a", "x", {"b": [1, 2]}, [3, 4]]
SELECT JSON_ARRAY_INSERT(@j6, '$[100]', 'x'); -- ["a", {"b": [1, 2]}, [3, 4], "x"]
SELECT JSON_ARRAY_INSERT(@j6, '$[1].b[0]', 'x'); -- ["a", {"b": ["x", 1, 2]}, [3, 4]]
SELECT JSON_ARRAY_INSERT(@j6, '$[0]', 'x', '$[3][1]', 'y'); -- ["x", "a", {"b": [1, 2]}, [3, "y", 4]]

 

3.JSON_INSERT 指定位置插入

-- JSON_INSERT(json_doc, path, val[, path, val] ...)
-- 在指定path下插入数据，如果path已存在，则忽略此val（不存在才插入）。
SET @j7 = '{ "a": 1, "b": [2, 3]}';
SELECT JSON_INSERT(@j7, '$.a', 10, '$.c', '[true, false]'); -- {"a": 1, "b": [2, 3], "c": "[true, false]"}
 

4.JSON_REPLACE 指定位置替换

-- JSON_REPLACE(json_doc, path, val[, path, val] ...)
-- 替换指定路径的数据，如果某个路径不存在则略过（存在才替换）。如果有参数为NULL，则返回NULL。
SELECT JSON_REPLACE(@j7, '$.a', 10, '$.c', '[true, false]'); -- {"a": 10, "b": [2, 3]}
 

5.JSON_SET 指定位置设置

-- JSON_SET(json_doc, path, val[, path, val] ...)
-- 设置指定路径的数据（不管是否存在）。如果有参数为NULL，则返回NULL。
SELECT JSON_SET(@j7, '$.a', 10, '$.c', '[true, false]'); -- {"a": 10, "b": [2, 3], "c": "[true, false]"}
 

6.JSON_MERGE 合并
-- JSON_MERGE(json_doc, json_doc[, json_doc] ...)
-- merge多个json文档。规则如下：
-- 如果都是json array，则结果自动merge为一个json array；
-- 如果都是json object，则结果自动merge为一个json object；
-- 如果有多种类型，则将非json array的元素封装成json array再按照规则一进行mege。
SELECT JSON_MERGE('[1, 2]', '[true, false]'); -- [1, 2, true, false]
SELECT JSON_MERGE('{"name": "x"}', '{"id": 47}'); -- {"id": 47, "name": "x"}
SELECT JSON_MERGE('1', 'true'); -- [1, true]
SELECT JSON_MERGE('[1, 2]', '{"id": 47}'); -- [1, 2, {"id": 47}]
 

7.JSON_REMOVE 指定位置移除

-- JSON_REMOVE(json_doc, path[, path] ...)
-- 移除指定路径的数据，如果某个路径不存在则略过此路径。如果有参数为NULL，则返回NULL。
SET @j8 = '["a", ["b", "c"], "d"]';
SELECT JSON_REMOVE(@j8, '$[1]'); -- ["a", "d"]
 

8.JSON_UNQUOTE 去"号

-- JSON_UNQUOTE(val)
-- 去掉val的引号。如果val为NULL，则返回NULL。
SELECT JSON_UNQUOTE("\"123\""); -- 123
 

五,返回json值属性的函数
1.JSON_DEPTH 深度

-- JSON_DEPTH(json_doc)
-- 获取json文档的深度。如果参数为NULL，则返回NULL。
-- 空的json array、json object或标量的深度为1。
SELECT JSON_DEPTH('{}'), JSON_DEPTH('[]'), JSON_DEPTH('true'); -- 1 1 1
SELECT JSON_DEPTH('[10, 20]'), JSON_DEPTH('[[], {}]'); -- 2 2
SELECT JSON_DEPTH('[10, {"a": 20}]'); -- 3
 

2.JSON_LENGTH 长度


-- JSON_LENGTH(json_doc[, path])
-- 获取指定路径下的长度。如果参数为NULL，则返回NULL。　
-- 长度的计算规则：
-- 标量的长度为1；
-- json array的长度为元素的个数；
-- json object的长度为key的个数。
SELECT JSON_LENGTH('[1, 2, {"a": 3}]'); -- 3
SELECT JSON_LENGTH('{"a": 1, "b": {"c": 30}}'); -- 2
SELECT JSON_LENGTH('{"a": 1, "b": {"c": 30}}', '$.b'); -- 1

 

3.JSON_TYPE 类型

-- JSON_TYPE(json_val)
-- 获取json文档的具体类型。如果参数为NULL，则返回NULL。
select JSON_TYPE('[1,2]'); -- ARRAY
 

4.JSON_VALID 是否有效json格式

-- JSON_VALID(val)
-- 判断val是否为有效的json格式，是为1，不是为0。如果参数为NUL，则返回NULL。
SELECT JSON_VALID('{"a": 1}'); -- 1
SELECT JSON_VALID('hello'), JSON_VALID('"hello"'); -- 1
 

附录:


JSON_ARRAY 生成json数组
JSON_OBJECT 生成json对象
JSON_QUOTE 加"号
JSON_CONTAINS 指定数据是否存在
JSON_CONTAINS_PATH 指定路径是否存在
JSON_EXTRACT 查找所有指定数据
JSON_KEYS 查找所有指定键值
JSON_SEARCH 查找所有指定值的位置
JSON_ARRAY_APPEND  指定位置追加数组元素
JSON_ARRAY_INSERT 指定位置插入数组元素
JSON_INSERT 指定位置插入
JSON_REPLACE 指定位置替换
JSON_SET 指定位置设置
JSON_MERGE 合并
JSON_REMOVE 指定位置移除
JSON_UNQUOTE 去"号
JSON_DEPTH 深度
JSON_LENGTH 长度
JSON_TYPE 类型
JSON_VALID 是否有效json格式

 

函数名 描述
JSON_APPEND()（废弃的5.7.9） JSON文件追加数据
JSON_ARRAY()  创建JSON数组
JSON_ARRAY_APPEND() JSON文件追加数据
JSON_ARRAY_INSERT() 插入JSON数组
->  在评估路径返回JSON列值；相当于json_extract()。
JSON_CONTAINS() 是否包含特定对象的JSON文档路径
JSON_CONTAINS_PATH()  无论是JSON文件包含任何数据路径
JSON_DEPTH()  JSON文档的最大深度
JSON_EXTRACT()  从JSON文档返回数据
->> 在评估路径和结束引语结果返回JSON列值；相当于json_unquote（json_extract()）。
JSON_INSERT() 将数据插入到JSON文档
JSON_KEYS() 从JSON文件密钥数组
JSON_LENGTH() 在JSON文档中的元素数
JSON_MERGE()（废弃的5.7.22） 合并的JSON文件，保存重复键。不json_merge_preserve()的同义词
JSON_MERGE_PATCH()  合并的JSON文件，免去重复键的值
JSON_MERGE_PRESERVE() 合并的JSON文件，保存重复键
JSON_OBJECT() 创建JSON对象
JSON_PRETTY() 版画在人类可读的格式JSON文档，每个数组元素或对象成员打印在新的行中，缩进两个空格就其母。
JSON_QUOTE()  引用JSON文档
JSON_REMOVE() 从JSON文件中删除数据
JSON_REPLACE()  在JSON文件的值替换
JSON_SEARCH() 在JSON文件价值路径
JSON_SET()  将数据插入到JSON文档
JSON_STORAGE_SIZE() 用于一个JSON文件的二进制表示形式存储空间；一个JSON柱，空间时使用的文档插入到任何部分更新之前，
JSON_TYPE() JSON值类型
JSON_UNQUOTE()  JSON值而言
JSON_VALID()  JSON值是否是有效的
  

mysql官方文档:https://dev.mysql.com/doc/refman/5.7/en/json-utility-functions.html

参考:https://www.cnblogs.com/waterystone/p/5626098.html


eg:
select cast(json_extract(json_keys(extra_data),'$[0]') as unsigned) as country_id from tb_electron_factory limit 1;
```




## 高级操作

### mysql导出文件数据
```
into outfile '导出的目录和文件名'
指定导出的目录和文件名

fields terminated by '字段间分隔符'
定义字段间的分隔符

optionally enclosed by '字段包围符'
定义包围字段的字符（数值型字段无效）

lines terminated by '行间分隔符' 
定义每行的分隔符 

select * from tb_electron_label_mapping_factory into outfile '/data/mysql_export_dir/user.csv' fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

查看官方文档，secure_file_priv参数用于限制LOAD DATA, SELECT …OUTFILE, LOAD_FILE()传到哪个指定目录
secure_file_priv 为 NULL 时，表示限制mysqld不允许导入或导出。
secure_file_priv 为 /tmp 时，表示限制mysqld只能在/tmp目录中执行导入导出，其他目录不能执行。
secure_file_priv 没有值时，表示不限制mysqld在任意目录的导入导出。

show global variables like '%secure_file_priv%';
查看 secure_file_priv 的值，默认为NULL，表示限制不能导入导出
secure_file_priv 参数是只读参数，不能使用set global命令修改。

解决方法
打开my.cnf 或 my.ini，加入以下语句后重启mysql。
secure_file_priv=''
  
查看secure_file_priv修改后的值

mysql> show global variables like '%secure_file_priv%';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| secure_file_priv |       |
+------------------+-------+
1 row in set (0.00 sec)

修改后再次执行，成功导出。

into outfile 实例:
不带表头:
select kw.zh_category,kw.en_category,kw.zh_sub_category,kw.en_sub_category,kw.category_id_1,kw.category_id_2,  kw.category_id_3,kw.temp_zh_sub_category,kw.temp_en_sub_category  from db_digikey_electron_base.temp_digikey_category_kwargs kw  
where kw.temp_category_id_3 is null  and category_id_1 not in ('08','09','10') into outfile '/data/mysql_export_dir/category_data.csv';

select * from user into outfile '/data/mysql_export_dir/user.csv' fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

select * from db_electron_property_base.tb_electron_category order by level asc into outfile '/data/mysql_export_dir/category_data.csv' character set gbk fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

select * from db_electron_cleaning.tb_extra_category_params into outfile '/data/mysql_export_dir/tb_extra_category_params.csv' character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

select id,model_name,images,source_web,data_sheet from tb_electron where factory_id is null limit 100000 into outfile '/data/mysql_export_dir/tb_electron_no_factory.csv' character set gbk fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

select id,model_name,images,source_web,data_sheet from tb_electron order by id desc into outfile '/data/mysql_export_dir/".$file_name."' fields terminated by ',' optionally enclosed by '\"' escaped by '\"' lines terminated by '\r\n' 

带表头:
select * into outfile '/data/mysql_export_dir/tb_extra_category_params.xlsx' fields terminated by '\\t' OPTIONALLY ENCLOSED BY '"' lines terminated by '\\n' from (select '姓名','性别','年龄' union select username,sex,age from table) b;


-- 导出不带标题的xlsx
select a.id,a.org_id,a.create_at,a.update_at,a.model_name,a.category_id,a.org_category_id,
a.factory_id,b.zh_name as factory_zh_name,b.en_name as factory_en_name,a.source_web,a.data_sheet_name,
a.data_sheet,a.state,a.pintopin,a.similar,a.summary,a.pdf_path,a.txt_path,a.packaging
from db_electron.tb_electron a,db_electron_property.tb_electron_factory b 
where a.factory_id = b.id into outfile '/data/mysql_export_dir/segment_electron_hash_data.csv' character set gbk
fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


-- 导出带标题的xlsx
select * into outfile '/data/mysql_export_dir/segment_electron_hash_data.xlsx' character set gbk
fields terminated by '\\t' optionally enclosed by '"' lines terminated by '\\n' from (
select "id","org_id","create_at","update_at","model_name","category_id","org_category_id","factory_id","factory_zh_name",
"factory_en_name","source_web","data_sheet_name","data_sheet","state","pintopin","similar","summary","pdf_path","txt_path","packaging" union
select a.id,a.org_id,a.create_at,a.update_at,a.model_name,a.category_id,a.org_category_id,
a.factory_id,b.zh_name as factory_zh_name,b.en_name as factory_en_name,a.source_web,a.data_sheet_name,
a.data_sheet,a.state,a.pintopin,a.similar,a.summary,a.pdf_path,a.txt_path,a.packaging
from db_electron.tb_electron a,db_electron_property.tb_electron_factory b 
where a.factory_id = b.id) c;
```


### mysql导入文件数据
```
load data infile 'c:/wamp/tmp/Data_OutFile.csv' replace into table data_1 character set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\r\n' (name,age,description );

replace into table data_1   ：指 在表data_1中插入数据时，碰到相同的数据怎么处理。replace是替换。也可以使用ignore，指不处理本条数据。
character set utf8：  使用字符集 utf8。
fields terminated by ','   ：  字段之间使用英文逗号隔开。
Enclosed By '"' ：内容包含在双引号内。
lines terminated by '\r\n'  ：每条数据以\r\n结尾。
(name,age,description )是可选的，当不写的时候，就是所有字段。如果数据与数据库的字段不对应的时候，需要填写，以使字段对应


导入文件到相应表students
load data infile '/data/students.txt' into table students;

load data infile '/data/mysql_export_dir/tb_electron_category.txt' into table tb_electron_category character set utf8mb4;" 

load data infile "/data/mysql_export_dir/tb_electron_category.sql" into table tb_electron_category fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';

load data infile "/data/mysql_export_dir/tb_extra_category_params.csv" into table db_electron_cleaning.tb_extra_category_params character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


select * into dumpfile 'f:/mysql/test/six' from teacher_class limit 1;


load file
将数据批量导入数据库的正确方法是生成csv文件,然后使用load命令,该命令在SQL数据库的MS风格中称为 BULK INSERT

BULK INSERT mydatabase.myschema.mytable
FROM 'mydatadump.csv';

语法参考如下:
BULK INSERT 
   [ database_name . [ schema_name ] . | schema_name . ] [ table_name | view_name ] 
      FROM 'data_file' 
     [ WITH 
    ( 
   [ [ , ] BATCHSIZE = batch_size ] 
   [ [ , ] CHECK_CONSTRAINTS ] 
   [ [ , ] CODEPAGE = { 'ACP' | 'OEM' | 'RAW' | 'code_page' } ] 
   [ [ , ] DATAFILETYPE = 
      { 'char' | 'native'| 'widechar' | 'widenative' } ] 
   [ [ , ] FIELDTERMINATOR = 'field_terminator' ] 
   [ [ , ] FIRSTROW = first_row ] 
   [ [ , ] FIRE_TRIGGERS ] 
   [ [ , ] FORMATFILE = 'format_file_path' ] 
   [ [ , ] KEEPIDENTITY ] 
   [ [ , ] KEEPNULLS ] 
   [ [ , ] KILOBYTES_PER_BATCH = kilobytes_per_batch ] 
   [ [ , ] LASTROW = last_row ] 
   [ [ , ] MAXERRORS = max_errors ] 
   [ [ , ] ORDER ( { column [ ASC | DESC ] } [ ,...n ] ) ] 
   [ [ , ] ROWS_PER_BATCH = rows_per_batch ] 
   [ [ , ] ROWTERMINATOR = 'row_terminator' ] 
   [ [ , ] TABLOCK ] 
   [ [ , ] ERRORFILE = 'file_name' ] 
    )] 

```


eg:
```
-- 导出csv文件
select * from db_electron_property.tb_electron_category into outfile 
'/data/mysql_export_dir/tb_electron_category.csv' 
character set gbk fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';


-- 导入csv文件
load data infile '/data/mysql_export_dir/tb_electron_category_online.csv' 
into table db_electron_property_base.tb_electron_category_online
character set gbk fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';
```



启动二进制日志
```
log-bin = path/filename #日志文件存储目录和文件名
expire_log_days = 10    #日志自动删除时间
max_binlog_size = 100M  # 日志文件最大大小
```

查看二进制日志
```
MYSQL> SHOW VARIABLES LIKE 'log_%';
MYSQL> SHOW BINARY LOGS;

# filename为二进制日志文件名。
$> mysqlbinlog filename
```

删除二进制日志
```
MYSQL> RESET MASTER; #删除所有二进制日志
MYSQL> PURGE {MASTER | BINARY} LOGS TO 'log_name';  #删除文件编号小于log_name编号的文件
MYSQL> PURGE {MASTER | BINARY} LOGS BEFORE 'date';  #删除指定日期以前的文件
```

暂时停止二进制日志（不需要重启mysql服务）
```
MYSQL> SET sql_log_bin = {0|1}  #暂停或启动二进制日志。
```


### msyql 1.6亿条数据的表分表
首先创建256张分表
```
select md5(123) = 202cb962ac59075b964b07152d234b70

create table `tb_extra_m_electron_kwargs_xx`(
  full_code char(32) not null,
  create_time int(10) unsigned NOT NULL,
  PRIMARY KEY (`full_code`),
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



create table `tb_extra_m_electron_kwargs_xx`(
  full_code char(32) not null,
  create_time datetime(6) NOT NULL,  
  PRIMARY KEY (full_code),
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


create table if not exists `tb_extra_m_electron_kwargs_full`(
  full_code char(32) not null,
  create_time datetime(6) NOT NULL,  
  index(full_code),
) type=merge UNION=(tb_extra_m_electron_kwargs_00,tb_extra_m_electron_kwargs_01,tb_extra_m_electron_kwargs_02.......) INSERT_METHOD=LAST;

这样我们通过select * from tb_extra_m_electron_kwargs_full 就可以得到所有的 full_code 数据了。
```







### mysql导入(还原)
#### 方法一：未连接数据库时方法
>语法格式：mysql -h ip -u userName -p dbName < sqlFilePath (最后没有分号) 
```
-h : 数据库所在的主机。如果是本机，可以使用localhost，或者省略此项； 
-u : 连接数据库用户名。 
-p : 连接数据库密码。出于安全考虑，一般不在-p之后直接写出明文的密码。整个命令回车之后，数据库会要求输入密码，那个时候再输入密码将以**的形式显示出来。有一定的保护作用。 
dbName : 要使用的具体的某个数据库。这个不是必须的，如果sql脚本中没有使用“use dbName”选择数据库，则此处必须制定数据库；如果使用了”use dbName”，则可以省略。 
sqlFilePath : sql脚本的路径。如我将sql脚本放在了D盘，我的sql脚本的名字是”test_sql.sql”。则路径为”D:\test_sql.sql”。 

mysql -h 192.168.99.100 -uroot -p test2 < E:/mysql/2019_08_04_bak.sql
mysql -h 192.168.99.100 -uroot -p test2 < /home/flack/bak/2019_08_04_bak.sql
```
命令执行情况如下图所示：
![导入例子](https://img-blog.csdn.net/20160223105910733 "导入例子")

#### 方法二：已连接数据库时方法
语法格式：source sqlFilePath（后面没有分号） 
sqlFilePath : sql脚本的路径。如我将sql脚本放在了D盘，我的sql脚本的名字是”test_sql.sql”。则路径为”D:\test_sql.sql”。 

命令执行情况如下图所示：
![导入例子](https://img-blog.csdn.net/20160223105926651 "导入例子")

#### 执行脚本sql文件
1. 进入mysql
`mysql>source /var/www/chinslickingweb/chin.sql;`

2. 不进入mysql
`mysql -uroot -p123456 -D chin < /var/www/chinslickingweb/chin.sql`


导入数据：
```
由于mysqldump导出的是完整的SQL语句，所以用mysql客户程序很容易就能把数据导入了：
#mysql 数据库名 < 文件名
or:
#show databases;
然后选择被导入的数据库：
#use 数据库；
#source /tmp/xxx.sql
```

直接复制数据库目录还原:
```
注： 该方式必须确保原数据库和待还原的数据库主版本号一致，并且只适用于MyISAM引擎的表。
关闭mysql服务。
将备份的文件或目录覆盖mysql的data目录。
启动mysql服务。
对于linux系统，复制完文件后需要将文件的用户和组更改为mysql运行的用户和组。
```

mysqlhotcopy快速恢复
```
停止mysql服务，将备份数据库文件复制到存放数据的位置（mysql的data文件夹），重先启动mysql服务即可(可能需要指定数据库文件的所有者)。
# 如果恢复的数据库已经存在，则使用DROP语句删除已经存在的数据库之后，恢复才能成功，还需要保证数据库版本兼容。
$> cp -R /usr/backup/test /usr/local/mysql/data

```

使用mysqlbinlog恢复数据
```
$> mysqlbinlog [option] filename | mysql -u user -p password
# filename为二进制日志文件，
$> mysqlbinlog --stop-date="2013-03-30 15:27:47" D:\MySQL\log\binlog\binlog.000008 | mysql -u root -p password
# 根据日志文件binlog.000008将数据恢复到2013-03-30 15:27:47以前的操作。
```


### mysql导出（备份）
导出（备份）某个数据库：
```
mysqldump -u root -p dbName > sqlFilePath
mysqldump -uroot -p test > E:/mysql/bak/2019_08_04.sql
mysqldump -uroot -p test > /home/flack/bak/aaa.sql
mysqldump -h 192.168.99.100 -uroot -p test > E:/mysql/2019_08_04_bak.sql
mysqldump -h 192.168.99.100 -uroot -p test > /home/flack/bak/aaa.sql


从meteo数据库的sdata表中导出sensorid=11 且 fieldid=0的数据到 /home/xyx/Temp.sql 这个文件中
mysqldump -uroot -p123456 meteo sdata --where=" sensorid=11 and fieldid=0" > /home/flack/bak/aaa.sql
mysqldump -uroot -p123456 meteo sdata --where=" sensorid=11" > /home/flack/bak/aaa.sql
mysqldump -uroot -p123456 meteo sdata --where=" sensorid in (1,2,3) " > /home/flack/bak/aaa.sql
```

导出多个数据库：
```
mysqldump -u root -p --add-drop-database --databases dbName1 dbName2 … > sqlFilePath 
–add-drop-database ： 该选项表示在创建数据库的时候先执行删除数据库操作 
–database : 该选项后面跟着要导出的多个数据库，以空格分隔

mysqldump -h localhost -u root -p --databases dbname1,dbname2 > /home/flack/bak/backdb.sql
```

导出某个数据库的某个表：
```
mysqldump -u root -p dbName students1,students2 > sqlFilePath
mysqldump -h localhost -u root -p db_electron students1,students2 > /home/flack/bak/aaa.sql
mysqldump -uroot -p123456 db_electron tb_electron --where=" sensorid=11 and fieldid=0" > /home/flack/bak/aaa.sql
mysqldump -uroot -p123456 db_electron tb_electron --where=" sensorid=11" > /home/flack/bak/aaa.sql
mysqldump -uroot -p123456 db_electron tb_electron --where=" sensorid in (1,2,3) " > /home/flack/bak/aaa.sql
mysqldump -umagic_ro -h121.201.107.32 -pMagic_ro.mofang123 magic m_electron --where=" category_id=34 and factory='Texas Instruments'" > /home/flack.chen/ti.log

```

到处（备份）系统中所有数据库
```
mysqldump -h localhost -u root -p --all-databases > /home/flack/bak/backdb_all.sql
```

导出结构不导出数据
只导出数据库结构，不带数据：
```
mysqldump -u root -p -d dbName > sqlFilePath 
-d : 只备份结构，不备份数据。也可以使用”--no-data”代替”-d”，效果一样。
```

导出数据不导出结构
```
mysqldump -t 数据库名 -uroot -p > xxx.sql
```

导出数据和表结构
```
mysqldump 数据库名 -uroot -p > xxx.sql
```

导出特定表的结构
```
mysqldump -uroot -p -B数据库名 --table 表名 > xxx.sql
#mysqldump [OPTIONS] database [tables]
```

直接复制整个数据库目录
```
mysql data 目录
windowns: installpath/mysql/data
linux: /var/lib/mysql

在复制前需要先执行如下命令：
MYSQL> LOCK TABLES;
在复制过程中允许客户继续查询表，
MYSQL> FLUSH TABLES;
将激活的索引页写入硬盘。

cp -R /var/lib/mysql/chf /home/flack/bak/chf
cp -R /var/lib/mysql/king /home/flack/bak/king
```

mysqlhotcopy工具备份
```
备份数据库或表最快的途径，只能运行在数据库目录所在的机器上，并且只能备份MyISAM类型的表。
要使用该备份方法必须可以访问备份的表文件。
$> mysqlhotcopy -u root -p dbname /path/to/new_directory;
将数据库复制到new_directory目录。
```


导出命令执行情况如下图所示： 
![导出例子](https://img-blog.csdn.net/20160223111231109 "导出例子")


### 相同版本数据库之间迁移
```
# 将服务器www.abc.com的数据库dbname迁移到服务器www.bcd.com的相同版本数据库上。
$> mysqldump -h www.abc.com -uroot -p password dbname | 
$> mysqldump -h www.bcd.com -uroot -p password

```

### 不同版本的mysql数据库之间的迁移
```
备份原数据库。
卸载原数据库。
安装新数据库。
在新数据库中还原备份的数据库数据。
数据库用户访问信息需要备份mysql数据库。
默认字符集问题，MySQL4.x中使用latin1作为默认字符集，mysql5.x使用utf8作为默认字符集。如果有中文数据需要对默认字符集进行更改。
```

### 不同数据库之间的迁移
```
MyODBC工具实现MySQL和SQL Server之间的迁移。
MySQL Migration Toolkit工具。
表的导出和导入
```

### 表的导出和导入
```
mysql查询结果导出/输出/写入到文件

方法一：
直接执行命令：
mysql> select count(1) from table  into outfile '/tmp/test.xls';

Query OK, 31 rows affected (0.00 sec)
在目录/tmp/下会产生文件test.xls
遇到的问题：
mysql> select count(1) from table   into outfile '/data/test.xls';
报错：
ERROR 1 (HY000): Can't create/write to file '/data/test.xls' (Errcode: 13)
可能原因：mysql没有向/data/下写的权限 

方法二：
查询都自动写入文件：
mysql> pager cat > /tmp/test.txt ;
PAGER set to 'cat > /tmp/test.txt'
之后的所有查询结果都自动写入/tmp/test.txt'，并前后覆盖
mysql> select * from table ;
30 rows in set (0.59 sec)
在框口不再显示查询结果


方法三：
跳出mysql命令行
[root@SHNHDX63-146 ~]# mysql -h 127.0.0.1 -u root -p XXXX -P 3306 -e "select * from table"  > /tmp/test/txt
```

```
SELECT * from test INTO OUTFILE '/home/flack/a.csv',该方法只能导出到数据库服务器上，并且导出文件不能已存在。

MYSQL> SELECT ...... INTO OUTFILE filename [OPTIONS]
MYSQL> SELECT * FROM test.person INTO OUTFILE "C:\person0.txt";
# 将表person里的数据导入为文本文件person0.txt。

mysqldump文件导出文本文件(和INTO OUTFILE不一样的是该方法所有的选项不需要添加引号)

$> mysqldump -T path -u root -p dbname [tables] [OPTIONS]
# -T参数表明导出文本文件。path导出数据的目录。
$> mysqldump -T C:\test person -u root -p
# 将test表中的person表导出到文本文件。执行成功后test目录下会有两个文件，person.sql和person.txt


mysql命令导出文本文件
MYSQL> mysql -u root -p --execute="SELECT * FROM person;" test > C:\person3.txt;
# 将test数据库中的person表数据导出到person3.txt文本文件中。--vartical参数可以将一行分为多行显示。
MYSQL> mysql -u root -p --vartical --execute="SELECT * FROM person;" test > C:\person3.txt;
# --html将表导出为html文件，--xml文件将表导出为xml文件


LOAD DATA INFILE导入文本文件
MYSQL> LOAD DATA INFILE 'filename.txt' INTO TABLE tablename [OPTIONS] [IGNORE number LINES];
# [IGNORE number LINES]表示忽略行数
MYSQL> LOAD DATA INFILE 'C:\person0.txt' INTO TABLE test.person;


mysqlimport导入文本文件
$> mysqlimport -u root -p dbname filename.txt [OPSTONS]
# 导入的表名有文件名决定，导入数据之前表必须存在
$> mysqlimport -uroot -p test C:\backup\person.txt
# 将数据导入到test数据库的person表中。
```



跨服务器访问数据库表
1.首先在mysql配置文件中添加federated
windows:
在my.ini中加入federated

linux:
vim /etc/my.cnf中mysqld节点下添加
federated
2.重启mysql服务
service mysqld restart
3.进入mysql查看引擎状态
show engines;
4.创建映射表结构
在mysql中创建远程服务器数据库中的需要映射的表，映射表名称可以随意命名，但是数据结构必要一样
```
CREATE TABLE `user_link` (
  `id` varchar(32) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `idcard` varchar(18) DEFAULT NULL,
  `update_time` bigint(13) DEFAULT NULL,
  `add_time` bigint(13) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED CONNECTION='mysql://root:123456@192.168.1.8:3306/magic/m_electron'; 
```


#### 设置事务隔离级别
```
set session transaction isolation level [read uncommitted|read committed|repeatable read|serializable]

start transaction

select id, name, balance from account;
update account set balance = balance + 50 where id = 1;


set session transaction isolation level read uncommitted|read committed|repeatable read|serializable

start transaction
commit;
rollbck;
```


<!-- 外键级联 -->
```
restrict
cascade
set null
no action
```




#### 函数
```
CAST,CONVERT
CAST() 和CONVERT() 函数可用来获取一个类型的值，并产生另一个类型的值。
这个类型 可以是以下值其中的 一个：
BINARY[(N)]
CHAR[(N)]
DATE
DATETIME
DECIMAL
SIGNED [INTEGER]
TIME
UNSIGNED [INTEGER]

CAST(xxx AS 类型),CONVERT(xxx,类型)，类型必须用下列的类型：
可用的类型：　   
  二进制,同带binary前缀的效果 : BINARY    
  字符型,可带参数 : CHAR()     
  日期 : DATE     
  时间: TIME     
  日期时间型 : DATETIME     
  浮点数 : DECIMAL      
  整数 : SIGNED     
  无符号整数 : UNSIGNED

select CAST(category_id as UNSIGNED) from tb_electron_category;
select CONVERT(category_id, UNSIGNED) from tb_electron_category;


字符集转换: CONVERT(xxx  USING   gb2312)


select max(cast(sex as UNSIGNED INTEGER)) from user;
select * from user order by cast(sex as UNSIGNED INTEGER) limit 1;
select server_id from cardserver where game_id = 1 order by CAST(server_id as SIGNED) desc limit 10;
select server_id from cardserver where game_id = 1 order by CONVERT(server_id,SIGNED) desc limit 10;



md5
select md5(123);


replace:
语法：replace(object,search,replace)
select uuid();
或 
select replace(uuid(), '-', '');

concat:
使用CONCAT("'",str)或者CONCAT("\'",str)，防止数字过长时导出显示科学计数


trim
语法：trim([{BOTH | LEADING | TRAILING} [remstr] FROM] str)
 
以下举例说明：
mysql> SELECT TRIM(' phpernote  ');  
-> 'phpernote'  

mysql> SELECT TRIM(LEADING 'x' FROM 'xxxphpernotexxx');  
-> 'phpernotexxx'  

mysql> SELECT TRIM(BOTH 'x' FROM 'xxxphpernotexxx');  
-> 'phpernote'  

mysql> SELECT TRIM(TRAILING 'xyz' FROM 'phpernotexxyz');  
-> 'phpernotex'  


left
从左开始截取字符串
用法：left(str, length)，即：left(被截取字符串， 截取长度)
SELECT LEFT('www.yuanrengu.com',8)

right
从右开始截取字符串
用法：right(str, length)，即：right(被截取字符串， 截取长度)
SELECT RIGHT('www.yuanrengu.com',6)


LPAD(str,len,padstr)

 

用字符串 padstr对 str进行左边填补直至它的长度达到 len个字符长度，然后返回 str。如果 str的长度长于 len'，那么它将被截除到 len个字符。

mysql> SELECT LPAD('hi',4,'??'); -> '??hi'

update account set name = LPAD('京A0',7,Substr(account,length(account)-3,5)) where account like '01300000%' ; ->00883京A

 

RPAD(str,len,padstr)

用字符串 padstr对 str进行右边填补直至它的长度达到 len个字符长度，然后返回 str。如果 str的长度长于 len'，那么它将被截除到 len个字符。

mysql> SELECT RPAD('hi',5,'?ud'); -> 'hi?ud'

update account set name = LPAD('京A0',7,Substr(account,length(account)-3,5)) where account like '01300000%' ; ->京A00883


MySQL 字符串截取函数：left(), right(), substring(), substring_index()。还有 mid(), substr()。其中，mid(), substr() 等价于 substring() 函数，substring() 的功能非常强大和灵活。



substring
截取特定长度的字符串
substring(str, pos)，即：substring(被截取字符串， 从第几位开始截取)
substring(str, pos, length)，即：substring(被截取字符串，从第几位开始截取，截取长度)

1.从字符串的第9个字符开始读取直至结束
SELECT SUBSTRING('www.yuanrengu.com', 9)
结果为：rengu.com

2.从字符串的第9个字符开始，只取3个字符
SELECT SUBSTRING('www.yuanrengu.com', 9, 3)
结果为：ren

3.从字符串的倒数第6个字符开始读取直至结束
SELECT SUBSTRING('www.yuanrengu.com', -6)
结果为：gu.com

4.从字符串的倒数第6个字符开始读取，只取2个字符
SELECT SUBSTRING('www.yuanrengu.com', -6, 2)
结果为：gu

substring_index
按关键字进行读取
用法：substring_index(str, delim, count)，即：substring_index(被截取字符串，关键字，关键字出现的次数)
1.截取第二个“.”之前的所有字符
SELECT SUBSTRING_INDEX('www.yuanrengu.com', '.', 2);
结果为：www.yuanrengu

2.截取倒数第二个“.”之后的所有字符
SELECT SUBSTRING_INDEX('www.yuanrengu.com', '.', -2);
结果为：yuanrengu.com

3.如果关键字不存在，则返回整个字符串
SELECT SUBSTRING_INDEX('www.yuanrengu.com', 'sprite', 1);
结果为：www.yuanrengu.com


substring_index
字符串截取：substring_index(str,delim,count)
4.1 截取第二个 '.' 之前的所有字符。

mysql> select substring_index('www.example.com', '.', 2);
+------------------------------------------------+
| substring_index('www.example.com', '.', 2) |
+------------------------------------------------+
| www.example                               |
+------------------------------------------------+
4.2 截取第二个 '.' （倒数）之后的所有字符。

mysql> select substring_index('www.example.com', '.', -2);
+-------------------------------------------------+
| substring_index('www.example.com', '.', -2) |
+-------------------------------------------------+
| example.com                                          |
+-------------------------------------------------+
4.3 如果在字符串中找不到 delim 参数指定的值，就返回整个字符串

mysql> select substring_index('www.example.com', '.coc', 1);
+---------------------------------------------------+
| substring_index('www.example.com', '.coc', 1) |
+---------------------------------------------------+
| www.example.com                               |
+---------------------------------------------------+


IF(condition, value_if_true, value_if_false)
参数  描述
condition 必须，判断条件
value_if_true 可选，当条件为true值返回的值
condition 可选，当条件为false值返回的值

eg:
SELECT IF(500<1000, 5, 10);
SELECT IF(STRCMP("hello","bye") = 0, "YES", "NO");



常用的字符串函数：
函数                                说明
CONCAT(s1,s2，...)                  返回连接参数产生的字符串，一个或多个待拼接的内容，任意一个为NULL则返回值为NULL。
CONCAT_WS(x,s1,s2,...)              返回多个字符串拼接之后的字符串，每个字符串之间有一个x。
SUBSTRING(s,n,len)、MID(s,n,len)     两个函数作用相同，从字符串s中返回一个第n个字符开始、长度为len的字符串。
LEFT(s,n)、RIGHT(s,n)                前者返回字符串s从最左边开始的n个字符，后者返回字符串s从最右边开始的n个字符。
INSERT(s1,x,len,s2)                 返回字符串s1，其子字符串起始于位置x，被字符串s2取代len个字符。
REPLACE(s,s1,s2)                    返回一个字符串，用字符串s2替代字符串s中所有的字符串s1。
LOCATE(str1,str)、POSITION(str1 IN str)、INSTR(str,str1)  三个函数作用相同，返回子字符串str1在字符串str中的开始位置（从第几个字符开始）。
FIELD(s,s1,s2,...)                  返回第一个与字符串s匹配的字符串的位置。
```



### explain
```
MySQL [db_electron_property_online]> explain select id,model_name,factory_id from db_electron.tb_electron where id between 10 and 20;
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table       | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | tb_electron | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |   11 |   100.00 | Using where |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.07 sec)


select_type：
SELECT类型,可以为以下任何一种:
SIMPLE:简单SELECT(不使用UNION或子查询)
PRIMARY:最外面的SELECT
UNION:UNION中的第二个或后面的SELECT语句
DEPENDENT UNION:UNION中的第二个或后面的SELECT语句,取决于外面的查询
UNION RESULT:UNION 的结果
SUBQUERY:子查询中的第一个SELECT
DEPENDENT SUBQUERY:子查询中的第一个SELECT,取决于外面的查询
DERIVED:导出表的SELECT(FROM子句的子查询)

table：
输出的行所引用的表

type：
联接类型。下面给出各种联接类型,按照从最佳类型到最坏类型进行排序:

system:表仅有一行(=系统表)。这是const联接类型的一个特例。
const:表最多有一个匹配行,它将在查询开始时被读取。因为仅有一行,在这行的列值可被优化器剩余部分认为是常数。const表很快,因为它们只读取一次!
eq_ref:对于每个来自于前面的表的行组合,从该表中读取一行。这可能是最好的联接类型,除了const类型。
ref:对于每个来自于前面的表的行组合,所有有匹配索引值的行将从这张表中读取。
ref_or_null:该联接类型如同ref,但是添加了MySQL可以专门搜索包含NULL值的行。
index_merge:该联接类型表示使用了索引合并优化方法。
unique_subquery:该类型替换了下面形式的IN子查询的ref: value IN (SELECT primary_key FROM single_table WHERE some_expr) unique_subquery是一个索引查找函数,可以完全替换子查询,效率更高。
index_subquery:该联接类型类似于unique_subquery。可以替换IN子查询,但只适合下列形式的子查询中的非唯一索引: value IN (SELECT key_column FROM single_table WHERE some_expr)
range:只检索给定范围的行,使用一个索引来选择行。
index:该联接类型与ALL相同,除了只有索引树被扫描。这通常比ALL快,因为索引文件通常比数据文件小。
ALL:对于每个来自于先前的表的行组合,进行完整的表扫描。

possible_keys：
指出MySQL能使用哪个索引在该表中找到行

key:
显示MySQL实际决定使用的键(索引)。如果没有选择索引,键是NULL。

key_len:
显示MySQL决定使用的键长度。如果键是NULL,则长度为NULL。

ref:
显示使用哪个列或常数与key一起从表中选择行。

rows:
显示MySQL认为它执行查询时必须检查的行数。多行之间的数据相乘可以估算要处理的行数。

filtered:
显示了通过条件过滤出的行数的百分比估计值。

Extra:
该列包含MySQL解决查询的详细信息

Distinct:MySQL发现第1个匹配行后,停止为当前的行组合搜索更多的行。
Not exists:MySQL能够对查询进行LEFT JOIN优化,发现1个匹配LEFT JOIN标准的行后,不再为前面的的行组合在该表内检查更多的行。
range checked for each record (index map: #):MySQL没有发现好的可以使用的索引,但发现如果来自前面的表的列值已知,可能部分索引可以使用。
Using filesort:MySQL需要额外的一次传递,以找出如何按排序顺序检索行。
Using index:从只使用索引树中的信息而不需要进一步搜索读取实际的行来检索表中的列信息。
Using temporary:为了解决查询,MySQL需要创建一个临时表来容纳结果。
Using where:WHERE 子句用于限制哪一个行匹配下一个表或发送到客户。
Using sort_union(...), Using union(...), Using intersect(...):这些函数说明如何为index_merge联接类型合并索引扫描。
Using index for group-by:类似于访问表的Using index方式,Using index for group-by表示MySQL发现了一个索引,可以用来查 询GROUP BY或DISTINCT查询的所有列,而不要额外搜索硬盘访问实际的表。

一.select_type的说明

1.UNION:

当通过union来连接多个查询结果时，第二个之后的select其select_type为UNION。

mysql> explain select * from t_order where order_id=100 union select * from t_order where order_id=200; 
+----+--------------+------------+-------+---------------+---------+---------+-------+------+-------+ 
| id | select_type  | table      | type  | possible_keys | key     | key_len | ref   | rows | Extra | 
+----+--------------+------------+-------+---------------+---------+---------+-------+------+-------+ 
|  1 | PRIMARY      | t_order    | const | PRIMARY       | PRIMARY | 4       | const |    1 |       | 
|  2 | UNION        | t_order    | const | PRIMARY       | PRIMARY | 4       | const |    1 |       | 
| NULL | UNION RESULT | <union1,2> | ALL   | NULL          | NULL    | NULL    | NULL  | NULL |       | 
+----+--------------+------------+-------+---------------+---------+---------+-------+------+-------+ 
3 rows in set (0.34 sec) 
2.DEPENDENT UNION与DEPENDENT SUBQUERY:

当union作为子查询时，其中第二个union的select_type就是DEPENDENT UNION。
第一个子查询的select_type则是DEPENDENT SUBQUERY。

mysql> explain select * from t_order where order_id in (select order_id from t_order where order_id=100 union select order_id from t_order where order_id=200); 
+----+--------------------+------------+-------+---------------+---------+---------+-------+--------+-------------+ 
| id | select_type        | table      | type  | possible_keys | key     | key_len | ref   | rows   | Extra       | 
+----+--------------------+------------+-------+---------------+---------+---------+-------+--------+-------------+ 
|  1 | PRIMARY            | t_order    | ALL   | NULL          | NULL    | NULL    | NULL  | 100453 | Using where | 
|  2 | DEPENDENT SUBQUERY | t_order    | const | PRIMARY       | PRIMARY | 4       | const |      1 | Using index | 
|  3 | DEPENDENT UNION    | t_order    | const | PRIMARY       | PRIMARY | 4       | const |      1 | Using index | 
| NULL | UNION RESULT       | <union2,3> | ALL   | NULL          | NULL    | NULL    | NULL  |   NULL |             | 
+----+--------------------+------------+-------+---------------+---------+---------+-------+--------+-------------+ 
4 rows in set (0.03 sec) 
3.SUBQUERY:

子查询中的第一个select其select_type为SUBQUERY。

mysql> explain select * from t_order where order_id=(select order_id from t_order where order_id=100); 
+----+-------------+---------+-------+---------------+---------+---------+-------+------+-------------+ 
| id | select_type | table   | type  | possible_keys | key     | key_len | ref   | rows | Extra       | 
+----+-------------+---------+-------+---------------+---------+---------+-------+------+-------------+ 
|  1 | PRIMARY     | t_order | const | PRIMARY       | PRIMARY | 4       | const |    1 |             | 
|  2 | SUBQUERY    | t_order | const | PRIMARY       | PRIMARY | 4       |       |    1 | Using index | 
+----+-------------+---------+-------+---------------+---------+---------+-------+------+-------------+ 
2 rows in set (0.03 sec) 
4.DERIVED:

当子查询是from子句时，其select_type为DERIVED。

mysql> explain select * from (select order_id from t_order where order_id=100) a; 
+----+-------------+------------+--------+---------------+---------+---------+------+------+-------------+ 
| id | select_type | table      | type   | possible_keys | key     | key_len | ref  | rows | Extra       | 
+----+-------------+------------+--------+---------------+---------+---------+------+------+-------------+ 
|  1 | PRIMARY     | <derived2> | system | NULL          | NULL    | NULL    | NULL |    1 |             | 
|  2 | DERIVED     | t_order    | const  | PRIMARY       | PRIMARY | 4       |      |    1 | Using index | 
+----+-------------+------------+--------+---------------+---------+---------+------+------+-------------+ 
2 rows in set (0.03 sec) 
二.type的说明

1.system，const

见上面4.DERIVED的例子。其中第一行的type就是为system，第二行是const，这两种联接类型是最快的。

2.eq_ref

在t_order表中的order_id是主键，t_order_ext表中的order_id也是主键，该表可以认为是订单表的补充信息表，他们的关系是1对1，在下面的例子中可以看到b表的连接类型是eq_ref，这是极快的联接类型。

mysql> explain select * from t_order a,t_order_ext b where a.order_id=b.order_id; 
+----+-------------+-------+--------+---------------+---------+---------+-----------------+------+-------------+ 
| id | select_type | table | type   | possible_keys | key     | key_len | ref             | rows | Extra       | 
+----+-------------+-------+--------+---------------+---------+---------+-----------------+------+-------------+ 
|  1 | SIMPLE      | b     | ALL    | order_id      | NULL    | NULL    | NULL            |    1 |             | 
|  1 | SIMPLE      | a     | eq_ref | PRIMARY       | PRIMARY | 4       | test.b.order_id |    1 | Using where | 
+----+-------------+-------+--------+---------------+---------+---------+-----------------+------+-------------+ 
2 rows in set (0.00 sec) 
3.ref

下面的例子在上面的例子上略作了修改，加上了条件。此时b表的联接类型变成了ref。因为所有与a表中order_id=100的匹配记录都将会从b表获取。这是比较常见的联接类型。

mysql> explain select * from t_order a,t_order_ext b where a.order_id=b.order_id and a.order_id=100; 
+----+-------------+-------+-------+---------------+----------+---------+-------+------+-------+ 
| id | select_type | table | type  | possible_keys | key      | key_len | ref   | rows | Extra | 
+----+-------------+-------+-------+---------------+----------+---------+-------+------+-------+ 
|  1 | SIMPLE      | a     | const | PRIMARY       | PRIMARY  | 4       | const |    1 |       | 
|  1 | SIMPLE      | b     | ref   | order_id      | order_id | 4       | const |    1 |       | 
+----+-------------+-------+-------+---------------+----------+---------+-------+------+-------+ 
2 rows in set (0.00 sec) 
4.ref_or_null

user_id字段是一个可以为空的字段，并对该字段创建了一个索引。在下面的查询中可以看到联接类型为ref_or_null，这是mysql为含有null的字段专门做的处理。在我们的表设计中应当尽量避免索引字段为NULL，因为这会额外的耗费mysql的处理时间来做优化。

mysql> explain select * from t_order where user_id=100 or user_id is null; 
+----+-------------+---------+-------------+---------------+---------+---------+-------+-------+-------------+ 
| id | select_type | table   | type        | possible_keys | key     | key_len | ref   | rows  | Extra       | 
+----+-------------+---------+-------------+---------------+---------+---------+-------+-------+-------------+ 
|  1 | SIMPLE      | t_order | ref_or_null | user_id       | user_id | 5       | const | 50325 | Using where | 
+----+-------------+---------+-------------+---------------+---------+---------+-------+-------+-------------+ 
1 row in set (0.00 sec) 
5.index_merge

经常出现在使用一张表中的多个索引时。mysql会将多个索引合并在一起，如下例:

mysql> explain select * from t_order where order_id=100 or user_id=10; 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+-------------------------------------------+ 
| id | select_type | table   | type        | possible_keys   | key             | key_len | ref  | rows | Extra                                     | 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+-------------------------------------------+ 
|  1 | SIMPLE      | t_order | index_merge | PRIMARY,user_id | PRIMARY,user_id | 4,5     | NULL |    2 | Using union(PRIMARY,user_id); Using where | 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+-------------------------------------------+ 
1 row in set (0.09 sec) 
6.unique_subquery

该联接类型用于替换value IN (SELECT primary_key FROM single_table WHERE some_expr)这样的子查询的ref。注意ref列，其中第二行显示的是func，表明unique_subquery是一个函数，而不是一个普通的ref。

mysql> explain select * from t_order where order_id in (select order_id from t_order where user_id=10); 
+----+--------------------+---------+-----------------+-----------------+---------+---------+------+--------+-------------+ 
| id | select_type        | table   | type            | possible_keys   | key     | key_len | ref  | rows   | Extra       | 
+----+--------------------+---------+-----------------+-----------------+---------+---------+------+--------+-------------+ 
|  1 | PRIMARY            | t_order | ALL             | NULL            | NULL    | NULL    | NULL | 100649 | Using where | 
|  2 | DEPENDENT SUBQUERY | t_order | unique_subquery | PRIMARY,user_id | PRIMARY | 4       | func |      1 | Using where | 
+----+--------------------+---------+-----------------+-----------------+---------+---------+------+--------+-------------+ 
2 rows in set (0.00 sec) 
7.index_subquery

该联接类型与上面的太像了，唯一的差别就是子查询查的不是主键而是非唯一索引。

mysql> explain select * from t_order where user_id in (select user_id from t_order where order_id>10); 
+----+--------------------+---------+----------------+-----------------+---------+---------+------+--------+--------------------------+ 
| id | select_type        | table   | type           | possible_keys   | key     | key_len | ref  | rows   | Extra                    | 
+----+--------------------+---------+----------------+-----------------+---------+---------+------+--------+--------------------------+ 
|  1 | PRIMARY            | t_order | ALL            | NULL            | NULL    | NULL    | NULL | 100649 | Using where              | 
|  2 | DEPENDENT SUBQUERY | t_order | index_subquery | PRIMARY,user_id | user_id | 5       | func |  50324 | Using index; Using where | 
+----+--------------------+---------+----------------+-----------------+---------+---------+------+--------+--------------------------+ 
2 rows in set (0.00 sec) 
8.range

按指定的范围进行检索，很常见。

mysql> explain select * from t_order where user_id in (100,200,300); 
+----+-------------+---------+-------+---------------+---------+---------+------+------+-------------+ 
| id | select_type | table   | type  | possible_keys | key     | key_len | ref  | rows | Extra       | 
+----+-------------+---------+-------+---------------+---------+---------+------+------+-------------+ 
|  1 | SIMPLE      | t_order | range | user_id       | user_id | 5       | NULL |    3 | Using where | 
+----+-------------+---------+-------+---------------+---------+---------+------+------+-------------+ 
1 row in set (0.00 sec) 
9.index

在进行统计时非常常见，此联接类型实际上会扫描索引树，仅比ALL快些。

mysql> explain select count(*) from t_order; 
+----+-------------+---------+-------+---------------+---------+---------+------+--------+-------------+ 
| id | select_type | table   | type  | possible_keys | key     | key_len | ref  | rows   | Extra       | 
+----+-------------+---------+-------+---------------+---------+---------+------+--------+-------------+ 
|  1 | SIMPLE      | t_order | index | NULL          | user_id | 5       | NULL | 100649 | Using index | 
+----+-------------+---------+-------+---------------+---------+---------+------+--------+-------------+ 
1 row in set (0.00 sec) 
10.ALL

完整的扫描全表，最慢的联接类型，尽可能的避免。

mysql> explain select * from t_order; 
+----+-------------+---------+------+---------------+------+---------+------+--------+-------+ 
| id | select_type | table   | type | possible_keys | key  | key_len | ref  | rows   | Extra | 
+----+-------------+---------+------+---------------+------+---------+------+--------+-------+ 
|  1 | SIMPLE      | t_order | ALL  | NULL          | NULL | NULL    | NULL | 100649 |       | 
+----+-------------+---------+------+---------------+------+---------+------+--------+-------+ 
1 row in set (0.00 sec) 
三.extra的说明

1.Distinct

MySQL发现第1个匹配行后,停止为当前的行组合搜索更多的行。对于此项没有找到合适的例子，求指点。

2.Not exists

因为b表中的order_id是主键，不可能为NULL，所以mysql在用a表的order_id扫描t_order表，并查找b表的行时，如果在b表发现一个匹配的行就不再继续扫描b了，因为b表中的order_id字段不可能为NULL。这样避免了对b表的多次扫描。

mysql> explain select count(1) from t_order a left join t_order_ext b on a.order_id=b.order_id where b.order_id is null;  
+----+-------------+-------+-------+---------------+--------------+---------+-----------------+--------+--------------------------------------+ 
| id | select_type | table | type  | possible_keys | key          | key_len | ref             | rows   | Extra                                | 
+----+-------------+-------+-------+---------------+--------------+---------+-----------------+--------+--------------------------------------+ 
|  1 | SIMPLE      | a     | index | NULL          | express_type | 1       | NULL            | 100395 | Using index                          | 
|  1 | SIMPLE      | b     | ref   | order_id      | order_id     | 4       | test.a.order_id |      1 | Using where; Using index; Not exists | 
+----+-------------+-------+-------+---------------+--------------+---------+-----------------+--------+--------------------------------------+ 
2 rows in set (0.01 sec) 
3.Range checked for each record

这种情况是mysql没有发现好的索引可用，速度比没有索引要快得多。

mysql> explain select * from t_order t, t_order_ext s where s.order_id>=t.order_id and s.order_id<=t.order_id and t.express_type>5; 
+----+-------------+-------+-------+----------------------+--------------+---------+------+------+------------------------------------------------+ 
| id | select_type | table | type  | possible_keys        | key          | key_len | ref  | rows | Extra                                          | 
+----+-------------+-------+-------+----------------------+--------------+---------+------+------+------------------------------------------------+ 
|  1 | SIMPLE      | t     | range | PRIMARY,express_type | express_type | 1       | NULL |    1 | Using where                                    | 
|  1 | SIMPLE      | s     | ALL   | order_id             | NULL         | NULL    | NULL |    1 | Range checked for each record (index map: 0x1) | 
+----+-------------+-------+-------+----------------------+--------------+---------+------+------+------------------------------------------------+ 
2 rows in set (0.00 sec)
4.Using filesort

在有排序子句的情况下很常见的一种情况。此时mysql会根据联接类型浏览所有符合条件的记录，并保存排序关键字和行指针，然后排序关键字并按顺序检索行。

mysql> explain select * from t_order order by express_type; 
+----+-------------+---------+------+---------------+------+---------+------+--------+----------------+ 
| id | select_type | table   | type | possible_keys | key  | key_len | ref  | rows   | Extra          | 
+----+-------------+---------+------+---------------+------+---------+------+--------+----------------+ 
|  1 | SIMPLE      | t_order | ALL  | NULL          | NULL | NULL    | NULL | 100395 | Using filesort | 
+----+-------------+---------+------+---------------+------+---------+------+--------+----------------+ 
1 row in set (0.00 sec) 
5.Using index

这是性能很高的一种情况。当查询所需的数据可以直接从索引树中检索到时，就会出现。上面的例子中有很多这样的例子，不再多举例了。

6.Using temporary

发生这种情况一般都是需要进行优化的。mysql需要创建一张临时表用来处理此类查询。

mysql> explain select * from t_order a left join t_order_ext b on a.order_id=b.order_id group by b.order_id; 
+----+-------------+-------+------+---------------+----------+---------+-----------------+--------+---------------------------------+ 
| id | select_type | table | type | possible_keys | key      | key_len | ref             | rows   | Extra                           | 
+----+-------------+-------+------+---------------+----------+---------+-----------------+--------+---------------------------------+ 
|  1 | SIMPLE      | a     | ALL  | NULL          | NULL     | NULL    | NULL            | 100395 | Using temporary; Using filesort | 
|  1 | SIMPLE      | b     | ref  | order_id      | order_id | 4       | test.a.order_id |      1 |                                 | 
+----+-------------+-------+------+---------------+----------+---------+-----------------+--------+---------------------------------+ 
2 rows in set (0.00 sec) 
7.Using where

当有where子句时，extra都会有说明。

8.Using sort_union(...)/Using union(...)/Using intersect(...)

下面的例子中user_id是一个检索范围，此时mysql会使用sort_union函数来进行索引的合并。而当user_id是一个固定值时，请参看上面type说明5.index_merge的例子，此时会使用union函数进行索引合并。

mysql> explain select * from t_order where order_id=100 or user_id>10; 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+------------------------------------------------+ 
| id | select_type | table   | type        | possible_keys   | key             | key_len | ref  | rows | Extra                                          | 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+------------------------------------------------+ 
|  1 | SIMPLE      | t_order | index_merge | PRIMARY,user_id | user_id,PRIMARY | 5,4     | NULL |    2 | Using sort_union(user_id,PRIMARY); Using where | 
+----+-------------+---------+-------------+-----------------+-----------------+---------+------+------+------------------------------------------------+ 
1 row in set (0.00 sec) 
对于Using intersect的例子可以参看下例，user_id与express_type发生了索引交叉合并。

mysql> explain select * from t_order where express_type=1 and user_id=100; 
+----+-------------+---------+-------------+----------------------+----------------------+---------+------+------+----------------------------------------------------+ 
| id | select_type | table   | type        | possible_keys        | key                  | key_len | ref  | rows | Extra                                              | 
+----+-------------+---------+-------------+----------------------+----------------------+---------+------+------+----------------------------------------------------+ 
|  1 | SIMPLE      | t_order | index_merge | user_id,express_type | user_id,express_type | 5,1     | NULL |    1 | Using intersect(user_id,express_type); Using where | 
+----+-------------+---------+-------------+----------------------+----------------------+---------+------+------+----------------------------------------------------+ 
1 row in set (0.00 sec) 
9.Using index for group-by

表明可以在索引中找到分组所需的所有数据，不需要查询实际的表。

mysql> explain select user_id from t_order group by user_id; 
+----+-------------+---------+-------+---------------+---------+---------+------+------+--------------------------+ 
| id | select_type | table   | type  | possible_keys | key     | key_len | ref  | rows | Extra                    | 
+----+-------------+---------+-------+---------------+---------+---------+------+------+--------------------------+ 
|  1 | SIMPLE      | t_order | range | NULL          | user_id | 5       | NULL |    3 | Using index for group-by | 
+----+-------------+---------+-------+---------------+---------+---------+------+------+--------------------------+ 
1 row in set (0.00 sec) 
除了上面的三个说明，还需要注意rows的数值，多行之间的数值是乘积的关系，可以估算大概要处理的行数，如果乘积很大，那就很有优化的必要了。
```











### 疑难杂症
>
1、首先安装mysqld服务器，输入命令：mysqld --install
2、接下来就是启动服务器了，输入命令：net start mysql
3、如果第2步不成功，则执行输入命令：mysqld --initialize-insecure
完了再次输入：net start mysql
4、又给我出了个问题:Access denied for user 'root'@'localhost' (using password: YES)
5、 安装的时候设了密码，为什么不用密码就可以登录
6、行！改密码呗。进入mysql数据库：use mysql
7、输入命令：update mysql.user set authentication_string=password('root') where user='root' ;
刷新一下：flush privileges;

>
打开MySQL数据库远程访问的权限
1、改表法 
```
可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，
更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 

重新远程登录
mysql -u root -p 
mysql>use mysql; 
mysql>update user set host = '%' where user = 'root'; 
mysql>select host, user from user; 
```

2、授权法 
```
在安装mysql的机器上运行： 
mysql -h localhost -u root 

进入MySQL服务器 
mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION 

赋予任何主机访问数据的权限 
例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。 
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码 
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

修改生效 
mysql>FLUSH PRIVILEGES 
```

>
### Incorrect string value: '\\xE5\\x93\\x81\\xE7\\x89\\x8C...' for column 'name'
这个问题一般都是字符集的问题
创建数据库的时候指定字符集：
create database if not exists chf default character set = 'utf8';

在mysql配置文件中指定数据库的字符集

查看创建的DB的字符集
select schema_name,default_character_set_name from information_schema.schemata where schema_name = 'test03';

>
修改密码方式(修改root密码)：
方法1： 用SET PASSWORD命令
mysql> set password for 用户名@localhost = password('新密码');  
mysql> set password for root@localhost = password('123');  

方法2：用mysqladmin   
格式：mysqladmin -u用户名 -p旧密码 password 新密码
例子：mysqladmin -uroot -p123456 password 123  

方法3：用UPDATE直接编辑user表
首先登录MySQL。  
mysql> use mysql;
mysql> update user set password=password('123') where user='root' and host='localhost';
mysql> flush privileges; 

方法4：在忘记root密码的时候，可以这样  
1. 关闭正在运行的MySQL服务。  
2. 打开DOS窗口，转到mysql\bin目录。  
3. 输入mysqld --skip-grant-tables 回车。--skip-grant-tables 的意思是启动MySQL服务的时候跳过权限表认证。  
4. 再开一个DOS窗口（因为刚才那个DOS窗口已经不能动了），转到mysql\bin目录。  
5. 输入mysql回车，如果成功，将出现MySQL提示符 >。  
6. 连接权限数据库： use mysql; 。  
6. 改密码：update user set password=password("123") where user="root";（别忘了最后加分号） 。  
7. 刷新权限（必须步骤）：flush privileges;　。  
8. 退出 quit。  
9. 注销系统，再进入，使用用户名root和刚才设置的新密码123登录。 


第三种方式：
1.打开mysql.exe和mysqld.exe所在的文件夹,复制路径地址
2.打开cmd命令提示符，进入上一步mysql.exe所在的文件夹。
3.输入命令  mysqld --skip-grant-tables  回车，此时就跳过了mysql的用户验证。注意输入此命令之后命令行就无法操作了，此时可以再打开一个新的命令行。注意：在输入此命令之前先在任务管理器中结束mysqld.exe进程，确保mysql服务器端已结束运行。
4.然后直接输入mysql，不需要带任何登录参数直接回车就可以登陆上数据库。
5.输入show databases;   可以看到所有数据库说明成功登陆。
6.其中mysql库就是保存用户名的地方。输入 use mysql;   选择mysql数据库。
7.show tables查看所有表，会发现有个user表，这里存放的就是用户名，密码，权限等等账户信息。
8.输入select user,host,password from user;   来查看账户信息。
9.更改root密码，输入update user set password=password('123456') where user='root' and host='localhost';
10.再次查看账户信息，select user,host,password from user;   可以看到密码已被修改。
11.退出命令行，重启mysql数据库，用新密码尝试登录。
12.测试不带密码登录mysql,发现还是能够登陆上，但显示数据库时只能看到两个数据库了，说明重启之后跳过密码验证已经被取消了。
13.我这地方重启数据库之后之所以不带密码任然能够登录是因为我的数据库里存在设无须口令的账户。

>
【mysql】mysql局域网访问设置
局域网连接mysql报错： 
ERROR 1130: Host '192.168.1.220' is not allowed to connect to this MySQL server

解决方法：
可能是帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 或添加一个用户为“%”  。    

想让局域网中的所有机器都能连接MySQL数据库，首先要给MySQL开启远程连接的功能，在MySQL服务器控制台上执行MySQL命令：

grant all privileges on *.* to root@"%" identified by 'abc' with grant option;  
flush privileges;
其中上面两行代码的意思是给从任意ip地址连接的用户名为root，密码为abc的用户赋予所有的权限。其中的"%"为任意的ip地址，如果想设为特定的值也可以设定为特定的值（以通配符%的内容增加主机/IP地址，也可以直接增加IP地址）。

做完这些之后，局域网内的mysql服务器可以访问了。


>
命令行复制sql插入数据太长，导致命令行死机，直接结束掉重新进入mysql,提示如下：
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

解决方法：
```
首先进入mysql
查看那个数据库占用了进程
show processlist;
kill 180;
然后既可以了
```

```
在进行ifnull处理时，比如 ifnull(a/b,'0') 这样就会导致 a/b成了字符串，因此需要把'0'改成0，即可解决此困扰
```


pymysql The table 'tb_electron_with_kwargs_56' is full

MySQL [db_electron_to_es]> show processlist;
ERROR 2006 (HY000): MySQL server has gone away
No connection. Trying to reconnect...
ERROR 2003 (HY000): Can't connect to MySQL server on '192.168.1.163' (111)
ERROR: Can't connect to the server
解决方法：
```
```



解决Lost connection to MySQL server during query错误方法
```
昨天使用MySQL数据库的时候，出现了一个严重的错误，Lost connection to MySQL server during query，字面意思就是在查询过程中丢失连接到MySQL服务器。

[Msg] Decompressing...
[Msg] Table Created: wp_wiki_copy
[Msg] Importing Data...
[Msg] 2013 - Lost connection to MySQL server during query
[Msg] Table Restored: wp_wiki_copy
[Msg] Finished - Stopped before completion

我的数据量大概了5万条，备份的数据库文件大小有240M，这还是压缩了的，确实有点大。初步判断是MySQL可能挂掉了，在系统服务里面查看MySQL的进程并没有停止。最开始考虑是数据库结构不对，但是我是通过Navicat for MySQL的备份和恢复备份导入数据，应该表结构都在备份文件里面，应该不是数据库结构的问题。网络环境都是本地。也不可能是网络链接和数据库服务器的问题。最后在早上找到了解决方法，在my.ini配置文件 mysqld 节点下添加

max_allowed_packet = 500M

配置MySQL允许的最大数据包大小，上面的500000M你可以根据你的项目修改为你自己的值，只要比要导入的备份文件大就可以了。

mysql出现ERROR : (2006, 'MySQL server has gone away') 问题意思是指client和MySQL server之间的链接断了

造成这样的原因一般是sql操作的时间过长，或者是传送的数据太大(例如使用insert ... values的语句过长， 这种情况可以通过修改max_allowed_packed的配置参数来避免，也可以在程序中将数据分批插入)。

产生这个问题的原因有很多，总结下网上的分析：

原因一. MySQL 服务宕了

判断是否属于这个原因的方法很简单，进入mysql控制台，查看mysql的运行时长

mysql> show global status like 'uptime';

+---------------+---------+

| Variable_name | Value   |

+---------------+---------+

| Uptime        | 3414707 |

+---------------+---------+

1 row in set或者查看MySQL的报错日志，看看有没有重启的信息

如果uptime数值很大，表明mysql服务运行了很久了。说明最近服务没有重启过。

如果日志没有相关信息，也表名mysql服务最近没有重启过，可以继续检查下面几项内容。

原因二. mysql连接超时

即某个mysql长连接很久没有新的请求发起，达到了server端的timeout，被server强行关闭。

此后再通过这个connection发起查询的时候，就会报错server has gone away

（大部分PHP脚本就是属于此类）

mysql> show global variables like '%timeout';

+----------------------------+----------+

| Variable_name              | Value    |

+----------------------------+----------+

| connect_timeout            | 10       |

| delayed_insert_timeout     | 300      |

| innodb_lock_wait_timeout   | 50       |

| innodb_rollback_on_timeout | OFF      |

| interactive_timeout        | 28800    |

| lock_wait_timeout          | 31536000 |

| net_read_timeout           | 30       |

| net_write_timeout          | 60       |

| slave_net_timeout          | 3600     |

| wait_timeout               | 28800    |

+----------------------------+----------+

10 rows in set

wait_timeout 是28800秒，即mysql链接在无操作28800秒后被自动关闭

原因三. mysql请求链接进程被主动kill 

这种情况和原因二相似，只是一个是人为一个是MYSQL自己的动作

mysql> show global status like 'com_kill';

+---------------+-------+

| Variable_name | Value |

+---------------+-------+

| Com_kill      | 21    |

+---------------+-------+

1 row in set原因四. Your SQL statement was too large.

当查询的结果集超过 max_allowed_packet 也会出现这样的报错。定位方法是打出相关报错的语句。

用select * into outfile 的方式导出到文件，查看文件大小是否超过 max_allowed_packet ，如果超过则需要调整参数，或者优化语句。

mysql> show global variables like 'max_allowed_packet';

+--------------------+---------+

| Variable_name      | Value   |

+--------------------+---------+

| max_allowed_packet | 1048576 |

+--------------------+---------+

1 row in set (0.00 sec)

修改参数：

mysql> set global max_allowed_packet=1024*1024*16;

mysql> show global variables like 'max_allowed_packet';

+--------------------+----------+

| Variable_name      | Value    |

+--------------------+----------+

| max_allowed_packet | 16777216 |

+--------------------+----------+

1 row in set (0.00 sec)

以下是补充：

应用程序（比如PHP）长时间的执行批量的MYSQL语句。执行一个SQL，但SQL语句过大或者语句中含有BLOB或者longblob字段。比如，图片数据的处理。都容易引起MySQL server has gone away。大概浏览了一下，主要可能是因为以下几种原因：

一种可能是发送的SQL语句太长，以致超过了max_allowed_packet的大小，如果是这种原因，你只要修改my.cnf，加大max_allowed_packet的值即可。

可能是某些原因导致超时，比如程序中获取数据库连接时采用Singleton做法，虽然多次连接数据库，但其实使用的都是同一个连接，而且程序中某两次操作数据库的间隔时间超过了wait_timeout（SHOW STATUS能看到此设置），那么就可能出现问题。最简单的处理方式就是把wait_timeout改大，当然也可以在程序里时不时顺手mysql_ping()一下，这样MySQL就知道它不是一个人在战斗。

解决MySQL server has gone away

1、应用程序（比如PHP）长时间的执行批量的MYSQL语句。最常见的就是采集或者新旧数据转化。

解决方案： 在my.cnf文件中添加或者修改以下两个变量：

wait_timeout=2880000

interactive_timeout = 2880000

关于两个变量的具体说明可以google或者看官方手册。如果不能修改my.cnf，则可以在连接数据库的时候设置CLIENT_INTERACTIVE，比如：

sql = "set interactive_timeout=24*3600";

mysql_real_query(...)

2、执行一个SQL，但SQL语句过大或者语句中含有BLOB或者longblob字段。比如，图片数据的处理

解决方案：在my.cnf文件中添加或者修改以下变量：

max_allowed_packet = 10M(也可以设置自己需要的大小)

max_allowed_packet 参数的作用是，用来控制其通信缓冲区的最大长度。

最近做网站有一个站要用到WEB网页采集器功能，当一个PHP脚本在请求URL的时候，可能这个被请求的网页非常慢慢，超过了mysql的 wait-timeout时间，然后当网页内容被抓回来后，准备插入到MySQL的时候，发现MySQL的连接超时关闭了，于是就出现了“MySQL server has gone away”这样的错误提示，解决这个问题，我的经验有以下两点，或许对大家有用处：

第 一种方法：

当然是增加你的 wait-timeout值，这个参数是在my.cnf(在Windows下台下面是my.ini）中设置，我的数据库负荷稍微大一点，所以，我设置的值 为10，（这个值的单位是秒，意思是当一个数据库连接在10秒钟内没有任何操作的话，就会强行关闭，我使用的不是永久链接 （mysql_pconnect),用的是mysql_connect,关于这个wait-timeout的效果你可以在MySQL的进程列表中看到 （show processlist) ），你可以把这个wait-timeout设置成更大，比如300秒，呵呵，一般来讲300秒足够用了，其实你也可以不用设置，MySQL默认是8个小 时。情况由你的服务器和站点来定。

第二种方法：

这也是我个人认为最好的方法，即检查 MySQL的链接状态，使其重新链接。

可能大家都知道有mysql_ping这么一个函数，在很多资料中都说这个mysql_ping的 API会检查数据库是否链接，如果是断开的话会尝试重新连接，但在我的测试过程中发现事实并不是这样子的，是有条件的，必须要通过 mysql_options这个C API传递相关参数，让MYSQL有断开自动链接的选项（MySQL默认为不自动连接），但我测试中发现PHP的MySQL的API中并不带这个函数，你重新编辑MySQL吧，但mysql_ping这个函数还是终于能用得上的，只是要在其中有一个小小的操作技巧：

我需要调用这个函数的代码可能是这样子的

$str = file_get_contents('http://www.jb51.net');

$db->ping();//经过前面的网页抓取后，或者会导致数据库连接关闭,检查并重新连接

$db->query('select * from table');

ping()这个函数先检测数据连接是否正常，如果被关闭，整个把当前脚本的MYSQL实例关闭，再重新连接。

经 过这样处理后，可以非常有效的解决MySQL server has gone away这样的问题，而且不会对系统造成额外的开销。

1） 方法1

可以编辑my.cnf来修改（windows下my.ini）,在[mysqld]段或者mysql的server配置段进行修改。

max_allowed_packet = 20M

如果找不到my.cnf可以通过

mysql --help | grep my.cnf

去寻找my.cnf文件。

2） 方法2

（很妥协，很纠结的办法）

进入mysql server

在mysql 命令行中运行

set global max_allowed_packet = 2*1024*1024*10

然后关闭掉这此mysql server链接，再进入。

show VARIABLES like '%max_allowed_packet%';

查看下max_allowed_packet是否编辑成功

mysql 默认最大能够处理的是1MB

如果你在sql使用了大的text或者BLOB数据，就会出现这个问题。 php手册上的注释

[mysqld]max_allowed_packet=16M

使用mysql做数据库还原的时候，由于有些数据很大，会出现这样的错误：The MySQL Server returned this Error:MySQL Error Nr.2006-MySQL server has gone away。我的一个150mb的备份还原的时候就出现了这错误。解决的方法就是找到mysql安装目录，找到my.ini文件，在文件的最后添加：max_allowed_packet = 10M(也可以设置自己需要的大小)。 max_allowed_packet 参数的作用是，用来控制其通信缓冲区的最大长度。
```

#### 使用 SSCursor (流式游标) 解决 Python 使用 pymysql 查询大量数据导致内存使用过高的问题

Python 导数据的时候，需要在一个大表上读取很大的结果集。
如果用传统的 fetchall() 或 fetchone() 方法，都是先默认在内存里缓存下所有行然后再处理，大量的数据会导致内存资源消耗光，内存容易溢出

解决的方法：
使用 SSCursor (流式游标)，避免客户端占用大量内存。(这个 cursor 实际上没有缓存下来任何数据，它不会读取所有所有到内存中，它的做法是从储存块中读取记录，并且一条一条返回给你。)
使用迭代器而不用 fetchall ,即省内存又能很快拿到数据

```
import pymysql

dbmy = pymysql.connect("ip","user","pass","date",cursorclass = pymysql.cursors.SSCursor)

cursor = dbmy.cursor()

sql = "select * from table"

relnum = cursor.execute(sql)

result = cursor.fetchone()

while result is not None:

    do something...

    result = cursor.fetchone()

cursor.close()
dbmy.close()
```
需要注意的是
因为 SSCursor 是没有缓存的游标,结果集只要没取完，这个 conn 是不能再处理别的 sql，包括另外生成一个 cursor 也不行的。如果需要干别的，请另外再生成一个连接对象。
每次读取后处理数据要快，不能超过 60 s，否则 mysql 将会断开这次连接，也可以修改 SET NET_WRITE_TIMEOUT = xx 来增加超时间隔。



#### ERROR 1290 (HY000): The MySQL server is running with the --secure-file-priv option so it cannot execute this statement
```
此原因一般是load data infile '路径'（导入）和导出路径不一致导致的
```

### 1366, "Incorrect string value: '\\xE5\\xA8\\x81\\xE6\\xAC\\xA3' for column 'xxx' at row"
```
是应为数据库字符集和连接字符集不一致导致的
修改数据库字符集
alter database db_electron_property_base character set utf8;
```


### Cannot delete or update a parent row: a foreign key constraint fails
```
先设置外键约束检查关闭
set foreign_key_checks = 0;

删除数据，表或者视图
drop table m_electron;

开启外键约束检查，以保持表结构完整性
set foreign_key_checks = 1;
```


### TypeError: object of type 'builtin_function_or_method’ has no len()
```
出现这个错误，最常见的是引入的函数需要后面加()
如， s.strip()
```

###ERROR 1270 (HY000): Illegal mix of collations (utf8_general_ci,COERCIBLE), (latin1_swedish_ci,IMPLICIT), (utf8_general_ci,COERCIBLE) for operation 'concat'
```

```

### mysql Lock wait timeout exceeded; try restarting transaction
```
问题场景 
问题出现环境： 
1、在同一事务内先后对同一条数据进行插入和更新操作； 
2、多台服务器操作同一数据库； 
3、瞬时出现高并发现象；

原因分析 
在高并发的情况下，事物造成数据库死锁，后续操作超时抛出异常。 
Mysql数据库采用InnoDB模式，默认参数:innodb_lock_wait_timeout设置锁等待的时间是50s，一旦数据库锁超过这个时间就会报错。

解决方案 
1. 运行以下命令，查找提交事务的数据，杀掉线程即可解决
select * from information_schema.innodb_trx;
kill thread_id;

2. 增加锁等待时间，即增大下面配置项参数值，单位为秒（s）
innodb_lock_wait_timeout=500;

3、优化存储过程,事务避免过长时间的等待。
```

### mysql AttributeError: 'NoneType' object has no attribute 'settimeout'
```
报错：
Exception ignored in: <function MySQLResult.__del__ at 0x000001CF71069168>
Traceback (most recent call last):
  File "D:\workspace\virtualenv\mofang_data_cleaning-PcrGzYSV\lib\site-packages\pymysql\connections.py", line 1071, in __del__
    self._finish_unbuffered_query()
  File "D:\workspace\virtualenv\mofang_data_cleaning-PcrGzYSV\lib\site-packages\pymysql\connections.py", line 1177, in _finish_unbuffered_query
    packet = self.connection._read_packet()
  File "D:\workspace\virtualenv\mofang_data_cleaning-PcrGzYSV\lib\site-packages\pymysql\connections.py", line 657, in _read_packet
    packet_header = self._read_bytes(4)
  File "D:\workspace\virtualenv\mofang_data_cleaning-PcrGzYSV\lib\site-packages\pymysql\connections.py", line 688, in _read_bytes
    self._sock.settimeout(self._read_timeout)
AttributeError: 'NoneType' object has no attribute 'settimeout'
解决方法：

```

### AttributeError: 'NoneType' object has no attribute 'cursor'
```
  File "D:\workspace\virtualenv\mofang_data_cleaning-PcrGzYSV\lib\site-packages\sqlalchemy\pool\base.py", line 965, in cursor
    return self.connection.cursor(*args, **kwargs)
AttributeError: 'NoneType' object has no attribute 'cursor'
解决方法：
```

### pymysql.err.InternalError: Packet sequence number wrong - got 193 expected 1
sqlalchemy.exc.InternalError: (pymysql.err.InternalError) Packet sequence number wrong - got 193 expected 1
```
解决方法：
```

### (1205, 'Lock wait timeout exceeded; try restarting transaction')
```

```


### ConnectionError(('Connection aborted.', ConnectionAbortedError(10053, '你的主机中的软件中止了一个已建立的连接。', None, 10053, None))) caused by: ProtocolError(('Connection aborted.', ConnectionAbortedError(10053, '你的主机中的软件中止了一个已建立的连接。', None, 10053, None)))
```

```



```
select distinct model_name,factory 
from m_electron 
where id >= (select floor(rand() * ((select max(id) from m_electron) - (select min(id) from m_electron)) +
(select min(id) from m_electron)))
and factory in 
(
'Analog Devices Inc.',
'Maxim Integrated',
'NXP USA Inc.',
'ON Semiconductor',
'STMicroelectronics',
'Texas Instruments',
'Xilinx Inc.',
'Microchip Technology',
'Vishay Dale',
'Yageo',
'Rohm Semiconductor',
'Murata Electronics North America',
'AVX Corporation',
'Molex',
'TE Connectivity AMP Connectors'
)
and pintopin in (select a.pintopin from ((select pintopin,count(*) from m_electron group by pintopin having  count(*) > 1)) a) limit 50


SELECT model_name,factory
FROM m_electron AS students JOIN (SELECT ROUND(RAND() * ((SELECT MAX(id) FROM m_electron)-(SELECT MIN(id) FROM m_electron))+(SELECT MIN(id) FROM m_electron)) AS id) AS t2
WHERE students.id >= t2.id
and factory in 
(
'Analog Devices Inc.',
'Maxim Integrated',
'NXP USA Inc.',
'ON Semiconductor',
'STMicroelectronics',
'Texas Instruments',
'Xilinx Inc.',
'Microchip Technology',
'Vishay Dale',
'Yageo',
'Rohm Semiconductor',
'Murata Electronics North America',
'AVX Corporation',
'Molex',
'TE Connectivity AMP Connectors'
) 
and students.pintopin in (select a.pintopin from ((select pintopin,count(*) from m_electron group by pintopin having  count(*) > 1)) a)
ORDER BY students.id LIMIT 50;
```

