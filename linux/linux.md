# Linux

```
ubuntu 截图快捷键
Ctrl+PrintScreen 复制截图到剪切板
Ctrl+Alt+PrintScreen 复制窗口截图到剪切板
Shift+Ctrl+PrintScreen 复制选区截图到剪切板
PrintScreen 截全屏保存到目录
Alt+PrintScreen 将窗口截图保存到目录
Shift+PrintScreen 将选区截图保存到目录
Shift+Ctrl+Alt+R 记录一小段屏幕录像

```

### linux 常用命令
```
ls
ll
ls -a
ls --full-time --author -la
man ls 
info ls

pwd
cd ~
whereis python
touch a.txt
sudo vim a.conf
su root
sudo apt-get update
sudo apt-get upgrade
mkdir aaa
# 复制mysite文件夹及内容到/opt/project/下
cp -r mysite /opt/project/
# 移动aaa文件夹及内容到/home/development下
mv aaa /home/development
tree

查看前10行内容
head -n 10 filename
查看后5行内容
tail -n 5 filename

如果想同时查看可以将前10行和后5行的显示信息通过输出重定向的方法保存到一个文档
将内容输出到/home/test文件中
head -n 10 filename >> /home/test
tail -n 5 filename >> /home/test
cat /home/test


显示前面1000行
head -n 1000
从1000行开始显示，显示1000行以后的
tail -n +1000


cat a.txt

查看前10行
cat filename | head -n 10
查看后10行
cat filename | tail -n 10
从100 行开始显示以后的所有行
cat filename | tail -n +100
查看前500行，后100行以后的所有行
cat filename | head -n 500 | tail -n +100
从第3000行开始，显示1000行。即显示3000~3999行
cat filename | tail -n +3000 | head -n 1000
显示1000行到3000行
cat filename| head -n 3000 | tail -n +1000 

查看文件的第5行到第10行
sed -n '5,10p' filename


查询MySQL安装目录
find / -name mysql
```

### 查看系统内核版本
```
cat /proc/version
```

### 显示linux的内核版本和系统是多少位的：X86_64代表系统是64位的。
```
uname -a
```

```
sb_release -a
显示如下
Distributor ID: Ubuntu                           //类别是ubuntu
Description:  Ubuntu 16.04.3 LTS          //16年3月发布的稳定版本，LTS是Long Term Support：长时间支持版本，支持周期长达三至五年
Release:    16.04                                    //发行日期或者是发行版本号
Codename:   xenial                               //ubuntu的代号名称
```

```
Task: Start Apache 2 Server /启动apache服务
# /etc/init.d/apache2 start
or
$ sudo /etc/init.d/apache2 start
Task: Restart Apache 2 Server /重启apache服务
# /etc/init.d/apache2 restart
or
$ sudo /etc/init.d/apache2 restart
Task: Stop Apache 2 Server /停止apache服务
# /etc/init.d/apache2 stop
or
$ sudo /etc/init.d/apache2 stop
```

当前目录是/local，而我经常要访问/usr/local/linux/work
那么我就可以使用在local下建立一个文件linkwork，
然后sudo ln -s /usr/local/linux/work  /local/linkwork
即建立两者之间的链接。

### 删除链接
`rm -rf   symbolic_name   注意不是rm -rf   symbolic_name/ `
那么上面我就是rm -rf /local/linkwork

链接有两种，一种被称为硬链接（Hard Link），另一种被称为符号链接（Symbolic Link）。
建立硬链接时，链接文件和被链接文件必须位于同一个文件系统中，并且不能建立指向目录的硬链接。而对符号链接，则不存在这个问题。默认情况下，ln产生硬链接。
　　在硬链接的情况下，参数中的“目标”被链接至[链接名]。如果[链接名]是一个目录名，系统将在该目录之下建立一个或多个与“目标”同名的链接文件，链接文件和被链接文件的内容完全相同。如果[链接名]为一个文件，用户将被告知该文件已存在且不进行链接。如果指定了多个“目标”参数，那么最后一个参数必须为目录。
　　如果给ln命令加上- s选项，则建立符号链接。如果[链接名]已经存在但不是目录，将不做链接。[链接名]可以是任何一个文件名（可包含路径），也可以是一个目录，并且允许它与“目标”不在同一个文件系统中。如果[链接名]是一个已经存在的目录，系统将在该目录下建立一个或多个与“目标”同名的文件，此新建的文件实际上是指向原“目标”的符号链接文件。

