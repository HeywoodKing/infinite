## mysql

### 安装mysql


### 基本操作
#### MySQL数据库远程访问
```
mysql -u root -p123456
mysql -h 192.168.10.38 -u root -p123456
mysql -h 192.168.10.38 -u root -p
mysql -h 30.158.59.78 -uroot -pabc123
mysql -h tom.xicp.net -uroot -pabc123
```
```
show databases;
show engines;
use mysql;
show tables;
```

创建数据库：
```
create database test charset=utf8;
create database test DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
create database test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use test;
show tables;
```
即可查看到用户和密码
```
select host,user,password from mysql.user;
select * from mysql.user;
```
修改密码
```
update mysql.user set password='这里填写你要设置的密码' where user='root';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
```
更新加密规则
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
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
    --foreign key(subid) references subjects(id)
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
```
增加多列字段
```
alter table students add column(aa bool default true, bb varchar(256) default '');
```
修改列字段
```
alter table students modify id int auto_increment unique;
alter table students modify column id int auto_increment unique;
```
修改多列字段
```
alter table students modify column(id int auto_increment unique,name varchar(100) not null);
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
查看外键
```
show create table my_foreign1;
```
添加表外键约束
```
alter table students add constraint my_foreign1 foreign key(subid) references subjects(id);
```
结构化查看数据
```
select * from students\G;
```
插入表数据
```
insert into students(name, gender, birthday) values('zhangsan', 1, '1990-7-8');
```
更新表数据
```
update students set name='lili' where id=1;
```
删除表数据
```
delete from students where id=1;
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

select gender,count(\*) from students group by gender having count(\*) > 2;

select * from (
select gender,count(\*) from students group by gender having count(\*) > 2);

select id,name,gender,birthday from students where gender in 
(select gender from (select gender,count(\*) from students group by gender having count(\*) > 2) as b);

select * from students order by birthday asc,gender desc;
```

查看表的索引
```
show index from students;
show view from students;
```
创建索引
```
create index idx_students_id on students(id, name(11), gender);
```
删除索引
```
drop index idx_students_id on students;
```

开启运行时间检测
```
set profiling=1;
```
查看执行时间
```
show profiles;
```
修改表users自动序列值
```
alter table users AUTO_INCREMENT=10000;
```

随机数
```
(SELECT floor( RAND() * ((SELECT MAX(id) FROM `table`)-(SELECT MIN(id) FROM `table`)) + (SELECT MIN(id) FROM `table`)))
```

获取某库某表当前自增id的值
```
SELECT auto_increment FROM information_schema.tables where table_schema="db_electron" and table_name="tb_electron";
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


数学函数
```
select abs(-32);
select mod(10/3);
select 10%3;
select floor(2/3);
select ceiling(2/3);
```

日期时间查询，转换等函数
```
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

## 进阶操作
```
排序
将pony表中的d 进行排序，可d的定义为varchar，可以这样解决
select * from pony order by (d+0)

```

### mysql json


## 高级操作

### mysql导入
#### 方法一：未连接数据库时方法
>语法格式：mysql -h ip -u userName -p dbName < sqlFilePath (最后没有分号) 
```
-h : 数据库所在的主机。如果是本机，可以使用localhost，或者省略此项； 
-u : 连接数据库用户名。 
-p : 连接数据库密码。出于安全考虑，一般不在-p之后直接写出明文的密码。整个命令回车之后，数据库会要求输入密码，那个时候再输入密码将以**的形式显示出来。有一定的保护作用。 
dbName : 要使用的具体的某个数据库。这个不是必须的，如果sql脚本中没有使用“use dbName”选择数据库，则此处必须制定数据库；如果使用了”use dbName”，则可以省略。 
sqlFilePath : sql脚本的路径。如我将sql脚本放在了D盘，我的sql脚本的名字是”test_sql.sql”。则路径为”D:\test_sql.sql”。 

mysql -h 192.168.99.100 -uroot -p test2 < E:/mysql/2019_08_04_bak.sql
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


### mysql导出
导出某个数据库：
```
mysqldump -uroot -p test > E:/mysql/bak/2019_08_04.sql
mysqldump -uroot -p test > ~/mysql/bak/2019_08_04.sql
mysqldump -h 192.168.99.100 -uroot -p test > E:/mysql/2019_08_04_bak.sql
mysqldump -h 192.168.99.100 -uroot -p test > ~/mysql/bak/2019_08_04.sql
mysqldump -u root -p dbName > sqlFilePath
```

导出多个数据库：
```
mysqldump -u root -p --add-drop-database --databases dbName1 dbName2 … > sqlFilePath 
–add-drop-database ： 该选项表示在创建数据库的时候先执行删除数据库操作 
–database : 该选项后面跟着要导出的多个数据库，以空格分隔
```

导出某个数据库的某个表：
```
mysqldump -u root -p dbName tableName > sqlFilePath
```

只导出数据库结构，不带数据：
```
mysqldump -u root -p -d dbName > sqlFilePath 
-d : 只备份结构，不备份数据。也可以使用”--no-data”代替”-d”，效果一样。
```
导出命令执行情况如下图所示： 
![导出例子](https://img-blog.csdn.net/20160223111231109 "导出例子")


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

创建索引
```
create view v_clouse_lg as 
select * from students
inner join
select * from subjects
```


#### 函数
```
CAST,CONVERT
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
FROM m_electron AS t1 JOIN (SELECT ROUND(RAND() * ((SELECT MAX(id) FROM m_electron)-(SELECT MIN(id) FROM m_electron))+(SELECT MIN(id) FROM m_electron)) AS id) AS t2
WHERE t1.id >= t2.id
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
and t1.pintopin in (select a.pintopin from ((select pintopin,count(*) from m_electron group by pintopin having  count(*) > 1)) a)
ORDER BY t1.id LIMIT 50;
```

