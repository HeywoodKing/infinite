## ElasticSearch

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
查看索引
http://192.168.1.169:9200/_cat/indices?v

查看指定索引的文档数量
http://110.43.50.188:9201/category_with_kwargs/_count
http://110.43.50.188:9201/electron_with_kwargs_00/_count

模糊查看前缀为xx的索引数量
http://110.43.50.188:9201/electron_with_kwargs_*/_count

查询某个索引的文档记录
http://110.43.50.188:9201/electron_with_kwargs_00/_search
```


### curl 使用
```
查看是否健康
curl 192.168.1.169:9200/_cat/health?v

查看索引(列出所有索引及存储大小)
curl 192.168.1.169:9200/_cat/indices?v
curl -XGET 192.168.1.169:9200/_cat/indices?v

查看节点
curl 192.168.1.169:9200/_cat/nodes?v

查询创建的index的mapping是什么
curl 192.168.1.169:9200/new_electron/_mapping

插入数据
curl -POST IP:9200/索引名称/索引类型 -d '{
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
curl -XPOST 127.0.0.1:9200/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"from\" : 10, \"size\" : 10,\"sort\" : {\"timestamp\" : {\"order\" : \"desc\" }}}"


只返回title和description两个字段
curl -XPOST 127.0.0.1:9200/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"_source\": [\"title\", \"description\"]}"


查询 name=student60
curl -XPOST 127.0.0.1:9200/electron_with_kwargs_00/_search?pretty -d "{\"query\": {\"match\": {\"name\": \"student60\" } }}"

查询 name=test
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"match\": {\"title\": \"test\" } }}"

返回 title=005 or name=007
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"match\": {\"title\": \"005 007\" } }}"

返回 title=007 or title=005
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"should\": [{\"match\": {\"title\": \"007\" }},{\"match\": {\"title\": \"005\" }}]}}}"

返回 不匹配title=007 & title=005
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must_not\": [{\"match\": {\"title\": \"007\" }},{\"match\": {\"title\": \"005\" }}]}}}"

返回 type=2 & title!=005
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"type\": 2 }}],\"must_not\": [{\"match\": {\"title\": \"005\" }}]}}}"

搜索商品名称中包含yagao的商品，而且按照售价降序排序
http://121.201.107.56:9209/electron_with_kwargs_00/_search?q=name:yagao&sort=price:desc

统计electron_with_kwargs_00数量
http://121.201.107.56:9209/electron_with_kwargs_00/_count


返回 短语匹配 title=title 007
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"match_phrase\": {\"title\": \"title 007\" } }}"

布尔值(bool)查询 返回 title=title & title=007
curl -XPOST IP:9200/索引名称/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"title\": \"title\" }},{\"match\": {\"title\": \"007\" }}]}}}"




bulk 1000个文档到bank索引中了
curl -XPOST 127.0.0.1:9200/bank/account/_bulk?pretty --data-binary @accounts.json

删除索引bank:
curl -XDELETE http://127.0.0.1:9200/bank


不指定索引
curl -XPOST http://127.0.0.1:9200/_analyze


指定索引及分析器
curl -XPOST http://127.0.0.1:9200/electron_with_kwargs_00/_analyze



搜索数据API
有两种方式：
一种方式是通过 REST 请求 URI ，发送搜索参数；
另一种是通过REST 请求体，发送搜索参数。而请求体允许你包含更容易表达和可阅读的JSON格式。
通过 REST 请求 URI
curl localhost:9200/bank/_search?pretty
pretty，参数告诉elasticsearch，返回形式打印JSON结果

通过REST 请求体
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }}"
query：告诉我们定义查询 
match_all：运行简单类型查询指定索引中的所有文档
除了指定查询参数，还可以指定其他参数来影响最终的结果。



查询查询index=electron_with_kwargs_ce 字段_id=14813的记录
curl -XGET '10.10.10.2:9201/electron_with_kwargs_ce/_doc/14813?pretty'

查询index=electron_with_kwargs_ce 字段值zh_parameter=ravf的记录
curl -XGET '10.10.10.2:9201/electron_with_kwargs_ce/_doc/_search?q=zh_parameter:ravf'

match_all & 只返回前两个文档：
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"size\" : 2}"
如果不指定size，默认是返回10条文档信息


match_all & 返回第11到第20的10个文档信息
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"from\" : 10, \"size\" : 10}"
from：指定文档索引从哪里开始，默认从0开始 
size：从from开始，返回多个文档 
这feature在实现分页查询很有用


match_all and 根据account 的balance字段 降序排序 & 返回10个文档（默认10个）
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"sort\" : {\"balance\" : {\"order\" : \"desc\" }}}"

比如只返回account_number 和balance两个字段
默认的，我们搜索返回完整的JSON文档。而source（_source字段搜索点击量）。如果我们不想返回完整的JSON文档，我们可以使用source返回指定字段。

　　　　
比如只返回account_number 和balance两个字段
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_all\": {} }, \"_source\": [\"account_number\", \"balance\"]}"
match 查询，可作为基本字段搜索查询 　


返回 account_number=20:
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match\": {\"account_number\": 20 } }}"

 　　　　
返回 address=mill：
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match\": {\"address\": \"mill\" } }}"

　　　　
返回 address=mill or address=lane：
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match\": {\"address\": \"mill lane\" } }}"

 
返回 短语匹配 address=mill lane：
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"match_phrase\": {\"address\": \"mill lane\" } }}"

 　　　　
布尔值(bool)查询
返回 匹配address=mill & address=lane：
must:要求所有条件都要满足（类似于&&）
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"


返回 匹配address=mill or address=lane
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"bool\": {\"should\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"
should：任何一个满足就可以（类似于||）

 
返回 不匹配address=mill & address=lane
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must_not\": [{\"match\": {\"address\": \"mill\" }},{\"match\": {\"address\": \"lane\" }}]}}}"
must_not:所有条件都不能满足（类似于! (&&)）

　　　　　　
返回 age=40 & state!=ID
curl -XPOST localhost:9200/bank/_search?pretty -d "{\"query\": {\"bool\": {\"must\": [{\"match\": {\"address\": \"mill\" }}],\"must_not\": [{\"match\": {\"state\": \"ID\" }}]}}}"


curl -XGET 'http://master:9200/zhouls/user/1?_source=name,age&pretty'
curl -XGET 'http://master:9200/zhouls/user/1?_source=name&pretty'
curl -XGET 'http://master:9200/zhouls/user/_search'
curl -XGET 'http://master:9200/zhouls/user/_search?q=name:john'
curl -XGET http://master:9200/zhouls/user/_search -d '{"query" : {"match" : {"name": "lily" }}}'





 
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

```




### 疑难杂症

#### 问题：表xxx，TransportError(429, 'circuit_breaking_exception', '[parent] Data too large, data for [<http_request>] would be [1037526858/989.4mb], which is larger than the limit of [986932838/941.2mb], real usage: [1036345280/988.3mb], new bytes reserved: [1181578/1.1mb]')
解决方法：
需要增加es ES_HEAP_SIZE大小，默认为1g，将堆内存大小调整到4g


#### ConnectionTimeout caused by - ReadTimeoutError(HTTPConnectionPool(host='110.43.50.188', port=9201): Read timed out.)
```

```

