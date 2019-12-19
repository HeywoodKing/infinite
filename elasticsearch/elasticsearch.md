# ElasticSearch

ElasticSearch是一个基于Lucene的搜索服务器。它提供了一个分布式多用户能力的全文搜索引擎，基于RESTful web接口。Elasticsearch是用Java语言开发的，并作为Apache许可条款下的开放源码发布，是一种流行的企业级搜索引擎。ElasticSearch用于云计算中，能够达到实时搜索，稳定，可靠，快速，安装使用方便。官方客户端在Java、.NET（C#）、PHP、Python、Apache Groovy、Ruby和许多其他语言中都是可用的。根据DB-Engines的排名显示，Elasticsearch是最受欢迎的企业搜索引擎，其次是Apache Solr，也是基于Lucene。

Elasticsearch是一个高度可伸缩的开源全文搜索和分析引擎。它允许您快速和接近实时地存储、搜索和分析大量数据。

### 优点
>
>查询 ： Elasticsearch 允许执行和合并多种类型的搜索 — 结构化、非结构化、地理位置、度量指标 — 搜索方式随心而变。
>分析 ： 找到与查询最匹配的十个文档是一回事。但是如果面对的是十亿行日志，又该如何解读呢？Elasticsearch 聚合让您能够从大处着眼，探索数据的趋势和模式。
>速度 ： Elasticsearch 很快。真的，真的很快。
>可扩展性 ： 可以在笔记本电脑上运行。 也可以在承载了 PB 级数据的成百上千台服务器上运行。
>弹性 ： Elasticsearch 运行在一个分布式的环境中，从设计之初就考虑到了这一点。
>灵活性 ： 具备多个案例场景。数字、文本、地理位置、结构化、非结构化。所有的数据类型都欢迎。
>HADOOP & SPARK ： Elasticsearch + Hadoop


### 基本概念

Near Realtime (NRT)

>Elasticsearch是一个近乎实时的搜索平台。这意味着从索引文档到可以搜索的时间只有轻微的延迟（通常是1秒）。

Cluster

>集群是一个或多个节点(服务器)的集合，它们共同保存你的整个数据，并提供跨所有节点的联合索引和搜索功能。一个集群由一个唯一的名称标识，默认这个唯一标识的名称是"elasticsearch"。这个名称很重要，因为如果节点被设置为按其名称加入集群，那么节点只能是集群的一部分。
确保不要在不同的环境中用相同的集群名称，否则可能导致节点加入到错误的集群中。例如，你可以使用"logging-dev", "logging-test", "logging-prod"分别用于开发、测试和正式集群的名字。


Node

>节点是一个单独的服务器，它是集群的一部分，存储数据，并参与集群的索引和搜索功能。就像集群一样，节点由一个名称来标识，默认情况下，该名称是在启动时分配给节点的随机通用唯一标识符(UUID)。如果不想用默认的节点名，可以定义任何想要的节点名。这个名称对于管理来说很重要，因为你希望识别网络中的哪些服务器对应于你的Elasticsearch集群中的哪些节点。

一个节点可以通过配置集群名称来加入到一个特定的集群中。默认情况下，每个节点都被设置加入到一个名字叫"elasticsearch"的集群中，这就意味着如果你启动了很多个节点，并且假设它们彼此可以互相发现，那么它们将自动形成并加入到一个名为"elasticsearch"的集群中。

一个集群可以有任意数量的节点。此外，如果在你的网络上当前没有运行任何节点，那么此时启动一个节点将默认形成一个单节点的名字叫"elasticsearch"的集群。

Index

>索引是具有某种相似特征的文档的集合。例如，你可以有一个顾客数据索引，产品目录索引和订单数据索引。索引有一个名称（必须是小写的）标识，该名称用于在对其中的文档执行索引、搜索、更新和删除操作时引用索引。

Document

>文档是可以被索引的基本信息单元。文档用JSON表示。

Shards & Replicas

>一个索引可能存储大量数据，这些数据可以超过单个节点的硬件限制。例如，一个包含10亿条文档占用1TB磁盘空间的索引可能不适合在单个节点上，或者可能太慢而不能单独处理来自单个节点的搜索请求。

