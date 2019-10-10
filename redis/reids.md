1，Redis
丰富的数据结构（Data Structures）
字符串（String）
Redis字符串能包含任意类型的数据
一个字符串类型的值最多能存储512M字节的内容
利用INCR命令簇（INCR, DECR, INCRBY）来把字符串当作原子计数器使用
使用APPEND命令在字符串后添加内容
列表（List）
Redis列表是简单的字符串列表，按照插入顺序排序
你可以添加一个元素到列表的头部（左边：LPUSH）或者尾部（右边：RPUSH）
一个列表最多可以包含232-1个元素（4294967295，每个表超过40亿个元素）
在社交网络中建立一个时间线模型，使用LPUSH去添加新的元素到用户时间线中，使用LRANGE去检索一些最近插入的条目
你可以同时使用LPUSH和LTRIM去创建一个永远不会超过指定元素数目的列表并同时记住最后的N个元素
列表可以用来当作消息传递的基元（primitive），例如，众所周知的用来创建后台任务的Resque Ruby库
集合（Set）
Redis集合是一个无序的，不允许相同成员存在的字符串合集（Uniq操作，获取某段时间所有数据排重值）
支持一些服务端的命令从现有的集合出发去进行集合运算，如合并（并集：union）,求交(交集：intersection)，差集, 找出不同元素的操作（共同好友、二度好友）
用集合跟踪一个独特的事。想要知道所有访问某个博客文章的独立IP？只要每次都用SADD来处理一个页面访问。那么你可以肯定重复的IP是不会插入的（ 利用唯一性，可以统计访问网站的所有独立IP）
Redis集合能很好的表示关系。你可以创建一个tagging系统，然后用集合来代表单个tag。接下来你可以用SADD命令把所有拥有tag的对象的所有ID添加进集合，这样来表示这个特定的tag。如果你想要同时有3个不同tag的所有对象的所有ID，那么你需要使用SINTER
使用SPOP或者SRANDMEMBER命令随机地获取元素
哈希（Hashes）
Redis Hashes是字符串字段和字符串值之间的映射
尽管Hashes主要用来表示对象，但它们也能够存储许多元素
有序集合（Sorted Sets）
Redis有序集合和Redis集合类似，是不包含相同字符串的合集
每个有序集合的成员都关联着一个评分，这个评分用于把有序集合中的成员按最低分到最高分排列（排行榜应用，取TOP N操作）
使用有序集合，你可以非常快地（O(log(N))）完成添加，删除和更新元素的操作
元素是在插入时就排好序的，所以很快地通过评分(score)或者位次(position)获得一个范围的元素（需要精准设定过期时间的应用）
轻易地访问任何你需要的东西: 有序的元素，快速的存在性测试，快速访问集合中间元素
在一个巨型在线游戏中建立一个排行榜，每当有新的记录产生时，使用ZADD 来更新它。你可以用ZRANGE轻松地获取排名靠前的用户， 你也可以提供一个用户名，然后用ZRANK获取他在排行榜中的名次。 同时使用ZRANK和ZRANGE你可以获得与指定用户有相同分数的用户名单。 所有这些操作都非常迅速
有序集合通常用来索引存储在Redis中的数据。 例如：如果你有很多的hash来表示用户，那么你可以使用一个有序集合，这个集合的年龄字段用来当作评分，用户ID当作值。用ZRANGEBYSCORE可以简单快速地检索到给定年龄段的所有用户
复制（Replication, Redis复制很简单易用，它通过配置允许slave Redis Servers或者Master Servers的复制品）
一个Master可以有多个Slaves
Slaves能通过接口其他slave的链接，除了可以接受同一个master下面slaves的链接以外，还可以接受同一个结构图中的其他slaves的链接
redis复制是在master段是非阻塞的，这就意味着master在同一个或多个slave端执行同步的时候还可以接受查询
复制在slave端也是非阻塞的，假设你在redis.conf中配置redis这个功能，当slave在执行的新的同步时，它仍可以用旧的数据信息来提供查询，否则，你可以配置当redis slaves去master失去联系是，slave会给发送一个客户端错误
为了有多个slaves可以做只读查询，复制可以重复2次，甚至多次，具有可扩展性（例如：slaves对话与重复的排序操作，有多份数据冗余就相对简单了）
他可以利用复制去避免在master端保存数据，只要对master端redis.conf进行配置，就可以避免保存（所有的保存操作），然后通过slave的链接，来实时的保存在slave端
LRU过期处理（Eviction）
EVAL 和 EVALSHA 命令是从 Redis 2.6.0 版本开始的，使用内置的 Lua 解释器，可以对 Lua 脚本进行求值
Redis 使用单个 Lua 解释器去运行所有脚本，并且， Redis 也保证脚本会以原子性(atomic)的方式执行： 当某个脚本正在运行的时候，不会有其他脚本或 Redis 命令被执行。 这和使用MULTI / EXEC 包围的事务很类似。 在其他别的客户端看来，脚本的效果(effect)要么是不可见的(not visible)，要么就是已完成的(already completed)
LRU过期处理（Eviction）
Redis允许为每一个key设置不同的过期时间，当它们到期时将自动从服务器上删除（EXPIRE）
事务
MULTI 、 EXEC 、 DISCARD 和 WATCH 是 Redis 事务的基础
事务是一个单独的隔离操作：事务中的所有命令都会序列化、按顺序地执行。事务在执行的过程中，不会被其他客户端发送来的命令请求所打断
事务中的命令要么全部被执行，要么全部都不执行，EXEC 命令负责触发并执行事务中的所有命令  
Redis 的 Transactions 提供的并不是严格的 ACID 的事务
Transactions 还是提供了基本的命令打包执行的功能： 可以保证一连串的命令是顺序在一起执行的，中间有会有其它客户端命令插进来执行
Redis 还提供了一个 Watch 功能，你可以对一个 key 进行 Watch，然后再执行 Transactions，在这过程中，如果这个 Watched 的值进行了修改，那么这个 Transactions 会发现并拒绝执行
数据持久化
RDB
特点
RDB持久化方式能够在指定的时间间隔能对你的数据进行快照存储
优点
RDB是一个非常紧凑的文件,它保存了某个时间点得数据集,非常适用于数据集的备份
RDB是一个紧凑的单一文件, 非常适用于灾难恢复
RDB在保存RDB文件时父进程唯一需要做的就是fork出一个子进程,接下来的工作全部由子进程来做，父进程不需要再做其他IO操作，所以RDB持久化方式可以最大化redis的性能
与AOF相比,在恢复大的数据集的时候，RDB方式会更快一些
缺点
如果你希望在redis意外停止工作（例如电源中断）的情况下丢失的数据最少的话，那么RDB不适合，Redis要完整的保存整个数据集是一个比较繁重的工作
RDB 需要经常fork子进程来保存数据集到硬盘上,当数据集比较大的时候,fork的过程是非常耗时的,可能会导致Redis在一些毫秒级内不能响应客户端的请求.如果数据集巨大并且CPU性能不是很好的情况下,这种情况会持续1秒,AOF也需要fork,但是你可以调节重写日志文件的频率来提高数据集的耐久度
AOF
特点
AOF持久化方式记录每次对服务器写的操作
redis重启的时候会优先载入AOF文件来恢复原始的数据,因为在通常情况下AOF文件保存的数据集要比RDB文件保存的数据集要完整
优点
使用AOF 会让你的Redis更加耐久: 你可以使用不同的fsync策略：无fsync,每秒fsync,每次写的时候fsync
AOF文件是一个只进行追加的日志文件,所以不需要写入seek
Redis 可以在 AOF 文件体积变得过大时，自动地在后台对 AOF 进行重写
AOF 文件有序地保存了对数据库执行的所有写入操作， 这些写入操作以 Redis 协议的格式保存， 因此 AOF 文件的内容非常容易被人读懂， 对文件进行分析（parse）也很轻松。 导出（export） AOF 文件也非常简单
缺点
对于相同的数据集来说，AOF 文件的体积通常要大于 RDB 文件的体积
根据所使用的 fsync 策略，AOF 的速度可能会慢于 RDB
选择
同时使用两种持久化功能
分布式
Redis Cluster （Redis 3版本）
Keepalived
当Master挂了后，VIP漂移到Slave；Slave 上keepalived 通知redis 执行：slaveof no one ,开始提供业务
当Master起来后，VIP 地址不变，Master的keepalived 通知redis 执行slaveof slave IP host ，开始作为从同步数据
依次类推
Twemproxy
快、轻量级、减少后端Cache Server连接数、易配置、支持ketama、modula、random、常用hash 分片算法
对于客户端而言，redis集群是透明的，客户端简单，遍于动态扩容
Proxy为单点、处理一致性hash时，集群节点可用性检测不存在脑裂问题
高性能，CPU密集型，而redis节点集群多CPU资源冗余，可部署在redis节点集群上，不需要额外设备
高可用（HA）
Redis Sentinel（redis自带的集群管理工具 ）
监控（Monitoring）： Redis Sentinel实时监控主服务器和从服务器运行状态
提醒（Notification）：当被监控的某个 Redis 服务器出现问题时， Redis Sentinel 可以向系统管理员发送通知， 也可以通过 API 向其他程序发送通知
自动故障转移（Automatic failover）： 当一个主服务器不能正常工作时，Redis Sentinel 可以将一个从服务器升级为主服务器， 并对其他从服务器进行配置，让它们使用新的主服务器。当应用程序连接到 Redis 服务器时， Redis Sentinel会告之新的主服务器地址和端口
单M-S结构
单M-S结构特点是在Master服务器中配置Master Redis（Redis-1M）和Master Sentinel（Sentinel-1M）
Slave服务器中配置Slave Redis（Redis-1S）和Slave Sentinel（Sentinel-1S）
其中 Master Redis可以提供读写服务，但是Slave Redis只能提供只读服务。因此，在业务压力比较大的情况下，可以选择将只读业务放在Slave Redis中进行
双M-S结构
双M-S结构的特点是在每台服务器上配置一个Master Redis，同时部署一个Slave Redis。由两个Redis Sentinel同时对4个Redis进行监控。两个Master Redis可以同时对应用程序提供读写服务，即便其中一个服务器出现故障，另一个服务器也可以同时运行两个Master Redis提供读写服务
缺点是两个Master redis之间无法实现数据共享，不适合存在大量用户数据关联的应用使用
单M-S结构和双M-S结构比较
单M-S结构适用于不同用户数据存在关联，但应用可以实现读写分离的业务模式。Master主要提供写操作，Slave主要提供读操作，充分利用硬件资源
双（多）M-S结构适用于用户间不存在或者存在较少的数据关联的业务模式，读写效率是单M-S的两（多）倍，但要求故障时单台服务器能够承担两个Mater Redis的资源需求
发布/订阅（Pub/Sub）
监控：Redis-Monitor
历史redis运行查询：CPU、内存、命中率、请求量、主从切换等
实时监控曲线
2，数据类型Redis使用场景
String
 计数器应用
