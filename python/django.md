创建工程
django-admin startproject projectname

创建应用
django-admin startapp appname
或者
python manage.py startapp appname

启动开发应用服务器
`python manage.py runserver 192.168.1.100:9090`

nohup指明服务后台运行，0.0.0.0指明项目跑在本地的127.0.0.1上，8000指明端口
`nohup python manage.py runserver 0.0.0.0:8000`

生成数据库迁移脚本
python manage.py makemigrations [appname]

生成表（这一步首先要确保能连接到数据库）
python manage.py migrate [appname]


创建超级用户
python manage.py createsuperuser 回车
输入超级用户名和密码


坑1：
报错：django Table 'django_session' doesn't exist

生成数据库迁移脚本
python manage.py makemigrations [appname]
生成表（这一步首先要确保能连接到数据库）
python manage.py migrate [appname]
如果输入了appname则少了以下三个表
执行结果如下：
mysql> show tables;
+----------------------------------+
| Tables_in_chf                    |
+----------------------------------+
| django_admin_log                 |
| django_content_type              |
| django_session                   |
+----------------------------------+
如果不输入appname则创建了以下三个表
执行结果如下：
mysql> show tables;
+----------------------------------+
| Tables_in_chf                    |
+----------------------------------+
| django_admin_log                 |
| django_content_type              |
| django_session                   |
+----------------------------------+
20 rows in set (0.00 sec)




Django template 过滤器

一、形式：小写
{{ name | lower }}

二、过滤器是可以嵌套的，字符串经过三个过滤器，第一个过滤器转换为小写，第二个过滤器输出首字母，第三个过滤器将首字母转换成大写

标签
{{ str|lower|first|upper }} 

三、过滤器的参数
显示前30个字
{{ bio | truncatewords:"30" }}
格式化
{{ pub_date | date:"F j, Y" }}

过滤器列表
{{ 123|add:"5" }} 给value加上一个数值
{{ "AB'CD"|addslashes }} 单引号加上转义号，一般用于输出到javascript中
{{ "abcd"|capfirst }} 第一个字母大写
{{ "abcd"|center:"50" }} 输出指定长度的字符串，并把值对中
{{ "123spam456spam789"|cut:"spam" }} 查找删除指定字符串
{{ value|date:"F j, Y" }} 格式化日期
{{ value|default:"(N/A)" }} 值不存在，使用指定值
{{ value|default_if_none:"(N/A)" }} 值是None，使用指定值
{{ 列表变量|dictsort:"数字" }} 排序从小到大
{{ 列表变量|dictsortreversed:"数字" }} 排序从大到小
{% if 92|pisibleby:"2" %} 判断是否整除指定数字
{{ string|escape }} 转换为html实体
{{ 21984124|filesizeformat }} 以1024为基数，计算最大值，保留1位小数，增加可读性
{{ list|first }} 返回列表第一个元素
{{ "ik23hr&jqwh"|fix_ampersands }} &转为&
{{ 13.414121241|floatformat }} 保留1位小数，可为负数，几种形式
{{ 13.414121241|floatformat:"2" }} 保留2位小数
{{ 23456 |get_digit:"1" }} 从个位数开始截取指定位置的1个数字
{{ list|join:", " }} 用指定分隔符连接列表
{{ list|length }} 返回列表个数
{% if 列表|length_is:"3" %} 列表个数是否指定数值

{{ "ABCD"|linebreaks }} 用新行用、
标记包裹
{{ "ABCD"|linebreaksbr }} 用新行用
标记包裹

{{ 变量|linenumbers }} 为变量中每一行加上行号
{{ "abcd"|ljust:"50" }} 把字符串在指定宽度中对左，其它用空格填充
{{ "ABCD"|lower }} 小写
{% for i in "1abc1"|make_list %}ABCDE,{% endfor %} 把字符串或数字的字符个数作为一个列表
{{ "abcdefghijklmnopqrstuvwxyz"|phone2numeric }} 把字符转为可以对应的数字？？
{{ 列表或数字|pluralize }} 单词的复数形式，如列表字符串个数大于1，返回s，否则返回空串
{{ 列表或数字|pluralize:"es" }} 指定es
{{ 列表或数字|pluralize:"y,ies" }} 指定ies替换为y
{{ object|pprint }} 显示一个对象的值
{{ 列表|random }} 返回列表的随机一项
{{ string|removetags:"br p p" }} 删除字符串中指定html标记
{{ string|rjust:"50" }} 把字符串在指定宽度中对右，其它用空格填充
{{ 列表|slice:":2" }} 切片
{{ string|slugify }} 字符串中留下减号和下划线，其它符号删除，空格用减号替换
{{ 3|stringformat:"02i" }} 字符串格式，使用Python的字符串格式语法
{{ "EABCD"|striptags }} 剥去[X]HTML语法标记
{{ 时间变量|time:"P" }} 日期的时间部分格式
{{ datetime|timesince }} 给定日期到现在过去了多少时间
{{ datetime|timesince:"other_datetime" }} 两日期间过去了多少时间
{{ datetime|timeuntil }} 给定日期到现在过去了多少时间，与上面的区别在于2日期的前后位置。
{{ datetime|timeuntil:"other_datetime" }} 两日期间过去了多少时间
{{ "abdsadf"|title }} 首字母大写
{{ "A B C D E F"|truncatewords:"3" }} 截取指定个数的单词
{{ "111221"|truncatewords_html:"2" }} 截取指定个数的html标记，并补完整
{{ list|unordered_list }}多重嵌套列表展现为html的无序列表
{{ string|upper }} 全部大写

