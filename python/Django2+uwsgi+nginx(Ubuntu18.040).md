# Django2+uwsgi+nginx部署详解（Ubuntu18.04）

## 相关软件版本：
>
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

## 安装之前首先更新系统依赖包
```
sudo apt-get update
sudo apt-get upgrade
```

## 安装python3
## 安装pip
```
建议使用非root用户，部署时最好使用python虚拟环境,系统自带Python3.6、vim和git，所以不用装,
安装python3-pip、python3-setuptools、gcc、python3-dev、wheel：
（缺一不可，不然之后用pip安装uwsgi会有各种各样的报错）
```
sudo apt-get install python3 (如果有python环境可以不装)
sudo apt-get install python3-pip  (如果有pip可以不装)
sudo apt-get install python3-dev #类库和头文件单独的包
sudo apt-get install python-setuptools 
sudo apt-get install wheel

以下如果项目中用不到可以不用安装
sudo apt-get install libxml* #解析xml文件的库
sudo apt-get install net-tools #网络管理命令如:ifconfig是查看本地ip
sudo apt-get install lsof #列出打开文件工具
```

## 安装python3.7
```
1. 直接使用apt-get安装python3.7失败:
sudo apt-get install python3.7

2. 改为手动安装
步骤1：在python官网找到python-3.7.1.tgz的地址：https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

步骤2：下载安装包
wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

步骤3：解压安装包
tar -zxvf Python-3.7.1.tgz

步骤4：切换到解压后的目录下
cd Python-3.7.1

步骤5：./configure（也可以./configure --prefix=/usr/local/python3.7.1）
./configure
# 或者
./configure --prefix=/usr/local/python3.7.1

步骤6：编译make（没有安装make的安装一下）
make

步骤7：测试make test
make test
关于make test命令出现ModuleNotFoundError: No module named ‘_ctypes’ 错误，请移步我的另外一篇博文https://blog.csdn.net/u014775723/article/details/85224447

步骤8：安装sudo make install
sudo make install

若步骤5执行的是 ./configure，则安装后可执行文件默认放在/usr /local/bin，库文件默认放在/usr/local/lib，配置文件默认放在/usr/local/include，其它的资源文件放在/usr /local/share。

若步骤5执行的是./configure --prefix=/usr/local/python3.7.1，则可执行文件放在/usr /local/python3.7.1/bin，库文件放在/usr/local/python3.7.1/lib，配置文件放在/usr/local/python3.7.1/include，其它的资源文件放在/usr /local/python3.7.1/share

步骤9：若步骤5执行./configure --prefix=/usr/local/python3.7.1，则需要添加环境变量。步骤5是./configure的跳过此步骤

添加环境变量
PATH=$PATH:$HOME/bin:/usr/local/python3.7.1/bin

查看环境变量
echo $PATH

步骤10：查看安装目录
可以看到此时python3.7安装到了/usr/local/lib/（若步骤5执行./configure --prefix=/usr/local/python3.7.1，python3.7安装到了/usr/local/python3.7.1/lib/）

步骤11：测试，输入python3.7
```
## 更新python默认指向为python3.7
```
步骤1：查看python命令指向
ls -l /usr/bin | grep python

步骤2：若如步骤1的图，若要安装python3.4则，由于python3.4为系统自带的，直接使用以下命令并跳过步骤3：
删除原有链接
rm /usr/bin/python 

建立新链接
ln -s /usr/bin/python3.4 /usr/bin/python

步骤3：由于python3.7是自己安装的，不在/usr/bin下，而在usr/local/bin或者/usr/local/python3.7.1/bin下（取决于前面执行的./configure还是./configure --prefix=/usr/local/python3.7.1。因此需要先加一条软链接并且把之前的python命令改为python.bak，同时pip也需要更改。依次执行以下命令

若python3.7安装时，执行的是./configure，则：
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/bin/python3 /usr/bin/python
mv /usr/bin/pip /usr/bin/pip.bak
ln -s /usr/local/bin/pip3 /usr/bin/pip

若python3.7安装时，执行的是./configure --prefix=/usr/local/python3.7.1，则为：
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/python3.7.1/bin/python3.7 /usr/bin/python
mv /usr/bin/pip /usr/bin/pip.bak
ln -s /usr/local/python3.7.1/bin/pip3 /usr/bin/pip

步骤4：此时输入python验证
```

## 测试python是否安装完成，如果原来是python但是版本低，需要设置python默认优先级
```
查看python指向
ls -l /usr/bin | grep python

调整优先级
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --config python3
```

## 以上安装python3.7版本太麻烦，为了更好的管理python多个版本，推荐使用pyenv版本管理工具
```
参考地址：https://github.com/pyenv/pyenv#basic-github-checkout

1.Check out pyenv where you want it installed. A good place to choose is $HOME/.pyenv (but you can install it somewhere else).
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv

2.Define environment variable PYENV_ROOT to point to the path where pyenv repo is cloned and add $PYENV_ROOT/bin to your $PATH for access to the pyenv command-line utility.
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

3.Add pyenv init to your shell to enable shims and autocompletion. Please make sure eval "$(pyenv init -)" is placed toward the end of the shell configuration file since it manipulates PATH during the initialization.
$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

4.Restart your shell so the path changes take effect. You can now begin using pyenv.
$ exec "$SHELL" -l

