# Supervisor-守护进程工具


### 简介

Supervisor是用Python开发的一个client/server服务，是Linux/Unix系统下的一个进程管理工具，不支持Windows系统。它可以很方便的监听、启动、停止、重启一个或多个进程。用Supervisor管理的进程，当一个进程意外被杀死，supervisort监听到进程死后，会自动将它重新拉起，很方便的做到进程自动恢复的功能，不再需要自己写shell脚本来控制


### Supervisor安装与配置

1. 安装Python包管理工具
```
ubuntu:
sudo apt-get install python-setuptools

centos:
sudo yum install python-setuptools
```
2. 安装Supervisor
```
pip3 install supervisor -i https://pypi.tuna.tsinghua.edu.cn/simple
```
3. 配置Supervisor应用守护

首先在 /etc/supervisor 查看是否存在 supervisord.conf 配置文件，如果不存在在根据一下步骤创建配置文件

+ 通过运行echo_supervisord_conf程序生成supervisor的初始化配置文件，如下所示：
```
mkdir /etc/supervisor/
echo_supervisord_conf > /etc/supervisor/supervisord.conf
```
然后查看路径下的supervisord.conf。在文件尾部添加如下配置。
```
...

;[include]
;files = relative/directory/*.ini

;conf.d 为配置表目录的文件夹，需要手动创建
[include]
files = conf.d/*.conf
```

supervisor的配置参数较多，下面介绍一下常用的参数配置，详细的配置及说明，请参考官方文档介绍。
注：分号（;）开头的配置表示注释
```
[unix_http_server]
file=/tmp/supervisor.sock   ;UNIX socket 文件，supervisorctl 会使用
;chmod=0700                 ;socket文件的mode，默认是0700
;chown=nobody:nogroup       ;socket文件的owner，格式：uid:gid

;[inet_http_server]         ;HTTP服务器，提供web管理界面
;port=127.0.0.1:9001        ;Web管理后台运行的IP和端口，如果开放到公网，需要注意安全性
;username=user              ;登录管理后台的用户名
;password=123               ;登录管理后台的密码

[supervisord]
logfile=/tmp/supervisord.log ;日志文件，默认是 $CWD/supervisord.log
logfile_maxbytes=50MB        ;日志文件大小，超出会rotate，默认 50MB，如果设成0，表示不限制大小
logfile_backups=10           ;日志文件保留备份数量默认10，设为0表示不备份
loglevel=info                ;日志级别，默认info，其它: debug,warn,trace
pidfile=/tmp/supervisord.pid ;pid 文件
nodaemon=false               ;是否在前台启动，默认是false，即以 daemon 的方式启动
minfds=1024                  ;可以打开的文件描述符的最小值，默认 1024
minprocs=200                 ;可以打开的进程数的最小值，默认 200

[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ;通过UNIX socket连接supervisord，路径与unix_http_server部分的file一致
;serverurl=http://127.0.0.1:9001 ; 通过HTTP的方式连接supervisord

; [program:xx]是被管理的进程配置参数，xx是进程的名称
[program:xx]
command=/opt/apache-tomcat-8.0.35/bin/catalina.sh run  ; 程序启动命令
autostart=true       ; 在supervisord启动的时候也自动启动
startsecs=10         ; 启动10秒后没有异常退出，就表示进程正常启动了，默认为1秒
autorestart=true     ; 程序退出后自动重启,可选值：[unexpected,true,false]，默认为unexpected，表示进程意外杀死后才重启
startretries=3       ; 启动失败自动重试次数，默认是3
user=tomcat          ; 用哪个用户启动进程，默认是root
priority=999         ; 进程启动优先级，默认999，值小的优先启动
redirect_stderr=true ; 把stderr重定向到stdout，默认false
stdout_logfile_maxbytes=20MB  ; stdout 日志文件大小，默认50MB
stdout_logfile_backups = 20   ; stdout 日志文件备份数，默认是10
; stdout 日志文件，需要注意当指定目录不存在时无法正常启动，所以需要手动创建目录（supervisord 会自动创建日志文件）
stdout_logfile=/opt/apache-tomcat-8.0.35/logs/catalina.out
stopasgroup=false     ;默认为false,进程被杀死时，是否向这个进程组发送stop信号，包括子进程
killasgroup=false     ;默认为false，向进程组发送kill信号，包括子进程

;包含其它配置文件
[include]
files = relative/directory/*.ini    ;可以指定一个或多个以.ini结束的配置文件
```
include示例：
```
[include]
files = /opt/absolute/filename.ini /opt/absolute/*.ini foo.conf config??.ini
```

+ 为你的程序创建一个.conf文件，放在目录"/etc/supervisor/conf.d/"下
```
[program:MGToastServer] ;程序名称，终端控制时需要的标识
command=dotnet MGToastServer.dll ; 运行程序的命令
directory=/root/文档/toastServer/ ; 命令执行的目录
autorestart=true ; 程序意外退出是否自动重启
stderr_logfile=/var/log/MGToastServer.err.log ; 错误日志文件
stdout_logfile=/var/log/MGToastServer.out.log ; 输出日志文件
environment=ASPNETCORE_ENVIRONMENT=Production ; 进程环境变量
user=root ; 进程执行的用户身份
stopsignal=INT
```
+ 启动运行supervisord，查看是否生效
运行supervisord服务的时候，需要指定supervisor配置文件，如果没有显示指定，默认在以下目录查找：
```
$CWD/supervisord.conf
$CWD/etc/supervisord.conf
/etc/supervisord.conf
/etc/supervisor/supervisord.conf (since Supervisor 3.3.0)
../etc/supervisord.conf (Relative to the executable)
../supervisord.conf (Relative to the executable)

$CWD表示运行supervisord程序的目录
```