```

which python
which python3

python --version
python3 --version
pip --version

FreeBSD
sudo pkg install python3

Debian/Ubuntu
sudo apt-get install python3

openSUSE
sudo zypper in python3

Arch linux
sudo pacman -S python
```

### 下载安装脚本（使用 wget 或者 curl）
`wget https://bootstrap.pypa.io/get-pip.py`

### 运行安装脚本（注意不同系统启动 Python 3 的命令，用哪个版本的 Python 运行安装脚本，pip 就被关联到哪个版本。）
`sudo python3 get-pip.py`

### 部分 Linux 发行版可直接用包管理器安装 pip，如 Debian 和 Ubuntu
`sudo apt-get install python-pip`

>macOS（Mac OS X）可用 Homebrew 安装 Python 3，再用通过 get-pip.py 安装 pip
安装 Python 3
`brew install python3`
下载安装脚本
`curl https://bootstrap.pypa.io/get-pip.py`
安装 pip
`python3 get-pip.py`

>CentOS 7 编译安装 Python 3 方法如下（默认安装 pip）：
### 为了命令更直观且避免新人不停的敲 sudo 直接用 root 敢死队模式进行
su
### 安装编译环境
yum groupinstall 'Development Tools'
yum install zlib-devel bzip2-devel openssl-devel ncurese-devel
### 下载源码包（替换成自己需要的版本）
wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tar.xz
### 解压并切换到源码目录
tar -jxvf Python-3.5.1.tar.xz
cd Python-3.5.1
### 编译（配置自定义安装路径 ./configure --prefix=/your/pach/）
./configure --prefix=/usr/local/python3
make 
make install

### 查看本机ip
```
ifconfig -a
```

### 修复上次安装异常
```
sudo apt-get --fix-broken install
```

### 修改权限
1. 修改chfweb文件夹权限为777
```
sudo chmod 777 chfweb
sudo chmod 777 /data1/from_163/digikey_pdf6/ -R
```
2. 修改文件夹chfweb以及子文件夹和子文件的权限为777
```
sudo chmod -R 777 chfweb
```
3. 增加组
```
sudo groupadd --system webapps
```

4. 增加用户
用户名为user_test
```
sudo useradd --system --gid webapps --shell /bin/bash --home /webapps/test user_test
```

设置密码为：test
```
passwd test
```

5. 给用户赋值权限
创建用户目录
```
mkdir -p /webapps/test
```
修改目录权限，下面的命令意思是：使/webapps/test/这个目录属于user_test这个用户
```
chown user_test /webapps/test/
```

添加用户user_test sudo权限 
在/etc/sudoers添加 
使用命令vim /etc/sudoers打开/etc/sudoers 
在里面添加下面这一句：
```
user_test ALL=(ALL:ALL) ALL
```
使用:wq!强制保存

切换用户为：user_test
```
su - user_test
```

6. 修改python默认版本
```
调整优先级
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --config python3
```

#### chgrp 改变用户所属用户组
```
chgrp users -R /home/flack.chen/log.txt
```


#### chown 改变文件所有者
```
chown flack.chen -R install.log

修改文件夹以及下属子目录和文件所属用户为root,用户组为root
chown root:root -R /home/flack.chen

修改文件所属用户为root,用户组为root
chown root.root install.log

修改文件所属用户组为root
chown .root -R install.log
```

