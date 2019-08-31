
### center os

```
[root@iZ0xi3h306hbdom7k6ejmjZ ~]# yum --help
Loaded plugins: fastestmirror
Usage: yum [options] COMMAND

List of Commands:

check          Check for problems in the rpmdb
check-update   Check for available package updates
clean          Remove cached data
deplist        List a package's dependencies
distribution-synchronization Synchronize installed packages to the latest available versions
downgrade      downgrade a package
erase          Remove a package or packages from your system
fs             Acts on the filesystem data of the host, mainly for removing docs/lanuages for minimal hosts.
fssnapshot     Creates filesystem snapshots, or lists/deletes current snapshots.
groups         Display, or use, the groups information
help           Display a helpful usage message
history        Display, or use, the transaction history
info           Display details about a package or group of packages
install        Install a package or packages on your system
list           List a package or groups of packages
load-transaction load a saved transaction from filename
makecache      Generate the metadata cache
provides       Find what package provides the given value
reinstall      reinstall a package
repo-pkgs      Treat a repo. as a group of packages, so we can install/remove all of them
repolist       Display the configured software repositories
search         Search package details for the given string
shell          Run an interactive yum shell
swap           Simple way to swap packages, instead of using shell
update         Update a package or packages on your system
update-minimal Works like upgrade, but goes to the 'newest' package match which fixes a problem that affects your system
updateinfo     Acts on repository update information
upgrade        Update packages taking obsoletes into account
version        Display a version for the machine and/or available repos.


Options:
  -h, --help            show this help message and exit
  -t, --tolerant        be tolerant of errors
  -C, --cacheonly       run entirely from system cache, don't update cache
  -c [config file], --config=[config file]
                        config file location
  -R [minutes], --randomwait=[minutes]
                        maximum command wait time
  -d [debug level], --debuglevel=[debug level]
                        debugging output level
  --showduplicates      show duplicates, in repos, in list/search commands
  -e [error level], --errorlevel=[error level]
                        error output level
  --rpmverbosity=[debug level name]
                        debugging output level for rpm
  -q, --quiet           quiet operation
  -v, --verbose         verbose operation
  -y, --assumeyes       answer yes for all questions
  --assumeno            answer no for all questions
  --version             show Yum version and exit
  --installroot=[path]  set install root
  --enablerepo=[repo]   enable one or more repositories (wildcards allowed)
  --disablerepo=[repo]  disable one or more repositories (wildcards allowed)
  -x [package], --exclude=[package]
                        exclude package(s) by name or glob
  --disableexcludes=[repo]
                        disable exclude from main, for a repo or for
                        everything
  --disableincludes=[repo]
                        disable includepkgs for a repo or for everything
  --obsoletes           enable obsoletes processing during updates
  --noplugins           disable Yum plugins
  --nogpgcheck          disable gpg signature checking
  --disableplugin=[plugin]
                        disable plugins by name
  --enableplugin=[plugin]
                        enable plugins by name
  --skip-broken         skip packages with depsolving problems
  --color=COLOR         control whether color is used
  --releasever=RELEASEVER
                        set value of $releasever in yum config and repo files
  --downloadonly        don't update, just download
  --downloaddir=DLDIR   specifies an alternate directory to store packages
  --setopt=SETOPTS      set arbitrary config and repo options
  --bugfix              Include bugfix relevant packages, in updates
  --security            Include security relevant packages, in updates
  --advisory=ADVS, --advisories=ADVS
                        Include packages needed to fix the given advisory, in
                        updates
  --bzs=BZS             Include packages needed to fix the given BZ, in
                        updates
  --cves=CVES           Include packages needed to fix the given CVE, in
                        updates
  --sec-severity=SEVS, --secseverity=SEVS
                        Include security relevant packages matching the
                        severity, in updates

  Plugin Options:
```

`vi start.sh`
编辑脚本代码如下：
```
for((i=1;i<=10000000000;i++)) ; do
   find /data/digikey/800/ -type f |wc -l
   sleep 2
done
```
执行/root/start.sh & 运行脚本

```
查看磁盘空间
df -h
查看指定目录的大小
du -sh

排序文件夹和文件
du -s * | sort -nr | head
```

```
快速删除大量小文件方法
mkdir /tmp/empty
rsync --delete-before -d /tmp/empty/ /the/folder/you/want/delete/
```

