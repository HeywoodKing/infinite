# center

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

### shell 脚本
eg:
```
统计/data/digikey/800/目录下的文件数量
vi start.sh

for((i=1;i<=10000000000;i++)) ; do
   find /data/digikey/800/ -type f |wc -l
   sleep 2
done
```

执行脚本
```
/root/start.sh & 
```

### 常用命令

+ 查看磁盘空间
```
df -h
```

+ 查看整个硬盘的使用状况，硬盘空间
```
du [-abcDhHklmsSx] [-L <符号连接>] [--block-size] [--exclude=<目录或文件>] [--max-depth=<目录层数>] [目录或文件]
选项介绍:
-a: 显示目录中个别文件的大小;
-b: 显示目录或文件大小时，以byte为单位;
-c: 除了显示个别目录或文件的大小外，同时也显示所有目录或文件的总和;
-D: 显示指定符号连接的源文件大小;
-h: 以K，M，G为单位，提高信息的可读性;
-H: 与-h参数相同，但是K，M，G是以1000为换算单位;
-k: 以1024 bytes为单位;
-l: 重复计算硬链接文件;
-L<符号连接>: 显示选项中所指定符号链接(软链接)的源文件大小;
-m: 以1MB为单位;
-s: 显示总计大小;
-S: 显示个别目录的大小时，并不含其子目录的大小;
-x: 以一开始处理时的文件系统为准，若遇上其它不同的文件系统目录则略过;
–exclude=<目录或文件>: 略过指定的目录或文件;
–max-depth=<目录层数>: 超过指定层数的目录后，予以忽略;
eg:
du ./  要显示一个目录树及其每个子树的磁盘使用情况
du -k /home/linux  要通过以1024字节为单位显示一个目录树及其每个子树的磁盘使用情况
du -m /home/linux  以MB为单位显示一个目录树及其每个子树的磁盘使用情况
du -g /home/linux  以GB为单位显示一个目录树及其每个子树的磁盘使用情况
du -h –exclude='*xyz*'  列出当前目录中的目录名不包括xyz字符串的目录的大小
du -ah user  列出user目录及其子目录下所有目录和文件的大小
du -0h user  想在一个屏幕下列出更多的关于user目录及子目录大小的信息
-0（杠零）表示每列出一个目录的信息，不换行，而是直接输出下一个目录的信息

查看指定目录的大小
du -sh .  统计当前目录的大小，以直观方式展现
du -sh /boot
du -sh ./*   统计当前目录下各个目录以及子目录大小

查看linux文件目录的大小和文件夹包含的文件数
du -sh xmldb/ 统计总数大小
du -sm * | sort -n 统计当前目录大小 并安大小 排序
du -sk * | sort -n
du -sk * | grep guojf 看一个人的大小
du -m | cut -d "/" -f 2 看第二个/ 字符前的文字

du -h --max-depth=1 |grep 'G' |sort   #查看上G目录并排序
du -h --max-depth=1 |sort    #查看当前目录下所有一级子目录文件夹大小 并排序
du -h --max-depth=1 |grep [TG] |sort -nr   #倒序排
du -sh --max-depth=1  #查看当前目录下所有一级子目录文件夹大小

常用参数：
-a或-all  为每个指定文件显示磁盘使用情况，或者为目录中每个文件显示各自磁盘使用情况。
-b或-bytes 显示目录或文件大小时，以byte为单位。
-c或–total 除了显示目录或文件的大小外，同时也显示所有目录或文件的总和。
-D或–dereference-args 显示指定符号连接的源文件大小。
-h或–human-readable 以K，M，G为单位，提高信息的可读性。
-H或–si 与-h参数相同，但是K，M，G是以1000为换算单位,而不是以1024为换算单位。
-k或–kilobytes 以1024 bytes为单位。
-l或–count-links 重复计算硬件连接的文件。
-L<符号连接>或–dereference<符号连接> 显示选项中所指定符号连接的源文件大小。
-m或–megabytes 以1MB为单位。
-s或–summarize 仅显示总计，即当前目录的大小。
-S或–separate-dirs 显示每个目录的大小时，并不含其子目录的大小。
-x或–one-file-xystem 以一开始处理时的文件系统为准，若遇上其它不同的文件系统目录则略过。
-X<文件>或–exclude-from=<文件> 在<文件>指定目录或文件。
–exclude=<目录或文件> 略过指定的目录或文件。
–max-depth=<目录层数> 超过指定层数的目录后，予以忽略。
–help 显示帮助。
–version 显示版本信息。

查看此文件夹有多少文件 /*/*/* 有多少文件
du xmldb/
du xmldb/*/*/* |wc -l
40752

解释：
wc [-lmw]
参数说明：
-l :多少行
-m:多少字符
-w:多少字

排序文件夹和文件
-s 这个参数的作用就是仅显示总计，即当前文件夹的大小
* 可以将当前目录下所有文件的大小给列出来
du -sh *
du -sh * | sort -nr  这个排序是不正确的，因为-h的原因
du -s * | sort -nr
du -s * | sort -nr | head 选出排在前面的10个
du -s * | sort -nr | tail 选出排在后面的10个


查看某文件夹占用总的空间大小
du -h --max-depth=1 /usr/local/
```

+ 查看当前文件夹下面各个文件的大小
```
ll -lh
```

+ 快速删除大量小文件方法
```
mkdir /tmp/empty
rsync --delete-before -d /tmp/empty/ /the/folder/you/want/delete/
```

