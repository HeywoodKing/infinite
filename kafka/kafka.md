# kafka

### kafka特点：
kafka作为一种消息中间件，有以下特性：

+ 高吞吐量：吞吐量高达数十万
+ 高并发：支持数千个客户端同时读写
+ 低延迟：延迟最低只有几毫秒
+ 消息持久性和可靠性：消息被持久化到本地磁盘，同时支持数据备份
+ 集群容错性：允许n-1个节点失败（n为副本个数）
+ 可扩展性：支持集群动态扩展


### 安装Kafka
安装Java
更新软件包
```
sudo apt-get update
```
安装openjdk-8-jdk
```
sudo apt-get install openjdk-8-jdk
```

查看java版本，看看是否安装成功
```
java -version
```

下载地址：https://kafka.apache.org/downloads，ubuntu下可以用wget直接下载，我是下载到了/home/flack/kafka目录
```
wget http://mirrors.shuosc.org/apache/kafka/1.0.0/kafka_2.11-1.0.0.tgz

tar -zxvf kafka_2.11-1.0.0.tgz
```

创建日志存储目录
```
cd kafka/
mkdir logs-1
```

进入kafka解压目录，修改kafka-server的配置文件
```
vim config/server.properties
```

修改配置文件中21、31、36和60行
```
broker.id=1
listeners=PLAINTEXT://:9092
advertised.listeners=PLAINTEXT://host_ip:9092
log.dirs=/home/wzj/kafka/logs-1
```

启动Zookeeper，Zookeeper部署的是单点的
```
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
```

启动Kafka服务，使用 kafka-server-start.sh 启动 kafka 服务
```
bin/kafka-server-start.sh config/server.properties
```

创建topic
使用 kafka-topics.sh 创建单分区单副本的 topic test
```
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
```

查看 topic 列表
```
bin/kafka-topics.sh --list --zookeeper localhost:2181
```

产生消息，创建消息生产者
```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
```

消费消息，创建消息消费者
```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
```

查看Topic消息
```
bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic test
```