#### chmod 改变文件权限
```
-rwxrwxrwx
r:4
w:2
x:1
owner = rwx = 4+2+1 = 7
group = rwx = 4+2+1 = 7
others=	r-- = 4		= 4

chmod 774 -R /home/flack.chen/
chmod 770 .bashrc

-rwxr-xr--
chmod 754 .bashrc
chmod u=rwx,g=rx,o=r .bashrc

-rw-rw-r--
chmod 664 .bashrc
chmod u=rw,g=rw,o=r .bashrc

-rwxr-xr-x
chmod 755 .bashrc
chmod u=rwx,g=rx,o=rx .bashrc

-rwxr-----
chmod 740 .bashrc
chmod u=rwx,g=r .bashrc

-rw-r--r--
chmod 644 .bashrc
chmod u=rw,g=r,o=r .bashrc

每个人均可以写入
chmod a+w .bashrc

去掉所有人的可执行权限，其他不变
chmod a-x .bashrc

chmod 600 testing.txt
chmod u=rw,g=-r,o=-r testing.txt

```


### 查找被占用的端口
```
netstat -tul /* 查看端口，-t：tcp，-u：udp，-l：listening */
netstat -tln

netstat -tln | grep 80
ps -aux | grep 8000 /* 查看8000端口占用情况，-a：all，-u：user，-x：ttys以外的 */
查看进程
netstat -ntpl
查看nginx进程
ps -ef | grep nginx
```
netstat -tln 查看所有端口的使用情况，netstat -tln | grep 80 只查看80端口的使用情况

### 查看端口被哪个进程占用
```
lsof -i :80
```

### 杀掉占用80端口的进程
```
kill -9 /* 进程id */
kill pid /* 杀死pid */
```

### ubuntu更新操作系统
`do-release-upgrade`


Ubuntu卸载自带Python后无法进入桌面
1、启动Ubuntu系统，Alt+Ctrl+F4进入命令行；
2、按提示输入用户名和密码；
3、输入sudo apt-get install ubuntu-minimal ubuntu-standard ubuntu-desktop；
4、等待安装结束输入：sudo reboot重新启动或输入命令：startx  即可进入桌面。


### 查找指定目录下的文件夹建立软连接
```

find /data1/digikey_pdf2/ -type d     -exec ln -s {} /data/eddie/pdf/ \;
find /data1/digikey_pdf3/ -type d     -exec ln -s {} /data/eddie/pdf/ \;
find /data1/digikey_pdf4/ -type d     -exec ln -s {} /data/eddie/pdf/ \;
find /data1/from_163/ -type d         -exec ln -s {} /data/eddie/pdf/ \;
find /data2/no_digikey/ -type d       -exec ln -s {} /data/eddie/pdf/ \;
find /data3/digikey_pdf5/ -type d     -exec ln -s {} /data/eddie/pdf/ \;
find /data4/digikey_again/ -type d    -exec ln -s {} /data/eddie/pdf/ \;
find /data4/from163-20190809/no_digikey2/ -type d  -exec ln -s {} /data/eddie/pdf/ \;
```

