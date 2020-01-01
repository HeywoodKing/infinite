# ubuntu

### 修改国内源
```
安装Ubuntu 18.04后，使用国外源太慢了，修改为国内源会快很多。

修改阿里源为Ubuntu 18.04默认的源

备份/etc/apt/sources.list
#备份
cp /etc/apt/sources.list /etc/apt/sources.list.bak

在/etc/apt/sources.list文件前面添加如下条目
#添加阿里源
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

最后执行如下命令更新源
##更新
sudo apt-get update
sudo apt-get upgrade

另外其他几个国内源如下：
中科大源
##中科大源
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

163源
##163源
deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse

清华源
##清华源
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```

### ubuntu18 备份还原
```
tar:
参数： 
-c： 新建一个备份文档 
-v： 显示详细信息 
-p： 保存权限，并应用到所有文件 
-z： 用gzip压缩备份文档，减小空间 
-f： 指定备份文件的路径 
--exclude： 排除指定目录，不进行备份

备份：
sudo su -
cd /
sudo tar -cvpzf /home/flack/ubuntu18_`date +%Y%m%d_%H`.tgz --exclude=/proc --exclude=lost+found --exclude=/home/flack/ubuntu18_`date +%Y%m%d_%H`.tgz --exclude=/mnt --exclude=/sys --exclude=/media /

还原：
sudo su -
cp /home/flack/ubuntu18_`date +%Y_%m_%d_%H`.tgz /
cd /
tar -xvpzf ubuntu18_`date +%Y_%m_%d_%H`.tgz -C /
```

### date
```
date --help
用法：date [选项]... [+格式]
　或：date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
Display the current time in the given FORMAT, or set the system date.

必选参数对长短选项同时适用。
  -d, --date=STRING          display time described by STRING, not 'now'
      --debug                annotate the parsed date,
                              and warn about questionable usage to stderr
  -f, --file=DATEFILE        like --date; once for each line of DATEFILE
  -I[FMT], --iso-8601[=FMT]  output date/time in ISO 8601 format.
                               FMT='date' for date only (the default),
                               'hours', 'minutes', 'seconds', or 'ns'
                               for date and time to the indicated precision.
                               Example: 2006-08-14T02:34:56-06:00
  -R, --rfc-email            output date and time in RFC 5322 format.
                               Example: Mon, 14 Aug 2006 02:34:56 -0600
      --rfc-3339=FMT         output date/time in RFC 3339 format.
                               FMT='date', 'seconds', or 'ns'
                               for date and time to the indicated precision.
                               Example: 2006-08-14 02:34:56-06:00
  -r, --reference=FILE       display the last modification time of FILE
  -s, --set=STRING           set time described by STRING
  -u, --utc, --universal     print or set Coordinated Universal Time (UTC)
      --help		显示此帮助信息并退出
      --version		显示版本信息并退出

给定的格式FORMAT 控制着输出，解释序列如下：

  %%	一个文字的 %
  %a	当前locale 的星期名缩写(例如： 日，代表星期日)
  %A	当前locale 的星期名全称 (如：星期日)
  %b	当前locale 的月名缩写 (如：一，代表一月)
  %B	当前locale 的月名全称 (如：一月)
  %c	当前locale 的日期和时间 (如：2005年3月3日 星期四 23:05:25)
  %C	世纪；比如 %Y，通常为省略当前年份的后两位数字(例如：20)
  %d	按月计的日期(例如：01)
  %D	按月计的日期；等于%m/%d/%y
  %e	按月计的日期，添加空格，等于%_d
  %F	完整日期格式，等价于 %Y-%m-%d
  %g	ISO-8601 格式年份的最后两位 (参见%G)
  %G	ISO-8601 格式年份 (参见%V)，一般只和 %V 结合使用
  %h	等于%b
  %H	小时(00-23)
  %I	小时(00-12)
  %j	按年计的日期(001-366)
  %k   hour, space padded ( 0..23); same as %_H
  %l   hour, space padded ( 1..12); same as %_I
  %m   month (01..12)
  %M   minute (00..59)
  %n   a newline
  %N   nanoseconds (000000000..999999999)
  %p   locale's equivalent of either AM or PM; blank if not known
  %P   like %p, but lower case
  %q   quarter of year (1..4)
  %r   locale's 12-hour clock time (e.g., 11:11:04 PM)
  %R   24-hour hour and minute; same as %H:%M
  %s   seconds since 1970-01-01 00:00:00 UTC
  %S	秒(00-60)
  %t	输出制表符 Tab
  %T	时间，等于%H:%M:%S
  %u	星期，1 代表星期一
  %U	一年中的第几周，以周日为每星期第一天(00-53)
  %V	ISO-8601 格式规范下的一年中第几周，以周一为每星期第一天(01-53)
  %w	一星期中的第几日(0-6)，0 代表周一
  %W	一年中的第几周，以周一为每星期第一天(00-53)
  %x	当前locale 下的日期描述 (如：12/31/99)
  %X	当前locale 下的时间描述 (如：23:13:48)
  %y	年份最后两位数位 (00-99)
  %Y	年份
  %z +hhmm		数字时区(例如，-0400)
  %:z +hh:mm		数字时区(例如，-04:00)
  %::z +hh:mm:ss	数字时区(例如，-04:00:00)
  %:::z			数字时区带有必要的精度 (例如，-04，+05:30)
  %Z			按字母表排序的时区缩写 (例如，EDT)

默认情况下，日期的数字区域以0 填充。
The following optional flags may follow '%':

  -  (hyphen) do not pad the field
  _  (underscore) pad with spaces
  0  (zero) pad with zeros
  ^  use upper case if possible
  #  use opposite case if possible

在任何标记之后还允许一个可选的域宽度指定，它是一个十进制数字。
作为一个可选的修饰声明，它可以是E，在可能的情况下使用本地环境关联的
表示方式；或者是O，在可能的情况下使用本地环境关联的数字符号。

Examples:
Convert seconds since the epoch (1970-01-01 UTC) to a date
  $ date --date='@2147483647'

Show the time on the west coast of the US (use tzselect(1) to find TZ)
  $ TZ='America/Los_Angeles' date

Show the local time for 9AM next Friday on the west coast of the US
  $ date --date='TZ="America/Los_Angeles" 09:00 next Fri'

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
请向<http://translationproject.org/team/zh_CN.html> 报告date 的翻译错误
Full documentation at: <http://www.gnu.org/software/coreutils/date>
or available locally via: info '(coreutils) date invocation'
flack@flack-K43SM:~/.local/share/virtualenvs/DataXWeb-aU-zDc
```

