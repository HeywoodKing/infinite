## srcapy

Scrapy 使用了 Twisted异步网络库来处理网络通讯

![scrapy架构图](https://images2015.cnblogs.com/blog/425762/201605/425762-20160507220247421-1722096301.png "scrapy架构图")

### 安装
```
linux:
pip install scrapy
或
pipenv install scrapy

Windows下的安装

　　a. 下载twisted 
　　　　http://www.lfd.uci.edu/~gohlke/pythonlibs/#twisted
　　b. 安装wheel
　　　　pip3 install wheel
　　c. 安装twisted
　　　　进入下载目录，执行 pip3 install Twisted‑18.7.0‑cp36‑cp36m‑win_amd64.whl
　　d. 安装pywin32
　　　　pip3 install pywin32
　　e. 安装scrapy
　　　　pip3 install scrapy
```

### 整体架构介绍
##### Scrapy主要包括了以下组件：

+ 引擎(Scrapy)
> 用来处理整个系统的数据流处理, 触发事务(框架核心)

+ 调度器(Scheduler)
> 用来接受引擎发过来的请求, 压入队列中, 并在引擎再次请求的时候返回. 可以想像成一个URL（抓取网页的网址或者说是链接）的优先队列, 由它来决定下一个要抓取的网址是什么, 同时去除重复的网址

+ 下载器(Downloader)
> 用于下载网页内容, 并将网页内容返回给蜘蛛(Scrapy下载器是建立在twisted这个高效的异步模型上的)

+ 爬虫(Spiders)
> 爬虫是主要干活的, 用于从特定的网页中提取自己需要的信息, 即所谓的实体(Item)。用户也可以从中提取出链接,让Scrapy继续抓取下一个页面

+ 项目管道(Pipeline)
> 负责处理爬虫从网页中抽取的实体，主要的功能是持久化实体、验证实体的有效性、清除不需要的信息。当页面被爬虫解析后，将被发送到项目管道，并经过几个特定的次序处理数据。

+ 下载器中间件(Downloader Middlewares)
> 位于Scrapy引擎和下载器之间的框架，主要是处理Scrapy引擎与下载器之间的请求及响应。

+ 爬虫中间件(Spider Middlewares)
> 介于Scrapy引擎和爬虫之间的框架，主要工作是处理蜘蛛的响应输入和请求输出。

+ 调度中间件(Scheduler Middewares)
> 介于Scrapy引擎和调度之间的中间件，从Scrapy引擎发送到调度的请求和响应。


##### Scrapy运行流程大概如下：
1. 引擎从调度器中取出一个链接(URL)用于接下来的抓取
2. 引擎把URL封装成一个请求(Request)传给下载器
3. 下载器把资源下载下来，并封装成应答包(Response)
4. 爬虫解析Response
5. 解析出实体（Item）,则交给实体管道进行进一步的处理
6. 解析出的是链接（URL）,则把URL交给调度器等待抓取



### 基本命令
```
scrapy -h

Scrapy 1.7.3 - project: ChouTi

Usage:
  scrapy <command> [options] [args]

Available commands(14):
  bench         Run quick benchmark test
  check         Check spider contracts
  crawl         Run a spider
  edit          Edit spider
  fetch         Fetch a URL using the Scrapy downloader
  genspider     Generate new spider using pre-defined templates
  list          List available spiders
  parse         Parse URL (using its spider) and print the results
  runspider     Run a self-contained spider (without creating a project)
  settings      Get settings values
  shell         Interactive scraping console
  startproject  Create new project
  version       Print Scrapy version
  view          Open URL in browser, as seen by Scrapy


Global Options
--------------
--logfile=FILE          log file. if omitted stderr will be used
--loglevel=LEVEL, -L LEVEL
                        log level (default: INFO)
--nolog                 disable logging completely
--profile=FILE          write python cProfile stats to FILE
--pidfile=FILE          write process ID to FILE
--set=NAME=VALUE, -s NAME=VALUE
                        set/override setting (may be repeated)
--pdb                   enable pdb on failure


Global commands:
startproject
genspider
settings
runspider
shell
fetch
view
version


Project-only commands:
crawl
check
list
edit
parse
bench




创建项目：
scrapy startproject myproject [project_dir]
scrapy startproject 项目名称

创建爬虫应用：
语法：scrapy genspider [-t template] <name> <domain>
首先进入上一步创建的项目目录下
cd 项目名称
scrapy genspider [-t template] chouti chouti.com
或
scrapy genspider -t basic chouti chouti.com
或
scrapy genspider -t xmlfeed chouti chouti.com

查看所有模板命令：
scrapy genspider -l

查看模板命令：
scrapy genspider -d 模板名称

查看爬虫列表应用
scrapy list

运行单独爬虫应用(默认以日志的形式)
scrapy crawl chouti

运行单独爬虫应用(不要日志的形式)
scrapy crawl chouti --nolog


命令行调试
scrapy shell 地址
>>> response.css('title')
[<Selector xpath='descendant-or-self::title' data='<title>Quotes to Scrape</title>'>]

>>> response.css('title::text').getall()
['Quotes to Scrape']

>>> response.css('title').getall()
['<title>Quotes to Scrape</title>']

>>> response.css('title::text').get()
'Quotes to Scrape'

>>> response.css('title::text')[0].get()
'Quotes to Scrape'

>>> response.css('title::text').re(r'Quotes.*')
['Quotes to Scrape']
>>> response.css('title::text').re(r'Q\w+')
['Quotes']
>>> response.css('title::text').re(r'(\w+) to (\w+)')
['Quotes', 'Scrape']

>>> response.css("div.quote")
>>> quote = response.css("div.quote")[0]
>>> tags = quote.css("div.tags a.tag::text").getall()
>>> tags
['change', 'deep-thoughts', 'thinking', 'world']
>>> for quote in response.css("div.quote"):
...     text = quote.css("span.text::text").get()
...     author = quote.css("small.author::text").get()
...     tags = quote.css("div.tags a.tag::text").getall()
...     print(dict(text=text, author=author, tags=tags))
{'tags': ['change', 'deep-thoughts', 'thinking', 'world'], 'author': 'Albert Einstein', 'text': '“The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.”'}
{'tags': ['abilities', 'choices'], 'author': 'J.K. Rowling', 'text': '“It is our choices, Harry, that show what we truly are, far more than our abilities.”'}
    ... a few more of these, omitted for brevity
>>>


>>> text = quote.css("span.text::text").get()
>>> text
'“The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.”'
>>> author = quote.css("small.author::text").get()
>>> author
'Albert Einstein'

>>> response.css('li.next a').get()
'<a href="/page/2/">Next <span aria-hidden="true">→</span></a>'

>>> response.css('li.next a::attr(href)').get()
'/page/2/'

>>> response.css('li.next a').attrib['href']
'/page/2'


>>> response.xpath('//title')
[<Selector xpath='//title' data='<title>Quotes to Scrape</title>'>]
>>> response.xpath('//title/text()').get()
'Quotes to Scrape'




```

### 项目结构以及爬虫应用
```
my_chouti
	scrapy.cfg
	my_chouti
		spiders
			__init__.py
			chouti.py
			爬虫2.py
			爬虫3.py
			...
		__init__.py
		items.py
		middlewares.py
		pipelines.py
		settings.py


```

##### 文件说明：
```
+ scrapy.cfg  项目的主配置信息。（真正爬虫相关的配置信息在settings.py文件中）
+ items.py    设置数据存储模板，用于结构化数据，如：Django的Model
+ pipelines   数据处理行为，如：一般结构化的数据持久化
+ settings.py 配置文件，如：递归的层数、并发数，延迟下载等
+ spiders     爬虫目录，如：创建文件，编写爬虫规则
```

### 数据解析
使用每个应用中的response.xpath(xxx) 进行数据的解析，print(response.xpath(...))  得到的是一个Selector对象。selector对象可以继续xpath进行数据的解析

xpath使用方法：
```
1. //+标签  表示从全局的子子孙孙中查找标签
2. /+标签   表示从子代中查找标签
3. 查找带有xxx属性的标签：   标签+[@标签属性="值"]
4. 查找标签的某个属性：  /标签/@属性
5. 从当前标签中查找时：.//+标签
6. xpath中支持正则的使用:  标签+[re:test(@属性值，"正则表达式")]
7. 获取标签的文本内容： /text()
8. 获取第一个值需要:  selector_obj.extract_first()    
9. 获取所有的值:  selector_obj.extract()值在一个list中

eg:
response = HtmlResponse(url='http://www.chouti.com', body=html, encoding='utf-8')
selector对象
hxs = HtmlXpathSelector(response)  

查找所有的a标签
res = Selector(response=response).xpath('//a')

查找某一个具体的a标签    取第三个a标签
res = Selector(response=response).xpath('//a[2]')

查找所有含有id属性的a标签
res = Selector(response=response).xpath('//a[@id]')

查找含有id=“i1”的a标签
res = Selector(response=response).xpath('//a[@id="i1"]')

查找含有href=‘xxx’并且id=‘xxx’的a标签
res = Selector(response=response).xpath('//a[@href="link.html"][@id="i1"]')

查找href属性值中包含有‘link’的a标签
res = Selector(response=response).xpath('//a[contains(@href, "link")]')

查找 href属性值以‘link’开始的a标签
res = Selector(response=response).xpath('//a[starts-with(@href, "link")]')

正则匹配的用法   匹配id属性的值为数字的a标签
res = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]')

匹配id属性的值为数字的a标签的文本内容
res = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]/text()').extract()

匹配id属性的值为数字的a标签的href属性值
res = Selector(response=response).xpath('//a[re:test(@id, "i\d+")]/@href').extract()

hxs = Selector(response=response).xpath('/html/body/ul/li/a/@href').extract()
hxs = Selector(response=response).xpath('//body/ul/li/a/@href').extract_first()

```

### scrapy持久化
```
1. scrapy crawl quotes -o quotes.json
2. scrapy crawl quotes -o quotes.jl
3. scrapy crawl quotes -o quotes.csv
4. scrapy crawl quotes -o quotes-humor.json -a tag=humor

```

### scrapy.cfg
```
[settings]
default = myproject1.settings
project1 = myproject1.settings
project2 = myproject2.settings

$ scrapy settings --get BOT_NAME
Project 1 Bot
$ export SCRAPY_PROJECT=project2
$ scrapy settings --get BOT_NAME
Project 2 Bot
```



### scrapyd
#### 安装
```
pip3 install scrapyd -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo mkdir /etc/scrapyd
sudo vim /etc/scrapyd/scrapyd.conf
```

优先以下路径搜索配置文件解析
```
/etc/scrapyd/scrapyd.conf (Unix)
c:\scrapyd\scrapyd.conf (Windows)
/etc/scrapyd/conf.d/* (in alphabetical order, Unix)
scrapyd.conf
~/.scrapyd.conf (users home directory)
```

#### 添加以下配置文件内容
```
[scrapyd]
eggs_dir    = eggs
logs_dir    = logs
items_dir   =
jobs_to_keep = 5
dbs_dir     = dbs
max_proc    = 0
max_proc_per_cpu = 10
finished_to_keep = 100
poll_interval = 5.0
bind_address = 0.0.0.0
http_port   = 6800
debug       = off
runner      = scrapyd.runner
application = scrapyd.app.application
launcher    = scrapyd.launcher.Launcher
webroot     = scrapyd.website.Root

[services]
schedule.json     = scrapyd.webservice.Schedule
cancel.json       = scrapyd.webservice.Cancel
addversion.json   = scrapyd.webservice.AddVersion
listprojects.json = scrapyd.webservice.ListProjects
listversions.json = scrapyd.webservice.ListVersions
listspiders.json  = scrapyd.webservice.ListSpiders
delproject.json   = scrapyd.webservice.DeleteProject
delversion.json   = scrapyd.webservice.DeleteVersion
listjobs.json     = scrapyd.webservice.ListJobs
daemonstatus.json = scrapyd.webservice.DaemonStatus
```
保存并退出
启动服务
```
scrapyd
```

Example using curl:
```
curl http://localhost:6800/schedule.json -d project=default -d spider=somespider
```

### centos7 安装scrapyd
Centos7安装Python3.7
```
说明
全部操作都在root用户下执行

1.安装编译相关工具
yum -y groupinstall "Development tools"
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
yum install libffi-devel -y

2.下载安装包解压
cd #回到用户目录
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
tar -xvJf  Python-3.7.0.tar.xz

3.编译安装
mkdir /usr/local/python3 #创建编译安装目录
cd Python-3.7.0
./configure --prefix=/usr/local/python3
make && make install

或者

编译安装Python3，默认的安装目录是 /usr/local 如果你要改成其他目录可以在编译(make)前使用 configure 命令后面追加参数 “–prefix=/alternative/path” 来完成修改。
$ tar xf Python-3.7.1.tgz
$ cd Python-3.7.1
$ ./configure
$ make
$ sudo make install

至此你已经在你的CentOS系统中成功安装了python3、pip3、setuptools


4.创建软连接
ln -s /usr/local/python3/bin/python3 /usr/local/bin/python3
ln -s /usr/local/python3/bin/pip3 /usr/local/bin/pip3

5.验证是否成功
python3 -V
pip3 -V
```

### centos7设置python3为默认环境
```
sudo yum install yum-utils
使用yum-builddep为Python3构建环境,安装缺失的软件依赖,使用下面的命令会自动处理.
sudo yum-builddep python
完成后下载Python3的源码包（笔者以Python3.5为例），Python源码包目录： https://www.python.org/ftp/python/ ，截至发博当日Python3的最新版本为 3.7.0
$ curl -O https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

查看python版本
$ python3 -V

如果你要使用Python3作为python的默认版本，你需要修改一下 bashrc 文件，增加一行alias参数
alias python='/usr/local/bin/python3.7'

由于CentOS 7建议不要动/etc/bashrc文件，而是把用户自定义的配置放入/etc/profile.d/目录中，具体方法为
vi /etc/profile.d/python.sh

输入alias参数 alias python="/usr/local/bin/python3.7"，保存退出
如果非root用户创建的文件需要注意设置权限
chmod 755 /etc/profile.d/python.sh

重启会话使配置生效
source /etc/profile.d/python.sh
```

### centos7安装scrapyd
```
pip3 install scrapyd -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo mkdir /etc/scrapyd
sudo vim /etc/scrapyd/scrapyd.conf

[scrapyd]
eggs_dir    = eggs
logs_dir    = logs
items_dir   =
jobs_to_keep = 5
dbs_dir     = dbs
max_proc    = 0
max_proc_per_cpu = 10
finished_to_keep = 100
poll_interval = 5.0
bind_address = 0.0.0.0
http_port   = 6800
debug       = off
runner      = scrapyd.runner
application = scrapyd.app.application
launcher    = scrapyd.launcher.Launcher
webroot     = scrapyd.website.Root

[services]
schedule.json     = scrapyd.webservice.Schedule
cancel.json       = scrapyd.webservice.Cancel
addversion.json   = scrapyd.webservice.AddVersion
listprojects.json = scrapyd.webservice.ListProjects
listversions.json = scrapyd.webservice.ListVersions
listspiders.json  = scrapyd.webservice.ListSpiders
delproject.json   = scrapyd.webservice.DeleteProject
delversion.json   = scrapyd.webservice.DeleteVersion
listjobs.json     = scrapyd.webservice.ListJobs
daemonstatus.json = scrapyd.webservice.DaemonStatus
```
保存并退出

我的python3路径：  /usr/local/python3
```
<!-- ln -s /usr/local/python3/bin/scrapy  /usr/bin/scrapy -->
ln -s /usr/local/python3/bin/scrapyd  /usr/bin/scrapyd
```

#### scrapyd 常用命令
```
查看状态：
scrapyd-deploy -l

启动爬虫：
curl http://localhost:6800/schedule.json -d project=PROJECT_NAME -d spider=SPIDER_NAME

停止爬虫：
curl http://localhost:6800/cancel.json -d project=PROJECT_NAME -d job=JOB_ID

删除项目：
curl http://localhost:6800/delproject.json -d project=PROJECT_NAME

列出部署过的项目：
curl http://localhost:6800/listprojects.json

列出某个项目内的爬虫：
curl http://localhost:6800/listspiders.json?project=PROJECT_NAME

列出某个项目的job：
curl http://localhost:6800/listjobs.json?project=PROJECT_NAME

1、获取状态
http://127.0.0.1:6800/daemonstatus.json

2、获取项目列表
http://127.0.0.1:6800/listprojects.json

3、获取项目下已发布的爬虫列表
http://127.0.0.1:6800/listspiders.json?project=myproject

4、获取项目下已发布的爬虫版本列表
http://127.0.0.1:6800/listversions.json?project=myproject

5、获取爬虫运行状态
http://127.0.0.1:6800/listjobs.json?project=myproject

6、启动服务器上某一爬虫（必须是已发布到服务器的爬虫）
http://localhost:6800/schedule.json （post方式，data={"project":myproject,"spider":myspider}）

7、删除某一版本爬虫
http://127.0.0.1:6800/delversion.json （post方式，data={"project":myproject,"version":myversion}）

8、删除某一工程，包括该工程下的各版本爬虫
http://127.0.0.1:6800/delproject.json（post方式，data={"project":myproject}）


重启scrapyd的方法

（1）ps aux|grep scrapyd：找到scrapyd的pid

（2） kill -9 pid 或者kill pid

（3）screen -S scrapyd 新建一个进程

（4） 在进程里启动scrapyd
/usr/bin/python /usr/local/bin/scrapyd

（5）ctrl+A+D退出进程

（6）改工程的scrapy.cfg文件，如果url有#号，把url前的#去掉

（7）可以scrapyd-deploy工程了


screen参考：
https://www.ibm.com/developerworks/cn/linux/l-cn-screen/
http://man.linuxde.net/screen

杀死screen会话 screen -X -S pid quit 其中pid为screen进程号
screen -ls 列出现有screen会话列表
screen -r pid 恢复到某个screen会话
Ctrl+a +d 保留会话离开当前窗口

```


### gerapy
Gerapy 是一款分布式爬虫管理框架，支持 Python 3，基于 Scrapy、Scrapyd、Scrapyd-Client、Scrapy-Redis、Scrapyd-API、Scrapy-Splash、Jinjia2、Django、Vue.js 开发，Gerapy 可以帮助我们：

更方便地控制爬虫运行
更直观地查看爬虫状态
更实时地查看爬取结果
更简单地实现项目部署
更统一地实现主机管理
更轻松地编写爬虫代码
安装非常简单，只需要运行 pip3 命令即可：

$ pip3 install gerapy
安装完成之后我们就可以使用 gerapy 命令了，输入 gerapy 便可以获取它的基本使用方法

```
gerapy
Usage:
gerapy init [--folder=<folder>]
gerapy migrate
gerapy createsuperuser
gerapy runserver [<host:port>]
gerapy makemigrations
```

如果出现上述结果，就证明 Gerapy 安装成功了

```
初始化
接下来我们来开始使用 Gerapy，首先利用如下命令进行一下初始化，在任意路径下均可执行如下命令：

gerapy init
执行完毕之后，本地便会生成一个名字为 gerapy 的文件夹，接着进入该文件夹，可以看到有一个 projects 文件夹，我们后面会用到。

紧接着执行数据库初始化命令：

cd gerapy
gerapy migrate
这样它就会在 gerapy 目录下生成一个 SQLite 数据库，同时建立数据库表。

接着我们只需要再运行命令启动服务就好了：

gerapy runserver
这样我们就可以看到 Gerapy 已经在 8000 端口上运行了。
```



### 疑难杂症
windows系统编码错误时解决方法：
```
import sys,io
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='gb18030')
```