```
目录结构查看
ls -a/-l/-h
pwd
tree -d
cd ~/-/./..
clear
ctrl、shift、=   放大字体
ctrl、-          缩小字体

命令帮助
command --help
man command

文件/目录 操作
cp -f/-i/-r
rm -f/-i/-r
mv -i/-r
mkdir -p

文件创建查看
touch
cat -b/-n
more 
grep -n/-v/-i  ^a/a$ 
echo
> 和 >>
|

字符匹配（正则表达式）
* 代表任意个数个字符
? 代表任意一个字符，至少一个
[] 表示可以匹配字符数组的任意一个
[abc] 匹配a、b、c中的任意一个
[a-f] 匹配a-f中的任意一个

more（查看内容时）
Space 显示手册页的下一屏
Enter 一次滚动手册页的一行
b 回滚一屏
f 前滚一屏
q 退出
/word 搜索word字符

关机重启
shutdown -r 时间[now/20:25/不加则一分钟后]
shutdown -c

查看网络
ifconfig | grep inet
ping

远程登录/传输
ssh [-p port] 用户名@ip
scp -r [-P port] 用户名@ip:文件名或路径 用户名@ip:文件名或路径

ssh免密码登录
在ssh客户端执行ssh-keygen生成ssh公钥、ssh私钥
让远程服务器记住公钥ssh-copy-id -p port user@remote

ssh配置别名
在~/.ssh/config里面追加
Host ubuntu
	HostName ip地址
	User xuguanglong
	Port 22
直接ssh ubuntu 就可以远程了

which 命令
/bin 		二进制执行文件目录
/sbin 		系统的bin
/usr/bin 	后期安装的软件
/usr/sbin 	超级用户的一些管理程序

usermod -g（主组） 组 用户名
usermod -G（附加组） 组（例：sudo） 用户名
usermod -s /bin/bash

组管理，都需要sudo权限
groupadd 组名
groupdel 组名
cat /etc/group 					里面有主组信息

用户管理，都需要sudo权限
useradd -m（建立家目录） -g 组 新建用户名
passwd 用户名
userdel -r（删除家目录）用户名
cat /etc/passwd | grep 用户名	里面有附加组信息

切换用户
su -（加上则到家目录） 用户名
exit

修改文件权限
chgrp -R 组名 文件/目录名
chmod -R +/-rwx(或者755) 文件名|目录名
chown 用户名 文件名|目录名

查看用户信息
id [用户名]
who
whoami

时间日期
date
cal -y

磁盘和目录空间
df -h			//disk free
du -h [目录名]  //disk usage

进程信息
ps aux 		 	// a所有用户的进程 u详细信息 x显示没有控制终端的进程
top 
kill [-9](强制终止) 进程代号

其它命令
find [路径] -name "*.py"
ln -s 被链接的源文件 链接名  
-s为软链接选项，一般不会建硬链接，软链接相当于快捷方式，硬链接相当于别名，建立链接用绝对路径
linux中文件名和文件数据是分开保存的
tar -cvf 打包文件.tar 被打包的文件/路径...
tar -xvf 打包文件.tar
gzip 压缩文件.tar.gz 打包文件.tar
tar -zcvf 压缩文件.tar.gz  被压缩的文件/路径...
tar -zxvf 压缩文件.tar.gz
tar -zxvf 压缩文件.tar.gz -C 目标路径    // 解压到指定路径，目标路径必须存在
tar -zxvf /bbs.tar.zip -C /zzz/bbs

把文件解压到当前目录下
unzip test.zip

如果要把文件解压到指定的目录下，需要用到-d参数
unzip -d /temp test.zip

解压的时候，有时候不想覆盖已经存在的文件，那么可以加上-n参数
unzip -n test.zip
unzip -n -d /temp test.zip

只看一下zip压缩包中包含哪些文件，不进行解压缩
unzip -l test.zip

查看显示的文件列表还包含压缩比率
unzip -v test.zip

检查zip文件是否损坏
unzip -t test.zip

将压缩文件test.zip在指定目录tmp下解压缩，如果已有相同的文件存在，要求unzip命令覆盖原先的文件
unzip -o test.zip -d /temp

sudo apt install 软件包
sudo apt remove 软件名
sudo apt update
```

### linux系统管理---好用的一些开源工具
#### htop
htop是一款运行于Linux系统上的监控与进程管理软件，取代传统UNIX的top。
可以通过F1获取帮助，了解其细节
```
sudo apt-get install htop
htop
```

#### dstat
dstat是一个用Python语言实现的系统资源统计生成工具。可以基本取代vmstat,iostat,netstat和ifstat工具。
收集网络，硬盘，CPU等系统资源情况
```
sudo apt-get install dstat
dstat -cdng
-c 表示CPU占用信息。idl代表idle空闲资源，wai代表等待I/O设备的响应情况，usr用户进程占用情况，sys是系统进程占用情况。
-d 表示磁盘的读写操作。
-n 表示网络发送和接受数据包的情况。
-g 表示分页(page)情况，一个较大的分页代表使用了大量的交换空间。

dstat -lym
其中:int代表中断，csw代表上下文切换，通常来说，值越大说明进程切换和中断频繁，可能造成一定的拥塞。

找出cpu，内存，io占用最高的进程和用户
dstat --proc-count --top-cpu --top-mem --top-io
```