接下来你就可以自如的安装你想要的版本了
$ pyenv install 3.7.3
```

## 查看已经安装的python版本：
`pyenv versions`

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

我的项目是在本机的home/flack/myproject/
下,而且我的项目本身用的就是pipenv虚拟环境，会在根目录下存在pipfile 和 pipfile.lock两个文件
这两个文件的生成是这样的
首先进入到你的django项目根目录，然后输入以下命令（确保已经安装了pipenv虚拟环境）

### 手动部署
```
pipenv --three 
或者
pipenv --python 3.7

然后激活pipenv环境
pipenv shell

在激活的虚拟环境中运行一下命令
pipenv install django
pipenv install django-simpleui
pipenv install pillow
pipenv install pytz
pipenv install sqlparse
pipenv install mysqlclient
安装mysqlclients时可能会报错，
>
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
1. git clone project.git

2. cd project

3. pipenv shell

4. 如果要安装跟Pipfile.lock版本一致的包，则执行
pipenv sync
如果不需要与Pipfile.lock版本一致，则执行
pipenv install

5. pipenv run python main.py
```

#### 注：确保以上组件或者您的项目所需要的第三方包都已安装
在开发环境下保证你的项目能够使用django内置的web服务器跑起来(python manage.py runserver 9090)

那么此时要做的使用就是lock,将pipfile第三方包lock住，运行以下命令
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
# socket = /opt/project/chf-project/chfweb/chfweb.sock
# 使用nginx连接时使用
socket = 127.0.0.1:9000
# 直接做web服务器使用
# http = 127.0.0.1:9000

# django-related settings
# the base directory full path
chdir = /opt/project/chf-project/chfweb
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



## 安装django
`sudo pip3 install django`

以上安装完都是安装到ubuntu系统上的组件

这里我需要部署到ubuntu上的虚拟环境下，我这里使用的是pipenv虚拟环境
## 安装pipenv
`pip install pipenv`

## 安装django
`pipenv install django`

## 上传你的项目，我们要将项目上传到/opt/下面
首先在该目录下创建一个用于存放项目的文件夹
`sudo mkdir /opt/project`
此时就可以将项目上传或者拷贝到发布目录，我们复制项目到发布路径（其实只要拷贝项目代码+pipfile.lock即可）
`sudo cp -r /home/flack/myproject/chf-project /opt/project/`

进入/opt/project/chf-project/chfweb/目录
```
cd /opt/project/chf-project/chfweb/
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser

python manage.py runserver 9000
浏览器访问127.0.0.1:9000查看成功与否
```

到这一步说明你的代码已经上传OK,接下来要安装uwsgi和nginx

安装 uwsgi
`sudo apt-get install uwsgi`

测试uwsgi 在/opt/project/下创建一个test
```
sudo mkdir /opt/project/test
cd /opt/project/test
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
uwsgi --http :9000 --chdir /opt/project/chf-project/chfweb/ --wsgi-file chfweb/wsgi.py --master --processes 4 --threads 2 --stats 127.0.0.1:9100
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

在项目目录下/opt/project/chf-project/chfweb/运行命令启动uwigs,看是否成功,注意查看uwsgi的启动信息，如果有错，就要检查配置文件的参数是否设置有误


用ini文件启动uwsgi
uwsgi --ini chfweb_uwsgi.ini

## 这里容易犯两个错误:
1. 项目文件没放对地方
2. http和socket弄混了(socket是搭配nginx用的,用uwsgi单独测试要用http)

成功之后安装nginx
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
    # server unix:///opt/project/chf-project/chfweb/chfweb.sock;
    server 127.0.0.1:9000; # 这里要和chfweb_uwsgi.ini中的socket = 127.0.0.1:9000保持一致
}

server{
    listen  8900;
    server_name chinslicking.local;
    charset utf-8;

    # max upload size
    client_max_body_size    75M;

    location /media {
        alias   /opt/project/chf-project/chfweb/uploads;
    }

    location /static {
        expires 30d;
        autoindex on; 
        add_header Cache-Control private;
        alias   /opt/project/chf-project/chfweb/static;
    }

    # finally, send all non-media requests to the django server
    location / {
        include     uwsgi_params;
        uwsgi_pass  django;
        uwsgi_read_timeout 2;
    }
}

```

除了上述要修改nginx.conf文件之外，我们有更好的方式，不需要修改nginx.conf文件，而是在/etc/nginx/sites-available/下创建一个chinslickingweb_nginx.conf

`sudo vim /etc/nginx/sites-available/chinslickingweb_nginx.conf # 打开此文件`
增加如下内容：
```
server{
        listen 8001;
        server_name ip地址; # 添加您服务器外网地址
        charset utf-8;
        client_max_body_size 75M;

        location /static {
                alias /var/www/chinslickingweb/static;
        }

        location /media {
                alias /var/www/chinslickingweb/uploads;
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
sudo ln -s /etc/nginx/sites-available/chinslickingweb_nginx.conf /etc/nginx/sites-enabled/
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
sudo chmod 777 /opt/project/chf-project/chfweb
sudo chmod 777 /opt/project/chf-project/chfweb/uwsgi.pid
sudo chmod 777 /opt/project/chf-project/chfweb/uwsgi.log
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

```
vim的使用方法:
光标：j 下   k 上  H 左 L右
    i --当前光标下进入编辑模式  
    ESC --退出编辑模式
    a --当前光标下一个字符进入编辑模式
    A --尾行进入编辑模式
    dd --删除整行
    dG --删除光标所在行到文件最后一行所有内容
    dgg --删除光标所在行到文件第一行所有内容
    u --返回上一次修改状态
    wq --保存退出
    q! --放弃打开文件后的所有修改退出
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