```
查看某目录下的文件数量
find /data/digikey/800/ -type f | wc -l

统计文件大小为0的文件数量
find /data/digikey/800/ -type f -size 0 | wc -l

查找大于100M的文件
find /data/digikey/800/ -size +100M -exec ls -lh {} \

删除文件
rm -rf 文件名
rm -f /opt/log/big.log

删除文件大小为0k的文件
find /data/digikey/800 -name "*" -type f -size 0c | xargs -n 1 rm -f
查找0字节文件并删除
find /data/digikey/800 -type f -size 0 -exec rm -rf {} \

删除大于50M的文件,不带-type f 会将目录页删除，如果当前路径位于该目录下会提示该目录不能删除的提示
find /data/digikey/800 -size +50M -exec rm {} \;

删除文件大小大于1k的文件
find /data/digikey/800/ -type f -size +1c -exec rm -f {} \;

查找某段时间内（365为天数）的文件并删除
find /data/digikey/800 -ctime +365 -exec rm -rf {} \

删除10天前的所有该目录下的文件
find /data/digikey/800 -mtime +10 -name "*.*" -exec rm -Rf {} ;

删除文件大小为1k大小的文件
find /data/digikey/800 -name "*" -type f -size 1024c | xargs -n 1 rm -f

删除文件占用空间为1k大小的文件
find /data/digikey/800 -name "*" -type f -size 1k | xargs -n 1 rm -f

查询所有的空文件夹
find -type d -empty

删除/data/digikey/800文件夹下的所有.pdf的文件
find /data/digikey/800 -name "*.pdf" | xargs rm -f

列出搜索到的文件
find /data/digikey/800 -name "shufa.txt" -exec ls {}

批量删除搜索到的文件
find /data/digikey/800 -name "shufa.txt" -exec rm -f {}
批量删除搜索到的文件包含名称ssss所有的文件，如果要连同目录一起删除，加-r参数
find /data/digikey/800 -name "*ssss*" | xargs rm -f

批量删除搜索到的文件(删除前有提示)
find /data/digikey/800 -name "shufa.txt" -ok rm -rf {}

删除目录下面所有 test 文件夹下面的文件
find /data/digikey/800 -name "test" -type d -exec rm -rf {}

删除文件夹下面的所有的.svn文件
find /data/digikey/800 -name '.svn' -exec rm -rf {}

删除某个文件夹下及该文件夹下所有子文件夹中的某种文件
find /data/digikey/800 -type f -iname "*_w*.jpg" -exec rm -rf {} \

注:
1.{}和前面之间有一个空格 
2.find . -name 之间也有空格 
3.exec 是一个后续的命令,{}内的内容代表前面查找出来的文件
```

```
清空文本文件内容
echo "" > /data/aaa.log
clear > /opt/log/big.log
true > /opt/log/big.log
flase > /opt/log/big.log
: > /opt/log/big.log
```


```
sudo su -

sudo ln -s /data1/digikey_pdf/ pdf
```


一：使用CentOS常用命令查看cpu
more /proc/cpuinfo | grep “model name”
grep “model name” /proc/cpuinfo
[root@localhost /]# grep “CPU” /proc/cpuinfo
model name : Intel(R) Pentium(R) Dual CPU E2180 @ 2.00GHz
model name : Intel(R) Pentium(R) Dual CPU E2180 @ 2.00GHz
如果觉得需要看的更加舒服
grep “model name” /proc/cpuinfo | cut -f2 -d:

二：使用CentOS常用命令查看内存
grep MemTotal /proc/meminfo

grep MemTotal /proc/meminfo | cut -f2 -d:

free -m |grep “Mem” | awk ‘{print $2}’

三：使用CentOS常用命令查看cpu是32位还是64位 
查看CPU位数(32 or 64)
getconf LONG_BIT

四：使用CentOS常用命令查看当前linux的版本 
more /etc/redhat-release
cat /etc/redhat-release

五：使用CentOS常用命令查看内核版本 
uname -r
uname -a

六：使用CentOS常用命令查看当前时间 
date上面已经介绍如何同步时间了

七：使用CentOS常用命令查看硬盘和分区 
df -h
fdisk -l
也可以查看分区
du -sh
可以看到全部占用的空间
du /etc -sh
可以看到这个目录的大小