+ find 命令用于按照指定条件来查找文件
```
一些比较常用参数如下表：
| 参数 |  作用 |
| ---- | ---- |
| -name | 匹配名称 |
| -perm | 匹配权限mode为完全匹配( –mode包含即可)
| -user | 匹配所有者
| -group | 匹配所有组
| -mtime –n +n | 匹配修改内容时间（-n n天以内 +n n天之前）
| -atime –n +n | 匹配访问内容时间（-n n天以内 +n n天之前）
| -ctime –n +n | 匹配修改文件权限时间(-n n天以内 +n n天之前)
| -nouser | 匹配无所有者文件
| -nogroup | 匹配无所有组文件
| -newer file1 !file2 | 匹配比file1新 比file2旧的文件
| -type b/d/c/p/l/f | 匹配文件类型（参数依次块设备、目录、字符设备、管道、链接文件、文本文件）
| -size | 匹配文件的大小（+为超过设定值大小的文件，-为小于设定值大小的文件）
| -prune | 忽略某个目录
| -exec ………… {} \; | 后面可跟用于进一步处理搜索结果的命令

搜索当前目录下的文件名包含Xen的文件夹
find . -name Xen* -exec ls {} \;

搜索当前目录下的文件名包含502的文件
find . -type f -name 502* -exec ls {} \;

查找当前目录下文件名为 591014.txt 的文件
find . -type f -name "591014.txt" -exec ls {} \;
find ./ -name "591014.txt" -exec ls {} \;

查看某目录下的文件数量(非链接文件数量)
find /data/digikey/800/ -type f | wc -l

查看某目录下的文件数量(链接文件数量)
find /data/digikey/800/ -type l | wc -l

统计文件大小为0的文件数量
find /data/digikey/800/ -type f -size 0 | wc -l

查找大于100M的文件
find /data/digikey/800/ -size +100M -exec ls -lh {} \;

删除文件大小为0k的文件
find /data/digikey/800 -name "*" -type f -size 0c | xargs -n 1 rm -f

查找0字节文件并删除
find /data/digikey/800 -type f -size 0 -exec rm -rf {} \;

删除大于50M的文件,不带-type f 会将目录页删除，如果当前路径位于该目录下会提示该目录不能删除的提示
find /data/digikey/800 -size +50M -exec rm {} \;

删除文件大小大于1k的文件
find /data/digikey/800/ -type f -size +1c -exec rm -f {} \;

查找某段时间内（365为天数）的文件并删除
find /data/digikey/800 -ctime +365 -exec rm -rf {} \;

删除10天前的所有该目录下的文件
find /data/digikey/800 -mtime +10 -name "*.*" -exec rm -Rf {} \;

删除文件大小为1k大小的文件
find /data/digikey/800 -name "*" -type f -size 1024c | xargs -n 1 rm -f

删除文件占用空间为1k大小的文件
find /data/digikey/800 -name "*" -type f -size 1k | xargs -n 1 rm -f

查询所有的空文件夹
find -type d -empty

删除/data/digikey/800文件夹下的所有.pdf的文件
find /data/digikey/800 -name "*.pdf" | xargs rm -f

列出搜索到的文件
find /data/digikey/800 -name "shufa.txt" -exec ls {} \;

批量删除搜索到的文件
find /data/digikey/800 -name "shufa.txt" -exec rm -f {} \;

批量删除搜索到的文件包含名称ssss所有的文件，如果要连同目录一起删除，加-r参数
find /data/digikey/800 -name "*ssss*" | xargs rm -f

批量删除搜索到的文件(删除前有提示)
find /data/digikey/800 -name "shufa.txt" -ok rm -rf {} \;

删除目录下面所有 test 文件夹下面的文件
find /data/digikey/800 -name "test" -type d -exec rm -rf {} \;

删除文件夹下面的所有的.svn文件
find /data/digikey/800 -name '.svn' -exec rm -rf {} \;

删除某个文件夹下及该文件夹下所有子文件夹中的某种文件
find /data/digikey/800 -type f -iname "*_w*.jpg" -exec rm -rf {} \;

#删除潜在危险文件
find / -name .netrc |xargs rm -rf
find / -name .rhosts |xargs rm -rf
find / -name hosts.equiv |xargs rm -rf

注:
1.{}和前面之间有一个空格 
2.find . -name 之间也有空格 
3.exec 是一个后续的命令,{}内的内容代表前面查找出来的文件
```

+ 删除文件
```
rm -rf 文件名
rm -f /opt/log/big.log
```

+ 清空文本文件内容
```
echo "" > /data/aaa.log
clear > /opt/log/big.log
true > /opt/log/big.log
flase > /opt/log/big.log
: > /opt/log/big.log
```

切换root用户
```
sudo su -
```

创建软连接
```
sudo ln -s /data1/digikey_pdf/ pdf
```

+ 使用CentOS常用命令查看cpu
```
more /proc/cpuinfo | grep "model name"
more /proc/cpuinfo | grep "cpu"
more /proc/cpuinfo | grep "cpuid"

grep "model name" /proc/cpuinfo
grep "cpu" /proc/cpuinfo
grep "cpuid" /proc/cpuinfo

eg:
model name : Intel(R) Pentium(R) Dual CPU E2180 @ 2.00GHz
model name : Intel(R) Pentium(R) Dual CPU E2180 @ 2.00GHz

如果觉得需要看的更加舒服
grep "model name" /proc/cpuinfo | cut -f2 -d:
```

