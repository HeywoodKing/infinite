# Ubuntu18+Django2.2+uwsgi+nginx部署详解

## 相关软件版本：
```
Django 2.1.3
Python 3.7
nginx 1.14.0
uwsgi 2.0.18
```
## 服务器：
>Ubuntu 18.04

## 查看系统版本
`cat /etc/issue`
`sudo lsb_release -a`

### 查看系统内核版本
```
cat /proc/version
```

### 查看系统名称
`uname -s`

### 显示linux的内核版本和系统是多少位的：X86_64代表系统是64位的。
```
uname -a
uname -r
```

### 查看本机ip
```
ifconfig -a
```

## 安装数据库（默认安装了就不用安装了）
```
sudo apt-get install mysql-server
sudo apt-get install mysql-client
sudo apt-get install libmysql-dev
sudo apt-get install libmysqlclient-dev
```

## 安装ssh
`sudo apt-get install openssh-server`

## 安装vim
`sudo apt-get install vim`

## 更新pip(这里可以不用更新pip)
`pip3 install --upgrade pip3`


## 安装pipenv
`pip3 install pipenv`

### 创建虚拟环境
```
cd /home/flack/myproject/djangotwo

pipenv --three 
或者
pipenv --python 3.7
```

### 激活pipenv环境
```
pipenv shell
```

### 上传你的项目到服务器，我们要将项目上传到/var/www/下面
在开发环境下保证你的项目能够使用django内置的web服务器跑起来(python manage.py runserver 9090)，然后上传，
这里您可以使用pycharm自带的ssh上传也可以使用ftp(filezilla)工具都可以


### 手动部署
```
在激活的虚拟环境中运行一下命令
pipenv install django
pipenv install django-simpleui
pipenv install pillow
pipenv install pytz
pipenv install sqlparse
pipenv install mysqlclient
安装mysqlclients时可能会报错，

1. 首先在虚拟环境pipenv下卸载刚才报错的mysqlclient,命令：
pipenv uninstall mysqlclient
2. 推出虚拟环境再次安装以下依赖
apt-get install setuptools libmysql-dev libmysqlclient-dev python3.7-dev
3. 进入虚拟环境
pipenv shell
4. 再次安装mysqlclient
pipenv install mysqlclient
```

### 自动部署
```
1. git clone git@xxx/xxx/project.git

2. cd project

3. pipenv shell

4. 如果要安装跟Pipfile.lock版本一致的包，则执行
pipenv sync
如果不需要与Pipfile.lock版本一致，则执行
pipenv install

5. pipenv run python main.py
```

#### 注：确保以上组件或者您的项目所需要的第三方包都已安装

那么此时要做的就是lock,将pipfile第三方包lock住，运行以下命令
`pipenv lock`

此时会将项目所需要的包lock到pipfile.lock里面，接下来收集项目的静态文件命令
`sudo python manage.py collectstatic --noinput`
或者
`sudo python manage.py collectstatic`

在项目目录下和manage.py同级目录创建uwsgi.ini，名称自己起，我这里使用chfweb_uwsgi.ini
内容如下：
```
[uwsgi]

# the socket use the full path to be safe
# socket = /var/www/chfweb/chfweb.sock
# 使用nginx连接时使用
socket = 127.0.0.1:9000
# 直接做web服务器使用
# http = 127.0.0.1:9000

# django-related settings
# the base directory full path
chdir = /var/www/chfweb
# 项目目录
# chdir = E:/MyWork/Project/chf-project/chfweb
# django's wsgi file
module = chfweb.wsgi
# 项目中wsgi.py文件的目录，相对于项目目录
# wsgi-file = chfweb/wsgi.py
# the virtualenv full path
# home = /path/to/virtualenv

# process-related settings
# master
master = true
# maximum number of worker processes
processes = 4
threads = 2
stats = 127.0.0.1:9100
# with appropriate permissions - may be needed
chmod-socket = 666
# clear environment on exit
vacuum = true

pidfile = uwsgi.pid
daemonize = uwsgi.log

```

