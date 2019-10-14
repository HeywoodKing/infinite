## Ubuntu 18.0.4安装docker

###第一步：如果之前安装过docker，执行下面命令删除
apt-get remove docker docker-engine docker.io
删除后执行sudo apt-get update更新软件

###第二步：安装必要的软件包以允许apt通过HTTPS使用存储库，具体如下：
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

###第三步：添加GPG密钥，可以添加官方的和阿里的，我添加 的阿里的，国内的快啊
```
官方
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
阿里
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```

添加完毕后可以执行以下命令验证：
`sudo apt-key fingerprint 0EBFCD88`

正常情况下会输出如下内容：
```
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ 未知 ] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```
说明 Ok，继续

###第四步：设定稳定仓储库，这一步我被 坑了好久，具体参考

docker配置仓储库时出错：无法安全地用该源进行更新，所以默认禁用该源
也可以不设置，不设置默认使用官方的，具体是：deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
同样可以用阿里 的镜像：设置命令如下：
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
其中的lsb_release -cs相当于一个函数，直接获取Ubuntu下的最新版本

设置完毕再次执行sudo apt-get update命令更新 软件包。

###第五步：安装docker，如下：

sudo apt-get -y install docker-ce
也可以指定想安装 的docker版本，方法 如下：

执行如下命令命令查看有哪些版本，
apt-cache madison docker-ce
输出如下：

复制代码
```
docker-ce | 5:18.09.0~3-0~ubuntu-bionic | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages

docker-ce | 18.06.1~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages

docker-ce | 18.06.0~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages

docker-ce | 18.03.1~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
```
选择要安装的版本，执行
`sudo apt-get install -y docker-ce=<VERSION>`
命令即可。

###安装完成 后执行docker -v命令，
如果正常输出说明安装成功，下面继续填坑吧。
```
搜索镜像：docker search ubuntu
获取镜像：docker pull ubuntu
查看镜像id：docker images -q 
删除镜像：docker rmi image_id 
删除所有镜像：docker rmi $(docker images -q) 
创建容器：docker run --name <container_name> centos:7,container_name是自己定义的容器名 
查看所有容器：docker ps -a 
查看运行容器：docker ps 
查看容器id：docker ps -q 
进入容器：docker exec -it <container_id> bash 
退出容器：exit 
删除容器：docker rm <container_id> 
删除所有容器：docker rm $(docker ps -aq) 
端口映射：docker run -d -p 8080:80 hub.c.163.com/library/nginx
说明：-d 表示后台运行，-p 8080:80 表示将宿主机的8080端口映射到容器端口80。容器开放的端口在镜像说明里面会有，nginx开放80，mysql开放3306，一般本来他们监听什么端口，容器就开放什么端口

启动/停止/重启容器：
docker start/stop/restart <container_id> 

获取容器/镜像的元数据：
docker inspect <container_id> 

挂载数据卷：
docker run -v host/machine/dir :container/path/dir --name volume_test_container centos:7
说明：数据卷的挂载相当于在宿主机的目录与容器目录创建了一个链接，你修改任何一方的内容，另一方的内容也会同步修改。创建数据卷的作用：当容器被删除的时候，容器内的数据也一起被删除。像数据库、媒体资源等文件我们通常都会使用 -v 将容器中的内容链接到宿主机，这样我们重新创建容器的时候再次-v，数据又回来了

启动mysql容器：
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=qwerasdf -d mysql:5.7 
默认用户为root，密码qwerasdf
mysql容器启动后，其他容器就可以来连接使用了，方法如下：
容器连接：
docker run --name some-app --link some-mysql:mysql -d application-that-uses-mysql
```