为了解决这个问题，Elasticsearch提供了将你的索引细分为多个碎片（或者叫分片）的能力。在创建索引时，可以简单地定义所需的分片数量。每个分片本身就是一个功能完全独立的“索引”，可以驻留在集群中的任何节点上。

分片之所以重要，主要有两个原因：

它允许你水平地分割/扩展内容卷
它允许你跨分片（可能在多个节点上）分布和并行操作，从而提高性能和吞吐量

在一个网络/云环境中随时都有可能出现故障，强烈推荐你有一个容灾机制。Elasticsearch允许你将一个或者多个索引分片复制到其它地方，这被称之为副本。

复制之所以重要，有两个主要原因：

它提供了在一个shard/node失败是的高可用性。出于这个原因，很重要的一个点是一个副本从来不会被分配到与它复制的原始分片相同节点上。也就是说，副本是放到另外的节点上的。
它允许扩展搜索量/吞吐量，因为搜索可以在所有副本上并行执行。
总而言之，每个索引都可以分割成多个分片。索引也可以被复制零(意味着没有副本)或更多次。一旦被复制，每个索引都将具有主分片(被复制的原始分片)和副本分片(主分片的副本)。在创建索引时，可以为每个索引定义分片和副本的数量。创建索引后，您可以随时动态地更改副本的数量，但不能更改事后分片的数量。

在默认情况下，Elasticsearch中的每个索引都分配了5个主分片和1个副本，这意味着如果集群中至少有两个节点，那么索引将有5个主分片和另外5个副本分片（PS：这5个副本分片组成1个完整副本），每个索引总共有10个分片。

（画外音：副本是针对索引而言的，同时需要注意索引和节点数量没有关系，我们说2个副本指的是索引被复制了2次，而1个索引可能由5个分片组成，那么在这种情况下，集群中的分片数应该是 5 × (1 + 2) = 15 ）


作为一个elasticsearch的新手，我觉得elasticsearch的官网的文档归类清楚，作为新手很有必要多阅读几次，每次都能加深印象。这里作为个人理解进行一些简单的归类便于查阅。
对于新手而言，熟悉各类能够掌握简单的操作包括：索引的创建删除查询，文档的增删改查、集群信息查询等。

1. Indices APIs：负责索引Index的创建（create）、删除（delete）、获取（get）、索引存在（exist）等操作。
2. Document APIs：负责索引文档的创建（index）、删除（delete）、获取（get）等操作。
3. Search APIs：负责索引文档的search（查询），Document APIS根据doc_id进行查询，Search APIs]根据条件查询。
4. Aggregations：负责针对索引的文档各维度的聚合（Aggregation）。
5. cat APIs：负责查询索引相关的各类信息查询。
6. Cluster APIs：负责集群相关的各类信息查询。
 提供一个操作的方法，就是本机搭建个es集群然后部署一个kibana，通过kibana熟悉http api就可以了，这篇文章就专注下cat和cluster相关的api。



### 安装
```
tar -zxf elasticsearch-6.3.2.tar.gz
cd elasticsearch-6.3.2/bin
./elasticsearch
```

### 卸载




### Python elasticsearch



### http

```
查询 category_with_kwargs 索引的参数name=Java的数据
http://192.168.1.169:9201/category_with_kwargs/_search?q=name:Java

查看指定索引的文档数量
http://192.168.1.169:9201/category_with_kwargs/_count
http://192.168.1.169:9201/electron_with_kwargs_00/_count

模糊查看前缀为xx的索引数量
http://192.168.1.169:9201/electron_with_kwargs_*/_count

查询某个索引的文档记录
http://192.168.1.169:9201/electron_with_kwargs_00/_search

查询某个索引文档的category_id=05050的记录
http://192.168.1.169:9201/category_with_kwargs/_search?q=category_id:05050

查询某个索引文档的en_parameter:Thermoplastic+200kHz的记录
http://192.168.1.169:9201/electron_with_kwargs_0d/_search?q=en_parameter:Thermoplastic+200kHz

```


