# Bug List Page
flack

##1.ubuntu 16 安装mysqlclient报错找不到'mysql_config'
`sudo apt-get install mysql-server mysql-client`

然后查看mysql是否安装成功
`mysql -V`

`sudo  apt-get install libmysqlclient-dev python3-dev`

然后

`pip install mysqlclient`
就不会报错找不到'mysql_config'了


##2.sublime text3 shift+ctrl+p install 报错的问题
Preferences》Package Settings》Package Control》settings-user增加如下配置
```
"channels":
[
    "https://erhan.in/channel_v3.json"
],
```
这个是我配置之后的内容如下：
```
{
    "bootstrapped": true,
    "channels":
    [
        "https://erhan.in/channel_v3.json"
    ],
    "in_process_packages":
    [
    ],
    "installed_packages":
    [
        "LiveReload",
        "MarkdownEditing",
        "MarkdownLight",
        "MarkdownLivePreview",
        "MarkdownPreview",
        "Package Control",
        "Python 3"
    ]
}
```

##3.mysql 修改用户密码
`set password for root@localhost = password('123456');`

##4.插入数据报(1366, "Incorrect string value: '\\xE6\\x95\\xB0\\xE7\\xA0\\x81...' for column 'name' at row 1")
###查看mysql数据库默认编码格式
`show variables like '%char%';`

###将character_set_database和character_set_server设置为utf8

```
set character_set_database=utf8;
set character_set_server=utf8;
```

###删除数据库并新建数据库，然后插入数据！成功

##5.python -c "import django print(django.__path__)"    
查看django安装路径


安装docker
sudo apt-get -y install docker-ce
报错
Ubuntu18.04
无法获得锁 /var/lib/dpkg/lock-frontend - open (11: 资源暂时不可用)的解决方案
sudo rm /var/cache/apt/archives/ock-frontend
sudo rm /var/lib/dpkg/ock-frontend


sudo apt-get update
报错
无法下载 https://download.sublimetext.com/apt/stable/InRelease  无法连接上 download.sublimetext.com:443 (104.236.0.104)，连接超时
进入到/etc/apt/sources.lisd.d目录
根据错误提示删除对应的文件或目录，我这里根据上面的提示删除了sublimetext和webupd8team的对应文件。
重新执行sudo apt-get update，更新成功


ubuntu18.04修改mysql5.7字符集
flack@flack-K43SM:/etc/mysql$ ls
conf.d      debian-start  mariadb.conf.d  my.cnf.fallback  mysql.conf.d
debian.cnf  mariadb.cnf   my.cnf          mysql.cnf
flack@flack-K43SM:/etc/mysql$ sudo vim my.cnf

增加以下配置
[client]
default_character_set=utf8

[mysqld]
collation-server = utf8_unicode_ci
#设定连接mysql数据库时使用utf8编码，以让mysql数据库为utf8运行
init-connect='SET NAMES utf8'
character-set-server = utf8


# 方法2
# 修改处1：添加以下2行
[client]
default-character-set=utf8
 
[mysqld]
#skip-grant-tables
#skip-networking
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
 
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
 
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
 
# 修改处2：添加以下3行
default-storage-engine=INNODB
character-set-server=utf8
collation-server=utf8_general_ci

flack@flack-K43SM:/etc/mysql$ service mysql restart



查看安装端口情况
sudo netstat -tap | grep mysql

配置文件位置
sudo vim /etc/mysql/my.cnf

打开关闭服务
/etc/init.d/mysql start/stop


其它文件默认位置
/usr/bin                 客户端程序和脚本  
/usr/sbin                mysqld 服务器  
/var/lib/mysql           日志文件，数据库  ［重点要知道这个］  
/usr/share/doc/packages  文档  
/usr/include/mysql       包含( 头) 文件  
/usr/lib/mysql           库  
/usr/share/mysql         错误消息和字符集文件  
/usr/share/sql-bench     基准程序  