### 测试项目能否正常运行
首先在该目录下创建一个用于存放项目的文件夹
`sudo mkdir /var/www/project`
此时就可以将项目上传或者拷贝到发布目录，我们复制项目到发布路径（其实只要拷贝项目代码+pipfile.lock即可）
`sudo cp -r /home/flack/myproject/chfweb /var/www/chfweb/`

进入/var/www/chfweb/目录
```
cd /var/www/chfweb/
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser

python manage.py runserver 9000
浏览器访问127.0.0.1:9000查看成功与否
```

到这一步说明你的代码已经上传OK,接下来要安装uwsgi和nginx

### 安装uwsgi
`sudo apt-get install uwsgi`

### 虚拟环境中安装uwsgi
```
pipenv install uwsgi
```

### 测试uwsgi 
在/var/www/下创建一个test
```
sudo mkdir /var/www/test
cd /var/www/test
touch helloworld.py
sudo vim helloworld.py

 然后输入
 def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    return [b'Hello World!']

保存并关闭
按Esc键，输入:wq 回车

测试
uwsgi --http :9000 --wsgi-file helloworld.py 回车
或者
uwsgi --http :9000 --wsgi-file helloworld.py --master --processes 4 --threads 2 --stats 127.0.0.1:9100 回车
```
在浏览器里面输入：http://localhost:9000即可看到Hello World!


```
接着直接测试项目示例：
uwsgi --http :9000 --chdir /var/www/chfweb/ --wsgi-file chfweb/wsgi.py --master --processes 4 --threads 2 --stats 127.0.0.1:9100
```
在浏览器里面输入：http://localhost:9000/admin即可看到django后台管理页面
```
常用选项：
http ： 协议类型和端口号
processes ： 开启的进程数量
workers ： 开启的进程数量，等同于processes（官网的说法是spawn the specified number ofworkers / processes）
chdir ： 指定运行目录（chdir to specified directory before apps loading）
wsgi-file ： 载入wsgi-file（load .wsgi file）
stats ： 在指定的地址上，开启状态服务（enable the stats server on the specified address）
threads ： 运行线程。由于GIL的存在，我觉得这个真心没啥用。（run each worker in prethreaded mode with the specified number of threads）
master ： 允许主进程存在（enable master process）
daemonize ： 使进程在后台运行，并将日志打到指定的日志文件或者udp服务器（daemonize uWSGI）。实际上最常用的，还是把运行记录输出到一个本地文件上。
pidfile ： 指定pid文件的位置，记录主进程的pid号。
vacuum ： 当服务器退出的时候自动清理环境，删除unix socket文件和pid文件（try to remove all of the generated file/sockets）
```

### 接下来，我们要将三者结合起来。首先罗列一下项目的所需要的文件：
```
chfweb/
├── manage.py
├── chfweb/
│ ├── __init__.py
│ ├── settings.py
│ ├── urls.py
│ └── wsgi.py
└── chfweb_uwsgi.ini
```
在我们通过Django创建chfweb项目时，在子目录chfweb下已经帮我们生成的 wsgi.py文件,所以，我们只需要再创建my_uwsgi.ini配置文件即可，当然，uwsgi支持多种类型的配置文件，如xml，ini等。此处，使用ini类型的配置。这一步我们开始的时候已经创建完成了，这个配置，其实就相当于在上一步中通过wsgi命令，后面跟一堆参数的方式，给文件化了。

在项目目录下/var/www/chfweb/运行命令启动uwsgi,看是否成功,注意查看uwsgi的启动信息，如果有错，就要检查配置文件的参数是否设置有误


用ini文件启动uwsgi
```
uwsgi --ini chfweb_uwsgi.ini
```

##### 这里容易犯两个错误:
1. 项目文件没放对地方
2. http和socket弄混了(socket是搭配nginx用的,用uwsgi单独测试要用http)

成功之后


### 安装nginx
```
sudo apt-get install nginx
sudo nginx -v # 查看版本
```