linkage url编码
{{ string|urlize }} 将URLs由纯文本变为可点击的链接。 
{{ string|urlizetrunc:"30" }} 同上，多个截取字符数。 
{{ "B C D E F"|wordcount }} 单词数
{{ "a b c d e f g h i j k"|wordwrap:"5" }} 每指定数量的字符就插入回车符
{{ boolean|yesno:"Yes,No,Perhaps" }} 对三种值的返回字符串，对应是 非空,空,None。



更新pip
python -m pip install --upgrade pip

国际化( Make sure you have GNU gettext tools 0.15 or newer installed.)
Windows下的gettext(linux下可能不用安装)
从http://sourceforge.net/projects/gettext下载以下zip文件
gettext-runtime-0.17.zip: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/gettext-runtime-0.17.zip
gettext-tools-0.17.zip: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/gettext-tools-0.17.zip
解压文件
在同一文件夹下（如: C:\Downloads\gettext）展开这2个压缩文件中的bin\。(注意目录合并了)
更新系统路径：控制面板>系统>高级>环境变量，在系统变量列表中，把;D:\Downloads\Programming\gettext\bin加到变量值字段的末尾。
在CMD中验证下我们的配置是否正确xgettext --version或者gettext --version。

python manage.py makemessages -l en
python manage.py makemessages -l zh-Hans
python manage.py makemessages -l zh-Hant

编译国际化翻译文件
python manage.py compilemessages
django-admin compilemessages
Django将自动搜索所有的.po文件，将它们都翻译成.mo文件。





Django:

FIELD_TYPE.BLOB: 'TextField',
FIELD_TYPE.CHAR: 'CharField',
FIELD_TYPE.DECIMAL: 'DecimalField',
FIELD_TYPE.NEWDECIMAL: 'DecimalField',
FIELD_TYPE.DATE: 'DateField',
FIELD_TYPE.DATETIME: 'DateTimeField',
FIELD_TYPE.DOUBLE: 'FloatField',
FIELD_TYPE.FLOAT: 'FloatField',
FIELD_TYPE.INT24: 'IntegerField',
FIELD_TYPE.LONG: 'IntegerField',
FIELD_TYPE.LONGLONG: 'BigIntegerField',
FIELD_TYPE.SHORT: 'SmallIntegerField',
FIELD_TYPE.STRING: 'CharField',
FIELD_TYPE.TIME: 'TimeField',
FIELD_TYPE.TIMESTAMP: 'DateTimeField',
FIELD_TYPE.TINY: 'IntegerField',
FIELD_TYPE.TINY_BLOB: 'TextField',
FIELD_TYPE.MEDIUM_BLOB: 'TextField',
FIELD_TYPE.LONG_BLOB: 'TextField',
FIELD_TYPE.VAR_STRING: 'CharField',



'AutoField': 'integer AUTO_INCREMENT',
'BigAutoField': 'bigint AUTO_INCREMENT',
'BinaryField': 'longblob',
'BooleanField': 'bool',
'CharField': 'varchar(%(max_length)s)',
'DateField': 'date',
'DateTimeField': 'datetime(6)',
'DecimalField': 'numeric(%(max_digits)s, %(decimal_places)s)',
'DurationField': 'bigint',
'FileField': 'varchar(%(max_length)s)',
'FilePathField': 'varchar(%(max_length)s)',
'FloatField': 'double precision',
'IntegerField': 'integer',
'BigIntegerField': 'bigint',
'IPAddressField': 'char(15)',
'GenericIPAddressField': 'char(39)',
'NullBooleanField': 'bool',
'OneToOneField': 'integer',
'PositiveIntegerField': 'integer UNSIGNED',
'PositiveSmallIntegerField': 'smallint UNSIGNED',
'SlugField': 'varchar(%(max_length)s)',
'SmallIntegerField': 'smallint',
'TextField': 'longtext',
'TimeField': 'time(6)',
'UUIDField': 'char(32)',



'exact': '= %s',
'iexact': 'LIKE %s',
'contains': 'LIKE BINARY %s',
'icontains': 'LIKE %s',
'gt': '> %s',
'gte': '>= %s',
'lt': '< %s',
'lte': '<= %s',
'startswith': 'LIKE BINARY %s',
'endswith': 'LIKE BINARY %s',
'istartswith': 'LIKE %s',
'iendswith': 'LIKE %s',

pattern_ops = {
    'contains': "LIKE BINARY CONCAT('%%', {}, '%%')",
    'icontains': "LIKE CONCAT('%%', {}, '%%')",
    'startswith': "LIKE BINARY CONCAT({}, '%%')",
    'istartswith': "LIKE CONCAT({}, '%%')",
    'endswith': "LIKE BINARY CONCAT('%%', {})",
    'iendswith': "LIKE CONCAT('%%', {})",
}

isolation_levels = {
    'read uncommitted',
    'read committed',
    'repeatable read',
    'serializable',
}