八：使用CentOS常用命令查看安装的软件包 
查看系统安装的时候装的软件包
cat -n /root/install.log
more /root/install.log | wc -l
查看现在已经安装了那些软件包
rpm -qa
rpm -qa | wc -l
yum list installed | wc -l
不过很奇怪，我通过rpm，和yum这两种方式查询的安装软件包，数量并不一样。没有找到原因。

九：使用CentOS常用命令查看键盘布局
cat /etc/sysconfig/keyboard
cat /etc/sysconfig/keyboard | grep KEYTABLE | cut -f2 -d=

十：使用CentOS常用命令查看selinux情况 
sestatus
sestatus | cut -f2 -d:
cat /etc/sysconfig/selinux

十一：使用CentOS常用命令查看ip，mac地址
在ifcfg-eth0 文件里你可以看到mac，网关等信息。
ifconfig
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep IPADDR
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep IPADDR | cut -f2
-d
=

ifconfig
eth0 |grep “inet addr:” |awk ‘{print $2}’|cut -c 6-

ifconfig | grep ‘inet addr:’| grep -v ‘127.0.0.1’ | cut -d: -f2 | awk ‘{ print $1}’

查看网关

cat /etc/sysconfig/network

查看dns

cat /etc/resolv.conf

十二：使用CentOS常用命令查看默认语言
echo $LANG $LANGUAGE
cat /etc/sysconfig/i18n

十三：使用CentOS常用命令查看所属时区和是否使用UTC时间 
cat /etc/sysconfig/clock

十四：使用CentOS常用命令查看主机名
hostname
cat /etc/sysconfig/network
修改主机名就是修改这个文件，同时最好也把host文件也修改。

十五：使用CentOS常用命令查看 系统资源使用情况 ( 开机运行时间 ) 
uptime
09:44:45 up 67 days, 23:32, …
看来刚才确实是网段的问题，我的机器还是67天前开机的。
#系统资源使用情况

vmstat 1 -S m

procs ———–memory———- —swap– —–io—- –system– —–cpu——

r b swpd free buff cache si so bi bo in cs us sy id wa st

0 0 0 233 199 778 0 0 4 25 1 1 3 0 96 0 0

0 0 0 233 199 778 0 0 0 0 1029 856 13 1 86 0 0

十六：实用命令
wget 网址 下载资源
tar zxvf 压缩包名称 解压
hostname or cat /etc/sysconfig/network 查看主机名
pkill mysqld 如何杀死mysql进程
find / -type f -size +100000k -ls 查询大小超过100M的文件

十七：CentOS文件常用命令
创建/改变文件系统的CentOS常用命令

NO1. 创建文件系统类型
[root@rehat root]# umount /dev/sdb1
[root@rehat root]# mkfs -t ext3 /dev/db1
[root@rehat root]# mount /dev/sdb1 /practice

改变文件或文件夹权限的CentOS常用命令

chmod
NO1. 将自己的笔记设为只有自己才能看
[root@rehat root]# chmod go-rwx test.txt
或者
[root@rehat root]# chmod 700 test.txt
NO2. 同时修改多个文件的权限
[root@rehat root]# chmod 700 test1.txt test2.txt
NO3. 修改一个目录的权限，包括其子目录及文件
[root@rehat root]# chmod 700 -R test

改变文件或文件夹拥有者的CentOS常用命令

chown 该命令只有 root 才能使用
NO1. 更改某个文件的拥有者
[root@rehat root]# chown jim:usergroup test.txt
NO2. 更改某个目录的拥有者,并包含子目录
[root@rehat root]# chown jim:usergroup -R test

查看文本文件内容的CentOS常用命令

cat
NO1. 查看文件内容，并在每行前面加上行号
[root@rehat root]# cat -n test.txt
NO2. 查看文件内容，在不是空行的前面加上行号
[root@rehat root]# cat -b test.txt
NO3. 合并两个文件的内容
[root@rehat root]# cat test1.txt test2.txt > test_new.txt
NO4. 全并两具文件的内容，并追回到一个文件
[root@rehat root]# cat test1.txt test2.txt >> test_total.txt
NO5. 清空某个文件的内容
[root@rehat root]# cat /dev/null > test.txt
NO6. 创建一个新的文件
[root@rehat root]# cat > new.txt 按 CTRL + C 结束录入