+ 使用CentOS常用命令查看内存
```
grep MemTotal /proc/meminfo
grep MemTotal /proc/meminfo | cut -f2 -d:
free -m |grep "Mem" | awk '{print $2}'
```

+ 使用CentOS常用命令查看cpu是32位还是64位 
查看CPU位数(32 or 64)
```
getconf LONG_BIT
```

+ 使用CentOS常用命令查看当前linux的版本 
```
more /etc/redhat-release
cat /etc/redhat-release
```

+ 使用CentOS常用命令查看内核版本 
```
uname -r
uname -a
```

+ 使用CentOS常用命令查看当前时间 
```
date
```

+ 使用CentOS常用命令查看硬盘和分区 
```
df -h
df -hv
df -lh
fdisk -l 也可以查看分区  查看硬盘号
du -sh 可以看到全部占用的空间
du /etc -sh 可以看到这个目录的大小
```

+ 查看系统安装的时候装的软件包
```
cat -n /root/install.log
more /root/install.log | wc -l
```

查看现在已经安装了那些软件包
```
rpm -qa
rpm -qa | wc -l
yum list installed | wc -l
```
不过很奇怪，我通过rpm，和yum这两种方式查询的安装软件包，数量并不一样。没有找到原因。

+ 使用CentOS常用命令查看键盘布局
```
cat /etc/sysconfig/keyboard
cat /etc/sysconfig/keyboard | grep KEYTABLE | cut -f2 -d=
```

+ 使用CentOS常用命令查看selinux情况 
```
sestatus
sestatus | cut -f2 -d:
cat /etc/sysconfig/selinux
```

+ 使用CentOS常用命令查看ip，mac地址,在ifcfg-eth0 文件里你可以看到mac，网关等信息。
```
ifconfig
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep IPADDR
cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep IPADDR | cut -f2

ifconfig
eth0 |grep "inet addr:" |awk '{print $2}'|cut -c 6-

ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'

查看网关
cat /etc/sysconfig/network

查看dns
cat /etc/resolv.conf
```

+ 使用CentOS常用命令查看默认语言
```
echo $LANG $LANGUAGE
cat /etc/sysconfig/i18n
```

+ 使用CentOS常用命令查看所属时区和是否使用UTC时间 
```
cat /etc/sysconfig/clock
```

+ 使用CentOS常用命令查看主机名
```
hostname
cat /etc/sysconfig/network
```
修改主机名就是修改这个文件，同时最好也把host文件也修改。

+ 使用CentOS常用命令查看 系统资源使用情况 ( 开机运行时间 ) 
```
uptime
14:41:24 up 45 days, 46 min,  6 users,  load average: 6.03, 6.16, 6.13
看来刚才确实是网段的问题，我的机器还是67天前开机的。
```

### 系统资源使用情况
```
vmstat 1

vmstat 1 -S m
procs ———–memory———- —swap– —–io—- –system– —–cpu——
r b swpd free buff cache si so bi bo in cs us sy id wa st
0 0 0 233 199 778 0 0 4 25 1 1 3 0 96 0 0
0 0 0 233 199 778 0 0 0 0 1029 856 13 1 86 0 0
```

+ 实用命令
```
wget 网址 下载资源
tar zxvf 压缩包名称 解压
hostname or cat /etc/sysconfig/network 查看主机名
pkill mysqld 如何杀死mysql进程
find / -type f -size +100000k -ls 查询大小超过100M的文件
```

+ 创建/改变文件系统的CentOS常用命令
```
创建文件系统类型
umount /dev/sdb1
mkfs -t ext3 /dev/db1
mount /dev/sdb1 /practice
```

+ 改变文件或文件夹权限的CentOS常用命令
chmod
```
将自己的笔记设为只有自己才能看
chmod go-rwx test.txt
或者
chmod 700 test.txt
同时修改多个文件的权限
chmod 700 test1.txt test2.txt
修改一个目录的权限，包括其子目录及文件
chmod 700 -R test

用 root 账号执行chmod命令：
chmod -R 777 dirPath              
参数 -R 表示递归，dirPath及其之内的所有文件夹、文件都被改变了权限
eg:
chmod -R 777 /home/user1/workspace/git
```

+ 改变文件或文件夹拥有者的CentOS常用命令
```
chown 该命令只有 root 才能使用
更改某个文件的拥有者
chown jim:usergroup test.txt
更改某个目录的拥有者,并包含子目录
chown jim:usergroup -R test
```

+ 查看文本文件内容的CentOS常用命令
```
cat
查看文件内容，并在每行前面加上行号
cat -n test.txt
查看文件内容，在不是空行的前面加上行号
cat -b test.txt
合并两个文件的内容
cat test1.txt test2.txt > test_new.txt
全并两具文件的内容，并追回到一个文件
cat test1.txt test2.txt >> test_total.txt
清空某个文件的内容
cat /dev/null > test.txt
创建一个新的文件
cat > new.txt 按 CTRL + C 结束录入
```

+ 编辑文件文件的CentOS常用命令
```
vi
新建档案文件
vi newfile.txt
修改档案文件
vi test.txt test.txt 已存在
vi 的两种工作模式：命令模式，编辑模式
进入 vi 后为命令模式，按 Insrt 键进入编辑模式
按 ESC 进入命令模式，在命令模式不能编辑，只能输入命令
命令模式常用命令
:w 保存当前文档
:q 直接退出 vi
:wq 先保存后退出 。
```

