使用 Gunicorn 运行程序
flask run 命令启动的开发服务器是由 Werkzeug 提供的。细分的话， Werkzeug 提供的这个开发服务器应该被称为 WSGI 服务器，而不是单纯意义上的 Web 服务器。在生产环境中，我们需要一个更强健、性能更高的 WSGI 服务器。这些 WSGI 服务器也被称为独立 WSGI 容器，因为它们可以承载我们编写的 WSGI 程序，然后处理 HTTP 请求和响应。这通常有很多选择，比如 Gunicorn 。 Gunicorn 是 Green Unicorn 的简写，意为绿色独角兽，是一款专为 UNIX 设计的 Python WSGI HTTP 服务器。是一个Pre-fork 工人模型。Gunicorn 服务器广泛兼容各种 web 框架，实现简单，节省服务器资源，速度相当快。

安装 Gunicorn ：

$ pipenv install gunicorn
使用 Gunicorn 运行一个 WSGI 程序：

$ pipenv run gunicorn --workers=4 --bind=0.0.0.0:8000 app:app
# --workers = 4 表示使用 4 worker 进程运行程序，建议 worker 数量为 ( CPU 核心数 × 2 ) + 1
# Gunicorn 默认只允许从本地 8000 端口访问，--bind=0.0.0.0:8000 表示允许使用 8000 端口从外部访问
# app:app 冒号前面的 app 表示 app.py 文件，冒号后面的 app 表示 flask 程序的名称
也可以把 --workers 简写为 -w 、--bind 简写为 -b ，如下：

# 没有 -b 或者 --bind 参数，默认监听 127.0.0.1:8000
$ pipenv run gunicorn -w 4 app:app

# 指定 -b 0.0.0.0:8000 监听 8000 端口的外部请求
$ pipenv run gunicorn -w 4 -b 0.0.0.0:8000 app:app
9. 使用 Nginx 提供反向代理
像 Gunicorn 这类 WSGI 服务器内置的 Web 服务器还不够强健，虽然程序可以正常运行，但是更流行的部署方式是使用一个常规的 Web 服务器运行在前端，为 WSGI 提供反向代理。比较流行的开源 Web 服务器有 Nginx 、Apache 等，这里选择使用和 Gunicorn 集成良好的 Nginx 。

访问 nginx packages 获取对应版本 Nginx 的 Yum 仓库的链接，例如：

http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
下载 Nginx Yum 仓库文件：

$ wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
安装 Nginx Yum 仓库文件：

$ sudo yum localinstall nginx-release-centos-7-0.el7.ngx.noarch.rpm
安装 Nginx ：

$ sudo yum install nginx
进入 Nginx 配置文件目录：

$ cd /etc/nginx/
创建 cert 目录，并上传你的 SSL 证书到该目录：

$ mkdir cert
上传 SSL 证书到 cert 目录你可以使用 scp 命令，或者使用 FileZilla 等 SFTP 软件，我上传的文件如下：

$ cd cert
$ ls
ssl.key  ssl.pem
进入 /etc/nginx/conf.d/ 目录编辑默认的配置文件 default.conf：

$ cd /etc/nginx/conf.d/
$ vim default.conf
删除文件中原有的全部内容，新增下面内容并保存：

# 监听 http 请求，强制跳转到 https
server {
    listen      80;
    
    # 这里的 your.domain.com 换成你购买的域名
    server_name your.domain.com;
    
    # 这里的 your.domain.com 换成你购买的域名
    return 301 https://your.domain.com$request_uri;
}

# 监听 https 请求
server {
    listen      443;
    
    # 这里的 your.domain.com 换成你购买的域名
    server_name your.domain.com;
    
    access_log  /var/log/nginx/host.access.log;
    error_log   /var/log/nginx/host.error.log;

    ssl on;
    
    # 这部分的 ssl.pem ssl.key 换成你上传的与其对应的文件
    ssl_certificate             cert/ssl.pem;
    ssl_certificate_key         cert/ssl.key;

    ssl_session_cache           shared:SSL:1m;
    ssl_session_timeout         5m;

    ssl_protocols               TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers                 ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_prefer_server_ciphers   on;

    location / {
        # 转发请求给 Gunicorn
        proxy_pass      http://127.0.0.1:8000;
        proxy_redirect  off;
        
        # 为了能正常运行，重写请求头
        proxy_set_header    Host                $host;
        proxy_set_header    X-Real-IP           $remote_addr;
        proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto   $scheme;
    }
    
    # 处理静态文件夹中的静态文件
    location /static {
        alias   /home/admin/FlaskApp/static/;
        
        # 设置静态文件缓存过期时间为 30 天
        expires  30d;
    }
}
测试配置正确性：

$ sudo nginx -t
如果出现的提示中没有报错，则可以启动 nginx 了。

启动 nginx ：

$ sudo nginx
现在，你可以使用 Gunicorn 不指定 --bind 参数运行 Flask 程序，然后尝试从外网通过 HTTPS 访问，判断 nginx 反向代理是否设置成功。

使用 nginx 命令管理 Nginx ：