再接下来要做的就是修改nginx.conf配置文件。
打开/etc/nginx/nginx.conf文件，添加如下内容。
```
sudo vim /etc/nginx/nginx.conf # 打开此文件

一定要把以下代码放在http{}中,不然会报错,还要特别注意分号(;)

upstream django{
    # server unix:///var/www/chfweb/chfweb.sock;
    server 127.0.0.1:9000; # 这里要和chfweb_uwsgi.ini中的socket = 127.0.0.1:9000保持一致
}

server{
    listen  8900;
    server_name chinslicking.local;
    charset utf-8;

    # max upload size
    client_max_body_size    75M;

    location /media {
        alias   /var/www/chfweb/uploads;
    }

    location /static {
        expires 30d;
        autoindex on; 
        add_header Cache-Control private;
        alias   /var/www/chfweb/static;
    }

    # finally, send all non-media requests to the django server
    location / {
        include     uwsgi_params;
        uwsgi_pass  django;
        uwsgi_read_timeout 2;
    }
}

```

除了上述要修改nginx.conf文件之外，我们有更好的方式，不需要修改nginx.conf文件，而是在/etc/nginx/sites-available/下创建一个chfweb_nginx.conf

`sudo vim /etc/nginx/sites-available/chfweb_nginx.conf # 打开此文件`
增加如下内容：
```
server{
        listen 8001;
        server_name ip地址; # 添加您服务器外网地址
        charset utf-8;
        client_max_body_size 75M;

        location /static {
                alias /var/www/chfweb/static;
        }

        location /media {
                alias /var/www/chfweb/uploads;
        }

        location / {
                uwsgi_pass 127.0.0.1:8023;
                include /etc/nginx/uwsgi_params;
        }
}
```
然后建立软连接到/etc/nginx/sites-enabled/
```
sudo ln -s ~/path/to/your/mysite/mysite_nginx.conf /etc/nginx/sites-enabled/
或者
sudo ln -s /etc/nginx/sites-available/chfweb_nginx.conf /etc/nginx/sites-enabled/
```

```
/etc/init.d/nginx start #启动
/etc/init.d/nginx stop #停止
/etc/init.d/nginx restart #重启

或者使用systemctl

sudo systemctl status nginx # 检查状态
sudo systemctl start nginx # 启动
sudo systemctl stop nginx # 停止
sudo systemctl restart nginx # 重启
```

现在重新启动nginx，然后浏览器访问：http://127.0.0.1:8900/，通过这个IP和端口号的指向，请求应该是先到nginx的。如果你在页面上执行一些请求，就会看到，这些请求最终会转到uwsgi来处理


最后要给你的项目目录复制权限
```
sudo chmod 777 /var/www/chfweb
sudo chmod 777 /var/www/chfweb/uwsgi.pid
sudo chmod 777 /var/www/chfweb/uwsgi.log
```

这时就完美成功

每次有更新时都要重载uwsgi与nginx才能生效，为了方便uwsgi的重载，在项目目录下新建一个uwsgi文件夹
然后在里面新建两个文件:uwsgi.pid（用于重载停止等操作）和uwsgi.status（用于查看状态）

修改chfweb_uwsgi.ini，把原先的stats那行删掉，下面加上这两行：
```
stats=%(chdir)/uwsgi/uwsgi.status
pidfile=%(chdir)/uwsgi/uwsgi.pid

这样如果项目有更新，就可以使用这两个命令来分别重载uwsgi和nginx了

uwsgi --reload uwsgi/uwsgi.pid
systemctl reload nginx.service
```

```
killall -QUIT uwsgi ，这样会杀死所有的站点uwsgi进程，可能有需要杀各自的进程
@N t s同学给出了linux shell方法，在此感谢。
line=`ps aux|grep uwsgi |grep 'uwsgi ./site1/.'|awk '{print $2}' `
for pid in line;
do
    kill -9 $pid;
done
```

### django项目国际化
```
建立语言文件是通过django-admin makemessages命令完成的。 
在项目的根目录下，也就是包含manage.py的目录下，运行下面的命令：
python manage.py makemessages -l zh_hans
python manage.py makemessages -l en
python manage.py makemessages -l zh_hant

编译语言文件
django-admin compilemessages
或者
python manage.py compilemessages
```