```
supervisord -c /etc/supervisor/supervisord.conf
或者
supervisorctl -c /etc/supervisord.conf
会进入shell界面
然后在指定命令
flack@flack-K43SM:~$ sudo supervisorctl
[sudo] flack 的密码： 
supervisor> help

default commands (type help <topic>):
=====================================
add    exit      open  reload  restart   start   tail   
avail  fg        pid   remove  shutdown  status  update 
clear  maintail  quit  reread  signal    stop    version


supervisord启动成功后，可以通过supervisorctl客户端控制进程，启动、停止、重启。运行supervisorctl命令，不加参数，会进入supervisor客户端的交互终端，并会列出当前所管理的所有进程
ps -ef | grep MGToastServer
```

成功后的效果
```
aaa@flack-K43SM:~$ ps -ef | grep MGToastServer
aaa    20654  4460  0 00:42 pts/0    00:00:00 grep --color=auto MGToastServer
```
###### ps 如果服务已启动，修改配置文件可用“supervisorctl reload”命令来使其生效




4. 配置Supervisor开机启动

+ 新建一个“supervisord.service”文件
```
# dservice for systemd (CentOS 7.0+)
# by ET-CS (https://github.com/ET-CS)
[Unit]
Description=Supervisor daemon
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
ExecStop=/usr/bin/supervisorctl $OPTIONS shutdown
ExecReload=/usr/bin/supervisorctl $OPTIONS reload
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
```
+ 将文件拷贝至"/usr/lib/systemd/system/supervisord.service"
+ 执行命令
```
systemctl enable supervisord.service
systemctl daemon-reload
```

修改文件权限为766
```
chmod 766 supervisord.service
```

+ 执行命令来验证是否为开机启动
```
systemctl is-enabled supervisord
```

### 配置service类型服务
```
#!/bin/bash
#
# supervisord   This scripts turns supervisord on
#
# Author:       Mike McGrath <mmcgrath@redhat.com> (based off yumupdatesd)
#
# chkconfig:    - 95 04
#
# description:  supervisor is a process control utility.  It has a web based
#               xmlrpc interface as well as a few other nifty features.
# processname:  supervisord
# config: /etc/supervisor/supervisord.conf
# pidfile: /var/run/supervisord.pid
#

# source function library
. /etc/rc.d/init.d/functions

RETVAL=0

start() {
    echo -n $"Starting supervisord: "
    daemon "supervisord -c /etc/supervisor/supervisord.conf "
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/supervisord
}

stop() {
    echo -n $"Stopping supervisord: "
    killproc supervisord
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/supervisord
}

restart() {
    stop
    start
}

case "$1" in
  start)
    start
    ;;
  stop) 
    stop
    ;;
  restart|force-reload|reload)
    restart
    ;;
  condrestart)
    [ -f /var/lock/subsys/supervisord ] && restart
    ;;
  status)
    status supervisord
    RETVAL=$?
    ;;
  *)
    echo $"Usage: $0 {start|stop|status|restart|reload|force-reload|condrestart}"
    exit 1
esac

exit $RETVAL
```
将上述脚本内容保存到/etc/rc.d/init.d/supervisor文件中，修改文件权限为755，并设置开机启动
```
chmod 755 /etc/rc.d/init.d/supervisor
chkconfig supervisor on
```
注意：修改脚本中supervisor配置文件路径为你的supervisor的配置文件路径

到此，就算配置完成啦

### 常用的相关管理命令
```
supervisorctl restart <application name>		重启指定应用
supervisorctl stop <application name>			停止指定应用
supervisorctl start <application name>			启动指定应用
supervisorctl restart all						重启所有应用
supervisorctl stop all							停止所有应用
supervisorctl start all							启动所有应用
supervisorctl status							查看程序状态
supervisorctl reread							读取有更新（增加）的配置文件，不会启动新添加的程序
supervisorctl update							重启配置文件修改过的程序
supervisorctl reload 							命令来使其生效
```

### Web管理界面
出于安全考虑，默认配置是没有开启web管理界面，需要修改supervisord.conf配置文件打开http访权限，将下面的配置
```
;[inet_http_server]         ; inet (TCP) server disabled by default
;port=127.0.0.1:9001        ; (ip_address:port specifier, *:port for all iface)
;username=user              ; (default is no username (open server))
;password=123               ; (default is no password (open server))
修改成：
[inet_http_server]         ; inet (TCP) server disabled by default
port=0.0.0.0:9001          ; (ip_address:port specifier, *:port for all iface)
username=user              ; (default is no username (open server))
password=123               ; (default is no password (open server))

port：绑定访问IP和端口，这里是绑定的是本地IP和9001端口
username：登录管理后台的用户名
password：登录管理后台的密码
```
