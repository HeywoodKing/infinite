
### pymysql


### 安装
1. windows
```
在Python3.4以上版本中自带了pip3
pip3 install pymysql -i https://pypi.douban.com/simple
或者
pip3 install pymysql -i https://pypi.tuna.tsinghua.edu.cn/simple
或
pip3 install pymysql -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/
```

2. linux
```
第一种：
在Python3.4以上版本中自带了pip3
pip3 install pymysql -i https://pypi.douban.com/simple
或者
pip3 install pymysql -i https://pypi.tuna.tsinghua.edu.cn/simple
或
pip3 install pymysql -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/

第二种：
1.tar包下载及解压
下载tar包
wget https://pypi.python.org/packages/29/f8/919a28976bf0557b7819fd6935bfd839118aff913407ca58346e14fa6c86/PyMySQL-0.7.11.tar.gz#md5=167f28514f4c20cbc6b1ddf831ade772
解压并展开tar包
tar xf PyMySQL-0.7.11.tar.gz

2.安装
[root@localhost PyMySQL-0.7.11]# python3 setup.py install
```

### 卸载
```
pip3 uninstall pymysql
```


### 代码使用
```
def mysql_context(is_dict_cursor=True, is_sscursor=False):
    try:
        config = {
            'host': MYSQL_HOST,
            'port': MYSQL_PORT,
            'user': MYSQL_USER,
            'password': MYSQL_PASSWORD,
            'database': MYSQL_DATABASE,
            'charset': MYSQL_CHARSET,
        }

        conn = pymysql.connect(**config)
        
        if is_dict_cursor:
            if is_sscursor:
                cursor = conn.cursor(cursor=pymysql.cursors.SSDictCursor)
            else:
                cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)
        else:
            if is_sscursor:
                cursor = conn.cursor(cursor=pymysql.cursors.SSCursor)
            else:
                cursor = conn.cursor()
        return conn, cursor
    except Exception as ex:
        logger.error("connect database failed, {},{}".format(200, ex))
        print("connect database failed, {},{}".format(200, ex))
        raise Exception({'code': 200, 'msg': ex})


```

| 类型 | 描述 | 用途 |
| :---- | :---- | ---- |
|Cursor|普通的游标对象，默认创建的游标对象|游标结果作为元祖的元祖返回 说明：1. 这是您用于与数据库交互的对象。 2. 不要自己创建Cursor实例。调用connections.Connection.cursor()|
|SSCursor|流式游标,避免客户端占用大量内存,不缓存游标，主要用于当操作需要返回大量数据的时候|无缓冲游标结果作为元祖的元祖返回 用途：1. 用于返回大量数据查询，或慢速网络连接到远程服务器 2. 缓冲区，根据需要获取行。客户端内存使用少 3.在慢速网络上或结果集非常大时行返回速度快 限制：1. MySQL协议不支持返回总行数，判断有多少行唯一方法是迭代返回的每一行。 2. 目前无法向后滚动，因为只有当前行保存在内存中。|
|DictCursor|以字典的形式返回操作结果|将结果作为字典返回游标|
|SSDictCursor|流式游标,避免客户端占用大量内存,不缓存游标，将结果以字典的形式进行返回|无缓冲游标结果作为字典返回|

### 举个栗子
```
import pymysql

dbmy = pymysql.connect("ip","user","pass","date",cursorclass = pymysql.cursors.SSCursor)
cursor = dbmy.cursor()
sql = "select * from table"
relnum = cursor.execute(sql)
result = cursor.fetchone()
while result is not None:
    # todo
    result = cursor.fetchone()

cursor.close()
dbmy.close()
```
需要注意的是
1. 因为 SSCursor 是没有缓存的游标,结果集只要没取完，这个 conn 是不能再处理别的 sql，包括另外生成一个 cursor 也不行的。如果需要干别的，请另外再生成一个连接对象。
2. 每次读取后处理数据要快，不能超过 60 s，否则 mysql 将会断开这次连接，也可以修改 SET NET_WRITE_TIMEOUT = xx 来增加超时间隔。


### 游标

游标只读属性：
```
cursor.description#返回游标活动状态 #(('VERSION()', 253, None, 24, 24, 31, False),)
包含7个元素的元组：
(name, type_code, display_size, internal_size, precision, scale, null_ok)

游标属性：

cursor.max_stmt_length#1024000
cursor.rownumber#5 #当前结果集中游标所在行的索引(起始行号为 0)
 
cursor.arraysize#1 #此读/写属性指定用.fetchmany()一次获取的行数。
# 默认1表示一次获取一行；也可以用于执行.executemany()
 
cursor.lastrowid#None #只读属性提供上次修改行的rowid
# DB仅在执行单个INSERT 操作时返回rowid 。
# 如未设rowid或DB不支持rowid应将此属性设置为None
# 如最后执行语句修改了多行，例如用INSERT和.executemany()时lastrowid语义是未定义
 
cursor.rowcount #5 #最近一次 execute() 创建或影响的行数
# 如无cursor.execute()或接口无法确定最后一个操作的rowcount则该属性为-1
# 该行数属性可以在动态更新其值的方式来编码。
# 这对于仅在第一次调用.fetch()方法后返回可用rowcount值的 数据库非常有用

```





