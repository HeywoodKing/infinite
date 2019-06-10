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