List
取最新N个数据的操作
消息队列
删除与过滤
实时分析正在发生的情况，用于数据统计与防止垃圾邮件（结合Set）
Set
Uniqe操作，获取某段时间所有数据排重值
实时系统，反垃圾系统
共同好友、二度好友
利用唯一性，可以统计访问网站的所有独立 IP
好友推荐的时候，根据 tag 求交集，大于某个 threshold 就可以推荐
Hashes
存储、读取、修改用户属性
Sorted Set
排行榜应用，取TOP N操作
需要精准设定过期时间的应用（时间戳作为Score）
带有权重的元素，比如一个游戏的用户得分排行榜
过期项目处理，按照时间排序
3，Redis解决秒杀/抢红包等高并发事务活动
秒杀开始前30分钟把秒杀库存从数据库同步到Redis Sorted Set
用户秒杀库存放入秒杀限制数长度的Sorted Set
秒杀到指定秒杀数后，Sorted Set不在接受秒杀请求，并显示返回标识
秒杀活动完全结束后，同步Redis数据到数据库，秒杀正式结束



##轻松搭建Redis缓存高可用集群

###1、Redis集群方案比较
+ 哨兵模式
![哨兵模式](https://static.oschina.net/uploads/img/201803/29191414_Dwf2.jpg "哨兵模式")

在redis3.0以前的版本要实现集群一般是借助哨兵sentinel工具来监控master节点的状态，如果master节点异常，则会做主从切换，将某一台slave作为master，哨兵的配置略微复杂，并且性能和高可用性等各方面表现一般，特别是在主从切换的瞬间存在访问瞬断的情况
 
+ 高可用集群模式
![高可用集群模式](https://static.oschina.net/uploads/space/2018/0330/181526_7mpT_3796575.png "高可用集群模式")

redis集群是一个由多个主从节点群组成的分布式服务器群，它具有复制、高可用和分片特性。Redis集群不需要sentinel哨兵也能完成节点移除和故障转移的功能。需要将每个节点设置成集群模式，这种集群模式没有中心节点，可水平扩展，据官方文档称可以线性扩展到1000节点。redis集群的性能和高可用性均优于之前版本的哨兵模式，且集群配置非常简单

###2、redis高可用集群搭建
+ redis安装
```
下载地址：http://redis.io/download
安装步骤：
# 安装gcc
yum install gcc

# 把下载好的redis-3.0.0-rc2.tar.gz放在/usr/local文件夹下，并解压
tar -zxvf redis-3.0.0-rc2.tar.gz

# 进入到解压好的redis-3.0.0目录下，进行编译
make

# 进入到redis-3.0.0/src目录下进行安装，安装完成验证src目录下是否已经生成了redis-server 、redis-cil
make install

# 建立俩个文件夹存放redis命令和配置文件
mkdir -p /usr/local/redis/etc
mkdir -p /usr/local/redis/bin

# 把redis-3.0.0下的redis.conf复制到/usr/local/redis/etc下
cp redis.conf /usr/local/redis/etc/

# 移动redis-3.0.0/src里的几个文件到/usr/local/redis/bin下
mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-dump redis-cli redis-server /usr/local/redis/bin

# 启动并指定配置文件
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf（注意要使用后台启动，所以修改redis.conf里的daemonize改为yes)

# 验证启动是否成功
ps -ef | grep redis 

# 查看是否有redis服务或者查看端口
netstat -tunpl | grep 6379

# 进入redis客户端 
/usr/local/redis/bin/redis-cli 

# 退出客户端
quit

# 退出redis服务： 
（1）pkill redis-server 
（2）kill 进程号                       
（3）/usr/local/redis/bin/redis-cli shutdown
```

+ redis集群搭建
redis集群需要至少要三个master节点，我们这里搭建三个master节点，并且给每个master再搭建一个slave节点，总共6个redis节点，由于节点数较多，这里采用在一台机器上创建6个redis实例，并将这6个redis实例配置成集群模式，所以这里搭建的是伪分布式集群模式，当然真正的分布式集群的配置方法几乎一样，搭建伪分布式集群的步骤如下：
```
第一步：在/usr/local下创建文件夹redis-cluster，然后在其下面分别创建6个文件夾如下
（1）mkdir -p /usr/local/redis-cluster
（2）mkdir 8001、 mkdir 8002、 mkdir 8003、 mkdir 8004、 mkdir 8005、 mkdir 8006

第一步：把之前的redis.conf配置文件copy到8001下，修改如下内容：
（1）daemonize yes
（2）port 8001（分别对每个机器的端口号进行设置）
（3）bind 192.168.0.61（必须要绑定当前机器的ip，这里方便redis集群定位机器，不绑定可能会出现循环查找集群节点机器的情况）
（4）dir /usr/local/redis-cluster/8001/（指定数据文件存放位置，必须要指定不同的目录位置，不然会丢失数据）
（5）cluster-enabled yes（启动集群模式）
（6）cluster-config-file nodes-8001.conf（这里800x最好和port对应上）
（7）cluster-node-timeout 5000
（8）appendonly yes

第三步：把修改后的配置文件，分别 copy到各个文夹下，注意每个文件要修改第2、4、6项里的端口号

第四步：由于 redis集群需要使用 ruby命令，所以我们需要安装 ruby
（1）yum install ruby
（2）yum install rubygems
（3）gem install redis --version 3.0.0（安装redis和 ruby的接囗）

第五步：分别启动6个redis实例，然后检查是否启动成功
（1）/usr/local/redis/bin/redis-server /usr/local/redis-cluster/800*/redis.conf
（2）ps -ef | grep redis 查看是否启动成功

第六步：在redis的安装目录下执行 redis-trib.rb命令
（1）cd /usr/local/redis-3.0.0/src
（2）./redis-trib.rb create --replicas 1 192.168.0.61:8001 192.168.0.61:8002 192.168.0.61:8003 192.168.0.61:8004 192.168.0.61:8005 192.168.0.61:8006

第七步：验证集群：
（1）连接任意一个客户端即可：./redis-cli -c -h -p (-c表示集群模式，指定ip地址和端口号）如：/usr/local/redis/bin/redis-cli -c -h 192.168.0.61 -p 800*
（2）进行验证： cluster info（查看集群信息）、cluster nodes（查看节点列表）
（3）进行数据操作验证
（4）关闭集群则需要逐个进行关闭，使用命令：
/usr/local/redis/bin/redis-cli -c -h 192.168.0.61 -p 800* shutdown

PS：当出现集群无法启动时，删除redis的临时数据文件，再次重新启动每一个redis服务，然后重新构造集群环境。
```

###3、Java操作redis集群
借助redis的java客户端jedis可以操作以上集群，引用jedis版本的maven坐标如下：
```
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.9.0</version>
</dependency>
```
Java编写访问redis集群的代码非常简单，如下所示：
```
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;
import redis.clients.jedis.JedisPoolConfig;

/**
 * 访问redis集群
 * @author aaron.rao
 *
 */
public class RedisCluster 
{
    public static void main(String[] args) throws IOException
    {
        Set<HostAndPort> jedisClusterNode = new HashSet<HostAndPort>();
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8001));
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8002));
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8003));
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8004));
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8005));
        jedisClusterNode.add(new HostAndPort("192.168.0.61", 8006));
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(100);
        config.setMaxIdle(10);
        config.setTestOnBorrow(true);
        JedisCluster jedisCluster = new JedisCluster(jedisClusterNode, 6000, 10, config);
        System.out.println(jedisCluster.set("student", "aaron"));
        System.out.println(jedisCluster.set("age", "18"));
        System.out.println(jedisCluster.get("student"));
        System.out.println(jedisCluster.get("age"));
        jedisCluster.close();
    }
}

运行效果如下：
OK
OK
aaron
18
```


##Redis高可用集群之水平扩展
Redis3.0以后的版本虽然有了集群功能，提供了比之前版本的哨兵模式更高的性能与可用性，但是集群的水平扩展却比较麻烦，今天就来带大家看看redis高可用集群如何做水平扩展，原始集群(见下图)由6个节点组成，且6个节点都在一台机器上(ip为192.168.0.61)，采用伪分布式的三主三从模式，集群搭建方法请参考<轻松搭建Redis缓存高可用集群>

![redis集群](https://static.oschina.net/uploads/img/201804/02213913_dF5B.jpg "redis集群")

###1、启动集群
```
# 启动整个集群
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8001/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8002/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8003/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8004/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8005/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8006/redis.conf

# 客户端连接8001端口的redis实例
/usr/local/redis/bin/redis-cli -c -h 192.168.0.61 -p 8001﻿﻿

# 查看集群状态
/usr/local/redis/bin/redis-cli -c -h 192.168.0.61 -p 8001
192.168.0.61:8001> cluster  nodes
```
![](https://static.oschina.net/uploads/space/2018/0402/210735_SV6G_3796575.png "查看集群状态")

从上图可以看出，整个集群运行正常，三个master节点和三个slave节点，8001端口的实例节点存储0-5460这些hash槽，8002端口的实例节点存储5461-10922这些hash槽，8003端口的实例节点存储10923-16383这些hash槽，这三个master节点存储的所有hash槽组成redis集群的存储槽位，slave点是每个主节点的备份从节点，不显示存储槽位

###2、集群操作
我们在原始集群基础上再增加一主(8007)一从(8008)，增加节点后的集群参见下图，新增节点用虚线框表示﻿
![集群操作](https://static.oschina.net/uploads/space/2018/0402/210834_YNoy_3796575.png "集群操作")

+ 1）增加redis实例8007和8008
```
# 在/usr/local/redis-cluster下创建8007和8008文件夹，并拷贝8001文件夹下的redis.conf文件到8007和8008这两个文件夹下
mkdir 8007
mkdir 8008
cd 8001
cp redis.conf /usr/local/redis-cluster/8007/
cp redis.conf /usr/local/redis-cluster/8008/
# 修改8007文件夹下的redis.conf配置文件
vim /usr/local/redis-cluster/8007/redis.conf
# 修改如下内容：
port:8007
dir /usr/local/redis-cluster/8007/
cluster-config-file nodes-8007.conf
# 修改8008文件夹下的redis.conf配置文件
vim /usr/local/redis-cluster/8008/redis.conf
# 修改内容如下：
port:8008
dir /usr/local/redis-cluster/8008/
cluster-config-file nodes8008.conf
 # 启动8007和8008俩个服务并查看服务状态
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8007/redis.conf
 /usr/local/redis/bin/redis-server /usr/local/redis-cluster/8008/redis.conf
 ps -el | grep redis
```

+ 2）查看redis-trib命令帮助
```
cd /usr/local/redis-3.0.0/src
redis-trib.rb

1.create：创建一个集群环境host1:port1 ... hostN:portN

2.call：可以执行redis命令

3.add-node：将一个节点添加到集群里，第一个参数为新节点的ip:port，第二个参数为集群中任意一个已经存在的节点的ip:port

4.del-node：移除一个节点

5.reshard：重新分片

6.check：检查集群状态
```

+ 3）配置8007为集群主节点
```
# 使用add-node命令新增一个主节点8007(master)，绿色为新增节点，红色为已知存在节点，看到日志最后有"[OK] New node added correctly"提示代表新节点加入成功
/usr/local/redis-3.0.0/src/redis-trib.rb add-node 192.168.0.61:8007 192.168.0.61:8001
```

#### 查看集群状﻿态
![查看集群状﻿态](https://static.oschina.net/uploads/space/2018/0402/211549_zbvL_3796575.png "查看集群状﻿态")
注意：当添加节点成功以后，新增的节点不会有任何数据，因为它还没有分配任何的slot(hash槽)，我们需要为新节点手工分配hash槽

```
#### 使用redis-trib命令为8007分配hash槽，找到集群中的任意一个主节点(红色位置表现集群中的任意一个主节点)，对其进行重新分片工作。
/usr/local/redis-3.0.0/src/redis-trib.rb reshard 192.168.0.61:8001

输出如下：
How many slots do you want to move (from 1 to 16384)? 600
(ps:需要多少个槽移动到新的节点上，自己设置，比如600个hash槽)

What is the receiving node ID? eb57a5700ee6f9ff099b3ce0d03b1a50ff247c3c
(ps:把这600个hash槽移动到哪个节点上去，需要指定节点id)

Please enter all the source node IDs.
Type all to use all the nodes as source nodes for the hash slots.
Type done once you entered all the source nodes IDs.

Source node 1:all
(ps:输入all为从所有主节点(8001,8002,8003)中分别抽取相应的槽数指定到新节点中，抽取的总槽数为600个)
... ...

Do you want to proceed with the proposed reshard plan (yes/no)? yes
(ps:输入yes确认开始执行分片任务)
```

####查看最新的集﻿群状态
![查看最新的集﻿群状态](https://static.oschina.net/uploads/space/2018/0402/211822_TUZq_3796575.png "查看最新的集﻿群状态")

如上图所示，现在我们的8007已经有hash槽了，也就是说可以在8007上进行读写数据啦！到此为止我们的8007已经加入到集群中，并且是主节点(Master)

+ 4）配置8008为8007的从节点
```
# 添加从节点8008到集群中去并查看集群状态
/usr/local/redis-3.0.0/src/redis-trib.rb add-node 192.168.0.61:8008 192.168.0.61:8001
```
![示例](https://static.oschina.net/uploads/space/2018/0402/212106_B1zt_3796575.png "示例")

如图所示，还是一个master节点，没有被分配任何的hash

我们需要执行replicate命令来指定当前节点(从节点)的主节点id为哪个,首先需要连接新加的8008节点的客户端，然后使用集群命令进行操作，把当前的8008(slave)节点指定到一个主节点下(这里使用之前创建的8007主节点，红色表示节点id)

/usr/local/redis/bin/redis-cli -c -h 192.168.0.61 -p 8008

192.168.0.61:8008> cluster replicate eb57a5700ee6f9ff099b3ce0d03b1a50ff247c3c

####查看集群状态，8008节点已成功添加为8007的从节点﻿
![示例](https://static.oschina.net/uploads/space/2018/0402/212251_JqVp_3796575.png "示例")

+ 5）删除8008从节点
```
# 用del-node命令删除从节点8008，指定删除节点ip和端口，以及节点id(红色为8008节点id)
/usr/local/redis-3.0.0/src/redis-trib.rb del-node 192.168.0.61:8008 1805b6339d91b0e051f46845eebacb9bc43baefe
```
####再次查看集群状态，如下图所示，8008这个slave节点已经移除，并且该节点的redis服务也已被﻿停止
![示例](https://static.oschina.net/uploads/space/2018/0402/212547_EvGO_3796575.png "示例")

+ 6）删除8007主节点
最后，我们尝试删除之前加入的主节点8007，这个步骤相对比较麻烦一些，因为主节点的里面是有分配了hash槽的，所以我们这里必须先把8007里的hash槽放入到其他的可用主节点中去，然后再进行移除节点操作，不然会出现数据丢失问题(目前只能把master的数据迁移到一个节点上，暂时做不了平均分配功能)，执行命令

```
/usr/local/redis-3.0.0/src/redis-trib.rb reshard 192.168.0.61:8007 
输出如下：
... ...

How many slots do you want to move (from 1 to 16384)? 599

(ps:这里不会是正好600个槽)

What is the receiving node ID? deedad3c34e8437baa6ff013fd3d1461a0c2e761
(ps:这里是需要把数据移动到哪？8001的主节点id)

Please enter all the source node IDs.
Type all to use all the nodes as source nodes for the hash slots.
Type done once you entered all the source nodes IDs.

Source node 1:eb57a5700ee6f9ff099b3ce0d03b1a50ff247c3c
(ps:这里是需要数据源，也就是我们的8007节点id)

Source node 2:done
(ps:这里直接输入done 开始生成迁移计划)
... ...

Do you want to proceed with the proposed reshard plan (yes/no)? Yes
(ps:这里输入yes开始迁移)

```
+ 

至此，我们已经成功的把8007主节点的数据迁移到8001上去了，我们可以看一下现在的集群状态如下图，你会发现8007下面已经没有任何hash槽了，证明迁移成功！
![示例](https://static.oschina.net/uploads/space/2018/0402/212814_xFrV_3796575.png "示例")

####最后我们直接使用del-node命令删除8007主节点即可（红色表示8007的节点id）
```
/usr/local/redis-3.0.0/src/redis-trib.rb del-node 192.168.0.61:8007 eb57a5700ee6f9ff099b3ce0d03b1a50ff247c3c
```

#### 查看集群状态，一切还原为集群最初状态啦！大功告成﻿！
![示例](https://static.oschina.net/uploads/space/2018/0402/212924_Swu4_3796575.png "示例")


### 连接redis
```
redis-cli -h host -p port -a password
-h 服务器地址 -p 端口号 -a 密码
```