+ 批量替换文件
今天使用svn进行系统迁移，结果发现最初的路径写错了，导致无法访问源服务器，查看 .svn/entries 大致了解了一下里面的内容。重新迁移时间太久了，还是直接把文件替换掉吧
```
for f in $(find ./ -type f -name 'entries')
do
sed -i "s/202\.68\.134\.18/202\.68\.134\.34/g" $f
done

sed 简单说明:
sed "s/sourcestring/newstring/g" $f
把 $f 文件中的 sourcestring 换成 newstring，输出到终端。s 表示搜索替换，/g表示全局。

sed -i $f
表示直接在 $f 中修改。

sed -iback $f
表示修改后的文件另存为 $fback

sed 中所有正则表达式都必须使用严格的转义符 \ 来限定
sed 的正则比较严格： " \ / ! 都需要分别用 \" \/ \\ \! 转义。
\n 表示换行
```

+ shell 变量 字符串操作
```
mono 跑在linux下时，apache+mod_mono有时候需要加载的 Assembly 必须配置在 GAC 中，下面是一个脚本完成此功能

cd bin
for f in $(find ./ -name "*.dll")
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
```

+ 查看当前连接
```
netstat -an
netstat -nap |grep 3306 | grep 185
netstat -ntulp | grep 10983
```

+ 有关重启
```
shutdown -r now 　 重新启动系统，使设置生效
shutdown -h now 关机
reboot 重启
poweroff 关机
```

+ 开机自启动设置
编辑rc.local文件
```
vim /etc/rc.d/rc.local
du -sh # 查看指定目录的大小
du -sh ./* 当前目录下各子目录的大小
uptime # 查看系统运行时间、用户数、负载
cat /proc/loadavg # 查看系统负载
iptables -L # 查看防火墙设置
route -n # 查看路由表
netstat -lntp # 查看所有监听端口
netstat -antp # 查看所有已经建立的连接
netstat -s # 查看网络统计信息
w # 查看活动用户
id # 查看指定用户信息
last # 查看用户登录日志
cut -d: -f1 /etc/passwd # 查看系统所有用户
cut -d: -f1 /etc/group # 查看系统所有组
crontab -l # 查看当前用户的计划任务
MAILTO=""
#* * * * * python2 /data/eddie/scripts/redis/redisstat.py >/dev/null 2>&1
#* * * * * python2 /data/eddie/scripts/mysql/MySQLMonitor.py >/dev/null 2>&1
#* * * * * python2 /data/eddie/scripts/mongodb/mongodb.py >/dev/null 2>&1
#0 0 * * * /data/eddie/scripts/mysqlbackup/mysqlbackup.sh >/dev/null 2>&1
#*/30 * * * * /data/eddie/scripts/waf/Whitelist4waf.sh 
#0 9 1 1 2   /data/elasticsearch/elasticsearch-dump-new_electron.sh  >/dev/null 2>&1 &
*/2 * * * * /data/mongodb/start.sh  >/dev/null 2>&1

chkconfig --list # 列出所有系统服务
chkconfig --list | grep on # 列出所有启动的系统服务
```