#### Glances
Glances是一个局域psutil的跨平台的系统监控工具。
```
sudo apt-get install glances

单机启动:
glances

web启动:
glances -w
web启动，需要安装bottle这个包
```


#### iftop
iftop是一个类似top命令实时流量监控工具
```
sudo apt-get install iftop
iftop

TX：发送流量
RX：接收流量
TOTAL：总流量
Cumm：运行iftop到目前时间的总流量
peak：流量峰值
rates：分别表示过去 2s 10s 40s 的平均流量
```

#### nethogs
nethogs查看进程占用的带宽使用情况
```
sudo apt-get install nethogs
nethogs eth0
```

#### iotop
iotop类似于top命令的查看占用硬盘I/O的进程
```
sudo apt-get install iotop
iotop
```

#### 超级系统工具Sysdig，比 strace、tcpdump、lsof 加起来还强大
可以用sysdig命令做很多很酷的事情
##### 网络
```
查看占用网络带宽最多的进程
sysdig -c topprocs_net
显示主机192.168.0.1的网络传输数据
as binary:
sysdig -s2000 -X -c echo_fds fd.cip=192.168.0.1
as ASCII:
sysdig -s2000 -A -c echo_fds fd.cip=192.168.0.1
查看连接最多的服务器端口
in terms of established connections:
sysdig -c fdcount_by fd.sport "evt.type=accept"
in terms of total bytes:
sysdig -c fdbytes_by fd.sport
查看客户端连接最多的ip
in terms of established connections
sysdig -c fdcount_by fd.cip "evt.type=accept"
in terms of total bytes
sysdig -c fdbytes_by fd.cip
列出所有不是访问apache服务的访问连接
sysdig -p"%proc.name %fd.name" "evt.type=accept and proc.name!=httpd"
```

##### 容器
```
查看机器上运行的容器列表及其资源使用情况
sudo csysdig -vcontainers
查看容器上下文的进程列表
sudo csysdig -pc
查看运行在wordpress1容器里CPU的使用率
sudo sysdig -pc -c topprocs_cpu container.name=wordpress1
查看运行在wordpress1容器里网络带宽的使用率
sudo sysdig -pc -c topprocs_net container.name=wordpress1
查看在wordpress1容器里使用网络带宽最多的进程
sudo sysdig -pc -c topprocs_net container.name=wordpress1
查看在wordpress1 容器里占用 I/O 字节最多的文件
sudo sysdig -pc -c topfiles_bytes container.name=wordpress1
查看在wordpress1 容器里网络连接的排名情况
sudo sysdig -pc -c topconns container.name=wordpress1
显示wordpress1容器里所有命令执行的情况
sudo sysdig -pc -c spy_users container.name=wordpress1
```

##### 应用
```
查看机器所有的HTTP请求
sudo sysdig -s 2000 -A -c echo_fds fd.port=80 and evt.buffer contains GET
查看机器所有的SQL select查询
sudo sysdig -s 2000 -A -c echo_fds evt.buffer contains SELECT
See queries made via apache to an external MySQL server happening in real time
sysdig -s 2000 -A -c echo_fds fd.sip=192.168.30.5 and proc.name=apache2 and evt.buffer contains SELECT
```

##### 硬盘 I/O
```
查看使用硬盘带宽最多的进程
sysdig -c topprocs_file
列出使用大量文件描述符的进程
sysdig -c fdcount_by proc.name "fd.type=file"
See the top files in terms of read+write bytes
sysdig -c topfiles_bytes
Print the top files that apache has been reading from or writing to
sysdig -c topfiles_bytes proc.name=httpd
Basic opensnoop: snoop file opens as they occur
sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open
See the top directories in terms of R+W disk activity
sysdig -c fdbytes_by fd.directory "fd.type=file"
See the top files in terms of R+W disk activity in the /tmp directory
sysdig -c fdbytes_by fd.filename "fd.directory=/tmp/"
Observe the I/O activity on all the files named 'passwd'
sysdig -A -c echo_fds "fd.filename=passwd"
Display I/O activity by FD type
sysdig -c fdbytes_by fd.type
```

