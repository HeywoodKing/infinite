# zookeeper

### ubuntu18 安装 zookeeper
```
cd ~
wget http://apache.osuosl.org/zookeeper/stable/apache-zookeeper-3.5.6.tar.gz

mv -v home/flack/zookeeper/apache-zookeeper-3.5.6.tar.gz /usr/local/zookeeper

tar -zxvf apache-zookeeper-3.5.6.tar.gz
```
设置环境变量
```
sudo vim /etc/profile
```

添加以下内容:
```
export ZOOKEEPER_HOME=/usr/local/zookeeper/zookeeper-3.4.10
export PATH=$PATH:$ZOOKEEPER_HOME/bin 
```
更新环境变量
```
source /etc/profile
```

创建配置文件

将apache-zookeeper-3.5.6/conf目录下的zoo_sample.cfg文件拷贝一份，命名为为“zoo.cfg”

```
tickTime = 2000
dataDir = /path/to/zookeeper/data
clientPort = 2181
initLimit = 5
syncLimit = 2
```

编辑该配置文件，gedit zoo.cfg
```
# The number of milliseconds of each tick
# 心跳间隔，毫秒
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
# 配置zookeeper接受客户端初始化连接时最长能忍受多少个时间心跳间隔。
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
# 这个配置项标识 Leader 与 Follower 之间发送消息，请求和应答时间长度，最长不能超过多少个 tickTime 的时间长度。
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.

# 数据存放的位置
dataDir=/home/flack/zookeeper/zookeeperData
#日志存放的位置
dataLogDir=/home/flack/zookeeper/zookeeperLog

# the port at which the clients will connect
# 服务器客户端的接口
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1

# 2888,3888 are election port
# 2888端口是zookeeper服务之间的通讯的端口，3888是zookeeper与其他应用程序通讯的端口。
server.1=localhost:2888:3888
```


根据中间添加的文件路径，创建相应的文件夹，并在zookeeperData目录下创建新的文件-myid，里面的内容为1，1表示当前的zookeeper定义为第一台服务器，

新建文件命令：touch myid

启动zookeeper服务器，进入zookeeper/bin目录，执行 ./zkServer.sh start 命令。就可以启动服务器。

检验服务器命令, ./zkCli.sh -server localhost:2181。可以看到控制台的输出没有报错表示以及启动成功。

停止服务器命令，./zkServer.sh stop


启动zookeeper，在安装路径下：
```
apache-zookeeper-3.5.6/bin/zkServer.sh start
```

启动CLI
```
sudo bin/zkCli.sh
```

输入jps命令查看进程：
```
jps
```


```