#### cat APIs介绍
```
查看索引
http://192.168.1.169:9201/_cat/indices?v

查看帮助
http://192.168.1.169:9201/_cat/master?help

查看索引(列出所有索引及存储大小)
http://192.168.1.169:9201/_cat/indices?v

Verbose 显示列名
http://192.168.1.169:9201/_cat/master?v

Headers 只显示特定列
health status index                   uuid                   pri rep docs.count docs.deleted store.size pri.store.size
http://192.168.1.169:9201/_cat/indices?v
http://192.168.1.169:9201/_cat/master?v&h=host,ip,node

数字格式化
http://192.168.1.169:9201/_cat/indices?v&h=index,docs.count,store.size&bytes=kb

Format 输出格式：
#以json格式输出 format=json&pretty
http://192.168.1.169:9201/_cat/indices?v&h=index,docs.count,store.size&bytes=kb&format=json&pretty

#以yaml格式输出 format=yaml&pretty
http://192.168.1.169:9201/_cat/indices?v&h=index,docs.count,store.size&bytes=kb&format=yaml&pretty

Sort 排序
#按index升序，docs.count降序
http://192.168.1.169:9201/_cat/indices?v&bytes=kb&s=index:asc,docs.count:desc

#按index升序，docs.count降序
http://192.168.1.169:9201/_cat/indices?v&s=index:asc,docs.count:desc

#按index升序，docs.count降序
http://192.168.1.169:9201/_cat/indices?v&h=index,docs.count,store.size&bytes=kb&format=json&pretty&s=index,docs.count:desc

查看集群健康状态
http://192.168.1.169:9201/_cat/health?v&h=cluster,status
http://192.168.0.12:9201/_cluster/health?pretty

向_cluster API发送放置请求以定义要打开的慢速日志级别：警告，信息，调试和跟踪
http://localhost:9201/_cluster/settings -H 'Content-Type: application/json' -d'

查看集群节点和磁盘剩余
#集群节点
http://192.168.1.169:9201/_cat/nodes?v

#磁盘剩余
http://192.168.1.169:9201/_cat/nodes?v&h=ip,node.role,name,disk.avail

查看集群master节点
http://192.168.1.169:9201/_cat/master?v

查看分配
#查看每个数据节点上的分片数(shards)，以及每个数据节点磁盘剩余
http://192.168.1.169:9201/_cat/allocation?v

查看被挂起任务
http://192.168.1.169:9201/_cat/pending_tasks?v

查看每个节点正在运行的插件
http://192.168.1.169:9201/_cat/plugins?v

查看每个节点的自定义属性
http://192.168.1.169:9201/_cat/nodeattrs?v

查看索引分片的恢复视图
#索引分片的恢复视图,包括正在进行和先前已完成的恢复
#只要索引分片移动到群集中的其他节点，就会发生恢复事件
http://192.168.1.169:9201/_cat/recovery/.kibana?v&format=json&pretty

查看每个数据节点上fielddata当前占用的堆内存
全文检索用倒排索引非常合适;但过滤、分组聚合、排序这些操作，正排索引更合适。
ES中引入了fielddata的数据结构用来做正排索引。如果需要对某一个字段排序、分组聚合、过滤，则可将字段设置成fielddata。

默认情况下:
text类型的字段是不能分组及排序的，如需要则需要开启该字段的fielddata=true,但是这样耗费大量的内存，不建议这么使用。
keyword类型默认可分组及排序。
fielddata默认是采用懒加载的机制加载到堆内存中。当某个字段基数特别大，可能会出现OOM。

http://192.168.1.169:9201/_cat/fielddata?v&h=node,field,size

#对某一字段进行查看
http://192.168.1.169:9201/_cat/fielddata?v&h=node,field,size&fields=kibana_stats.kibana.uuid


查看注册的快照仓库
http://192.168.1.169:9201/_cat/repositories?v

查看快照仓库下的快照
#可将ES中的一个或多个索引定期备份到如HDFS、S3等更可靠的文件系统，以应对灾难性的故障
#第一次快照是一个完整拷贝，所有后续快照则保留的是已存快照和新数据之间的差异
#当出现灾难性故障时，可基于快照恢复

http://192.168.1.169:9201/_cat/snapshots/repo1?v

查看每个节点线程池的统计信息
#查看每个节点bulk线程池的统计信息
# actinve（活跃的），queue（队列中的）和 reject（拒绝的）
http://192.168.1.169:9201/_cat/thread_pool/bulk?v&format=json&pretty

查看索引(aliases 负责展示当前es集群配置别名包括filter和routing信息)
http://192.168.1.169:9201/_cat/indices/.monitoring*?v&h=index,health

查看别名
http://192.168.1.169:9201/_cat/aliases?v&h=alias,index
http://192.168.1.169:9201/_cat/aliases?v
http://192.168.1.169:9201/_cat/aliases/alias1,alias2


allocation负责展示es的每个数据节点分配的索引分片以及使用的磁盘空间。
http://192.168.1.169:9201/_cat/allocation?v

count负责展示整个ES集群或者单个索引的文档数
http://192.168.1.169:9201/_cat/count?v
http://192.168.1.169:9201/_cat/count/electron_with_kwargs_00?v


fielddata负责展示ES集群每个数据节点中fileddata占用的堆内存
http://192.168.1.169:9201/_cat/fielddata?v
http://192.168.1.169:9201/_cat/fielddata?v&fields=body
http://192.168.1.169:9201/_cat/fielddata/body,soul?v


health负责展示集群的健康状态
GET /_cat/health?v
GET /_cat/health?v&ts=false


indices负责提供索引的相关信息，包括组成一个索引（index）的shard、document的数量，删除的doc数量，主存大小和所有索引的总存储大小。
http://192.168.1.169:9201/_cat/indices/electron_with_kwargs_*?v&s=index
http://192.168.1.169:9201/_cat/indices/electron_with_kwargs_*?v&s=store.size:desc

indices负责提供索引的相关信息，包括组成一个索引（index）的shard、document的数量，删除的doc数量，主存大小和所有索引的总存储大小。
命令：
GET /_cat/indices/twi*?v&s=index


master负责展示es集群的master节点信息包括节点id、节点名、ip地址等。
命令：
GET /_cat/master?v


nodeattrs负责展示通用的节点信息。

命令：
GET /_cat/nodeattrs?v


nodes负责展示es集群的拓扑信息。

命令：
GET /_cat/nodes?v


pending_tasks返回集群层面的未执行的任务列表包括创建索引，更新mapping，allocate分片信息。

命令：
GET /_cat/pending_tasks?v


plugins命令展示每个节点正在运行的插件信息。

命令：
GET /_cat/plugins?v&s=component&h=name,component,version,description


recovery命令展示索引分片恢复，包括正在进行的和已经完成的任务。

命令：
GET _cat/recovery?v
GET _cat/recovery?v&h=i,s,t,ty,st,shost,thost,f,fp,b,bp


repositories命令展示在集群中注册的快照仓库。

命令：
GET /_cat/repositories?v
GET /_cat/thread_pool/generic?v&h=id,name,active,rejected,completed


thread_pool命令展示集群节点的线程池的统计信息，包括处于活跃、队列等待、拒绝的线程任务信息。

命令：
GET /_cat/thread_pool


shards命令展示每个节点包括哪些分片信息。

命令：
GET _cat/shards
GET _cat/shards/electron_with_kwargs_*


segments命令展示索引的segments的信息。 

命令：
GET /_cat/segments?v


snapshots命令展示属于某个指定快照仓库的所有快照信息。通过/_cat/repositories查找所有的仓库列表。

命令：
GET /_cat/snapshots/repo1?v&s=id


templates展示已存在的模板信息。

命令：
GET /_cat/templates?v&s=name


查看索引模板
http://192.168.1.169:9201/_cat/templates?v&format=json&pretty

查看单个或某类或整个集群文档数
#整个集群文档数
http://192.168.1.169:9201/_cat/count?v

#某类索引文档数
http://192.168.1.169:9201/_cat/count/.monitoring*?v

查看每个索引的分片
http://192.168.1.169:9201/_cat/shards?v&format=json&pretty&s=index

查看每个索引的segment
http://192.168.1.169:9201/_cat/segments/.kibana?v&format=json&pretty


```