+ 查看磁盘io
如果 iostat 没有，要 yum install sysstat安装这个包
```
iostat -c 1 10
iostat还可以用来获取cpu部分状态值：
iostat -x 1 10
iostat -d -x -k 1

如果%util接近100%,表明I/O请求太多,I/O系统已经满负荷，磁盘可能存在瓶颈,一般%util大于70%,I/O压力就比较大，读取速度有较多的wait

rrqm/s:每秒进行merge的读操作数目。即delta(rmerge)/s 
wrqm/s:每秒进行merge的写操作数目。即delta(wmerge)/s 
r/s:每秒完成的读I/O设备次数。即delta(rio)/s 
w/s:每秒完成的写I/0设备次数。即delta(wio)/s 
rsec/s:每秒读扇区数。即delta(rsect)/s 
wsec/s:每秒写扇区数。即delta(wsect)/s 
rKB/s:每秒读K字节数。是rsec/s的一半，因为每扇区大小为512字节 
wKB/s:每秒写K字节数。是wsec/s的一半 
avgrq-sz:平均每次设备I/O操作的数据大小(扇区)。即delta(rsect+wsect)/delta(rio+wio) 
avgqu-sz:平均I/O队列长度。即delta(aveq)/s/1000(因为aveq的单位为毫秒) 
await:平均每次设备I/O操作的等待时间(毫秒)。即delta(ruse+wuse)/delta(rio+wio) 
svctm:平均每次设备I/O操作的服务时间(毫秒)。即delta(use)/delta(rio+wio) 
%util:一秒中有百分之多少的时间用于I/O操作,或者说一秒中有多少时间I/O队列是非空的

iostat -d -k 1 |grep sda10

使用sar来检查操作系统是否存在IO问题
sar -u 2 10 — 即每隔2秒检察一次，共执行20次
[flack.chen@dev-web mysql_export_dir]$ sar -u 2 10
Linux 3.10.0-327.el7.x86_64 (dev-web)   12/14/2019  _x86_64_  (2 CPU)

11:11:16 AM     CPU     %user     %nice   %system   %iowait    %steal     %idle
11:11:18 AM     all      3.30      0.00      2.79     77.66      0.00     16.24
11:11:20 AM     all      5.30      0.00      3.28     62.12      0.00     29.29
11:11:22 AM     all      5.57      0.00      2.28     73.67      0.00     18.48
11:11:24 AM     all      3.80      0.00      2.53     67.34      0.00     26.33
11:11:26 AM     all      3.79      0.00      1.52     91.41      0.00      3.28
11:11:28 AM     all      4.33      0.00      2.54     91.60      0.00      1.53
11:11:30 AM     all      3.02      0.00      3.27     93.47      0.00      0.25
11:11:32 AM     all      5.32      0.00      4.05     90.13      0.00      0.51
11:11:34 AM     all      6.14      0.00      3.32     82.61      0.00      7.93
11:11:36 AM     all      4.56      0.00      3.04     89.37      0.00      3.04
Average:        all      4.51      0.00      2.86     81.94      0.00     10.69

%usr指的是用户进程使用的cpu资源的百分比;
%sys指的是系统资源使用cpu资源的百分比;
%wio指的是等待io完成的百分比，这是值得观注的一项;
%idle即空闲的百分比。
如果wio列的值很大，如在35%以上，说明系统的IO存在瓶颈，CPU花费了很大的时间去等待I/O的完成。Idle很小说明系统CPU很忙。像以上的示例，可以看到wio平均值为11，说明I/O没什么特别的问题，而idle值为零，说明cpu已经满负荷运行了


top
显示更新十次后退出;
top -n 10

使用者将不能利用交谈式指令来对行程下命令:
top -s

将更新显示二次的结果输入到名称为top.log的档案里:
top -n 2 -b < top.log
使用方式：top [-] [d delay] [q] [c] [S] [s] [i] [n] [b]

说明：即时显示process的动态
d :改变显示的更新速度，或是在交谈式指令列( interactive command)按s
q :没有任何延迟的显示速度，如果使用者是有superuser的权限，则top将会以最高的优先序执行
c :切换显示模式，共有两种模式，一是只显示执行档的名称，另一种是显示完整的路径与名称S :累积模式，会将己完成或消失的子行程( dead child process )的CPU time累积起来
s :安全模式，将交谈式指令取消,避免潜在的危机
i :不显示任何闲置(idle)或无用(zombie)的行程
n :更新的次数，完成后将会退出top
b :批次档模式，搭配"n"参数一起使用，可以用来将top的结果输出到档案内

第一行：
— 当前系统时间
days — 系统已经运行了N天N小时N分钟（在这期间没有重启过）
2 users — 当前有2个用户登录系统
load average: 1.17, 1.86, 1.59 — load average后面的三个数分别是1分钟、5分钟、15分钟的负载情况。
load average数据是每隔5秒钟检查一次活跃的进程数，然后按特定算法计算出的数值。如果这个数除以逻辑CPU的数量，结果高于5的时候就表明系统在超负荷运转了。

第二行：
Tasks — 任务（进程），系统现在共有164个进程，其中处于运行中的有2个，162个在休眠（sleep），stoped状态的有0个，zombie状态（僵尸）的有0个。

第三行：cpu状态
us — 用户空间占用CPU的百分比。
sy — 内核空间占用CPU的百分比。
ni — 改变过优先级的进程占用CPU的百分比
id — 空闲CPU百分比
wa — IO等待占用CPU的百分比
hi — 硬中断（Hardware IRQ）占用CPU的百分比
si — 软中断（Software Interrupts）占用CPU的百分比

第四行：内存状态
total — 物理内存总量
used — 使用中的内存总量
free — 空闲内存总量
buffers — 缓存的内存量

第五行：swap交换分区
total — 交换区总量
used — 使用的交换区总量
free — 空闲交换区总量
cached — 缓冲的交换区总量

第七行以下：各进程（任务）的状态监控
PID — 进程id
USER — 进程所有者
PR — 进程优先级
NI — nice值。负值表示高优先级，正值表示低优先级
VIRT — 进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
RES — 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
SHR — 共享内存大小，单位kb
S — 进程状态。D=不可中断的睡眠状态 R=运行 S=睡眠 T=跟踪/停止 Z=僵尸进程
%CPU — 上次更新到现在的CPU时间占用百分比
%MEM — 进程使用的物理内存百分比
TIME+ — 进程使用的CPU时间总计，单位1/100秒
COMMAND — 进程名称（命令名/命令行）

敲击键盘"b"（打开/关闭加亮效果）;
敲击键盘"x"（打开/关闭排序列的加亮效果）


* PID     = Process Id             PGRP    = Process Group Id       vMj     = Major Faults delta  
* USER    = Effective User Name    TTY     = Controlling Tty        vMn     = Minor Faults delta  
* PR      = Priority               TPGID   = Tty Process Grp Id     USED    = Res+Swap Size (KiB) 
* NI      = Nice Value             SID     = Session Id             nsIPC   = IPC namespace Inode 
* VIRT    = Virtual Image (KiB)    nTH     = Number of Threads      nsMNT   = MNT namespace Inode 
* RES     = Resident Size (KiB)    P       = Last Used Cpu (SMP)    nsNET   = NET namespace Inode 
* SHR     = Shared Memory (KiB)    TIME    = CPU Time               nsPID   = PID namespace Inode 
* S       = Process Status         SWAP    = Swapped Size (KiB)     nsUSER  = USER namespace Inode
* %CPU    = CPU Usage              CODE    = Code Size (KiB)        nsUTS   = UTS namespace Inode 
* %MEM    = Memory Usage (RES)     DATA    = Data+Stack (KiB)    
* TIME+   = CPU Time, hundredths   nMaj    = Major Page Faults   
* COMMAND = Command Name/Line      nMin    = Minor Page Faults   
  PPID    = Parent Process pid     nDRT    = Dirty Pages Count   
  UID     = Effective User Id      WCHAN   = Sleeping in Function
  RUID    = Real User Id           Flags   = Task Flags <sched.h>
  RUSER   = Real User Name         CGROUPS = Control Groups      
  SUID    = Saved User Id          SUPGIDS = Supp Groups IDs     
  SUSER   = Saved User Name        SUPGRPS = Supp Groups Names   
  GID     = Group Id               TGID    = Thread Group Id     
  GROUP   = Group Name             ENVIRON = Environment vars


iotop  使用io高的进程的工具

mpstat
要查看cpu波动情况的，尤其是多核机器上。该命令可间隔2秒钟采样一次CPU的使用情况，每个核的情况都会显示出来
mpstat -P ALL 2 5

proc
查看cpu的配置信息(它能显示诸如CPU核心数，时钟频率、CPU型号等信息)
cat /proc/cpuinfo

查看进程状态
cat /proc/进程id/status

查看经常地址空间信息
cat /proc/进程id/maps

查看内存
cat /proc/meminfo

Procs（进程）：
r: 运行队列中进程数量
b: 等待IO的进程数量
Memory（内存）：
swpd: 使用虚拟内存大小
free: 可用内存大小
buff: 用作缓冲的内存大小
cache: 用作缓存的内存大小

Swap：
si: 每秒从交换区写到内存的大小
so: 每秒写入交换区的内存大小
IO：（现在的Linux版本块的大小为1024bytes）
bi: 每秒读取的块数
bo: 每秒写入的块数

系统：
in: 每秒中断数，包括时钟中断。
cs: 每秒上下文切换数。

CPU（以百分比表示）：
us: 用户进程执行时间(user time)
sy: 系统进程执行时间(system time)
id: 空闲时间(包括IO等待时间)
wa: 等待IO时间


vmstat  使用vmstat监控内存 cpu资源
每N秒输出一条结果
vmstat 2
[flack.chen@dev-web mysql_export_dir]$ vmstat 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  3 980600 661724      0 433528   12    6   803   626    1    0  4  1 86  9  0
 0  4 980600 658076      0 434264    0    0  2238  3203 1097  935  3  1 34 63  0

io bo: 磁盘写的数据量稍大，如果是大文件的写，10M以内基本不用担心，如果是小文件写2M以内基本正常

r 表示运行队列的大小，
b 表示由于IO等待而block的线程数量，
in 表示中断的数量，
cs 表示上下文切换的数量，
us 表示用户CPU时间，
sy 表示系统CPU时间，
wa 表示由于IO等待而是CPU处于idle状态的时间，
id 表示CPU处于idle状态的总时间。

pmap 进程id
可以显示一个或多个进程所使用的内存数量。你可以使用这个工具来了解服务器上的某个进程分配了多少内存，输出进程内存的状况，可以用来分析线程堆栈
pmap 进程id -d选项


监控进程线程数
ps -eLf | grep 进程 | wc -l


lsblk 　　　　                                   查看分区和磁盘
df -h 　　                                      查看空间使用情况
fdisk -l 　　                                   分区工具查看分区信息
cfdisk /dev/sda  　　                           查看分区
blkid 　                                        查看硬盘label（别名）
du -sh ./* 　　                                 统计当前目录各文件夹大小
free -h 　                                    　查看内存大小
cat /proc/cpuinfo| grep "cpu cores"| uniq  　　 查看cpu核心数
cat /proc/cpuinfo| grep "physical id"|uniq| wc -l   查看物理cpu个数
cat /proc/cpuinfo| grep "processor"| wc -l          查看逻辑cpu的个数

cat  /etc/redhat-release            查看系统版本
getconf LONG_BIT                    查看系统位数

查看消耗内存最多的前40个进程
ps auxw|head -1;
ps auxw|sort -rn -k4|head -40


#时区/时间设置
yum install -y ntpdate
timedatectl set-timezone Asia/Shanghai
ntpdate time.windows.com

#空闲超时设置
echo TMOUT=300 >> /etc/profile

#禁用Telnetd
systemctl disable telnetd.service


#口令期限，缺省用户创建权限设置
sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs
sed -i 's/PASS_MIN_LEN\t5/PASS_MIN_LEN\t8/' /etc/login.defs
sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t10/' /etc/login.defs
sed -i 's/UMASK 077/UMASK 027/' /etc/login.defs

#密码复杂度设置，root用户不受限制，此项最好人工设定(不同的安装或云主机文件不一样)
sed -i '/password required pam_deny.so/a\password requisite pam_cracklib.so retry=3 minlen=8 minclass=3 dictpath=/usr/share/cracklib/pw_dict' /etc/pam.d/system-auth

#创建普通用户、授权wheel组用户可以su -、禁用root远程登入
useradd -G wheel yunwei
echo 'Hdhxt@8978' |passwd --stdin yunwei
sed -i 's/#auth\t\trequired\tpam_wheel.so use_uid/auth\t\trequired\tpam_wheel.so group=wheel/' /etc/pam.d/su
echo "SU_WHEEL_ONLY yes" >> /etc/login.defs
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
service sshd restart

#账号信息文件权限
chmod 644 /etc/passwd
chmod 400 /etc/shadow
chmod 644 /etc/group

#关闭SELINUX，设置firewalld
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-rich-rule="rule family="ipv4" source address="192.168.126.0/24" service name="ssh" accept"
firewall-cmd --reload

#（备选） - 用户可以使用sudo,如果用户可以使用sudo则代表其具有sudo su - 的root权限
#sed -i '/root\tALL=(ALL)[[:space:]]\tALL/a\yunwei ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
```