$ sudo nginx            # 启动 Nginx 服务
$ sudo nginx -s stop    # 关闭 Nginx 服务
$ sudo nginx -s reload  # 重载 Nginx 服务
$ sudo nginx -s reopen  # 重启 Nginx 服务
$ sudo nginx -s quit    # 退出 Nginx 服务
使用 service 命令管理 Nginx 服务：

$ sudo service nginx start          # 启动 Nginx 服务
$ sudo service nginx stop           # 停止 Nginx 服务
$ sudo service nginx restart        # 重启 Nginx 服务
$ sudo service nginx status         # 查看 Nginx 服务状态
使用 systemctl 命令管理 Nginx 服务：

$ sudo systemctl start nginx   # 启动 Nginx 服务
$ sudo systemctl stop nginx    # 停止 Nginx 服务
$ sudo systemctl restart nginx # 重启 Nginx 服务
$ sudo systemctl status nginx  # 查看 Nginx 服务状态
$ sudo systemctl enable nginx  # 设置 Nginx 服务开机自启动
$ sudo systemctl disable nginx # 关闭 Nginx 服务开机自启动
如果 Nginx 已经启动却又被启动了一次，可能会报错。比如：找不到 nginx.pid 文件、提示 XX 端口已经被使用等等...，解决办法如下：

# 杀掉占用 80 端口的进程
$ sudo fuser -k 80/tcp

# 杀掉占用 443 端口的进程
$ sudo fuser -k 443/tcp

# 使用默认配置文件重新启动 Nginx
$ sudo nginx -c /etc/nginx/nginx.conf
10. 使用 Supervisor 管理进程
Supervisor 是用 Python 开发的一套通用的进程管理程序，能将一个普通的命令行进程变为后台 daemon ，并监控进程状态，异常退出时能自动重启。它是通过 fork/exec 的方式把这些被管理的进程当作 Supervisor 的子进程来启动，这样只要在 Supervisor 的配置文件中把要管理的进程的可执行文件的路径写进去即可。也实现当子进程挂掉的时候，父进程可以准确获取子进程挂掉的信息的，可以选择是否自己启动和报警。Supervisor 还提供了一个功能，可以为 supervisord 或者每个子进程设置一个非 root 的用户，这个用户就可以管理它对应的进程。

安装 Supervisor ：

$ sudo yum install supervisor
检查 Supervisor 配置文件：

$ vim /etc/supervisord.conf
找到最后一行，检查是否是如下内容：

[include]
files = supervisord.d/*.ini
如果不是，则修改文件使其跟上面内容一致。

进入 /etc/supervisord.d/ 目录， 为项目创建一个 Supervisor 配置文件：

$ cd /etc/supervisord.d/
$ vi FlaskApp.ini
配置文件内容为：

[program:app]
; 下面命令中的 app:app 请修改为你实际部署时的项目名称
command=pipenv run gunicorn -w 4 app:app

; 下面的路径请修改为你创建的项目的根目录
directory=/home/admin/FlaskApp

autostart=true
autorestart=true
stopsignal=QUIT
stopasgroup=true
killasgroup=true

; 下面的用户请修改为创建该项目的用户
user=admin

redirect_stderr=true

; log 文件的路径你可以重新自定义
stdout_logfile=/home/admin/FlaskApp/log/supervisor.log

; 解决编码问题
[supervisord]
environment=LC_ALL='en_US.UTF-8',LANG='en_US.UTF-8'
启动 Supervisor ：

$ supervisord -c /etc/supervisord.conf
使用 service 命令管理 Supervisor 服务：

$ sudo service supervisord start          # 启动 Supervisor 服务
$ sudo service supervisord stop           # 停止 Supervisor 服务
$ sudo service supervisord restart        # 重启 Supervisor 服务
$ sudo service supervisord status         # 查看 Supervisor 服务状态
使用 systemctl 命令管理 Supervisor 服务：

$ sudo systemctl start supervisord   # 启动 Supervisor 服务
$ sudo systemctl stop supervisord    # 停止 Supervisor 服务
$ sudo systemctl restart supervisord # 重启 Supervisor 服务
$ sudo systemctl status supervisord  # 查看 Supervisor 服务状态
$ sudo systemctl enable supervisord  # 设置 Supervisor 服务开机自启动
$ sudo systemctl disable supervisord # 关闭 Supervisor 服务开机自启动
进入 Supervisor 控制台，管理后台进程：

$ sudo supervisorctl
app                              RUNNING   pid 2696, uptime 23:46:00
supervisor > help # 输入 help 命令，查看 supervisor 支持的命令

default commands (type help <topic>):
=====================================
add    clear  fg        open  quit    remove  restart   start   stop  update
avail  exit   maintail  pid   reload  reread  shutdown  status  tail  version
使用 status 命令，查看正在运行的后台进程：

supervisor> status
app                              RUNNING   pid 2696, uptime 23:49:37
使用 stop 命令，结束指定的进程：

supervisor> stop app
app: stopped
使用 start 命令，启动指定的进程：

supervisor> start app
app: started
测试，你可以先使用 Supervisor 运行进程，再通过外网访问页面，检查是否正常访问；再结束进程，看看页面是否显示 502 Bad Gateway 。