### Ubuntu安装SSH SERVER
```
sudo apt-get update
sudo apt-get install openssh-server

```
安装好后查看SSH是否启动 
```
sudo ps -ef |grep ssh
```
有sshd,说明ssh服务已经启动，如果没有启动,启动ssh服务
```
sudo service ssh start
```

使用gedit修改配置文件”/etc/ssh/sshd_config” 获取远程ROOT权限
```
sudo gedit /etc/ssh/sshd_config

PermitRootLogin without-password
修改为：
# PermitRootLogin without-password
PermitRootLogin yes
```
保存退出，修改成功

### 卸载openssh
```
apt-get purge openssh-client
```

### ubuntu18 安装 xmind8
1. 下载安装包
xmind8安装包 [官网地址](https://www.xmind.cn/download/xmind8 "官网地址")
破解文件 [下载地址](http://web.wvdon.com/soft/XMind_amd64.tar.gz "下载地址")

2. 将下载的安装包解压到指定目录
```
mkdir /opt/xmind8
unzip -d /opt/xmind8/ xmind-8-update8-linux.zip
```

3. 解压破解文件
将下载的破解文件解压到/xmind8/xmind-8-update8-linux/XMind_amd64/ 并选择替换
```
unzip -o -d /opt/xmind8/xmind-8-update8-linux/XMind_amd64/ XMind_amd64.tar.gz
```

4. 修改host
```
sudo vim /etc/hosts
```
在最后添加
```
127.0.0.1 www.xmind.net
```

5. 进入到解压后的目录下
执行
```
sudo ./setup.sh
```

6. 进入/opt/xmind8/xmind-8-update8-linux/XMind_amd64/ 点击运行XMind

+ 点击 帮助 序列号
+ 输入 邮箱（随便输入）
+ 输入序列号
```
XAka34A2rVRYJ4XBIU35UZMUEEF64CMMIYZCK2FZZUQNODEKUHGJLFMSLIQMQUCUBXRENLK6NZL37JXP4PZXQFILMQ2RG5R7G4QNDO3PSOEUBOCDRYSSXZGRARV6MGA33TN2AMUBHEL4FXMWYTTJDEINJXUAV4BAYKBDCZQWVF3LWYXSDCXY546U3NBGOI3ZPAP2SO3CSQFNB7VVIY123456789012345
```
激活成功

7. 创建桌面快捷方式
+ 进入到/opt/xmind8/xmind-8-update8-linux/XMind_amd64/并创建运行脚本文件
```
sudo vim run.sh
```
+ 输入以下
```
cd /opt/xmind8/xmind-8-update8-linux/XMind_amd64/
/opt/xmind8/xmind-8-update8-linux/XMind_amd64/XMind
```
保存退出

+ 为run.sh加上可执行权限
```
chmod +x ./run.sh
```
+ 进入到applications目录下
```
cd /usr/share/applications/
```
+ 创建xmind.desktopp
```
sudo vim xmind.desktop
```
+ 输入以下
```
[Desktop Entry]
Name=XMind
Exec=/opt/xmind8/xmind-8-update8-linux/XMind_amd64/run.sh
Icon=/opt/xmind8/xmind-8-update8-linux/XMind_amd64/configuration/org.eclipse.osgi/983/0/.cp/icons/xmind.128.png
Path=/opt/xmind8/xmind-8-update8-linux/XMind_amd64/
Type=Application
Categories=GTK;GNOME;Office;

字段解释：
Name: 应用文件名，本例中此处填写 XMind 。
Exec: 应用执行路径，必须准确填写。
Icon: 图标路径。(自己选择下载的图片所在路径）
Path：应用所在路径。
Type: .desktop 类型，此处我们应填写 Application 。
sudo chmod a+x XMind.desktop
```

8. 复制XMind.desktop 到桌面粘贴即可创建快捷方式,也可以搜索 xmind 添加到收藏夹