```
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
常用：kill -9 324
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

例如：
更改目录拥有者为oracle
chown -R oracle:oinstall /oracle/u01/app/oracle  


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

例如：
让所有用户可以读和执行文件filename。 
chmod a+rx filename 

取消同组和其他用户的读和执行文件filename的权限。 
chmod go-rx filename 

让本人可读写执行、同组用户可读、其他用户可执行文件filename。 
chmod 741 filename 

递归更改目录权限，本人可读写执行、同组用户可读可执行、其他用户可读可执行 
chmod -R 755 /home/oracle 

3. 修改文件日期 
命令：touch 
格式：touch filenae 
功能：改变文件的日期，不对文件的内容做改动，若文件不存在则建立新文件。 
例如：touch file 

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
例如：ln -s filename linkname 

5. 显示日期
命令：date 
例如：date 

6. 显示日历
命令：cal (calendar) 
格式：cal [month] year 
功能：显示某年内指定的日历 
例如：cal 1998  

7. 显示文件头部 
命令：head 
格式：head [option] filename 
功能：显示文件的头部 
选项：缺省  显示文件的头10行。 
      -i   显示文件的开始 i行。 
例如：head filename 

8. 显示文件尾部 
命令：tail 
格式：tail [option] filename 
功能：显示文件的尾部 
选项：缺省  显示文件的末10行。 
      -i    显示文件最后 i行。 
      +i    从文件的第i行开始显示。 
例如：tail filename 

9. 显示用户标识 
命令：id 
格式：id [option] [user] 
功能：显示用户标识及用户所属的所有组。 
选项：-a 显示用户名、用户标识及用户所属的所有组 
注释： 
例如：id username 

10. 查看当前登录的用户 
命令：users 

11. 显示都谁登录到机器上 
命令：who 
格式：who 
功能：显示当前正在系统中的所有用户名字，使用终端设备号，注册时间。 
例如：who 

12. 显示当前终端上的用户名 
命令：whoami 
格式：whoami 
功能：显示出当前终端上使用的用户。 
例如：whoami 

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
例如：wc -c ./test/run.sh 

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

例如：df -hi 

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

例如：du -a 
du -sh /etc 只显示该目录的总合 
du /etc | sort -nr | more 统计结果用sort 指令进行排序， 
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
```



