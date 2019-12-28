# fabric python 远程部署工具

### 简介
Fabric是Python的一个模块，基于SSH提供了丰富的交互接口，可以用来在本地或远程机器上自动化的执行Shell命令，非常适合用来做应用的远程部署及系统维护

>fabric底层基于paramiko（paramiko是用于ssh连接的库）

### 安装Fabric
```
pip3 install fabric -i https://pypi.tuna.tsinghua.edu.cn/simple
```

Fabric默认的脚本文件是fabfile.py，创建该文件并定义以hello函数
```
def hello():
	print('Hello Fabric!')
```

可以使用参数-l来列出当前fabfile.py中定义了哪些任务，然后在fabfile.py目录下执行命令可以看到输出结果：
```
$ fab -l
Available commands:

    hello
    
$ fab hello
Hello Fabric!
```

>fabfile.py中每个函数代表一个任务，任务名即函数名。fab命令用来执行fabfile.py中定义的任务，它必须显示的指定任务名

任务也可以带参数，比如我们将hello函数改为：
```
def hello(name, value):
	print("Hello Fabric! %s %s." % (name, value))
```

此时执行hello任务时需要传入参数：
```
$ fab hello:name=Year,value=2017
```

fabric默认执行的脚本是fabfile.py，如果要换脚本文件需要使用-f指定。比如我们将hello任务放到script.py中就要执行：
```
$ fab -f script.py hello:name=Year,value=2017
```

### 执行本地命令
fabfile.py内容如下：
```
#-*- coding:utf-8 -*-
from fabric.api import local

def taskA():
    local('touch fab.out && echo "fabric" >> fab.out')

def taskB():
    # capture参数可以捕获标准输出存到变量，默认为False
    output = local('echo "Hello World."', capture=True)
    print output

```

执行任务：
```
$ fab taskA taskB
```

### 执行远程命令
Fabric真正强大在于可以很方便的执行远程机器上的Shell命令，它基于SSH实现。
```
#-*- coding:utf-8 -*-
from fabric.api import run, env

# env被称为环境字典，用来配置一些运行环境相关的信息
env.hosts = ['192.168.1.100', '192.168.1.101']
env.user = 'user'
env.password = 'passwd'

def taskA():
    run('cd /usr/local/webserver/php && ls -l')
    run('sudo /usr/local/webserver/nginx/sbin/nginx -t')
```

env.hosts是设置机器列表的，也可以把用户直接写到hosts里：
```
env.hosts = ['user@192.168.1.100', 'user@192.168.1.101']
```

如果代码中没有设置env.hosts，也可以在执行任务时通过-H参数进行指定：
```
$ fab -H 192.168.1.100 taskA
```
>环境字典fabric.state.env是作为全局单例实现的，为方便使用也包含在fabric.api中。env中的键通常也被称为环境变量。

几个常用的环境变量如下：
+ user：可以通过设置env.user来指定Fabric建立SSH连接时使用的用户名（默认使用本地用户名）。
+ password：用来显式设置默认连接或者在需要的时候提供sudo密码。如果没有设置密码或密码错误，Fabric将会提示你输入。
+ passwords：密码字典，针对不同的机器设置密码。
+ warn_only：布尔值，用来设置Fabric是否在检测到远程错误时退出。
+ hosts：全局主机列表。
+ roledefs：定义角色名和主机列表的映射字典。


如果对于不同的服务器想执行不同的任务，上面的程序就做不到了，我们需要对服务器定义角色:
```
#-*- coding:utf-8 -*-
from fabric.api import env, roles, run, execute, cd

env.roledefs = {
    'dev': ['user1@10.216.224.65', 'user2@10.216.224.66'],
    'online': ['user3@45.33.108.82']
}

# host strings必须由username@host:port三部分构成，缺一不可，否则运行时还是会要求输入密码
env.passwords = {
    'user1@10.216.224.65:22': 'passwd1',
    'user2@10.216.224.66:22': 'passwd2',
    'user3@45.33.108.82:22': 'passwd3'
}

@roles('dev')
def taskA():
    with cd('/usr/local/webserver'):
        run('pwd')

@roles('online')
def taskB():
    run('pwd')

def task():
    execute(taskA)
    execute(taskB)
```

然后执行task任务即可：
```
$ fab task
```

Fabric会在dev机器上执行taskA任务，然后在online机器上执行taskB任务。@roles装饰器指定了它所装饰的任务会被哪个角色的服务器执行


### SSH自动登陆
上面的例子都是将登陆密码写到脚本文件里的，这样做不安全，推荐的方法是设置SSH KEY自动登陆。登陆本地机器生成KEY：
```
$ ssh-keygen -t rsa -f ~/.ssh/id_rsa_fabric
```

`
生成密钥对之后将公钥添加到远程服务器的~/.ssh/authorized_keys文件中，就可以实现自动登陆了
`

