# tornado

#### Tornado：python编写的web服务器兼web应用框架，是非阻塞式服务器，而且速度相当快。得利于其非阻塞的方式和对epoll的运用，Tornado 每秒可以处理数以千计的连接，因此 Tornado 是实时 Web 服务的一个 理想框架。

### Tornado的优势
1. 轻量级web框架
2. 异步非阻塞IO处理方式
3. 出色的抗负载能力
4. 优异的处理性能，不依赖多进程/多线程，一定程度上解决C10K问题
5. WSGI全栈替代产品，推荐同时使用其web框架和HTTP服务器

### Tornado VS Django
>Django：重量级web框架，功能大而全，注重高效开发
1. 内置管理后台 
2. 内置封装完善的ORM操作 
3. session功能 
4. 后台管理 
5. 缺陷：高耦合

>Tornado：轻量级web框架，功能少而精，注重性能优越 
1. HTTP服务器 
2. 异步编程 
3. WebSocket 
4. 缺陷：入门门槛较高

![Tornado VS Django](https://img-blog.csdnimg.cn/20181226231046802.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzA5NzMwMQ==,size_16,color_FFFFFF,t_70 "Tornado VS Django")

![反向代理服务器后端的Tornado实例](https://img-blog.csdnimg.cn/20181216012721967.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzA5NzMwMQ==,size_16,color_FFFFFF,t_70 "反向代理服务器后端的Tornado实例")

![反向代理服务器后端的Tornado实例2](https://img-blog.csdnimg.cn/20181226231128322.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzA5NzMwMQ==,size_16,color_FFFFFF,t_70 "反向代理服务器后端的Tornado实例2")

### 安装
`pip install tornado`

### 单线程
tornado.web：基础web框架模块
tornado.ioloop：核心IO循环模块，高效的基础。

封装了:
1. asyncio 协程，异步处理
2. epoll模型：水平触发（状态改变就询问，select(),poll()）， 边缘触发（一直询问，epoll()）
3. poll 模型：I/O多路复用技术
4. BSD（UNIX操作系统中的一个分支的总称）的kqueue（kueue是在UNIX上比较高效的IO复用技术）

#### epoll和kqueue的区别如下：
>'epoll'仅适用于文件描述符，在Unix中，一切都是文件”。
这大多是正确的，但并非总是如此。例如，计时器不是文件。
信号不是文件。信号量不是文件。进程不是文件。
（在Linux中）网络设备不是文件。类UNIX操作系统中有许多不是文件的东西
。您不能使用select（）/ poll（）/ epoll来复制那些“事物”。
Linux支持许多补充系统调用，signalfd（），eventfd（）和timerfd_create（）
它们将非文件资源转换为文件描述符，以便您可以将它们与epoll（）复用。
epoll甚至不支持所有类型的文件描述符;
 select（）/ poll（）/ epoll不适用于常规（磁盘）文件。
 因为epoll 对准备模型有很强的假设; 监视套接字的准备情况，
 以便套接字上的后续IO调用不会阻塞。但是，磁盘文件不适合此模型，因为它们总是准备就绪。kqueue 中，通用的（struct kevent）系统结构支持各种非文件事件

```
import tornado.web      #tornado.web：基础web框架模块
import tornado.ioloop       #tornado.ioloop：核心IO循环模块，高效的基础。

class IndexHandler(tornado.web.RequestHandler):      
                            #类比Django中的视图，相当于业务逻辑处理的类
    def get(self):      #处理get请求的，并不能处理post请求
        self.write("good boy")      #响应http的请求

if __name__=="__main__":

    """
    实例化一个app对象
    Application：他是tornado.web框架的核心应用类，是与服务器对应的一个接口
    里面保存了路由映射表，还有一个listen方法，可以认为用来创建一个http的实例
    并绑定了端口
    """
    
    app = tornado.web.Application([
            (r"/" ,IndexHandler),
        ])

    app.listen(8888)        #绑定监听端口，但此时的服务器并没有开启监听
    tornado.ioloop.IOLoop.current().start()
    
                #Application([(r"/" ,IndexHandler),])传入的第一个参数是
                #路由路由映射列表，但是在此同时Application还能定义更多参数
                
                 #IOLoop.current():返回当前线程的IOLoop实例
                #例如实例化对象 ss=run() ,ss.start()
                #start()：启动了IOloop实例的循环，连接客服端后，同时开启了监听
```

#### 原理如下：
```
linux-epoll进行管理多个客服端socket
tornado-IoLoop不断进行询问epoll：小老弟，有没有我需要做的事吗？    
当epoll返回说：老哥，有活了
tornado-IoLoop将活上传给tornado.web.Application
tornado.web.Application中有 路由映射表
就会将socket进行一个路由匹配
把socket匹配给相对应的Handler（处理者）
Handler（处理者）处理后将数据返回给对应的socket，
（这里因为可能会延时响应，所以这里进行异步处理）
socket然后再传给了客服端浏览器。
```

![原理](https://img-blog.csdnimg.cn/20190109205011104.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzA5NzMwMQ==,size_16,color_FFFFFF,t_70 "原理")

### 多线程

#### 新加模块如下：
`tornado.httpserver     #tornado的HTTP服务器实现`

注意：
在windows中运行多进程会报错：
AttributeError: module ‘os’ has no attribute 'fork’
这是因为fork这个系统命令，只在linux中才有用，
如果你是在windows， win7、winxp中运行的话就会出错。
所以把上面的python文件，拷贝到linux的系统中再运行就没问题了.
这个错误我暂时没有解决,后续补上。

```
import tornado.web
import tornado.ioloop
import tornado.httpserver   #tornado的HTTP服务器实现


class IndexHandler(tornado.web.RequestHandler):
    def get(self):      #处理get请求的，并不能处理post请求
        self.write("good boy")      #响应http的请求

if __name__=="__main__":

    app = tornado.web.Application([
            (r"/" ,IndexHandler),
        ])
    httpServer = tornado.httpserver.HTTPServer(app)

    #httpServer.listen(8000)  #多进程改动原来的这一句

    httpServer.bind(8888)      #绑定在指定端口
    httpServer.start(2)
                                #默认（0）开启一个进程，否则对面开启数值（大于零）进程
                          #值为None，或者小于0，则开启对应硬件机器的cpu核心数个子进程
                            #例如 四核八核，就四个进程或者八个进程
    tornado.ioloop.IOLoop.current().start()
```

#### app.listen(),只能在单进程中使用

#### 多进程中，虽然tornado给我们提供了一次性启动多个进程的方式，但是由于一些问题，不建议使用上面打的方式启动多进程，而是手动启动多个进程，并且我们还能绑定不同的端口


>问题如下:
1. 每个子进程都会从父进程中复制一份IOLoop的实例，
如果在创建子进程前修改了IOLoop，会影响所有的子进程
2. 所有的进程都是由一个命令启动的，无法做到不停止服务的情况下修改代码。
修改单个进程是需要关掉所有进程，影响客服服务使用。
3. 所有进程共享一个端口，向要分别监控很困难。

所以：我们手动启动多个进程，并且我们还能绑定不同的端口，进行单个进程操作

### options模块
#### 新运用模块如下：
`tornado.options模块：提供了全局参数的定义，储存和转换`

属性和方法
tornado.options.define()
原型tornado.options.define(name, default=None, type=None, help=None, metavar=None,multiple=False, group=None, callback=None)

#### 常用参数：
```
# name（选项变量名），必须保证其唯一性，
否则报错"options 'xxx' already define in '....'"

#default(设置选项变量的默认值)，默认为None

#type(设置选项变量的类型)，str，int，float,datetime(时间日期),等，
从命令行或配置文件导入参数时，会根据类型转换输入的值。
如果不能转化则报错，如果没有设置type的值，
会根据default的值的类型进行转换，比如default的值 8000，
而传给type的为‘8080’字符串，
则会转换成int类型。如果default也没有设置，则不转化

#multipe（设置选项变量是否为多个值），默认False 比如传递为列表，
列表包括了多个值，就要改为Ture。

#help 选项变量的提示信息。自主添加，比如  help="描述变量"

#方法
#tornado.options.options
#全局的options对象，所有定义的选项变量都会作为该对象的属性

#获取参数的方法(命令行传入)
#1. tornado.options.parse_command_line()
#作用：转化命令行参数，接收转换并保存

#获取参数的方法（从配置文件导入参数）
#tornado.options.parse_config_file(path=)
```