### centos7安装mongodb
```
curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.2.12.tgz
解压 放到 /usr/local/ 目录下

tar -zxvf mongodb-linux-x86_64-3.2.12.tgz
mv  mongodb-linux-x86_64-3.2.12/ /usr/local/mongodb

sudo systemctl start mongod.service
sudo systemctl stop mongod.service
sudo systemctl restart mongod.service
sudo systemctl status mongod.service
```


### centos7安装python3
```
编译安装 Python 3
Cent OS 预装了一个 Python 2，并且系统很多组件都依赖于 Python 2 ，笔者在安装和使用 Python 3 时就因为这些依赖情况遇到了很多问题，最后总结下来，正确的安装和使用 Python 3 的过程如下：

远程连接云服务器实例，在本示例中将使用 root 用户通过编译安装方式全局安装 Python 3，你也可以选择单独为某个用户安装 Python 3 ，步骤上大同小异，详细编译安装文档参考 Using Python on Unix platforms 。
使用 Yum 安装编译安装 Python 3 时依赖的包：

$ yum -y groupinstall "Development tools"
$ yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
下载 Python 3.6.7 版本的安装包，其它版本的请自行去 Download Python | Python.org 获取链接：

$ wget https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz
在当前用户目录解压下载的 Python 安装包：

$ tar -zxvf Python-3.6.7.tgz
进入已解压的 Python 安装文件根目录：

$ cd Python-3.6.7
通过编译配置指定 Python 的安装位置：

$ ./configure --prefix=/usr/local/python3
使用 make 命令开始编译安装 Python：

$ make && make install
为了和系统自带的 python 和 pip 命令区分开来，给刚刚安装的 Python 建立软链接，并为其设置命令别名。分别取名为 python3 、pip3 ：

$ ln -s /usr/local/python3/bin/python3.6 /usr/bin/python3
$ ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
测试 Python 3 是否正确安装，输入 python3 命令：

$ python3
Python 3.6.7 (default, Feb  4 2019, 19:05:27)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
测试 Pip 3 是否正确安装，输入 pip3 命令：

$ pip3 -V
pip 10.0.0 from /usr/local/python3/lib/python3.6/site-packages/pip (python 3.6)
更新 Pip ：

$ pip3 install --upgrade pip
7. 使用 Pipenv 管理 Python 虚拟环境
Pipenv 是 Pipfile 主要倡导者、requests 作者 Kenneth Reitz 写的一个命令行工具，主要包含了 Pipfile、pip、click、requests 和 virtualenv ，使用 Pipenv 可以方便的管理 Python 虚拟环境、管理依赖文件。Pipfile 和 Pipenv本来都是Kenneth Reitz 的个人项目，后来贡献给了 pypa 组织。Pipfile 是社区拟定的依赖管理文件，用于替代过于简陋的 requirements.txt 文件。

执行下面命令，安装 Pipenv ：

$ pip3 install pipenv
执行下面命令，为 Pipenv 可执行文件设置软链接，之后可以通过 pipenv 命令来使用 Pipenv ：

$ ln -s /usr/local/python3/bin/pipenv /usr/bin/pipenv
切换到一个拥有 root 权限的用户，这里以 admin 用户为例：

$ su admin
在用户目录下为你的项目创建一个目录，并进入项目目录，项目名称以 FlaskApp 为例：

$ cd ~
$ mkdir FlaskApp
$ cd FlaskApp
执行下面命令，为项目创建 Python 虚拟环境，默认将虚拟环境保存在 ~/.local/share/virtualenvs：

$ pipenv install
如果想把虚拟环境保存至项目根目录，需要设置环境变量 PIPENV_VENV_IN_PROJECT=1 ，再执行创建命令：

$ export PIPENV_VENV_IN_PROJECT=1
$ pipenv install
虚拟环境创建完成后，执行下面命令为虚拟环境安装 Flask 包：

$ pipenv install flask
在项目根目录编写一个简单的 Flask Demo 进行测试：

# 新建并打开一个名为 app.py 的文件
$ vim app.py
输入下面的代码并保存：

from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_flask():
    return 'Hello Flask!'
使用 pipenv run 调用虚拟环境中的 Python 执行 flask run 命令可以运行编写的代码：

$ pipenv run flask run
也可以使用 pipenv shell 命令进入虚拟环境，然后再在虚拟环境执行 flask run 命令运行程序：

$ pipenv shell
(venv)$ flask run
Flask 默认运行的地址和端口为 http://127.0.0.1:5000 ，云服务器实例不包含桌面环境的话，你很难去浏览这个页面。你可以设置 flask 运行的地址和端口，然后尝试从外网访问该页面。先执行下面命令，让 flask 允许外网访问，并且监听 80 端口：

$ pipenv run flask run --host 0.0.0.0 --port 80
然后你可以通过你的服务器公网 IP 或 域名 直接访问到该页面。
```