##十分钟学会用docker部署微服务
![docker](https://oscimg.oschina.net/oscnet/f23f11d5dd57c2cf07aee5239c9ebffbb70.jpg "docker")

###Docker简介
Docker是一个开源的容器引擎，它有助于更快地交付应用。 Docker可将应用程序和基础设施层隔离，并且能将基础设施当作程序一样进行管理。使用 Docker可更快地打包、测试以及部署应用程序，并可以缩短从编写到部署运行代码的周期。

Docker的优点如下：

1. 简化程序
Docker 让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，便可以实现虚拟化。Docker改变了虚拟化的方式，使开发者可以直接将自己的成果放入Docker中进行管理。方便快捷已经是 Docker的最大优势，过去需要用数天乃至数周的 任务，在Docker容器的处理下，只需要数秒就能完成。

2. 避免选择恐惧症
如果你有选择恐惧症，还是资深患者。Docker 帮你 打包你的纠结！比如 Docker 镜像；Docker 镜像中包含了运行环境和配置，所以 Docker 可以简化部署多种应用实例工作。比如 Web 应用、后台应用、数据库应用、大数据应用比如 Hadoop 集群、消息队列等等都可以打包成一个镜像部署。

3. 节省开支
一方面，云计算时代到来，使开发者不必为了追求效果而配置高额的硬件，Docker 改变了高性能必然高价格的思维定势。Docker 与云的结合，让云空间得到更充分的利用。不仅解决了硬件管理的问题，也改变了虚拟化的方式。

###Docker架构 
![Docker架构 ](https://oscimg.oschina.net/oscnet/4b0f439b7bb3d382139a82db0260075b5ba.jpg "Docker架构 ")

+ Docker daemon（ Docker守护进程）
Docker daemon是一个运行在宿主机（ DOCKER-HOST）的后台进程。可通过 Docker客户端与之通信。

+ Client（ Docker客户端）
Docker客户端是 Docker的用户界面，它可以接受用户命令和配置标识，并与 Docker daemon通信。图中， docker build等都是 Docker的相关命令。

+ Images（ Docker镜像）
Docker镜像是一个只读模板，它包含创建 Docker容器的说明。它和系统安装光盘有点像，使用系统安装光盘可以安装系统，同理，使用Docker镜像可以运行 Docker镜像中的程序。

+ Container（容器）
容器是镜像的可运行实例。镜像和容器的关系有点类似于面向对象中，类和对象的关系。可通过 Docker API或者 CLI命令来启停、移动、删除容器。

+ Registry
Docker Registry是一个集中存储与分发镜像的服务。构建完 Docker镜像后，就可在当前宿主机上运行。但如果想要在其他机器上运行这个镜像，就需要手动复制。此时可借助 Docker Registry来避免镜像的手动复制。

一个 Docker Registry可包含多个 Docker仓库，每个仓库可包含多个镜像标签，每个标签对应一个 Docker镜像。这跟 Maven的仓库有点类似，如果把 Docker Registry比作 Maven仓库的话，那么 Docker仓库就可理解为某jar包的路径，而镜像标签则可理解为jar包的版本号。

###Docker安装
Docker 是一个开源的商业产品，有两个版本：社区版（Community Edition，缩写为 CE）和企业版（Enterprise Edition，缩写为 EE）。企业版包含了一些收费服务，个人开发者一般用不到。下面的介绍都针对社区版。

Docker CE 的安装请参考官方文档。以下列出不同操作系统的安装方法，直接点击进入查看
[Mac](https://docs.docker.com/docker-for-mac/install/ "Mac")
[Windows](https://docs.docker.com/docker-for-windows/install/ "Windows")
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/ "Ubuntu")
[Debian](https://docs.docker.com/install/linux/docker-ce/debian/ "Debian")
[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/ "CentOS")
[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/ "Fedora")
[其他 Linux 发行版](https://docs.docker.com/install/linux/docker-ce/binaries/ "其他 Linux 发行版")

这里以CentOS为例：

1.Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker 。

通过 uname -r 命令查看你当前的内核版本

`uname -r`

2.使用 root 权限登录 Centos。确保 yum 包更新到最新。

`yum -y update`

3.卸载旧版本(如果安装过旧版本的话)

`yum remove docker docker-common docker-selinux docker-engine`

4.安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

`yum install -y yum-utils device-mapper-persistent-data lvm2`

5.设置yum源

`yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`

6.可以查看所有仓库中所有docker版本，并选择特定版本安装

`yum list docker-ce --showduplicates | sort -r`

![查看所有仓库中所有docker版本](https://oscimg.oschina.net/oscnet/c4d2d3fa03fa71d6dee4e623f2b6e02f77d.jpg "查看所有仓库中所有docker版本")

7.安装docker

`sudo yum install -y docker-ce     #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版18.03.1`

8.启动并加入开机启动
```
systemctl start docker
systemctl enable docker
```

9.验证安装是否成功(有client和service两部分表示docker安装启动都成功了)

`docker version`

![验证安装是否成功](https://oscimg.oschina.net/oscnet/61265623f6eb9d1d8bde3116dcb898e7cb6.jpg "验证安装是否成功")

10.卸载docker

`yum -y remove docker-engine`

###Docker常用命令
####镜像相关命令
1. 搜索镜像

可使用 docker search命令搜索存放在 Docker Hub(这是docker官方提供的存放所有docker镜像软件的地方，类似maven的中央仓库)中的镜像。执行该命令后， Docker就会在Docker Hub中搜索含有 java这个关键词的镜像仓库。
```
docker search python
docker search httpd
```
![搜索镜像](https://oscimg.oschina.net/oscnet/a1dbbedab9f66b84a1cd6025c026f0f79fb.jpg "搜索镜像")
```
以上列表包含五列，含义如下：
- NAME:镜像仓库名称。
- DESCRIPTION:镜像仓库描述。
- STARS：镜像仓库收藏数，表示该镜像仓库的受欢迎程度，类似于 GitHub的 stars0
- OFFICAL:表示是否为官方仓库，该列标记为[0K]的镜像均由各软件的官方项目组创建和维护。
- AUTOMATED：表示是否是自动构建的镜像仓库。
注意：使用docker查找或下载镜像可能会超时，所以我们需要为docker配置国内的镜像加速器
我们可以借助阿里云的镜像加速器，登录阿里云(https://cr.console.aliyun.com/#/accelerator)
```
可以看到镜像加速地址如下图：

![示例](https://oscimg.oschina.net/oscnet/81362bf392bbdfc6b232641215af59cf438.jpg "示例")

```
cd /etc/docker
查看有没有 daemon.json。这是docker默认的配置文件。如果没有新建，如果有，则修改。
vim daemon.json
{
"registry-mirrors": ["https://m9r2r2uj.mirror.aliyuncs.com"]
}

保存退出并重启docker服务
service docker restart
```
2. 下载镜像 获取一个新的镜像

```
使用命令docker pull命令即可从 Docker Registry上下载镜像，执行该命令后，Docker会从 Docker Hub中的 java仓库下载最新版本的 Java镜像。如果要下载指定版本则在java后面加冒号指定版本，例如：docker pull java:8

docker pull java:8
docker pull ubuntu:13.10
docker pull httpd
下载完成后，我们可以直接使用这个镜像来运行容器。
```
![java:8](https://oscimg.oschina.net/oscnet/9075decf748113d41ca48fa35230a2d60d4.jpg "java:8")

3. 列出镜像
```
使用 docker images命令即可列出已下载的镜像
docker images
```
![镜像](https://oscimg.oschina.net/oscnet/b649652e175fe794d45811420dbf9087f38.jpg "镜像")
```
以上列表含义如下
- REPOSITORY：镜像所属仓库名称。
- TAG:镜像标签。默认是 latest,表示最新。
- IMAGE ID：镜像 ID，表示镜像唯一标识。
- CREATED：镜像创建时间。
- SIZE: 镜像大小。
```

4. 删除本地镜像
```
使用 docker rmi命令即可删除指定镜像
docker rmi java
```

5. 创建镜像
当我们从docker镜像仓库中下载的镜像不能满足我们的需求时，我们可以通过以下两种方式对镜像进行更改。
- 从已经创建的容器中更新镜像，并且提交这个镜像
- 使用 Dockerfile 指令来创建一个新的镜像

6. 更新镜像
```
更新镜像之前，我们需要使用镜像来创建一个容器。
runoob@runoob:~$ docker run -t -i ubuntu:15.10 /bin/bash

在运行的容器内使用 apt-get update 命令进行更新。
在完成操作之后，输入 exit命令来退出这个容器。
此时ID为e218edb10161的容器，是按我们的需求更改的容器。我们可以通过命令 docker commit来提交容器副本
runoob@runoob:~$ docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2

各个参数说明：
-m:提交的描述信息
-a:指定镜像作者
e218edb10161：容器ID
runoob/ubuntu:v2: 指定要创建的目标镜像名

我们可以使用 docker images 命令来查看我们的新镜像 runoob/ubuntu:v2：
runoob@runoob:~$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
runoob/ubuntu       v2                  70bf1840fd7c        15 seconds ago      158.5 MB
ubuntu              14.04               90d5884b1ee0        5 days ago          188 MB
php                 5.6                 f40e9e0f10c8        9 days ago          444.8 MB
nginx               latest              6f8d099c3adc        12 days ago         182.7 MB
mysql               5.6                 f2e8d6c772c0        3 weeks ago         324.6 MB
httpd               latest              02ef73cf1bc0        3 weeks ago         194.4 MB
ubuntu              15.10               4e3b13c8a266        4 weeks ago         136.3 MB
hello-world         latest              690ed74de00f        6 months ago        960 B
training/webapp     latest              6fae60ef3446        12 months ago       348.8 MB

使用我们的新镜像 runoob/ubuntu 来启动一个容器
runoob@runoob:~$ docker run -t -i runoob/ubuntu:v2 /bin/bash        
root@1a9fbdeb5da3:/#
```

7. 

###容器相关命令
1. 新建并启动容器
```
使用以下docker run <镜像名>命令即可新建并启动一个容器，该命令是最常用的命令，它有很多选项，下面将列举一些常用的选项。
docker run -d -p 91:80 nginx

这样就能启动一个 Nginx容器。在本例中，为docker run添加了两个参数，含义如下：
-d 后台运行
-p 宿主机端口:容器端口     #开放容器端口到宿主机端口
```
访问 http://Docker宿主机 IP:91/，将会看到nginx的主界面如下：
![示例](https://oscimg.oschina.net/oscnet/ed9b3114c4b2044d7a588473471a66cf44c.jpg "示例")

需要注意的是，使用 docker run命令创建容器时，会先检查本地是否存在指定镜像。如果本地不存在该名称的镜像， Docker就会自动从 Docker Hub下载镜像并启动一个 Docker容器。
```
该命令还有一个网络配置参数，如下所示
--net选项：指定网络模式，该选项有以下可选参数：
--net=bridge:默认选项，表示连接到默认的网桥。
--net=host:容器使用宿主机的网络。
--net=container:NAME-or-ID：告诉 Docker让新建的容器使用已有容器的网络配置。
--net=none：不配置该容器的网络，用户可自定义网络配置。
```

2. 列出容器
```
用 docker ps命令即可列出运行中的容器
docker ps

如需列出所有容器（包括已停止的容器），可使用-a参数。
docker ps -a

该列表包含了7列，含义如下
- CONTAINER_ID：表示容器 ID。
- IMAGE:表示镜像名称。
- COMMAND：表示启动容器时运行的命令。
- CREATED：表示容器的创建时间。
- STATUS：表示容器运行的状态。UP表示运行中， Exited表示已停止。
- PORTS:表示容器对外的端口号。
- NAMES:表示容器名称。该名称默认由 Docker自动生成，也可使用 docker run命令的--name选项自行指定。
```

3. 停止容器
```
使用 docker stop <容器id>命令，即可停止容器
docker stop 容器ID|容器名
当然也可使用 docker stop容器名称来停止指定容器
```

4. 强制停止容器
```
可使用 docker kill <容器id>命令发送 SIGKILL信号来强制停止容器
docker kill f0b1c8ab3633
```

5. 启动已停止的容器
```
使用docker run命令，即可新建并启动一个容器。对于已停止的容器，可使用 docker start <容器id>命令来启动
docker start f0b1c8ab3633
```

6. 查看容器所有信息
```
使用命令docker inspect <容器id>
docker inspect f0b1c8ab3633
```

7. 查看容器日志
```
使用命令docker container logs <容器id>
docker container logs f0b1c8ab3633
```

8. 查看容器里的进程
```
使用命令docker top <容器id>
docker top f0b1c8ab3633
```

9. 进入容器
```
使用docker container exec -it <容器id> /bin/bash

命令用于进入一个正在运行的docker容器。如果docker run命令运行容器的时候，没有使用-it参数，就要用这个命令进入容器。一旦进入了容器，就可以在容器的 Shell 执行命令了

docker container exec -it f0b1c8ab3633 /bin/bash
```

10. 删除容器
```
使用 docker rm命令即可删除指定容器
docker rm f0b1c8ab3633
该命令只能删除已停止的容器，如需删除正在运行的容器，可使用-f参数
```

###构建自己的docker镜像
使用Dockerfile构建自己的Docker镜像,
Dockerfile是一个文本文件，其中包含了若干条指令，指令描述了构建镜像的细节,先来编写一个最简单的Dockerfile，以前文下载的Nginx镜像为例，来编写一个Dockerfile修改该Nginx镜像的首页

1. 新建文件夹/app，在app目录下新建一个名为Dockerfile的文件，在里面增加如下内容：
```
FROM nginx    #从本地的镜像仓库里拉取ngxin的docker镜像
RUN echo 'This is QingFeng Nginx!!!' > /usr/share/nginx/html/index.html    

修改ngxin的docker镜像的首页内容


FROM    centos:6.7
MAINTAINER      Fisher "fisher@sudops.com"
RUN     /bin/echo 'root:123456' |chpasswd
RUN     useradd runoob
RUN     /bin/echo 'runoob:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D

该Dockerfile非常简单，其中的 FORM、 RUN都是 Dockerfile的指令。 FROM指令用于指定使用哪个镜像源，RUN 指令告诉docker 在镜像内执行命令
每一个指令都会在镜像上创建一个新的层，每一个指令的前缀都必须是大写的。

```

2. 在Dockerfile所在路径执行以下命令构建我们自己的ngxin镜像，构建完可用docker images命令查看是否已生成镜像ngxin:tuling
```
docker build -t nginx:qingfeng .
docker build -t runoob/centos:6.7 .
其中，-t指定镜像名字，命令最后的点（.）表示Dockerfile文件所在路径，可以指定Dockerfile 的绝对路径
```

3. 执行以下命令，即可使用该镜像启动一个Docker容器
```
docker run -d -p 92:80 nginx:qingfeng
docker run -d -P training/webapp python app.py
docker run -d -p 127.0.0.1:5001:5000 training/webapp python app.py
上面的例子中，默认都是绑定 tcp 端口，如果要绑定 UDP 端口，可以在端口后面加上 /udp。
docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py
两种方式的区别是:
-P: 是容器内部端口随机映射到主机的高端口。
-p: 是容器内部端口绑定到指定的主机端口。

docker run -t -i runoob/centos:6.7  /bin/bash
[root@41c28d18b5fb /]# id runoob
uid=500(runoob) gid=500(runoob) groups=500(runoob)

设置镜像标签
docker tag 镜像ID
我们可以使用 docker tag 命令，为镜像添加一个新的标签。
runoob@runoob:~$ docker tag 860c279d2fec runoob/centos:dev
```

4. 访问 http://Docker宿主机IP:92/，可看到下图所示界面
![示例](https://oscimg.oschina.net/oscnet/389a1913c5ca3f184252f6a40acf027741a.jpg "示例")

Dockerfile的文件编写还有如下常用指令
![Dockerfile命令](https://oscimg.oschina.net/oscnet/1fab7621f377758510cb4b84b4366b5b1bb.jpg "Dockerfile命令")

注意：RUN命令在 image 文件的构建阶段执行，执行结果都会打包进入 image 文件；CMD命令则是在容器启动后执行。另外，一个 Dockerfile 可以包含多个RUN命令，但是只能有一个CMD命令。

注意，指定了CMD命令以后，docker container run命令就不能附加命令了（比如前面的/bin/bash），否则它会覆盖CMD命令。

docker port 命令可以让我们快捷地查看端口的绑定情况
```
docker port adoring_stonebraker 5000
```


###Docker容器连接
端口映射并不是唯一把 docker 连接到另一个容器的方法。

docker 有一个连接系统允许将多个容器连接在一起，共享连接信息。

docker 连接会创建一个父子关系，其中父容器可以看到子容器的信息。

####容器命名
当我们创建一个容器的时候，docker会自动对它进行命名。另外，我们也可以使用 --name 标识来命名容器，例如：
```
docker run -d -P --name runoob training/webapp python app.py

我们可以使用 docker ps 命令来查看容器名称
runoob@runoob:~$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
43780a6eabaa        training/webapp     "python app.py"     3 minutes ago       Up 3 minutes        0.0.0.0:32769->5000/tcp   runoob
```

###运行容器
```
在~/python/myapp目录下创建一个 helloworld.py 文件，代码如下：
#!/usr/bin/python
print("Hello, World!");

runoob@runoob:~/python$ docker run  -v $PWD/myapp:/usr/src/myapp  -w /usr/src/myapp python:3.5 python helloworld.py

命令说明：
-v $PWD/myapp:/usr/src/myapp :将主机中当前目录下的myapp挂载到容器的/usr/src/myapp
-w /usr/src/myapp :指定容器的/usr/src/myapp目录为工作目录
python helloworld.py :使用容器的python命令来执行工作目录中的helloworld.py文件

输出结果：
Hello, World!
```



###使用Dockerfile构建微服务镜像
以spring boot项目ms-eureka-server(源码在最后)为例，该项目就是一个spring cloud eureka的微服务项目，该项目可通过spring boot的maven插件打包成可执行的jar包运行，如下图所示：
![示例](https://oscimg.oschina.net/oscnet/b40ad966759b2bce55dca4a13ef2bc9cf7b.jpg "示例")

将该项目的可执行jar包构建成docker镜像：

1. 将jar包上传linux服务器/app/eureka目录，在jar包所在目录创建名为Dockerfile的文件

2. 在Dockerfile中添加以下内容
```
基于哪个镜像
From java:8

复制文件到容器
ADD microservice-eureka-server-0.0.1-SNAPSHOT.jar /app.jar

声明需要暴露的端口
EXPOSE 8761    # 微服务项目的启动端口

配置容器启动后执行的命令
ENTRYPOINT ["java","-jar","/app.jar"]
```

3. 使用docker build命令构建镜像
```
docker build -t microservice-eureka-server:0.0.1 .
格式： docker build -t 镜像名称:标签 Dockerfile的相对位置
```
在这里，使用-t选项指定了镜像的标签。执行该命令后，终端将会输出如下的内容
![示例](https://oscimg.oschina.net/oscnet/12efc0f26324161631a354470d81e162581.jpg "示例")

4. 启动镜像，加-d可在后台启动
```
docker run -p 8761:8761 microservice-eureka-server:0.0.1
```

5. 访问http://Docker宿主机IP:8761/，可正常显示微服务Eureka Server的首页
![示例](https://oscimg.oschina.net/oscnet/220467b8b6d8266571bf849405e9460568b.jpg "示例")

至此，我们就算用docker完成了微服务项目的部署，当然docker还有很多有意思的东西，比如docker compose编排微服务，kubernetes容器编排等等


###运行一个web应用
接下来让我们尝试使用 docker 构建一个 web 应用程序。

我们将在docker容器中运行一个 Python Flask 应用来运行一个web应用。
```
docker pull training/webapp  # 载入镜像
docker run -d -P training/webapp python app.py

-d:让容器在后台运行。
-P:将容器内部使用的网络端口映射到我们使用的主机上。
```

###查看 WEB 应用容器
```
查看正在运行的容器
docker ps

runoob@runoob:~#  docker ps
CONTAINER ID        IMAGE               COMMAND             ...        PORTS
d3d5e39ed9d3        training/webapp     "python app.py"     ...        0.0.0.0:32769->5000/tcp
```

Docker 开放了 5000 端口（默认 Python Flask 端口）映射到主机端口 32769 上

我们也可以通过 -p 参数来设置不一样的端口：

`docker run -d -p 5000:5000 training/webapp python app.py`

###网络端口的快捷方式
通过 docker ps 命令可以查看到容器的端口映射，docker 还提供了另一个快捷方式 docker port，使用 docker port 可以查看指定 （ID 或者名字）容器的某个确定端口映射到宿主机的端口号。

`docker port bf08b7f2cd89 或 docker port wizardly_chandrasekhar`

###查看 WEB 应用程序日志
`docker logs -f bf08b7f2cd89`

-f: 让 docker logs 像使用 tail -f 
一样来输出容器内部的标准输出。我们可以看到应用程序使用的是 5000 端口并且能够查看到应用程序的访问日志

###查看WEB应用程序容器的进程
使用 docker top 来查看容器内部运行的进程

```
docker top wizardly_chandrasekhar
```

###检查 WEB 应用程序
```
docker inspect wizardly_chandrasekhar

[
    {
        "Id": "bf08b7f2cd897b5964943134aa6d373e355c286db9b9885b1f60b6e8f82b2b85",
        "Created": "2018-09-17T01:41:26.174228707Z",
        "Path": "python",
        "Args": [
            "app.py"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 23245,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2018-09-17T01:41:26.494185806Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
......
```

###停止 WEB 应用容器
```
docker stop wizardly_chandrasekhar
```

###重启WEB应用容器
```
docker start wizardly_chandrasekhar

正在运行的容器，我们可以使用 docker restart 命令来重启
docker restart wizardly_chandrasekhar
```

###查询最后一次创建的容器
```
docker ps -l
```

### 移除WEB应用容器
```
docker rm wizardly_chandrasekhar

删除容器时，容器必须是停止状态，否则会报如下错误
Error response from daemon: You cannot remove a running container bf08b7f2cd897b5964943134aa6d373e355c286db9b9885b1f60b6e8f82b2b85. Stop the container before attempting removal or force remove
```

查看docker容器虚拟主机所在的IP（查看IP）
```
docker-machine ip

docker inspect
docker inspect <container_id> | grep IPAddress
docker inspect --format '{{.NetworkSettings.IPAddress}}' <container_id>
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id
显示所有容器IP
docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```


```
docker-machine

$ docker-machine
Usage: docker-machine.exe [OPTIONS] COMMAND [arg...]

Create and manage machines running Docker.

Version: 0.14.0, build 89b8332

Author:
  Docker Machine Contributors - <https://github.com/docker/machine>

Options:
  --debug, -D                                           Enable debug mode
  --storage-path, -s "C:\Users\chenh\.docker\machine"   Configures storage path [$MACHINE_STORAGE_PATH]
  --tls-ca-cert                                         CA to verify remotes against [$MACHINE_TLS_CA_CERT]
  --tls-ca-key                                          Private key to generate certificates [$MACHINE_TLS_CA_KEY]
  --tls-client-cert                                     Client cert to use for TLS [$MACHINE_TLS_CLIENT_CERT]
  --tls-client-key                                      Private key used in client TLS auth [$MACHINE_TLS_CLIENT_KEY]
  --github-api-token                                    Token to use for requests to the Github API [$MACHINE_GITHUB_API_TOKEN]
  --native-ssh                                          Use the native (Go-based) SSH implementation. [$MACHINE_NATIVE_SSH]
  --bugsnag-api-token                                   BugSnag API token for crash reporting [$MACHINE_BUGSNAG_API_TOKEN]
  --help, -h                                            show help
  --version, -v                                         print the version

Commands:
  active                Print which machine is active
  config                Print the connection config for machine
  create                Create a machine
  env                   Display the commands to set up the environment for the Docker client
  inspect               Inspect information about a machine
  ip                    Get the IP address of a machine
  kill                  Kill a machine
  ls                    List machines
  provision             Re-provision existing machines
  regenerate-certs      Regenerate TLS Certificates for a machine
  restart               Restart a machine
  rm                    Remove a machine
  ssh                   Log into or run a command on a machine with SSH.
  scp                   Copy files between machines
  mount                 Mount or unmount a directory from a machine with SSHFS.
  start                 Start a machine
  status                Get the status of a machine
  stop                  Stop a machine
  upgrade               Upgrade a machine to the latest version of Docker
  url                   Get the URL of a machine
  version               Show the Docker Machine version or a machine docker version
  help                  Shows a list of commands or help for one command
```


### docker安装redis
```
docker run -p 6379:6379 -v $PWD/data:/data --name redis_foxy -d redis:latest redis-server --appendonly yes
```

### docker安装es
```
-e ES_JAVA_OPTS="-Xms256m -Xmx256m" //设置初始内存 和最大内存

docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -d -p 9200:9200 -p 9300:9300 --name elasticsearch_foxy elasticsearch:latest

```

### docker安装mongodb
```
https://www.jianshu.com/p/1e1847cdf3b9
-v后面的参数表示把数据文件挂载到宿主机的路径
-p把mongo端口映射到宿主机的指定端口
--auth表示连接mongodb需要授权

docker run --name mongodb_foxy -v /data/mongodb:/data/db -p 27017:27017 -d mongodb --auth

docker exec -it mongo_foxy /bin/bash

mongo 192.168.31.206:27017/admin
```

### docker安装mysql/maridb
```
-p 3306:3306：将容器的 3306 端口映射到主机的 3306 端口。
-v -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf。
-v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。
-v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。
-e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码。

docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql

```

### docker安装
```

```
