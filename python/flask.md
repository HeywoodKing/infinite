# flask

Flask是一个基于Python开发并且依赖jinja2模板和Werkzeug WSGI服务的一个微型框架，对于Werkzeug本质是Socket服务端，其用于接收http请求并对请求进行预处理，然后触发Flask框架，开发人员基于Flask框架提供的功能对请求进行相应的处理，并返回给用户，如果要返回给用户复杂的内容时，需要借助jinja2模板来实现对模板的处理，即：将模板和数据进行渲染，将渲染后的字符串返回给用户浏览器。

### Flask依赖一个实现wsgi协议的模块：werkzeug

### 与django简单比较
>Django：无socket，依赖第三方模块wsgi,中间件，路由系统（CBV，FBV），视图函数，ORM。cookie,session,Admin,Form,缓存，信号，序列化。。

>Flask:无socket,中间件（需要扩展），路由系统，视图（CBV）、第三方模块（依赖jinja2）,cookie，session弱爆了


入门博客：https://www.cnblogs.com/huchong/p/8227606.html#_label0
官网：https://dormousehole.readthedocs.io/en/latest/

### 安装
`pip install flask`