### centos7-修改默认python为3
```
$ sudo yum install yum-utils
使用yum-builddep为Python3构建环境,安装缺失的软件依赖,使用下面的命令会自动处理.
$ sudo yum-builddep python

完成后下载Python3的源码包（笔者以Python3.5为例），Python源码包目录： https://www.python.org/ftp/python/ ，截至发博当日Python3的最新版本为 3.7.0
$ curl -O https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

最后一步，编译安装Python3，默认的安装目录是 /usr/local 如果你要改成其他目录可以在编译(make)前使用 configure 命令后面追加参数 "–prefix=/alternative/path" 来完成修改。
$ tar xf Python-3.7.1.tgz
$ cd Python-3.7.1
$ ./configure
$ make
$ sudo make install

至此你已经在你的CentOS系统中成功安装了python3、pip3、setuptools，查看python版本
$ python3 -V

如果你要使用Python3作为python的默认版本，你需要修改一下 bashrc 文件，增加一行alias参数
alias python='/usr/local/bin/python3.7'

由于CentOS 7建议不要动/etc/bashrc文件，而是把用户自定义的配置放入/etc/profile.d/目录中，具体方法为
vi /etc/profile.d/python.sh

输入alias参数 alias python="/usr/local/bin/python3.7"，保存退出
如果非root用户创建的文件需要注意设置权限
chmod 755 /etc/profile.d/python.sh

重启会话使配置生效
source /etc/profile.d/python.sh
```

linux 路径映射
```
/data/eddie/new_pdf：本机路径
//192.168.1.62/new_pdf：远程路径
mount -v -t cifs //192.168.1.62/new_pdf /data/eddie/new_pdf -o 'username=icmofang,password=icmofang,vers=1.0'
```

### centos7 安装 pyhanlp
```
pip3 install pyhanlp -i https://pypi.tuna.tsinghua.edu.cn/simple
安装出错：
centos下gcc编译出现gcc: error trying to exec 'cc1plus': execvp: No such file or directory
原因是在你的fedora/centos中没有安装g++。（或许你像我一样装的是最小linux系统，很多东西都缺）
解决办法：
1、切换root用户，或有权限的用户使用sudo
2、执行以下在线安装代码：
<!-- yum install gcc -->
yum install gcc-c++

然后再运行
pip3 install pyhanlp -i https://pypi.tuna.tsinghua.edu.cn/simple
```


```
JPype1 (0.7.0)

networkx (2.4)
nltk (3.4.5)
numpy (1.17.4)
pyhanlp (0.1.54)
requests (2.22.0)
scipy (1.3.2)
sklearn (0.0)
```


### centos7 安装jdb1.8+
1. jdk8下载参考，下载jdk-8u161-linux-x64.tar.gz
https://blog.csdn.net/qq_21187515/article/details/84850814
2. 在/usr/目录下创建java目录
```
mkdir /usr/java
cd /usr/java
```
3. 把下载的jdk-8u161-linux-x64.tar.gz上传到linux上的/usr/java,可以通过rz命令上传windows下载的jdk（也可以通过Xftp上传）
没有rz命令可以用yum安装
```
yum安装 rz命令
yum install lrzsz
```
4. 解压jdk压缩包
```
tar -zxvf jdk-8u161-linux-x64.tar.gz
```
5. 设置环境变量
```
vim /etc/profile
```
在profile中追加如下内容
```
export JAVA_HOME=/usr/java/jdk1.8.0_161
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```
6. 让修改的环境变量生效
```
source /etc/profile
```
7. 验证jdk是否生效
```
java -version
```



