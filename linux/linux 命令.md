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
cat a.txt

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
```
1. 修改chfweb文件夹权限为777
sudo chmod 777 chfweb
sudo chmod 777 /data1/from_163/digikey_pdf6/ -R
2. 修改文件夹chfweb以及子文件夹和子文件的权限为777
sudo chmod -R 777 chfweb
3. 增加组
`sudo groupadd --system webapps`

4. 增加用户
用户名为user_test
`sudo useradd --system --gid webapps --shell /bin/bash --home /webapps/test user_test`

设置密码为：test
`passwd test`

5. 给用户赋值权限
创建用户目录
`mkdir -p /webapps/test`
修改目录权限，下面的命令意思是：使/webapps/test/这个目录属于user_test这个用户
`chown user_test /webapps/test/`

添加用户user_test sudo权限 
在/etc/sudoers添加 
使用命令vim /etc/sudoers打开/etc/sudoers 
在里面添加下面这一句：
`user_test ALL=(ALL:ALL) ALL`
使用:wq!强制保存

切换用户为：user_test
`su - user_test`

6. 修改python默认版本
```
调整优先级
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --config python3
```
7. 


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


