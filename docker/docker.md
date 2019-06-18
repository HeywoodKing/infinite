Ubuntu 18.0.4安装docker
第一步：如果之前安装过docker，执行下面命令删除

apt-get remove docker docker-engine docker.io
删除后执行sudo apt-get update更新软件

第二步：安装必要的软件包以允许apt通过HTTPS使用存储库，具体如下：

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
第三步：添加GPG密钥，可以添加官方的和阿里的，我添加 的阿里的，国内的快啊

// 官方
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
// 阿里
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
添加完毕后可以执行以下命令验证：

sudo apt-key fingerprint 0EBFCD88
正常情况下会输出如下内容：

pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ 未知 ] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
说明 Ok，继续

第四步：设定稳定仓储库，这一步我被 坑了好久，具体参考

docker配置仓储库时出错：无法安全地用该源进行更新，所以默认禁用该源
也可以不设置，不设置默认使用官方的，具体是：deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
同样可以用阿里 的镜像：设置命令如下：
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
其中的lsb_release -cs相当于一个函数，直接获取Ubuntu下的最新版本

设置完毕再次执行sudo apt-get update命令更新 软件包。

第五步：安装docker，如下：

sudo apt-get -y install docker-ce
也可以指定想安装 的docker版本，方法 如下：

执行如下命令命令查看有哪些版本，

apt-cache madison docker-ce
输出如下：

复制代码
 docker-ce | 5:18.09.0~3-0~ubuntu-bionic | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
 docker-ce | 18.06.1~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
 docker-ce | 18.06.0~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
 docker-ce | 18.03.1~ce~3-0~ubuntu | http://mirrors.aliyun.com/docker-ce/linux/ubuntu bionic/stable amd64 Packages
复制代码
选择要安装的版本，执行sudo apt-get install -y docker-ce=<VERSION>命令即可。

安装完成 后执行docker -v命令，如果正常输出说明安装成功，下面继续填坑吧。


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

启动/停止/重启容器：docker start/stop/restart <container_id> 
获取容器/镜像的元数据：docker inspect <container_id> 
挂载数据卷：docker run -v host/machine/dir :container/path/dir --name volume_test_container centos:7
说明：数据卷的挂载相当于在宿主机的目录与容器目录创建了一个链接，你修改任何一方的内容，另一方的内容也会同步修改。创建数据卷的作用：当容器被删除的时候，容器内的数据也一起被删除。像数据库、媒体资源等文件我们通常都会使用 -v 将容器中的内容链接到宿主机，这样我们重新创建容器的时候再次-v，数据又回来了

启动mysql容器：docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=qwerasdf -d mysql:5.7 
默认用户为root，密码qwerasdf
mysql容器启动后，其他容器就可以来连接使用了，方法如下：
容器连接：docker run --name some-app --link some-mysql:mysql -d application-that-uses-mysql