```
#-*- coding:utf-8 -*-
from fabric.api import env, roles, run, execute, cd

env.hosts = ['10.216.224.65', '10.216.224.66']
env.user = 'user'
env.key_filename = '~/.ssh/id_rsa_fabric'

def taskA():
    with cd('/usr/local/webserver'):
        run('pwd')
```
>authorized_keys文件权限只所有者可写，其他用户均无写权限，否则sshd将认为不安全不允许使用该文件导致还需要输入密码认证


### 上下文管理器

Fabric的上下文管理器是一系列与Python的with语句配合使用的方法，它可以在with语句块内设置当前工作环境的上下文
```
#-*- coding:utf-8 -*-
from fabric.api import env, lcd, local, cd, path, settings, shell_env, prefix, sudo, run

env.hosts = ['10.216.224.66']
env.user = 'user'
env.key_filename = '~/.ssh/id_rsa_fabric'

def task():
    # 设置本地工作目录
    with lcd('/usr/local/webserver'):
        local('touch local.out')

    # 设置远程机器的工作目录
    # sudo功能类似run方法，以超级用户权限执行远程命令
    with cd('/usr/local/webserver'):
        sudo('touch remote.out')

    # 添加远程机器的path路径
    # 出了with语句path又回到原来的值
    with path('/usr/local/webserver'):
        run('echo $PATH')
    run('echo $PATH')

    # 设置Fabric环境变量参数
    # fabric.api.env
    # warn_only设置为True，遇到错误不会退出
    with settings(warn_only=True):
        run('echo $USER')

    # shell_env可以用来临时设置远程和本机上的Shell环境变量
    with shell_env(JAVA_HOME='/opt/java'):
        run('echo $JAVA_HOME')
        local('echo $JAVA_HOME')

    # 设置命令执行前缀，等同于 run('echo Hi && pwd')
    with prefix('echo Hi'):
        run('pwd')
        local('pwd')
```

### 错误处理
默认情况下，Fabric在任务遇到错误时就会退出，如果我们希望捕获这个错误而不是退出任务的话，就要开启warn_only参数。在上面介绍settings()上下文管理器时，我们已经看到了临时开启warn_only的方法了，如果要全局开启，有两个方法：
1. 在执行fab时加上-w参数
```
$ fab -w task
```

2. 设置env.warn_only环境参数为True
```
#-*- coding:utf-8 -*-
from fabric.api import env

env.warn_only = True
```

现在遇到错误时，控制台会打出一个警告信息，然后继续执行后续任务。那我们怎么捕获错误并处理呢？像local/run/sudo/get/put等函数都有返回值，当返回值的succeeded属性为True时，说明执行成功，反之就是失败；也可以检查返回值的failed属性，为True表示执行失败，有错误发生。

```
#-*- coding:utf-8 -*-
from fabric.api import env, local, cd, put

env.hosts = ['10.216.224.66']
env.user = 'liuzhen'
env.key_filename = '~/.ssh/id_rsa_fabric'
env.warn_only=True

def task():
    with cd('/data/server'):
    	local('touch /data/server/README.md')
    	upload = put('/data/server/README.md', 'README.md')
    	if upload.failed:
    	    put('/data/server/README.md', 'README.md', use_sudo=True)
```


### 并行执行
Fabric在多台机器上执行任务时默认情况下是串行的。Fabric支持在多台服务器上并行执行任务，并行可以有效的加快执行速度。开启并行执行有如下两个方法：
1. 在执行fab命令时加上-P参数
```
$ fab -P task
```
2. 设置env.parallel环境参数为True
```
#-*- coding:utf-8 -*-
from fabric.api import env
env.parallel = True
```

以上是对任务并行做一个全局控制。如果只想对某一个任务做并行的话，我们可以在任务函数上加上@parallel装饰器，这样即便全局并行未开启，被@parallel装饰的任务也会并行执行：
```
#-*- coding:utf-8 -*-
from fabric.api import env, run, parallel

env.hosts = ['10.216.224.65', '10.216.224.66']
env.user = 'user'
env.key_filename = '~/.ssh/id_rsa_fabric'

@parallel
def taskA():
    run('echo "parallel"')

def taskB():
    run('echo "serial"')

```

假如全局并行已开启，我们想让某个任务串行执行，我们可以在任务函数上加上@serial装饰器，这样即便并行已开启，被@serial装饰的任务也会串行执行：
```
#-*- coding:utf-8 -*-
from fabric.api import env, run, serial

env.hosts = ['10.216.224.65', '10.216.224.66']
env.user = 'user'
env.key_filename = '~/.ssh/id_rsa_fabric'
env.parallel = True

def taskA():
    run('echo "parallel"')

@serial
def taskB():
    run('echo "serial"')
```

Fabric常规用法这里就基本介绍完了，详细的可以参考官方文档。