#### Cluster APIs介绍
```
health命令展示集群的健康状态，

命令：
http://192.168.1.169:9201/_cluster/health
GET /_cluster/health/test1,test2
返回结果：
{
  cluster_name: "elasticsearch",
  status: "yellow",
  timed_out: false,
  number_of_nodes: 1,
  number_of_data_nodes: 1,
  active_primary_shards: 259,
  active_shards: 259,
  relocating_shards: 0,
  initializing_shards: 0,
  unassigned_shards: 259,
  delayed_unassigned_shards: 0,
  number_of_pending_tasks: 0,
  number_of_in_flight_fetch: 0,
  task_max_waiting_in_queue_millis: 0,
  active_shards_percent_as_number: 50
}

state命令展示集群详细的状态信息，
其中metrics指标包括version、master_node、nodes、routing_table、metadata、blocks。

命令：
GET /_cluster/state
GET /_cluster/state/{metrics}/{indices}
GET /_cluster/state/metadata,routing_table/foo,bar

Stats命令展示集群的多维度统计信息。
指标包括shard numbers, store size, memory usage、
number, roles, os, jvm versions, memory usage, cpu and installed plugins。

命令：
GET /_cluster/stats?human&pretty


pending_tasks返回集群级别的未执行的任务，
包括创建索引,、更新mapping、 分配分片等。

命令：
GET /_cluster/pending_tasks


reroute命令允许我们人工的重新分配集群中的索引分片。
move：移动分片
cancel：取消分片分配
allocate_replica：分配副本

命令：
POST /_cluster/reroute
http://192.168.1.169:9201/_cluster/reroute
{
  error: "Incorrect HTTP method for uri [/_cluster/reroute] and method [GET], allowed: [POST]",
  status: 405
}


更新集群的配置信息并返回执行更新完成的配置。

命令：
PUT /_cluster/settings
{
    "persistent" : {
        "indices.recovery.max_bytes_per_sec" : "50mb"
    }
}

PUT /_cluster/settings?flat_settings=true
{
    "transient" : {
        "indices.recovery.max_bytes_per_sec" : "20mb"
    }
}

返回值：
{
    ...
    "persistent" : { },
    "transient" : {
        "indices.recovery.max_bytes_per_sec" : "20mb"
    }
}


_nodes/stats 展示集群中指定节点或所有节点的统计信息。

命令：
GET /_nodes/stats
GET /_nodes/nodeId1,nodeId2/stats


_nodes展示集群中每个节点的信息。

命令：
GET /_nodes
GET /_nodes/nodeId1,nodeId2
指标包括settings, os, process, jvm, thread_pool, transport, http, plugins, ingest，indices


_nodes/usage展示集群各个节点各类服务调用次数

命令：
GET _nodes/usage
GET _nodes/nodeId1,nodeId2/usage


返回集群的连接信息。

命令：
GET /_remote/info


_nodes/hot_threads展示集群节点的热点线程信息。

命令：
GET /_nodes/hot_threads
GET /_nodes/{nodesIds}/hot_threads.


用于解释分片没有被分配的原因

命令：
GET /_cluster/allocation/explain



```


