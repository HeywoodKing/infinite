1、首先安装mysqld服务器，输入命令：mysqld --install
2、接下来就是启动服务器了，输入命令：net start mysql
3、如果第2不不成功，则执行输入命令：mysqld --initialize-insecure
完了再次输入：net start mysql
4、又给我出了个问题:Access denied for user 'root'@'localhost' (using password: YES)
5、 安装的时候设了密码，为什么不用密码就可以登录
6、行！改密码呗。进入mysql数据库：use mysql
7、输入命令：update mysql.user set authentication_string=password('root') where user='root' ;
刷新一下：flush privileges;


修改密码方式：
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




cmd下
mysql,打开MySQL数据库远程访问的权限

mysql -u root -p123456

mysql -h 192.168.10.38 -u root -p123456
mysql -h30.158.59.78 -uroot -pabc123
mysql -htom.xicp.net -uroot -pabc123

show databases;

use mysql;

show tables;

打开MySQL数据库远程访问的权限
1、改表法 

可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，
更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 

mysql -u root -p 
mysql>use mysql; 
mysql>update user set host = '%' where user = 'root'; 
mysql>select host, user from user; 

2、授权法 

在安装mysql的机器上运行： 

1、mysql -h localhost -u root 

//这样应该可以进入MySQL服务器 

2、mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION 

//赋予任何主机访问数据的权限 

例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

3、mysql>FLUSH PRIVILEGES 

//修改生效 

4、mysql>EXIT 

退出MySQL服务器，这样就可以在其它任何的主机上以root身份登录


修改root密码




DATETIME -> Timestamp: UNIX_TIMESTAMP(...)

Timestamp -> DATETIME: FROM_UNIXTIME(...)





cmd下
mysql,打开MySQL数据库远程访问的权限

mysql -u root -p123456

mysql -h 192.168.10.38 -u root -p123456
mysql -h30.158.59.78 -uroot -pabc123
mysql -htom.xicp.net -uroot -pabc123

show databases;

use mysql;

show tables;

打开MySQL数据库远程访问的权限
1、改表法 

可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，
更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 

mysql -u root -p 
mysql>use mysql; 
mysql>update user set host = '%' where user = 'root'; 
mysql>select host, user from user; 

2、授权法 

在安装mysql的机器上运行： 

1、mysql -h localhost -u root 

//这样应该可以进入MySQL服务器 

2、mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION 

//赋予任何主机访问数据的权限 

例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

3、mysql>FLUSH PRIVILEGES 

//修改生效 

4、mysql>EXIT 

退出MySQL服务器，这样就可以在其它任何的主机上以root身份登录


修改root密码






cmd下
mysql,打开MySQL数据库远程访问的权限

mysql -u root -p123456

mysql -h 192.168.10.38 -u root -p123456
mysql -h30.158.59.78 -uroot -pabc123
mysql -htom.xicp.net -uroot -pabc123

show databases;

use mysql;

show tables;

打开MySQL数据库远程访问的权限
1、改表法 

可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，
更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 

mysql -u root -p 
mysql>use mysql; 
mysql>update user set host = '%' where user = 'root'; 
mysql>select host, user from user; 

2、授权法 

在安装mysql的机器上运行： 

1、mysql -h localhost -u root 

//这样应该可以进入MySQL服务器 

2、mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION 

//赋予任何主机访问数据的权限 

例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码 

GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3'IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 

3、mysql>FLUSH PRIVILEGES 

//修改生效 

4、mysql>EXIT 

退出MySQL服务器，这样就可以在其它任何的主机上以root身份登录


修改root密码


### mysql导入导出数据库

### 导入
#### 方法一：未连接数据库时方法
>语法格式：mysql -h ip -u userName -p dbName < sqlFilePath (最后没有分号) 
```
-h : 数据库所在的主机。如果是本机，可以使用localhost，或者省略此项； 
-u : 连接数据库用户名。 
-p : 连接数据库密码。出于安全考虑，一般不在-p之后直接写出明文的密码。整个命令回车之后，数据库会要求输入密码，那个时候再输入密码将以**的形式显示出来。有一定的保护作用。 
dbName : 要使用的具体的某个数据库。这个不是必须的，如果sql脚本中没有使用“use dbName”选择数据库，则此处必须制定数据库；如果使用了”use dbName”，则可以省略。 
sqlFilePath : sql脚本的路径。如我将sql脚本放在了D盘，我的sql脚本的名字是”test_sql.sql”。则路径为”D:\test_sql.sql”。 
```
命令执行情况如下图所示：
![导入例子](https://img-blog.csdn.net/20160223105910733 "导入例子")

#### 方法二：已连接数据库时方法
语法格式：source sqlFilePath（后面没有分号） 
sqlFilePath : sql脚本的路径。如我将sql脚本放在了D盘，我的sql脚本的名字是”test_sql.sql”。则路径为”D:\test_sql.sql”。 

命令执行情况如下图所示：
![导入例子](https://img-blog.csdn.net/20160223105926651 "导入例子")

### 导出
导出某个数据库：

mysqldump -u root -p dbName > sqlFilePath

导出多个数据库：

mysqldump -u root -p –add-drop-database –databases dbName1 dbName2… > sqlFilePath 
–add-drop-database ： 该选项表示在创建数据库的时候先执行删除数据库操作 
–database : 该选项后面跟着要导出的多个数据库，以空格分隔

导出某个数据库的某个表：

mysqldump -u root -p dbName tableName > sqlFilePath

只导出数据库结构，不带数据：

mysqldump -u root -p -d dbName > sqlFilePath 
-d : 只备份结构，不备份数据。也可以使用”–no-data”代替”-d”，效果一样。

导出命令执行情况如下图所示： 
![导出例子](https://img-blog.csdn.net/20160223111231109 "导出例子")