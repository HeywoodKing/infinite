##爬虫

1. TCP/IP模型，TCP协议原理，IP协议原理，TCP三次握手，四次挥手


2. HTTP协议原理


3. HTTP1.1和HTTP2.0区别？


4. python多进程，多线程，协程开发（gevent, asyncio, greenlet）


5. Scrapy框架原理以及分布式爬取


6. Selenium框架原理，WebDriver


7. 解析工具Jsoup, Xpath, Beautifulsoup, htmpparser,正则, Nutch, Heritrix

Jsoup:
```
Beautifulsoup for Java
Jsoup就是java环境下同样具有html文档解析的最好的选择之一
主要方法就是 Jsoup.parse()，解析出来的是一个Document对象。Element对象则提供了一系列类似于DOM的方法来查找元素，抽取并处理其中的元素。这边还是根据官方文档的中文版将它们一一列举，以便使用：

查找元素

getElementById(String id)

getElementsByTag(String tag)

getElementsByClass(String className)

getElementsByAttribute(String key) (and related methods)

Element siblings: siblingElements(), firstElementSibling(), lastElementSibling(); nextElementSibling(), previousElementSibling()

Graph: parent(), children(), child(int index)

元素数据

attr(String key)获取属性attr(String key, String value)设置属性

attributes()获取所有属性

id(), className() and classNames()

text()获取文本内容text(String value) 设置文本内容

html()获取元素内HTMLhtml(String value)设置元素内的HTML内容

outerHtml()获取元素外HTML内容

data()获取数据内容（例如：script和style标签)

tag() and tagName()

操作HTML和文本

append(String html), prepend(String html)

appendText(String text), prependText(String text)

appendElement(String tagName), prependElement(String tagName)

html(String value)

这给我大致的感觉就像是html的读写，而爬虫就是利用它的读的功能。

```

Xpath:
- //标签                  表示从全局的子子孙孙中查找标签
- /标签                   表示从子代中查找标签
- 标签[@标签属性]         查找带有xxx属性的标签
- 标签[@标签属性="值"]    查找带有xxx属性=x值的标签
- 标签/@标签属性          查找标签xxx属性的值
- .//标签                 从当前标签中查找
- 
```
response = HtmlResponse(url='http://example.com', body=html,encoding='utf-8')
hxs = HtmlXPathSelector(response)
print(hxs)   # selector对象
hxs = Selector(response=response).xpath('//a')
print(hxs)    #查找所有的a标签
hxs = Selector(response=response).xpath('//a[2]')
print(hxs)    #查找某一个具体的a标签    取第三个a标签
hxs = Selector(response=response).xpath('//a[@id]')
print(hxs)    #查找所有含有id属性的a标签
hxs = Selector(response=response).xpath('//a[@id="i1"]')
print(hxs)    # 查找含有id=“i1”的a标签
hxs = Selector(response=response).xpath('//a[@href="link.html"][@id="i1"]')
print(hxs)   # 查找含有href=‘xxx’并且id=‘xxx’的a标签
hxs = Selector(response=response).xpath('//a[contains(@href, "link")]')
print(hxs)   # 查找 href属性值中包含有‘link’的a标签
hxs = Selector(response=response).xpath('//a[starts-with(@href, "link")]')
print(hxs)   # 查找 href属性值以‘link’开始的a标签
hxs = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]')
print(hxs)   # 正则匹配的用法   匹配id属性的值为数字的a标签
hxs = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]/text()').extract()
print(hxs)    # 匹配id属性的值为数字的a标签的文本内容
hxs = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]/@href').extract()
print(hxs)    #匹配id属性的值为数字的a标签的href属性值
hxs = Selector(response=response).xpath('/html/body/ul/li/a/@href').extract()
print(hxs)    #抽取当前路径/html/body/ul/li/下a标签的href属性值
hxs = Selector(response=response).xpath('//body/ul/li/a/@href').extract_first()
print(hxs)    #抽取全局路径//body/ul/li/下a标签的href属性第一个值

备注：
xpath中支持正则的使用：    用法  标签[re:test（@属性值，"正则表达式"）]
获取标签的文本内容：   /text()     
获取第一个值：  selector_obj.extract_first()    
获取所有的值：  selector_obj.extract()  返回一个list

```
Beautifulsoup：