#### index APIs
```
Index management:
Create index
PUT /twitter

Delete index
DELETE /twitter


Get index
GET /twitter

Index exists
HEAD /twitter

Close index
POST /twitter/_close

Open index
POST /twitter/_open

Shrink index
POST /twitter/_shrink/shrunk-twitter-index

Split index
POST /twitter/_split/split-twitter-index

Clone index
POST /twitter/_clone/cloned-twitter-index

Rollover index
POST /alias1/_rollover/twitter

Freeze index
POST /my_index/_freeze

Unfreeze index
POST /my_index/_unfreeze


Mapping management:
Put mapping
PUT /twitter/_mapping

Get mapping
GET /twitter/_mapping

Get field mapping
GET /twitter/_mapping/field/user

Type exists
HEAD twitter/_mapping/tweet


Alias management:
Add index alias
PUT /twitter/_alias/alias1
PUT /<index>/_alias/<alias>
POST /<index>/_alias/<alias>
PUT /<index>/_aliases/<alias>
POST /<index>/_aliases/<alias>

Delete index alias
DELETE /twitter/_alias/alias1
DELETE /<index>/_alias/<alias>
DELETE /<index>/_aliases/<alias>

Get index alias
GET /twitter/_alias/alias1
GET /_alias
GET /_alias/<alias>
GET /<index>/_alias/<alias>

Index alias exists
HEAD /_alias/alias1
HEAD /_alias/<alias>
HEAD /<index>/_alias/<alias>

Update index alias
POST /_aliases

Index settings:
Update index settings
PUT /twitter/_settings

Get index settings
GET /twitter/_settings

Analyze
GET /_analyze


Index templates:
Put index template
PUT _template/template_1

Delete index template
DELETE /_template/template_1

Get index template
GET /_template/template_1

Index template exists
HEAD /_template/template_1

Monitoring:
Index stats
GET /twitter/_stats

Index segments
GET /twitter/_segments

Index recovery
GET /twitter/_recovery

Index shard stores
GET /twitter/_shard_stores

Status management:
Clear cache
POST /twitter/_cache/clear
POST /_cache/clear

Refresh
POST /twitter/_refresh
POST <index>/_refresh
GET <index>/_refresh
POST /_refresh
GET /_refresh

Flush
POST /twitter/_flush
POST /<index>/_flush
GET /<index>/_flush
POST /_flush
GET /_flush

Synced flush
POST /twitter/_flush/synced
POST /<index>/flush/synced
GET /<index>/flush/synced
POST /flush/synced
GET /flush/synced

Force merge
POST /twitter/_forcemerge
POST /<index>/_forcemerge
POST /_forcemerge

explore api
POST <index>/_graph/explore
```