编辑文件文件的CentOS常用命令

vi
NO1. 新建档案文件
[root@rehat root]# vi newfile.txt
NO2. 修改档案文件
[root@rehat root]# vi test.txt test.txt 已存在
NO3. vi 的两种工作模式：命令模式，编辑模式
NO4. 进入 vi 后为命令模式，按 Insrt 键进入编辑模式
按 ESC 进入命令模式，在命令模式不能编辑，只能输入命令
NO5. 命令模式常用命令
:w 保存当前文档
:q 直接退出 vi
:wq 先保存后退出 。

十八：批量替换文件
今天使用svn进行系统迁移，结果发现最初的路径写错了，导致无法访问源服务器，查看 .svn/entries 大致了解了一下里面的内容。重新迁移时间太久了，还是直接把文件替换掉吧

for f in $(find ./ -type f -name ‘entries’)
do
sed -i “s/202\.68\.134\.18/202\.68\.134\.34/g” $f
done

sed 简单说明:

sed “s/sourcestring/newstring/g” $f

把 $f 文件中的 sourcestring 换成 newstring，输出到终端。s 表示搜索替换，/g表示全局。

sed -i $f

表示直接在 $f 中修改。

sed -iback $f

表示修改后的文件另存为 $fback

sed 中所有正则表达式都必须使用严格的转义符 \ 来限定

sed 的正则比较严格： ” \ / ! 都需要分别用 \” \/ \\ \! 转义。

\n 表示换行

十九. shell 变量 字符串操作
mono 跑在linux下时，apache+mod_mono有时候需要加载的 Assembly 必须配置在 GAC 中，下面是一个脚本完成此功能

cd bin

for f in $(find ./ -name “*.dll”)

do

gacutil -i $f

done

如果要从 GAC 中批量卸载这些 Assembly, 可以如下

for f in $(ls *.dll)

do

gacutil -u ${f%%.dll}

done

其中就用到了字符串变量的替换， ${f%%.dll}

${f%%.dll} 的意义为 删除 $f 变量 .dll 及之后的所有内容

相关的变量操作还有:

${f##.} 等，后面再补充

二十、 查看当前连接

netstat -an

二十一、有关重启
shutdown -r now 　 重新启动系统，使设置生效
shutdown -h now 关机
reboot 重启
poweroff 关机

二十二、开机自启动设置
编辑rc.local文件
#vim /etc/rc.d/rc.local

# du -sh # 查看指定目录的大小

# uptime # 查看系统运行时间、用户数、负载

# cat /proc/loadavg # 查看系统负载

# iptables -L # 查看防火墙设置
# route -n # 查看路由表
# netstat -lntp # 查看所有监听端口
# netstat -antp # 查看所有已经建立的连接
# netstat -s # 查看网络统计信息

# w # 查看活动用户
# id # 查看指定用户信息
# last # 查看用户登录日志
# cut -d: -f1 /etc/passwd # 查看系统所有用户
# cut -d: -f1 /etc/group # 查看系统所有组
# crontab -l # 查看当前用户的计划任务
# chkconfig –list # 列出所有系统服务
# chkconfig –list | grep on # 列出所有启动的系统服务



关键字: linux 查进程、杀进程、起进程
1.查进程
    ps命令查找与进程相关的PID号：
    ps a 显示现行终端机下的所有程序，包括其他用户的程序。
    ps -A 显示所有程序。
    ps c 列出程序时，显示每个程序真正的指令名称，而不包含路径，参数或常驻服务的标示。
    ps -e 此参数的效果和指定"A"参数相同。
    ps e 列出程序时，显示每个程序所使用的环境变量。
    ps f 用ASCII字符显示树状结构，表达程序间的相互关系。
    ps -H 显示树状结构，表示程序间的相互关系。
    ps -N 显示所有的程序，除了执行ps指令终端机下的程序之外。
    ps s 采用程序信号的格式显示程序状况。
    ps S 列出程序时，包括已中断的子程序资料。
    ps -t<终端机编号> 指定终端机编号，并列出属于该终端机的程序的状况。
    ps u 以用户为主的格式来显示程序状况。
    ps x 显示所有程序，不以终端机来区分。
   
    最常用的方法是ps aux,然后再通过管道使用grep命令过滤查找特定的进程,然后再对特定的进程进行操作。
    ps aux | grep program_filter_word,ps -ef |grep tomcat

ps -ef|grep java|grep -v grep 显示出所有的java进程，去处掉当前的grep进程。
   
2.杀进程
   使用kill命令结束进程：kill xxx
   常用：kill －9 324
   Linux下还提供了一个killall命令，可以直接使用进程的名字而不是进程标识号，例如：# killall -9 NAME

3.进入到进程的执行文件所在的路径下，执行文件 ./文件名

附：

这是本人花了两天时间整理得来的，一些最常用的地球人都知道的命令就省去啦！最后提供pdf手册下载 

1. 更改档案拥有者 
命令 : chown [-cfhvR] [--help] [--version] user[:group] file... 
功能 : 更改文件或者文件夹的拥有者 
参数格式 : 
　　    user : 新的档案拥有者的使用者 IDgroup : 新的档案拥有者的使用者群体(group) 
　　       -c : 若该档案拥有者确实已经更改，才显示其更改动作 
　　       -f : 若该档案拥有者无法被更改也不要显示错误讯息 
　　       -h : 只对于连结(link)进行变更，而非该 link 真正指向的档案 
　　       -v : 显示拥有者变更的详细资料 
　       　-R : 对目前目录下的所有档案与子目录进行相同的拥有者变更(即以递回的方式逐个变更) 

例如：chown -R oracle:oinstall /oracle/u01/app/oracle  
      更改目录拥有者为oracle 

2. 修改权限 
    命令：chmod (change mode) 
    功能：改变文件的读写和执行权限。有符号法和八进制数字法。 
    选项：(1)符号法： 
  命令格式：chmod {u|g|o|a}{+|-|=}{r|w|x} filename 
          u (user)   表示用户本人。 
          g (group)  表示同组用户。 
          o (oher)   表示其他用户。 
          a (all)    表示所有用户。 
          +          用于给予指定用户的许可权限。 
          -          用于取消指定用户的许可权限。 
          =          将所许可的权限赋给文件。 
          r (read)   读许可，表示可以拷贝该文件或目录的内容。 
          w (write)  写许可，表示可以修改该文件或目录的内容。 
          x (execute)执行许可，表示可以执行该文件或进入目录。 
  
          (2)八进制数字法：   
  命令格式：chmod abc file 
  其中a,b,c各为一个八进制数字，分别表示User、Group、及Other的权限。 
          4 (100)    表示可读。 
          2 (010)    表示可写。 
          1 (001)    表示可执行。 
  若要rwx属性则4+2+1=7； 
  若要rw-属性则4+2=6； 
  若要r-x属性则4+1=5。 

    例如：# chmod a+rx filename 
            让所有用户可以读和执行文件filename。 
          # chmod go-rx filename 
            取消同组和其他用户的读和执行文件filename的权限。 
          # chmod 741 filename 
            让本人可读写执行、同组用户可读、其他用户可执行文件filename。 
  # chmod -R 755 /home/oracle 
    递归更改目录权限，本人可读写执行、同组用户可读可执行、其他用户可读可执行 

3. 修改文件日期 
    命令：touch 
    格式：touch filenae 
    功能：改变文件的日期，不对文件的内容做改动，若文件不存在则建立新文件。 
    例如：% touch file 

4. 链接文件 
    命令：ln (link) 
    格式：ln [option] filename linkname 
          ln [option] directory pathname 
    功能：为文件或目录建立一个链。其中，filename和directory是源文件名和 
          源目录名；linkname和pathname分别表示与源文件或源目录名相链接的 
          文件或目录。 
    选项：-s  为文件或目录建立符号链接。不加-s表示为文件或目录建立硬链接 
    注释：链接的目地在于，对一个文件或目录赋予两个以上的名字，使其可以出 
          现在不同的目录中，既可以使文件或目录共享，又可以节省磁盘空间。 
    例如：% ln -s filename linkname 

5. 显示日期 
    命令：date 
    例如：% date 

6. 显示日历 
    命令：cal (calendar) 
    格式：cal [month] year 
    功能：显示某年内指定的日历 
    例如：% cal 1998  

7. 显示文件头部 
    命令：head 
    格式：head [option] filename 
    功能：显示文件的头部 
    选项：缺省  显示文件的头10行。 
          -i    显示文件的开始 i行。 
    例如：% head filename 

8. 显示文件尾部 
    命令：tail 
    格式：tail [option] filename 
    功能：显示文件的尾部 
    选项：缺省  显示文件的末10行。 
          -i    显示文件最后 i行。 
          +i    从文件的第i行开始显示。 
    例如：% tail filename 

9. 显示用户标识 
    命令：id 
    格式：id [option] [user] 
    功能：显示用户标识及用户所属的所有组。 
    选项：-a 显示用户名、用户标识及用户所属的所有组 
    注释： 
    例如：% id username 

10. 查看当前登录的用户 
    命令：users 

11. 显示都谁登录到机器上 
    命令：who 
    格式：who 
    功能：显示当前正在系统中的所有用户名字，使用终端设备号，注册时间。 
    例如：% who 

12. 显示当前终端上的用户名 
    命令：whoami 
    格式：whoami 
    功能：显示出当前终端上使用的用户。 
    例如：% whoami 

13. 寻找文件 
    命令：find 
    格式：find pathname [option] expression 
    功能：在所给的路经名下寻找符合表达式相匹配的文件。 
    选项：-name     表示文件名 
          -user     用户名，选取该用户所属的文件 
          -size     按大小查找，以block为单位，一个block是512B 
          -mtime n  按最后一次修改时间查找，选取n天内被修改的文件 
  -perm     按权限查找 
          -type     按文件类型查找 
  -atime    按最后一次访问时间查找 

    例如：% find ./ -name '*abc*' -print 

14. 搜索文件中匹配符 
    命令：grep 
    格式：grep [option] pattern filenames 
    功能：逐行搜索所指定的文件或标准输入，并显示匹配模式的每一行。 
    选项：-i    匹配时忽略大小写 
  -v 找出模式失配的行 

    例如：% grep -i 'java*' ./test/run.sh 

15. 统计文件字数 
    命令：wc [option] filename 
    功能：统计文件中的文件行数、字数和字符数。 
    选项：-l 统计文件的行数 
-w 统计文件的单词数 
-c 统计文件的字符数 
    注释：若缺省文件名则指标准输入 
    例如：% wc -c ./test/run.sh 

16. 显示磁盘空间 
    命令：df (disk free) 
    格式：df [option] 
    功能：显示磁盘空间的使用情况，包括文件系统安装的目录名、块设备名、总 
          字节数、已用字节数、剩余字节数占用百分比。 
    选项： 
-a：显示全部的档案系统和各分割区的磁盘使用情形 
-i：显示i -nodes的使用量 
-k：大小用k来表示 (默认值) 
-t：显示某一个档案系统的所有分割区磁盘使用量 
-x：显示不是某一个档案系统的所有分割区磁盘使用量 
-T：显示每个分割区所属的档案系统名称 
-h: 表示使用「Human-readable」的输出，也就是在档案系统大小使用 GB、MB 等易读的格式。 
    注释： 
    例如：% df -hi 

17. 查询档案或目录的磁盘使用空间 
    命令：du (disk usage) 
    格式：du [option] [filename] 
    功能：以指定的目录下的子目录为单位，显示每个目录内所有档案所占用的磁盘空间大小 
    选项： 
-a：显示全部目录和其次目录下的每个档案所占的磁盘空间 
-b：大小用bytes来表示 (默认值为k bytes) 
-c：最后再加上总计 (默认值) 
-s：只显示各档案大小的总合 
-x：只计算同属同一个档案系统的档案 
-L：计算所有的档案大小 
-h: 表示档案系统大小使用 GB、MB 等易读的格式。 
    例如：% du -a 
% du -sh /etc 只显示该目录的总合 
% du /etc | sort -nr | more 统计结果用sort 指令进行排序， 
sort 的参数 -nr 表示要以数字排序法进行反向排序。 

18. 显示进程 
    命令：ps 
    格式：ps [option] 
    功能：显示系统中进程的信息。包括进程ID、控制进程终端、执行时间和命令。 
    选项： 
  -a 显示所有进程信息 
  -U uidlist 列出这个用户的所有进程 
          -e 显示当前运行的每一个进程信息 
          -f 显示一个完整的列表 
  -x 显示包括没有终端控制的进程状况 。 
    注释：      例如：% ps -ef    % ps -aux 然后再利用一个管道符号导向到grep去查找特定的进程,然后再对特定的进程进行操作。  19. 终止进程      命令：kill      格式：kill [option] pid      功能：向指定的进程送信号或终止进程。kill指令的用途是送一个signal给某一个process，      因为大部份送的都是用来杀掉 process 的 SIGKILL 或 SIGHUP ，因此称为 kill       选项：-9  强行终止进程      注释：pid标示进程号，可由ps命令得到。      例如：% kill -9 pid      你也可以用 kill -l 来察看可代替 signal 号码的数目字。kill 的详细情形请参阅 man kill。  20. 查看自己的IP地址      命令：ifconfig      格式：ifconfig -a      21. 查看路由表      命令：netstat      格式：netstat -rn  22. 远程登录      命令：telnet      格式：telnet hostname  23. 文件传输      命令：ftp (file transfer program)      格式：ftp hostname      功能：网络文件传输及远程操作。      选项：ftp命令：             cd [dirname]  进入远程机的目录             lcd [dirname] 设置本地机的目录             dir/ls        显示远程的目录文件             bin           以二进制方式进行传输     asc           以文本文件方式进行传输             get/mget      从远程机取一个或多个文件             put/mput      向远程机送一个或多个文件             prompt        打开或关闭多个文件传送时的交互提示             close         关闭与远程机的连接             quit          退出ftp     !/exit ftp登陆状态下，!表示暂时退出ftp状态回到本地目录，exit表示返回ftp状态      注释：      例如：% ftp hostname  24. 查看自己的电子邮件      命令：mailx      格式：mailx      选项：  delete  删除  next    下一个  quit    退出           reply   回复     25. 回忆命令      命令：history      格式：history      功能：帮助用户回忆执行过的命令。      选项：      注释：      例如：% history  26. 网上对话      命令：talk      格式：talk username      功能：在网上与另一用户进行对话。      选项：      注释：对话时系统把终端分为上下两部分，上半部显示自己键入信息，下半部            显示对方用户键入的信息。键入delete或Ctrl+C则结束对话。      例如：% talk username  27. 允许或拒绝接受信息      命令：mesg (message)      格式：mesg [n/y]      功能：允许或拒绝其它用户向自己所用的终端发送信息。      选项：n 拒绝其它用户向自己所用的终端写信息            y 允许其它用户向自己所用的终端写信息（缺省值）      注释：      例如：% mesg n  28. 给其他用户写信息      命令：write      格式：write username [ttyname]      功能：给其他用户的终端写信息。      选项：      注释：若对方没有拒绝，两用户可进行交谈，键入EOF或Ctrl+C则结束对话。      例如：write username  29. 创建、修改、删除用户和群组      a. 创建群组：  例如： groupadd oinstall    创建群组名为oinstall的组  groupadd -g 344 dba   创建组号是344的组，此时在/etc/passwd文件中产生一个组ID（GID）是344的项目。      b. 修改群组：  groupmod:该命令用于改变用户组帐号的属性  groupmod –g 新的GID 用户组帐号名  groupmod –n 新组名 原组名：此命令由于改变用户组的名称      c. 删除群组：  groupdel 组名：该命令用于删除指定的组帐号      d. 新建用户：  命令： useradd [－d home] [－s shell] [－c comment] [－m [－k template]]  [－f inactive] [－e expire ] [－p passwd] [－r] name  主要参数  -c：加上备注文字，备注文字保存在passwd的备注栏中。　  -d：指定用户登入时的启始目录。  -D：变更预设值。  -e：指定账号的有效期限，缺省表示永久有效。  -f：指定在密码过期后多少天即关闭该账号。  -g：指定用户所属的群组。  -G：指定用户所属的附加群组。  -m：自动建立用户的登入目录。  -M：不要自动建立用户的登入目录。  -n：取消建立以用户名称为名的群组。  -r：建立系统账号。  -s：指定用户登入后所使用的shell。  -u：指定用户ID号。  举例： # useradd -g oinstall -G dba oracle  创建Oracle用户           e. 删除用户  命令： userdel 用户名  删除指定的用户帐号  userdel –r 用户名(userdel 用户名;rm 用户名)：删除指定的用户帐号及宿主目录  例：#useradd -g root kkk //把kkk用户加入root组里      f. 修改用户  命令： usermod 修改已有用户的信息  usermod –l 旧用户名 新用户名： 修改用户名  usermod –L 用户名： 用于锁定指定用户账号，使其不能登陆系统  usermod –U 用户名： 对锁定的用户帐号进行解锁  passwd –d 用户名： 使帐号无口令，即用户不需要口令就能登录系统  例：#usermod -l user2 user1 //把用户user2改名为user1  30. 启动、关闭防火墙  永久打开或则关闭  chkconfig iptables on  chkconfig iptables off  即时生效：重启后还原  service iptables start  service iptables stop       或者：  /etc/init.d/iptables start  /etc/init.d/iptables stop  31. 启动VSFTP服务  即时启动： /etc/init.d/vsftpd start  即时停止： /etc/init.d/vsftpd stop  开机默认VSFTP服务自动启动:  方法一:(常用\方便)  [root@localhost etc]# chkconfig --list|grep vsftpd ( 查看情况)  vsftpd          0:off   1:off   2:off   3:off   4:off   5:off   6:off  [root@localhost etc]# chkconfig vsftpd on  (执行ON设置)  或者:方法二:  修改文件 /etc/rc.local , 把行/usr/local/sbin/vsftpd & 插入文件中，以实现开机自动启动。  32. vi技巧  a. 进入输入模式  新增 (append)  a ：从光标所在位置後面开始新增资料，光标後的资料随新增资料向後移动。  A：从光标所在列最後面的地方开始新增资料。  插入 (insert)  i：从光标所在位置前面开始插入资料，光标後的资料随新增资料向後移动。  I ：从光标所在列的第一个非空白字元前面开始插入资料。  开始 (open)  o ：在光标所在列下新增一列并进入输入模式。  O: 在光标所在列上方新增一列并进入输入模式。  b. 退出vi  在指令模式下键入:q,:q!,:wq或:x(注意:号），就会退出vi。其中:wq和:x是存盘退出，而:q是直接退出，如果文件已有新的变化，vi会提示你保存文件而:q命令也会失效，这时你可以用:w命令保存文件后再用:q 退出，或用:wq或:x命令退出，如果你不想保存改变后的文件，你就需要用:q!命令，这个命令将不保存文件而直接退出vi。  c. 删除与修改文件的命令：  x：删除光标所在字符。  dd ：删除光标所在的列。  r ：修改光标所在字元，r 後接著要修正的字符。  R：进入取替换状态，新增文字会覆盖原先文字，直到按 [ESC] 回到指令模式下为止。  s：删除光标所在字元，并进入输入模式。  S：删除光标所在的列，并进入输入模式。  d. 屏幕翻滚类命令  Ctrl+u: 向文件首翻半屏  Ctrl+d: 向文件尾翻半屏  Ctrl+f: 向文件尾翻一屏  Ctrl＋b: 向文件首翻一屏  nz: 将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部。  e. 删除命令  ndw或ndW: 删除光标处开始及其后的n-1个字  do: 删至行首  d$: 删至行尾  ndd: 删除当前行及其后n-1行  x或X: 删除一个字符，x删除光标后的，而X删除光标前的  Ctrl+u: 删除输入方式下所输入的文本  f. 搜索及替换命令  /pattern: 从光标开始处向文件尾搜索pattern  ?pattern: 从光标开始处向文件首搜索pattern  n: 在同一方向重复上一次搜索命令  N: 在反方向上重复上一次搜索命令  :s/p1/p2/g: 将当前行中所有p1均用p2替代  :n1,n2s/p1/p2/g: 将第n1至n2行中所有p1均用p2替代  :g/p1/s//p2/g: 将文件中所有p1均用p2替换  g. 复制，黏贴  (1) 选定文本块，使用v进入可视模式；移动光标键选定内容  (2) 复制选定块到缓冲区，用y；复制整行，用yy  (3) 剪切选定块到缓冲区，用d；剪切整行用dd  (4) 粘贴缓冲区中的内容，用p  h. 其他  在同一编辑窗打开第二个文件，用:sp [filename]  在多个编辑文件之间切换，用Ctrl+w