BeautifulSoup库通俗来说是【解析、遍历、维护“标签树”(例如html、xml等格式的数据对象)的功能库 】

有五种基本元素：Tag  Name Attributes NavigableString Comment

```
from bs4 import BeautifulSoup
import requests

url = 'http://python123.io/ws/demo.html'
r = requests.get(url)
demo = r.text  # 服务器返回响应

soup = BeautifulSoup(demo, "html.parser")
"""
demo 表示被解析的html格式的内容
html.parser表示解析用的解析器
"""
print(soup)  # 输出响应的html对象
print(soup.prettify())  # 使用prettify()格式化显示输出

```

得到一个BeautifulSoup对象后，一般通过BeautifulSoup类的基本元素来提取html中的内容

![Beautifulsoup](https://images2018.cnblogs.com/blog/1158674/201804/1158674-20180405201803471-1308841470.png "Beautifulsoup")
```
print(soup.title)  # 获取html的title标签的信息
print(soup.a)  # 获取html的a标签的信息(soup.a默认获取第一个a标签，想获取全部就用for循环去遍历)
print(soup.a.name)   # 获取a标签的名字
print(soup.a.parent.name)   # a标签的父标签(上一级标签)的名字
print(soup.a.parent.parent.name)  # a标签的父标签的父标签的名字

```
![示例](https://images2018.cnblogs.com/blog/1158674/201804/1158674-20180405211857515-237793977.png "示例")

```
print('a标签类型是：', type(soup.a))   # 查看a标签的类型
print('第一个a标签的属性是：', soup.a.attrs)  # 获取a标签的所有属性(注意到格式是字典)
print('a标签属性的类型是：', type(soup.a.attrs))  # 查看a标签属性的类型
print('a标签的class属性是：', soup.a.attrs['class'])   # 因为是字典，通过字典的方式获取a标签的class属性
print('a标签的href属性是：', soup.a.attrs['href'])   # 同样，通过字典的方式获取a标签的href属性
```
![示例](https://images2018.cnblogs.com/blog/1158674/201804/1158674-20180405212511679-268746778.png "示例")

```
print('a标签的非属性字符串的类型是：', type(soup.a.string))  # 查看标签string字符串的类型
print('第一个p标签的内容是：', soup.p.string)  # p标签的字符串信息(注意p标签中还有个b标签，但是打印string时并未打印b标签，说明string类型是可跨越多个标签层次)
```
![示例](https://images2018.cnblogs.com/blog/1158674/201804/1158674-20180405212751192-1243460941.png "示例")

```
介绍一下find_all()方法：

常用通过find_all()方法来查找标签元素：<>.find_all(name, attrs, recursive, string, **kwargs) ，返回一个列表类型，存储查找的结果 

• name：对标签名称的检索字符串
• attrs：对标签属性值的检索字符串，可标注属性检索
• recursive：是否对子孙全部检索，默认True
• string：<>…</>中字符串区域的检索字符串

print('所有a标签的内容：', soup.find_all('a')) # 使用find_all()方法通过标签名称查找a标签,返回的是一个列表类型
print('a标签和b标签的内容：', soup.find_all(['a', 'b']))  # 把a标签和b标签作为一个列表传递，可以一次找到a标签和b标签

for t in soup.find_all('a'):  # for循环遍历所有a标签，并把返回列表中的内容赋给t
    print('t的值是：', t)  # link得到的是标签对象
    print('t的类型是：', type(t))
    print('a标签中的href属性是：', t.get('href'))  # 获取a标签中的url链接


for i in soup.find_all(True):  # 如果给出的标签名称是True，则找到所有标签
    print('标签名称：', i.name)  # 打印标签名称
```
![find_all](https://images2018.cnblogs.com/blog/1158674/201804/1158674-20180405213752162-2114635153.png "find_all")


```
print('href属性为http..的a标签元素是:', soup.find_all('a', href='http://www.icourse163.org/course/BIT-268001'))  # 标注属性检索
print('class属性为title的标签元素是：', soup.find_all(class_='title'))  # 指定属性，查找class属性为title的标签元素，注意因为class是python的关键字，所以这里需要加个下划线'_'
print('id属性为link1的标签元素是：', soup.find_all(id='link1'))  # 查找id属性为link1的标签元素


print('href属性为http..的a标签元素是:', soup.find_all('a', href='http://www.icourse163.org/course/BIT-268001'))  # 标注属性检索
print('class属性为title的标签元素是：', soup.find_all(class_='title'))  # 指定属性，查找class属性为title的标签元素，注意因为class是python的关键字，所以这里需要加个下划线'_'
print('id属性为link1的标签元素是：', soup.find_all(id='link1'))  # 查找id属性为link1的标签元素


print(soup.head)  # head标签
print(soup.head.contents)   # head标签的儿子标签，contents返回的是列表类型
print(soup.body.contents)   # body标签的儿子标签
"""对于一个标签的儿子节点，不仅包括标签节点，也包括字符串节点，比如返回结果中的 \n"""


print(len(soup.body.contents))  # 获得body标签儿子节点的数量
print(soup.body.contents[1])   # 通过列表索引获取第一个节点的内容


print(type(soup.body.children))  # children返回的是一个迭代对象，只能通过for循环来使用，不能直接通过索引来读取其中的内容
for i in soup.body.children:   # 通过for循环遍历body标签的儿子节点
    print(i.name)   # 打印节点的名字
```








htmpparser:
```

```

正则：
```
```

Nutch:
```
```

Heritrix:
```
```



8. 爬虫策略，反爬虫策略


9. 验证码破解


10. mysql数据库原理
> 特点：适用于大中小型网站， 体积小，速度快，总体成本低，开放源代码
mysqld三层结构：
- 连接层：
    + 提供链接协议（TCP/IP socket）
    + 验证功能（用户身份信息）
    + 提供一个专门的连接线程（接受用户发来的sql语句，并在执行后返回最终结果，但不能读和执行sql语句，会将sql语句传递给下一层）
- sql层
    + 接受上层传入的sql
    + 语法检查模块进行语法检查
    + 语义检查模块检查语义，分辨sql语句的类型，将不同种类的语句，交给不同的解析器
    + 解析器接收到sql语句，进行解析操作，得到sql语句的执行计划（explain）
    + 优化器负责基于"开销"找到执行开销最小的执行计划（优化sql，让优化器选择最优的执行方式，了解优化器的规则）
    + 执行器基于优化器的选择，执行SQL语句，并得到获取数据的方法，交给下一层继续处理
    + 接受存储引擎层获取到的二进制数据，结构化成表
    + 查询缓存：SQL语句的哈希值+数据结果（在修改类业务很多的情况下，并不适用）
- 存储引擎层
    + 根据上一层获取数据的方法，将数据提取出来
    + 重新再交给sql层

权限分类：
```
ALL privileges（所有权限）
SELECT, INSERT, UPDATE, DELETE, CREATE, RELOAD, 
SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, 
SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, DROP
LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT,
CREATE VIEW, SHOW VIEW, CREATE ROUTINE,
ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE
```

开发一般用到的权限
```
create、 update、 insert、  select、  CREATE VIEW、  CREATE ROUTINE、     SHOW VIEW 、CREATE TEMPORARY TABLES、  ALTER
```

权限作用范围:
```
*.*   　  　  ------->所有库的所有表
py.*　  　    ------->py库的所有表
bbs.*　       ------->bbs库的所有表
py.t1　　     ------->py库的t1表
```

设置权限的语句:
```
grant 权限 on 权限作用范围 to 用户 identified by '密码'

给了全部权限，*.*所有作用范围 所有表 app用户使用123密码在10.0.0.1到10.0.0.254IP地址范围内
grant  all privileges   on   *.*   to   app@'10.0.0.%'     identified  by    '123'

将bbs数据库的所有表的create,update,insert,select ,CREATE VIEW权限，给了 IP地址在12网段的用户（bbsuser@'192.168.12.%'），这些用户的密码是‘123’
grant　 create,update,insert,select ,CREATE VIEW　　 on 　　bbs.*　　 to 　　bbsuser@'192.168.12.%' 　　identified by　　 '123';
```


用户组成：
`用户名@‘主机范围’`

主机范围：
```
即IP地址范围，有如下几种写法：
10.0.0.200              -------> 指定就这一个
10.0.0.%                -------> 10.0.0.1--10.0.0.254 范围的ip地址
10.0.0.5%               -------> 10.0.0.50-- 10.0.0.59
%                       -------> 所有的地址都可以
```




mysql数据库索引
B树（默认）：
B+tree 
B*tree

+ Hash 索引
哈希索引只有Memory, NDB两种引擎支持，Memory引擎默认支持哈希索引，如果多个hash值相同，出现哈希碰撞，那么索引以链表方式存储，但是，Memory引擎表只对能够适合机器的内存有限的数据集，

要使InnoDB或MyISAM支持哈希索引，可以通过伪哈希索引来实现，叫自适应哈希索引。
主要通过增加一个字段，存储hash值，将hash值建立索引，在插入和更新的时候，建立触发器，自动添加计算后的hash到表里
+ fulltext 全文索引
B树：
cluster indexes 聚集索引 ，随机IO变成顺序IO
辅助索引 ------>人为管控的：unique 普通的 index

+ 前缀索引
根据字段的前N个字符建立索引
```
alter table student add note varchar(200);
alter table student add index idx_note(note(10)); 
```
 
+ 联合索引
多个字段建立一个索引,联合主键是联合索引的特殊形式
```
where a=女生 and b身高=165 and c身材=好
index(a,b,c)

alter table people add index idx(a,b,c);
a,ab,abc,ac 可以走索引或部分走索引(5.6之后 ac 可以走主键索引)
b bc c ca ba 不走索引
原则：把最常用来作为条件查询的列放在前面。

create table people
(
    id int not null auto_increment primary key ,
    name varchar(20),
    gender enum('m','f'),
    shengao int,
    tizhong int
);

alter table people add index idx_gst(gender,shengao,tizhong);
```

+ 主键索引
只能有一个主键。
主键索引:列的内容是唯一值,例如学号.
表创建的时候至少要有一个主键索引，最好和业务无关。

+ 普通索引
加快查询速度，工作中优化数据库的关键。
在合适的列上建立索引，让数据查询更高效。
```
create index index_name on test(name);
alter table test add index index_name(name);
```
在where条件关键字后面的列建立索引才会加快查询速度.
select id,name from test where state=1 order by id group by name;

+ 唯一索引
内容唯一，但不是主键。
```
create unique index index_name on test(name);
```

数据库索引的设计原则
>为了使索引的使用效率更高，在创建索引时，必须考虑在哪些字段上创建索引和创建什么类型的索引

1. 选择唯一性索引


2. 经常需要排序、分组和联合操作的字段建立索引
经常需要ORDER BY、GROUP BY、DISTINCT和UNION等操作的字段，排序操作会浪费很多时间

3. 常作为查询条件的字段建立索引


4. 限制索引的数目
索引的数目不是越多越好。每个索引都需要占用磁盘空间，索引越多，需要的磁盘空间就越大。修改表时，对索引的重构和更新很麻烦。越多的索引，会使更新表变得很浪费时间。

5. 尽量使用数据量少的索引
如果索引的值很长，那么查询的速度会受到影响。例如，对一个CHAR（100）类型的字段进行全文检索需要的时间肯定要比对CHAR（10）类型的字段需要的时间要多

6. 尽量使用前缀来索引
如果索引字段的值很长，最好使用值的前缀来索引。例如，TEXT和BLOG类型的字段，进行全文检索会很浪费时间。如果只检索字段的前面的若干个字符，这样可以提高检索速度。

7. 删除不再使用或者很少使用的索引
表中的数据被大量更新，或者数据的使用方式被改变后，原有的一些索引可能不再需要。数据库管理员应当定期找出这些索引，将它们删除，从而减少索引对更新操作的影响。

8. 小表不应建立索引
包含大量的列并且不需要搜索非空值的时候可以考虑不建索引

### 索引采用BTree、B+Tree
BTree是平衡树，多路搜索树，
+ 开区间
+ 关键字集合分布在整颗树中
+ 任何一个关键字出现且只出现在一个结点中
+ 搜索有可能在非叶子结点命中而结束
+ 搜索有可能在叶子节点命中而结束
+ 其搜索性能等价于在关键字全集内做一次二分查找
+ 自动层次控制
+ 由于限制了除根结点以外的非叶子结点，至少含有M/2个儿子，确保了结点的至少利用率

B+Tree是平衡树，多路搜索树，是BTree的变体
+ 其定义基本与B-树同
+ 所有关键字都出现在叶子结点节点的链表中（稠密索引），且链表中的关键字是有序的
+ 不可能在非叶子结点命中
+ 非叶子结点相当于是叶子结点的索引（稀疏索引），叶子结点相当于是存储（关键字）数据的数据层
+ 更适合文件索引系统


B*Tree
B*Tree 是B+树的变体
```
B\*树定义了非叶子结点关键字个数至少为(2/3)*M，即块的最低使用率为2/3
B*树分配新结点的概率比B+树要低，空间使用率更高
```

```
B+树的分裂：当一个结点满时，分配一个新的结点，并将原结点中1/2的数据
复制到新结点，最后在父结点中增加新结点的指针；B+树的分裂只影响原结点和父
结点，而不会影响兄弟结点，所以它不需要指向兄弟的指针；

B*树的分裂：当一个结点满时，如果它的下一个兄弟结点未满，那么将一部分
数据移到兄弟结点中，再在原结点插入关键字，最后修改父结点中兄弟结点的关键字
（因为兄弟结点的关键字范围改变了）；如果兄弟也满了，则在原结点与兄弟结点之
间增加新结点，并各复制1/3的数据到新结点，最后在父结点增加新结点的指针；

### 总结：
二叉搜索树：二叉树，每个结点只存储一个关键字，等于则命中，小于走左结点，大于走右结点；

B（B-）树：多路搜索树，每个结点存储M/2到M个关键字，非叶子结点存储指向关键字范围的子结点；所有关键字在整颗树中出现，且只出现一次，非叶子结点可以命中；

B+树：在B-树基础上，为叶子结点增加链表指针，所有关键字都在叶子结点中出现，非叶子结点作为叶子结点的索引；B+树总是到叶子结点才命中；

B*树：在B+树基础上，为非叶子结点也增加链表指针，将结点的最低利用率从1/2提高到2/3；


AVL Tree：
windows NT内核中应用广泛，适合查找，不适合修改、更新、删除等

红黑树：
+ 广泛用于C++的STL中,map和set都是用红黑树实现的.
+ 著名的linux进程调度Completely Fair Scheduler,用红黑树管理进程控制块,进程的虚拟内存区域都存储在一颗红黑树上,每个虚拟地址区域都对应红黑树的一个节点,左指针指向相邻的地址虚拟存储区域,右指针指向相邻的高地址虚拟地址空间.
+ IO多路复用epoll的实现采用红黑树组织管理sockfd，以支持快速的增删改查.
+ ngnix中,用红黑树管理timer,因为红黑树是有序的,可以很快的得到距离当前最小的定时器.
+ java中TreeMap的实现.

```

MySQL事务隔离级别
+ 原子性 Atomicity
+ 一致性 Consistency
+ 隔离性 Isolation
+ 持久性 Durability
ACID

事物的并发问题：
+ 脏读：事务A读取了事务B更新的数据，然后B回滚操作，那么A读取到的数据就是脏数据
+ 不可重复读：事务A多次读取同一个数据，事务B在事务B多次读取的过程中，对数据进行了更新并提交，导致事务A多次读取同一数据时，结果不一致
+ 幻读：系统管理员A更改了数据记录的某一个字段值，此时B插入了一条记录，当A修改结束时发现还有一条记录没有修改过来，这就好像发生了幻觉一样，这就是幻读

不可重复读侧重于修改，解决不可重复读只需要锁住满足条件的行。
幻读侧重于新增或删除，解决幻读只需要锁住表


隔离级别：
```
名称                                              脏读    不可重复读     幻读
读未提交（read uncommitted）                      是        是            是
读已提交（不可重复读）（read committed）          否        是            是
可重复读（repeatable read）                       否        否            是
串行化（serializable）                            否        否            否
```


数据库设计范式


乐观锁：


悲观锁：


如何解决事务并发问题





11. mongodb数据库原理
非关系型数据库：高性能，高并发，对数据一致性要去不高，json格式存取
nosql菲关系型数据库总结：
+ nosql不是否定关系数据库，而是作为关系数据库的一个重要补充
+ nosql为了高性能，高并发而生，忽略影响高性能，高并发的功能
+ nosql典型的产品有memcached(纯内存)，redis(持久化缓存)， mongodb(文档型数据库)

BSON文档（对象）是一种计算机数据交换格式，主要被用作MongoDB数据库中的数据存储和网络传输格式，Binary JSON（二进制JSON）
JSON相比，BSON着眼于提高存储和扫描效率

```
BSON文档（对象）由一个有序的元素列表构成。每个元素由一个字段名、一个类型和一个值组成。字段名为字符串。类型包括：
* string
* integer(32 or 64)
* double(64位IEEE 754浮点数)
* decimal128(128位IEEE 754-2008浮点数；Binary Integer Decimal变体)适合作为任意精度为34个十进制数字的数字载体，最大值近似10
* date(整数，uninx时间的毫秒数)
* byte array(二进制数组)
* 布尔(true or false)
* null
* BSON数组
* BSON对象
* JavaScript代码
* md5二进制数据
* 正则表达式
```

BSON的类型名义上是JSON类型的一个超集（JSON没有date或字节数组类型），但是没有像JSON那样的通用“数字”（number）类型

12. redis原理
redis特点：
* 高性能高并发
* 数据持久化功能
* 支持多数据类型，主从复制和集群
* 管理不再使用SQL

13. web安全


14. 用户行为分析，BI


15. 深度学习CNN/RNN/GAN网络结构


16. numpy,scipy,pandas,matplotlib


17. flask, tornado, django


18. restful api


19. 
os.listdir(path)
os.walk(path)
os.walk(top[, topdown=True[, onerror=None[, followlinks=False]]])
方法参数说明：
top：要遍历的目录的路径
topdown：可选，如果为 True，则优先遍历 top 目录，以及 top 目录下的每一个子目录，否则优先遍历 top 的子目录，默认为 True
onerror: 可选， 需要一个 callable 对象，当 walk 异常时调用
followlinks：可选， 如果为 True，则会遍历目录下的快捷方式(linux 下是 symbolic link)实际所指的目录，默认为 False
args：包含那些没有 '-' 或 '--' 的参数列表

返回值: 三元组 (root, dirs, files)
root ：所指的是当前正在遍历的目录的地址
dirs ：当前文件夹中所有目录名字的 list (不包括子目录)
files ：当前文件夹中所有的文件 (不包括子目录中的文件)
def work_dir(file_dir):
    print'\n\n<><><><><> work dir <><><><><>'
    for root, dirs, files in os.walk(file_dir):
        print'\n========================================'
        print "root : {0}".format(root)
        print "dirs : {0}".format(dirs)
        print "files : {0}".format(files)
​
        for file in files:
            try:
                print'-----------------------------------'
                
                file_name = os.path.splitext(file)[0]
                file_suffix = os.path.splitext(file)[1]
                file_path = os.path.join(root, file)
                file_abs_path = os.path.abspath(file)
                file_parent = os.path.dirname(file_path)
​
                print "file : {0}".format(file)
                print "file_name : {0}".format(file_name)
                print "file_suffix : {0}".format(file_suffix)
                print "file_path : {0}".format(file_path)
                print "file_abs_path : {0}".format(file_abs_path)
                print "file_parent : {0}".format(file_parent)
                
            except Exception, e:
                print "Exception", e



os.path.splitext()：分离文件名和扩展名

file = "file_test.txt"
file_name = os.path.splitext(file)[0] # 输出：file_test
file_suffix = os.path.splitext(file)[1] # 输出：.txt

os.path.exists()：判断文件或目录是否存在
os.path.isfile()：判断是否是文件
os.path.isdir()：判断是否是目录
os.path.dirname()：获取当前文件所在的目录，即父目录
os.makedirs()：创建多级目录
os.mkdir()：创建单级目录
os.path.getsize()：获取文件大小

20. 
格式化符号

%y 两位数的年份表示（00-99）
%Y 四位数的年份表示（000-9999）
%m 月份（01-12）
%d 月内中的一天（0-31）
%H 24小时制小时数（0-23）
%I 12小时制小时数（01-12）
%M 分钟数（00=59）
%S 秒（00-59）
%a本地简化星期名称
%A 本地完整星期名称
%b 本地简化的月份名称
%B 本地完整的月份名称
%c 本地相应的日期表示和时间表示
%j年内的一天（001-366）
%p 本地A.M.或P.M.的等价符
%U 一年中的星期数（00-53）星期天为星期的开始
%w星期（0-6），星期天为星期的开始
%W 一年中的星期数（00-53）星期一为星期的开始
%x 本地相应的日期表示
%X本地相应的时间表示
%Z 当前时区的名称
%% %号本身

21.