#### document APIs
```
Single document APIs

Index
PUT /<index>/_doc/<_id>
POST /<index>/_doc/
PUT /<index>/_create/<_id>
POST /<index>/_create/<_id>

Get
GET <index>/_doc/<_id>
HEAD <index>/_doc/<_id>
GET <index>/_source/<_id>
HEAD <index>/_source/<_id>

Delete
DELETE /<index>/_doc/<_id>

Update
POST /<index>/_update/<_id>

Multi-document APIs

Multi get
GET /_mget
GET /<index>/_mget

Bulk
POST /_bulk
POST /<index>/_bulk

Delete by query
POST /twitter/_delete_by_query

Update By Query API
POST twitter/_update_by_query?conflicts=proceed

Reindex
POST /_reindex


```



### curl 使用
```
查看是否健康
curl 192.168.1.169:9201/_cat/health?v

查看索引(列出所有索引及存储大小)
curl 192.168.1.169:9201/_cat/indices?v
curl -XGET 192.168.1.169:9201/_cat/indices?v

查看节点
curl 192.168.1.169:9201/_cat/nodes?v

查询创建的index的mapping是什么
curl 192.168.1.169:9201/new_electron/_mapping

带有用户名和密码的查询（带有验证信息的查询）
# 无账号密码，不可访问
curl http://[your-node-name]:[your-port]/[your-index]/_count?pretty=true
Authentication Required
# 通过user选项带上账号密码，返回正常数据
curl --user [your-admin]:[your-password] http://[your-node-name]:[your-port]/[your-index]/_count?pretty=true
eg:
curl --user [your-admin]:[your-password] http://192.168.1.169:9201/electron_with_kwargs_00/_count?pretty=true

插入数据
curl -POST IP:9201/索引名称/索引类型 -d '{
  "title": "test title 001",
  "description": "this is a random desc ",
  "price": 22.6,
  "onSale": "true",
  "type": 2,
  "createDate": "2018-01-12"
}'

查询数据
curl -XPOST http://127.0.0.1:9209/electron_with_kwargs_00/_search

检索全部
curl -XPOST http://127.0.0.1:9209/electron_with_kwargs_00/_search?pretty
curl -XPOST 127.0.0.1:9209/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }}"

match_all & 只返回前两个文档
curl -XPOST 127.0.0.1:9209/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"size\" : 2}"


match_all & 返回第11到第20的10个文档信息 & 降序排序
curl -XPOST 127.0.0.1:9201/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"from\" : 10, \"size\" : 10,\"sort\" : {\"timestamp\" : {\"order\" : \"desc\" }}}"


只返回title和description两个字段
curl -XPOST 127.0.0.1:9201/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"_source\": [\"title\", \"description\"]}"


查询 name=student60
curl -XPOST 127.0.0.1:9201/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match\": {\"name\": \"student60\" } }}"

查询 name=test
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"match\": {\"title\": \"test\" } }}"

返回 title=005 or name=007
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"match\": {\"title\": \"005 007\" } }}"

返回 title=007 or title=005
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"should\": [{\"match\": {\"title\": \"007\" }},{\"match\": {\"title\": \"005\" }}]}}}"

返回 不匹配title=007 & title=005
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must_not\": [{\"match\": {\"title\": \"007\" }},{\"match\": {\"title\": \"005\" }}]}}}"

返回 type=2 & title!=005
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"type\": 2 }}],\"must_not\": [{\"match\": {\"title\": \"005\" }}]}}}"

搜索商品名称中包含yagao的商品，而且按照售价降序排序
http://121.201.107.56:9209/electron_with_kwargs_00/_search?q=name:yagao&sort=price:desc

统计electron_with_kwargs_00数量
http://121.201.107.56:9209/electron_with_kwargs_00/_count


返回 短语匹配 title=title 007
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"match_phrase\": {\"title\": \"title 007\" } }}"

布尔值(bool)查询 返回 title=title & title=007
curl -XPOST IP:9201/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"title\": \"title\" }},{\"match\": {\"title\": \"007\" }}]}}}"




bulk 1000个文档到bank索引中了
curl -XPOST 127.0.0.1:9201/bank/account/_bulk?pretty --data-binary @accounts.json

删除索引bank:
curl -XDELETE http://127.0.0.1:9201/bank


不指定索引
curl -XPOST http://127.0.0.1:9201/_analyze


指定索引及分析器
curl -XPOST http://127.0.0.1:9201/electron_with_kwargs_00/_analyze



搜索数据API
有两种方式：
一种方式是通过 REST 请求 URI ，发送搜索参数；
另一种是通过REST 请求体，发送搜索参数。而请求体允许你包含更容易表达和可阅读的JSON格式。
通过 REST 请求 URI
curl localhost:9201/bank/_search?pretty
pretty，参数告诉elasticsearch，返回形式打印JSON结果

通过REST 请求体
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }}"
query：告诉我们定义查询 
match_all：运行简单类型查询指定索引中的所有文档
除了指定查询参数，还可以指定其他参数来影响最终的结果。



查询查询index=electron_with_kwargs_ce 字段_id=14813的记录
curl -XGET '10.10.10.2:9201/electron_with_kwargs_ce/_doc/14813?pretty'

查询index=electron_with_kwargs_ce 字段值zh_parameter=ravf的记录
curl -XGET '10.10.10.2:9201/electron_with_kwargs_ce/_doc/_search?q=zh_parameter:ravf'

match_all & 只返回前两个文档：
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"size\" : 2}"
如果不指定size，默认是返回10条文档信息


match_all & 返回第11到第20的10个文档信息
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"from\" : 10, \"size\" : 10}"
from：指定文档索引从哪里开始，默认从0开始 
size：从from开始，返回多个文档 
这feature在实现分页查询很有用


match_all and 根据account 的balance字段 降序排序 & 返回10个文档（默认10个）
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"sort\" : {\"balance\" : {\"order\" : \"desc\" }}}"

比如只返回account_number 和balance两个字段
默认的，我们搜索返回完整的JSON文档。而source（_source字段搜索点击量）。如果我们不想返回完整的JSON文档，我们可以使用source返回指定字段。

　　　　
比如只返回account_number 和balance两个字段
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"_source\": [\"account_number\", \"balance\"]}"
match 查询，可作为基本字段搜索查询 　


返回 account_number=20:
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match\": {\"account_number\": 20 } }}"

 　　　　
返回 address=mill：
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match\": {\"address\": \"mill\" } }}"

　　　　
返回 address=mill or address=lane：
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match\": {\"address\": \"mill lane\" } }}"

 
返回 短语匹配 address=mill lane：
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"match_phrase\": {\"address\": \"mill lane\" } }}"

 　　　　
布尔值(bool)查询
返回 匹配address=mill & address=lane：
must:要求所有条件都要满足（类似于&&）
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"


返回 匹配address=mill or address=lane
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"bool\": {\"should\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"
should：任何一个满足就可以（类似于||）

 
返回 不匹配address=mill & address=lane
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must_not\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"
must_not:所有条件都不能满足（类似于! (&&)）

　　　　　　
返回 age=40 & state!=ID
curl -XPOST localhost:9201/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"address\": \"mill\" }}],\"must_not\": [{\"match\": {\"state\": \"ID\" }}]}}}"


curl -XGET 'http://master:9201/zhouls/user/1?_source=name,age&pretty'
curl -XGET 'http://master:9201/zhouls/user/1?_source=name&pretty'
curl -XGET 'http://master:9201/zhouls/user/_search'
curl -XGET 'http://master:9201/zhouls/user/_search?q=name:john'
curl -XGET http://master:9201/zhouls/user/_search -d '{"query" : {"match" : {"name": "lily" }}}'





 
执行过滤器
文档中score(_score字段是搜索结果)。score是一个数字型的，是一种相对方法匹配查询文档结果。分数越高，搜索关键字与该文档相关性越高；越低，搜索关键字与该文档相关性越低。
在elasticsearch中所有的搜索都会触发相关性分数计算。如果我们不使用相关性分数计算，那要使用另一种查询能力，构建过滤器。
过滤器是类似于查询的概念,除了得以优化,更快的执行速度的两个主要原因: 

1、过滤器不计算得分，所以他们比执行查询的速度 
2、过滤器可缓存在内存中，允许重复搜索
为了便于理解过滤器，先介绍过滤器搜索(like match_all, match, bool, etc.)，可以与其他的普通查询搜索组合一个过滤器。 
range filter,允许我们通过一个范围值来过滤文档，一般用于数字或日期过滤
使用过滤器搜索返回 balances[ 20000,30000]。换句话说，balance>=20000 && balance<=30000


POST /bank/_search?pretty
{
  "query": {
    "bool": {
        "must":     { "match": { "age": 39 }},
        "must_not": { "match": { "employer":"Digitalus" }},
        "filter": 
        {
          "range": 
            { "balance": 
              {
                "gte": 20000,
                "lte": 30000             
              }          
            } 
        }
    }
  }
}


执行聚合
聚合提供从你的数据中分组和提取统计能力， 类似于关系型数据中的SQL GROUP BY和SQL 聚合函数。
在Elasticsearch中,你有能力执行搜索返回命中结果,同时拆分命中结果，然后统一返回结果。当你使用简单的API运行搜索和多个聚合，然后返回所有结果避免网络带宽过大的情况是高效的。
根据state分组，降序统计top 10 state


返回指定的字段，排除不需要的字段
GET /_search
{
    "_source": {
        "includes": [ "obj1.*", "obj2.*" ],
        "excludes": [ "*.description" ]
    },
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}
```




### 疑难杂症

#### 问题：表xxx，TransportError(429, 'circuit_breaking_exception', '[parent] Data too large, data for [<http_request>] would be [1037526858/989.4mb], which is larger than the limit of [986932838/941.2mb], real usage: [1036345280/988.3mb], new bytes reserved: [1181578/1.1mb]')
解决方法：
需要增加es ES_HEAP_SIZE大小，默认为1g，将堆内存大小调整到4g


#### ConnectionTimeout caused by - ReadTimeoutError(HTTPConnectionPool(host='192.168.1.169', port=9201): Read timed out.)
```

```

