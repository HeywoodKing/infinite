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



### 疑难杂症
windows系统编码错误时解决方法：
```
import sys,io
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='gb18030')
```