##### 进程和CPU使用率
```
See the top processes in terms of CPU usage
sysdig -c topprocs_cpu
See the top processes for CPU 0
sysdig -c topprocs_cpu evt.cpu=0
Observe the standard output of a process
sysdig -s4096 -A -c stdout proc.name=cat
```

##### 性能和错误
```
See the files where most time has been spent
sysdig -c topfiles_time
See the files where apache spent most time
sysdig -c topfiles_time proc.name=httpd
See the top processes in terms of I/O errors
sysdig -c topprocs_errors
See the top files in terms of I/O errors
sysdig -c topfiles_errors
See all the failed disk I/O calls
sysdig fd.type=file and evt.failed=true
See all the failed file opens by httpd
sysdig "proc.name=httpd and evt.type=open and evt.failed=true"
See the system calls where most time has been spent
sysdig -c topscalls_time
See the top system calls returning errors
sysdig -c topscalls "evt.failed=true"
snoop failed file opens as they occur
sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open and evt.failed=true
Print the file I/O calls that have a latency greater than 1ms:
sysdig -c fileslower 1
```

##### 安全
```
Show the directories that the user "root" visits
sysdig -p"%evt.arg.path" "evt.type=chdir and user.name=root"
Observe ssh activity
sysdig -A -c echo_fds fd.name=/dev/ptmx and proc.name=sshd
Show every file open that happens in /etc
sysdig evt.type=open and fd.name contains /etc
Show the ID of all the login shells that have launched the "tar" command
sysdig -r file.scap -c list_login_shells tar
Show all the commands executed by the login shell with the given ID
sysdig -r trace.scap.gz -c spy_users proc.loginshellid=5459 
```

### Grafana
```
安装
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.1.3_amd64.deb
sudo apt-get install -y adduser libfontconfig
sudo dpkg -i grafana_5.1.3_amd64.deb

启动Grafana服务
sudo service grafana-server start
启动grafana
systemctl start grafana-server
systemctl enable grafana-server

web登录,输入服务器IP地址，grafana默认端口为3000，默认用户名和密码都是admin
Web登录Grafana
http://ip:3000
默认账号密码 admin admin


安装Zabbix及图形样式插件
命令：
grafana-cli plugins install 软件包
添加一个zabbix的监控插件
其中的URL，填写http://10.x.x.21/zabbix/api_jsonrpc.php ，即之前在zabbix上执行过的json代码中的链接


Add Package Cloud key
curl https://packagecloud.io/gpg.key | sudo apt-key add -

Update&apt-transport-https package
apt-get update
apt-get install -y apt-transport-https

Service
systemctl daemon-reload
systemctl start grafana-server
systemctl status grafana-server


Grafana需要和zabbix_api接口进行交互并且获取数据展示
curl -i -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"user.login","params":{"user":"Admin","password":"admin"},"auth":null,"id":0}' http://10.x.x.21/zabbix/api_jsonrpc.php


HTTP/1.1 200 OK
Date: Wed, 15 Feb 2017 13:33:26 GMT
Server: Apache/2.4.6 (CentOS) PHP/5.4.16
X-Powered-By: PHP/5.4.16
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: Content-Type
Access-Control-Allow-Methods: POST
Access-Control-Max-Age: 1000
Content-Length: 68
Content-Type: application/json

#返回result如下这种sessionid表述访问是ok的
{"jsonrpc":"2.0","result":"800b578c7409de36aba0cd69704985dafa","id":0}


curl -i -X POST -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","method":"user.login","params":{"user":"Admin","password":"admin"},"auth":null,"id":0}' http://10.x.x.21/zabbix/api_jsonrpc.php



```

