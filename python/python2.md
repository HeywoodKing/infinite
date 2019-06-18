#101.简述any()和all()方法
+ any(x)判断x对象是否为空对象，如果都为空、0、false，则返回false，如果不都为空、0、false，则返回true
+ all(x)如果all(x)参数x对象的所有元素不为0、''、False或者x为空对象，则返回True，否则返回False
```
>>> any('123')
True
>>> any([0,1])
True
>>> any([0,'0',''])
True
>>> any([0,''])
False
>>> any([0,'','false'])
True
>>> any([0,'',bool('false')])
True
>>> any([0,'',False])
False
>>> any(('a','b','c'))
True
>>> any(('a','b',''))
True
>>> any((0,False,''))
False
>>> any([])
False
>>> any(())
False
>>> all(['a', 'b', 'c', 'd'])  #列表list，
True
>>> all(['a', 'b', 'c', 'd'])  #列表list，元素都不为空或0
True
>>> all(['a', 'b', '', 'd'])  #列表list，存在一个为空的元素
False
>>> all([0, 1,2, 3])  #列表list，存在一个为0的元素
False
>>> all(('a', 'b', 'c', 'd'))  #元组tuple，元素都不为空或0
True
>>> all(('a', 'b', '', 'd'))  #元组tuple，存在一个为空的元素
False
>>> all((0, 1,2, 3))  #元组tuple，存在一个为0的元素
False
>>> all([]) # 空列表
True
>>> all(()) # 空元组
True
>>> #注意：空元组、空列表返回值为True，这里要特别注意
>>> all(('', '', '', ''))  #元组tuple，全部为空的元素
False
>>> all('')
True
>>> #如果all(x)参数x对象的所有元素不为0、''、False或者x为空对象，则返回True，否则返回False
>>> 
```

any():只要迭代器中有一个元素为真就为真

all():迭代器中所有的判断项返回都是真，结果才为真

python中什么元素为假？

答案：（0，空字符串，空列表、空字典、空元组、None, False）


#102.IOError、AttributeError、ImportError、IndentationError、IndexError、KeyError、SyntaxError、NameError分别代表什么异常
IOError错误主要是指要打开的文件不存在的错误提示，引起IOError错误的可能原因有很多
>1. 文件确实不存在
当错误的输入了一个不存在的文件名，并试图打开它的时候，程序会因为找不到这个文件名而引发IOError错误，这种情况就需要将输入的文件名修改成正确的文件名！
>2. 文件写入时遇到IOError错误
该错误引起的原因极有可能是以读取方式打开了文件，并在读取模式中写入文件内容，所以引起错误，正确的方式应该是在读取文件之后记得把文件关闭，当需要写入文件时，要再将文件以W+方式写入。
>3. 权限问题导致
当不满足访问该文件的权限时，也会引发IOError错误，要解决该问题，需要超级管理员设置相应的读取和写入权限即可！
```
AttributeError：试图访问一个对象没有的属性
ImportError：无法引入模块或包，基本是路径问题
IndentationError：语法错误，代码没有正确的对齐
IndexError：下标索引超出序列边界
KeyError:试图访问你字典里不存在的键
SyntaxError:Python代码逻辑语法出错，不能执行
NameError:使用一个还未赋予对象的变量

python标准异常：
BaseException   所有异常的基类
SystemExit  解释器请求退出
KeyboardInterrupt   用户中断执行(通常是输入^C)
Exception   常规错误的基类
StopIteration   迭代器没有更多的值
GeneratorExit   生成器(generator)发生异常来通知退出
StandardError   所有的内建标准异常的基类
ArithmeticError 所有数值计算错误的基类
FloatingPointError  浮点计算错误
OverflowError   数值运算超出最大限制
ZeroDivisionError   除(或取模)零 (所有数据类型)
AssertionError  断言语句失败
AttributeError  对象没有这个属性
EOFError    没有内建输入,到达EOF 标记
EnvironmentError    操作系统错误的基类
IOError 输入/输出操作失败
OSError 操作系统错误
WindowsError    系统调用失败
ImportError 导入模块/对象失败
LookupError 无效数据查询的基类
IndexError  序列中没有此索引(index)
KeyError    映射中没有这个键
MemoryError 内存溢出错误(对于Python 解释器不是致命的)
NameError   未声明/初始化对象 (没有属性)
UnboundLocalError   访问未初始化的本地变量
ReferenceError  弱引用(Weak reference)试图访问已经垃圾回收了的对象
RuntimeError    一般的运行时错误
NotImplementedError 尚未实现的方法
SyntaxError Python 语法错误
IndentationError    缩进错误
TabError    Tab 和空格混用
SystemError 一般的解释器系统错误
TypeError   对类型无效的操作
ValueError  传入无效的参数
UnicodeError    Unicode 相关的错误
UnicodeDecodeError  Unicode 解码时的错误
UnicodeEncodeError  Unicode 编码时错误
UnicodeTranslateError   Unicode 转换时错误
Warning 警告的基类
DeprecationWarning  关于被弃用的特征的警告
FutureWarning   关于构造将来语义会有改变的警告
OverflowWarning 旧的关于自动提升为长整型(long)的警告
PendingDeprecationWarning   关于特性将会被废弃的警告
RuntimeWarning  可疑的运行时行为(runtime behavior)的警告
SyntaxWarning   可疑的语法的警告
UserWarning 用户代码生成的警告
```

#103.python中copy和deepcopy区别
复制不可变数据类型，不管copy还是deepcopy,都是同一个地址当浅复制的值是不可变对象（数值，字符串，元组）时和=“赋值”的情况一样，对象的id值与浅复制原来的值相同。
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134429748-1171745107.png "演示")

复制的值是可变对象（列表和字典）
浅拷贝copy有两种情况：

第一种情况：复制的 对象中无 复杂 子对象，原来值的改变并不会影响浅复制的值，同时浅复制的值改变也并不会影响原来的值。原来值的id值与浅复制原来的值不同。

第二种情况：复制的对象中有 复杂 子对象 （例如列表中的一个子元素是一个列表）， 改变原来的值 中的复杂子对象的值  ，会影响浅复制的值。

深拷贝deepcopy：完全复制独立，包括内层列表和字典
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134457274-1983903746.png "演示")

![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134507501-540381558.png "演示")


—–我们寻常意义的复制就是深复制，即将被复制对象完全再复制一遍作为独立的新个体单独存在。所以改变原有被复制对象不会对已经复制出来的新对象产生影响。 
—–而浅复制并不会产生一个独立的对象单独存在，他只是将原有的数据块打上一个新标签，所以当其中一个标签被改变的时候，数据块就会发生变化，另一个标签也会随之改变。这就和我们寻常意义上的复制有所不同了。

对于简单的 object，用 shallow copy 和 deep copy 没区别

复杂的 object， 如 list 中套着 list 的情况，shallow copy 中的 子list，并未从原 object 真的「独立」出来。也就是说，如果你改变原 object 的子 list 中的一个元素，你的 copy 就会跟着一起变。这跟我们直觉上对「复制」的理解不同。
```
 1 >>> import copy
 2 >>> origin = [1, 2, [3, 4]]
 3 #origin 里边有三个元素：1， 2，[3, 4]
 4 >>> cop1 = copy.copy(origin)
 5 >>> cop2 = copy.deepcopy(origin)
 6 >>> cop1 == cop2
 7 True
 8 >>> cop1 is cop2
 9 False 
10 #cop1 和 cop2 看上去相同，但已不再是同一个object
11 >>> origin[2][0] = "hey!" 
12 >>> origin
13 [1, 2, ['hey!', 4]]
14 >>> cop1
15 [1, 2, ['hey!', 4]]
16 >>> cop2
17 [1, 2, [3, 4]]
18 #把origin内的子list [3, 4] 改掉了一个元素，观察 cop1 和 cop2
```
Python 存储变量的方法跟其他 OOP 语言不同。它与其说是把值赋给变量，不如说是给变量建立了一个到具体值的 reference。

当在 Python 中 a = something 应该理解为给 something 贴上了一个标签 a。当再赋值给 a 的时候，就好象把 a 这个标签从原来的 something 上拿下来，贴到其他对象上，建立新的 reference。 这就解释了一些 Python 中可能遇到的诡异情况
```
 1 >> a = [1, 2, 3]
 2 >>> b = a
 3 >>> a = [4, 5, 6] //赋新的值给 a
 4 >>> a
 5 [4, 5, 6]
 6 >>> b
 7 [1, 2, 3]
 8 # a 的值改变后，b 并没有随着 a 变
 9 
10 >>> a = [1, 2, 3]
11 >>> b = a
12 >>> a[0], a[1], a[2] = 4, 5, 6 //改变原来 list 中的元素
13 >>> a
14 [4, 5, 6]
15 >>> b
16 [4, 5, 6]
17 # a 的值改变后，b 随着 a 变了
```

对于一个复杂对象的浅copy，在copy的时候到底发生了什么？ 
再看一段代码：
```
>>> import copy
>>> origin = [1, 2, [3, 4]]
#origin 里边有三个元素：1， 2，[3, 4]
>>> cop1 = copy.copy(origin)
>>> cop2 = copy.deepcopy(origin)
>>> cop1 == cop2
True
>>> cop1 is cop2
False 
#cop1 和 cop2 看上去相同，但已不再是同一个object
>>> origin[2][0] = "hey!" 
>>> origin
[1, 2, ['hey!', 4]]
>>> cop1
[1, 2, ['hey!', 4]]
>>> cop2
[1, 2, [3, 4]]
#把origin内的子list [3, 4] 改掉了一个元素，观察 cop1 和 cop2
```
copy对于一个复杂对象的子对象并不会完全复制，什么是复杂对象的子对象呢？就比如序列里的嵌套序列，字典里的嵌套序列等都是复杂对象的子对象。对于子对象，python会把它当作一个公共镜像存储起来，所有对他的复制都被当成一个引用，所以说当其中一个引用将镜像改变了之后另一个引用使用镜像的时候镜像已经被改变了

deepcopy的时候会将复杂对象的每一层复制一个单独的个体出来。 
这时候的 origin[2] 和 cop2[2] 虽然值都等于 [3, 4]，但已经不是同一个 list了。即我们寻常意义上的复制。

#104.列出几种魔法方法并简要介绍用途
__init__:对象初始化方法
__new__:创建对象时候执行的方法，单列模式会用到
__str__:当使用print输出对象的时候，只要自己定义了__str__(self)方法，那么就会打印从在这个方法中return的数据
__del__:删除对象执行的方法

#105.C:Users\y-wu.junya\Desktop>python 1.py 22 33命令行启动程序并传参，print(sys.argv)会输出什么数据？
文件名和参数构成的列表
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134525646-1422668006.png "演示")

#106.请将[i for i in range(3)]改成生成器
生成器是特殊的迭代器，
1、列表表达式的[]改为（）即可变成生成器
2、函数在返回值得时候出现yield就变成生成器，而不是函数了；中括号换成小括号即可，有没有惊呆了
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134537207-2067775190.png "演示")


#107.a = "  hehheh  ",去除收尾空格
```
a = "  hehheh  "
print(a.strip())
```

#108.举例sort和sorted对列表排序，list  = [0,-1,3,-10,5,9]
```
li = [0,-1,3,-10,5,9]
li.sort(reverse=False)
print(li)
sort在原基础上修改，无返回值

li = [0,-1,3,-10,5,9]
res = sorted(li, reverse=False)
print(res)
排序后有返回值的新列表
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134706969-1925834698.png "演示")

#109.对list排序foo = [-5,8,0,4,9,-4,-20,-2,8,2,-4],使用lambda函数从小到大排序
```
foo = [-5,8,0,4,9,-4,-20,-2,8,2,-4]
res = sorted(foo, key=lambda x:x)
print(res)
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134713034-2037009040.png "演示")

#110.使用lambda函数对list排序foo = [-5,8,0,4,9,-4,-20,-2,8,2,-4]，输出结果为[0,2,4,8,8,9,-2,-4,-4,-5,-20]，正数从小到大，负数从大到小
```
foo = [-5,8,0,4,9,-4,-20,-2,8,2,-4]
res = sorted(foo, key=lambda x:(x<0, abs(x)))
print(res)

[0, 2, 4, 8, 8, 9, -2, -4, -4, -5, -20]
```
（传两个条件，x<0和abs(x)）
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134726432-1290327662.png "演示")

#111.列表嵌套字典的排序，分别根据年龄和姓名排序
```
foo = [{"name":"zs","age":19},{"name":"ll","age":54},{"name":"wa","age":17},{"name":"df","age":23}]
res = sorted(foo, key=lambda x:x["name"])  # 姓名从小到大
print(res)
res = sorted(foo, key=lambda x:x["age"], reverse=True)  # 年龄从大到小
print(res)

[{'name': 'df', 'age': 23}, {'name': 'll', 'age': 54}, {'name': 'wa', 'age': 17}, {'name': 'zs', 'age': 19}]
[{'name': 'll', 'age': 54}, {'name': 'df', 'age': 23}, {'name': 'zs', 'age': 19}, {'name': 'wa', 'age': 17}]
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134740364-799138817.png "演示")

#112.列表嵌套元组，分别按字母和数字排序
```
foo = [("zs",19),("ll", 54),("wa", 17),("df", 23)]
res = sorted(foo, key=lambda x:x[0])  # 按字母排序
print(res)
res = sorted(foo, key=lambda x:x[1], reverse=True) #按数字排序
print(res)

[('df', 23), ('ll', 54), ('wa', 17), ('zs', 19)]
[('ll', 54), ('df', 23), ('zs', 19), ('wa', 17)]
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134749801-640892894.png "演示")

#113.列表嵌套列表排序，年龄数字相同怎么办？
```
foo = [["zs",19],["ll", 54],["wa", 19],["df", 23]]
res = sorted(foo, key=lambda x:x[0])  # 按字母排序
print(res)
res = sorted(foo, key=lambda x:(x[1], x[0])) #按数字排序
print(res)

[['df', 23], ['ll', 54], ['wa', 19], ['zs', 19]]
[['wa', 19], ['zs', 19], ['df', 23], ['ll', 54]]
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134842470-44733925.png "演示")

#114.根据键对字典排序（方法一，zip函数）
```
dic = {"name":"zs", "sex":"man","city":"bj"}
foo = zip(dic.keys(), dic.values())  #构造列表
foo = [i for i in foo]
print(foo)
b = sorted(foo, key=lambda x:x[0])  #字典嵌套元组，按照key排序
print(b)
new_dic = {i[0]:i[1] for i in b}
print(new_dic)

[('name', 'zs'), ('sex', 'man'), ('city', 'bj')]
[('city', 'bj'), ('name', 'zs'), ('sex', 'man')]
{'city': 'bj', 'name': 'zs', 'sex': 'man'}
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134855818-1558307101.png "演示")

#115.根据键对字典排序（方法二,不用zip)
有没有发现dic.items和zip(dic.keys(),dic.values())都是为了构造列表嵌套字典的结构，方便后面用sorted()构造排序规则
```
dic = {"name":"zs", "sex":"man","city":"bj"}
b = sorted(dic.items, key=lambda x:x[0])
new_dic = {i[0]:i[1] for i in b}
print(new_dic)

[('city', 'bj'), ('name', 'zs'), ('sex', 'man')]
{'city': 'bj', 'name': 'zs', 'sex': 'man'}
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630134909156-2004698740.png "演示")

#116.列表推导式、字典推导式、生成器
```
列表推导式 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] <class 'list'>
生成器 <generator object <genexpr> at 0x000001E6FBCB9840>
字典推导式 {'a': 9, 'b': 4, 'c': 6, 'd': 4} <class 'dict'>
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135011999-75222251.png "演示")

#117.最后出一道检验题目，根据字符串长度排序，看排序是否灵活运用
```
s = ["ab", "c", "fadea", "123", "dkafdlasdfsd", "ad"]
res = sorted(s, key=lambda x:len(x))  #从小到大
print(res)

res = sorted(s, key=lambda x:len(x), reverse=True) #从大到小
print(res)
```
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135025331-372839180.png "演示")

#118.举例说明SQL注入和解决办法
当以字符串格式化书写方式的时候，如果用户输入的有;+SQL语句，后面的SQL语句会执行，比如例子中的SQL注入会删除数据库demo
```
input_name = "aa"
sql = 'select * from demo where name="%s"' % input_name
print("正常sql", sql)

# input_name = "aa; drop database demo;"
input_name = "aa\" or 1=1 or \"true"
sql = 'select * from demo where name="%s"' % input_name
# select * from home_ad where title="123" or 1=1 or "";
print("sql注入语句", sql)
```
解决方式：通过传参数方式解决SQL注入
params = [input_name]
count = cs.execute('select * from demo where name="%s"', params)

#119.s="info:xiaoZhang 33 shandong",用正则切分字符串输出['info', 'xiaoZhang', '33', 'shandong']
```
import re

s = "info:xiaoZhang 33 shandong"
res = re.split(r":| ", s)
print(res)
```

#120.正则匹配以163.com结尾的邮箱
```
email_list = ["aaa@163.com0211313asdf", "afasdf@163.com", "123@hotmail.com", ".com.3332423@qq.com"]
for email in email_list:
    ret = re.match("[\w]{1,20}@163\.com$", email)
    # ret = re.match("[\w]{1,20}@163.com$", email)
    if ret:
        print("%s 是符合规定的邮箱，匹配后的结果是：%s" % (email, ret.group()))
    else:
        print("%s 不符合要求" % email)
```

#121.递归求和
```
def get_total(num):
    if num >= 1:
        res = num + get_total(num - 1)
    else:
        res = 0

    return res

print(get_total(10))
```

#122.python字典和json字符串相互转化方法
json.dumps()	字典转json字符串

json.loads()	json字符串转字典
```
import json

# 字典转json串
dic = {"name": "flack"}
res = json.dumps(dic)
print(res, type(res))

# json串转字典
ret = json.loads(res)
print(ret, type(ret))
```

#123.MyISAM 与 InnoDB 区别：
1、InnoDB 支持事务，MyISAM 不支持，这一点是非常之重要。事务是一种高级的处理方式，如在一些列增删改中只要哪个出错还可以回滚还原，而 MyISAM
就不可以了；
2、MyISAM 适合查询以及插入为主的应用，InnoDB 适合频繁修改以及涉及到安全性较高的应用；
3、InnoDB 支持外键，MyISAM 不支持；
4、对于自增长的字段，InnoDB 中必须包含只有该字段的索引，但是在 MyISAM表中可以和其他字段一起建立联合索引；
5、清空整个表时，InnoDB 是一行一行的删除，效率非常慢。MyISAM 则会重建表；


#124.统计字符串中某字符出现次数
```
s = "张三李四张三王五马六陈七陈七"
res = s.count("张三")
print(res)
```

#125.字符串转化大小写
```
s = "adbdadafda"
res = s.upper()
print(res)
res = res.lower()
print(res)
```

#126.用两种方法去空格
```
s = " asdf hello world ha ha"
res = s.replace(" ","")
print(res)

li = s.split(" ")
res = "".join(li)
print(res)
```

#126.1.lambda,zip,map,reduce,filter
lambda:匿名函数lambda是指一类无需定义标识符（函数名）的函数或子程序
def sum(x,y):
    return x+y

用lambda来实现：
p = lambda x,y:x+y
print(p(4,6))

传入一个参数的lambda函数:
a=lambda x:x*x
print(a(3))

多个参数的lambda形式：
a = lambda x,y,z:(x+8)*y-z
print(a(5,6,8))

lambda 函数可以接收任意多个参数 (包括可选参数) 并且返回单个表达式的值。
lambda匿名函数的格式：冒号前是参数，可以有多个，用逗号隔开，冒号右边的为表达式。其实lambda返回值是一个函数的地址，也就是函数对象。

zip() 函数用于将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。
如果各个迭代器的元素个数不一致，则返回列表长度与最短的对象相同，利用 * 号操作符，可以将元组解压为列表。

map()是 Python 内置的高阶函数，它接收一个函数 f 和一个 list，并通过把函数 f 依次作用在 list 的每个元素上，得到一个新的 list 并返回。
map()函数是python内置的高阶函数，对传入的list的每一个元素进行映射，返回一个新的映射之后的list
python3中，map函数返回的是一个map对象，需要list（map(fun,itor)）来将映射之后的map对象转换成列表
对于list [1, 2, 3, 4, 5, 6, 7, 8, 9]如果希望把list的每个元素都作平方，就可以用map()函数：
因此，我们只需要传入函数f(x)=x*x，就可以利用map()函数完成这个计算：

def f(x):
    return x*x
print map(f, [1, 2, 3, 4, 5, 6, 7, 8, 9])

reduce() 函数在 python 2 是内置函数， 从python 3 开始移到了 functools 模块。
reduce 有 三个参数
function    有两个参数的函数， 必需参数
sequence    tuple ，list ，dictionary， string等可迭代物，必需参数
initial 初始值， 可选参数

reduce的工作过程是 ：在迭代sequence(tuple ，list ，dictionary， string等可迭代物)的过程中，首先把 前两个元素传给 函数参数，函数加工后，然后把得到的结果和第三个元素作为两个参数传给函数参数， 函数加工后得到的结果又和第四个元素作为两个参数传给函数参数，依次类推。 如果传入了 initial 值， 那么首先传的就不是 sequence 的第一个和第二个元素，而是 initial值和 第一个元素。经过这样的累计计算之后合并序列到一个单一返回值
>>> def add(x, y):
...     return x+y
...
>>> from functools import reduce
>>> reduce(add, [1,2,3,4])
10

还可以把一个整数列表拼成整数，如下:
>>> from functools import reduce
>>> reduce(lambda x, y: x * 10 + y, [1 , 2, 3, 4, 5])
12345

reduce高级用法待挖掘



filter()函数用于过滤序列，过滤掉不符合条件的元素，返回由符合条件元素组成的新列表。
接收两个参数，第一个为函数，第二个为序列，序列的每个元素作为参数传递给函数进行判断，返回True或False，将返回True的元素放到新列表中。
filter(function, iterable)
```
# 过滤列表中所有奇数
def is_odd(n):
    return n % 2 == 1

newlist = list(filter(is_odd, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
print(newlist)

[1, 3, 5, 7, 9]

# 过滤出1~100中平方根是整数的数：

import math
def is_sqr(x):
    return math.sqrt(x) % 1 == 0

newlist = list(filter(is_sqrt, range(1, 101)))
print(newlist) 

[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```
当出现这种错误时，是因为没将filter函数转换成list。
![演示](https://images2017.cnblogs.com/blog/1235684/201711/1235684-20171103103435591-2008900996.jpg "演示")


#127.正则匹配不是以4和7结尾的手机号
```
import re
tel_list = ["13523565214", "13252635896", "13312458547", "15056238596", "15952631257"]
for tel in tel_list:
    ret = re.match("1\d{9}[0-3,5-6,8-9]", tel)
    if ret:
        print("是想要的手机号：%s" % ret.group())
    else:
        print("%s 不是想要的手机号" % tel)
```

#128.简述python引用计数机制
python垃圾回收主要以引用计数为主，标记-清除和分代清除为辅的机制，其中标记-清除和分代回收主要是为了处理循环引用的难题。
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135250986-803431565.png "演示")
引用计数算法
当有1个变量保存了对象的引用时，此对象的引用计数就会加1

当使用del删除变量指向的对象时，如果对象的引用计数不为1，比如3，那么此时只会让这个引用计数减1，即变为2，当再次调用del时，变为1，如果再调用1次del，此时会真的把对象进行删除

#129.int("1.4"),int(1.4)输出结果？
int("1.4")报错，int(1.4)输出1

#130.列举3条以上PEP8编码规范
1、顶级定义之间空两行，比如函数或者类定义。
2、方法定义、类定义与第一个方法之间，都应该空一行
3、三引号进行注释
4、使用Pycharm、Eclipse一般使用4个空格来缩进代码

#131.正则表达式匹配第一个URL
findall结果无需加group(),match,search需要加group()提取
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135259724-1847914904.png "演示")

#132.正则匹配中文
```
import re

title = "你好，hellow world，世界"
pattern = re.compile(r'[\u4e00-\u9fa5]+')
res = pattern.findall(title)

print(res)

['你好', '世界']
```

#133.简述乐观锁和悲观锁
悲观锁, 就是很悲观，每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁，这样别人想拿这个数据就会block直到它拿到锁。传统的关系型数据库里边就用到了很多这种锁机制，比如行锁，表锁等，读锁，写锁等，都是在做操作之前先上锁。 

乐观锁，就是很乐观，每次去拿数据的时候都认为别人不会修改，所以不会上锁，但是在更新的时候会判断一下在此期间别人有没有去更新这个数据，可以使用版本号等机制，乐观锁适用于多读的应用类型，这样可以提高吞吐量

#134.r、r+、rb、rb+文件打开模式区别
```
r:默认值，文件读取数据，只读
r+:表示对文件进行可读写操作（删除以前的所有操作）
rb:按照二进制位进行读取
rb+:按照二进制位进行读写
```

```
t:文本模式
x:写模式，新建一个文件，如果该文件已存在则报错
b:二进制模式
+:打开一个文件进行更新（可读可写）
U:通用换行模式
r:打开一个文件用于只读，文件的指针在文件的开头，默认模式
rb:以二进制格式打开一个文件用于只读，文件指针在文件的开头，一般用于非文本文件如图片
r+:打开一个文件用于读写，文件指针将会放在文件的开头
rb+:以二进制格式打开一个文件读写，文件指针将会放在文件的开头，一般用于非文本文件如图片
w:打开一个文件只写，如果文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除，如果文件不存在，则创建新文件
wb:以二进制格式打开一个文件只写，如果文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除，如果文件不存在，则创建新文件，一般用于非文本文件如图片
w+:打开一个文件用于读写，如果文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除，如果文件不存在，则创建新文件
wb+:以二进制格式打开一个文件用于读写，如果文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除，如果文件不存在，则创建新文件，一般用于非文本文件如图片
a:打开一个文件用于追加，如果该文件已存在，文件指针将会放在文件的结尾，也就是说，新内容将会被写入到已有内容之后，如果该文件不存在，创建新文件进行写入
ab:以二进制格式打开一个文件用于追加，如果该文件已存在，文件指针将会放在文件的结尾，也就是说，新内容将会被写入到已有内容之后，如果该文件不存在，创建新文件进行写入
a+:打开一个文件用于读写，如果该文件已存在，文件指针将会放在文件的结尾，文件打开时会是追加模式，如果该文件不存在，创建新文件用于读写
ab+:以二进制格式打开一个文件用于追加，如果该文件已存在，文件指针将会放在文件的结尾，如果该文件不存在，创建新文件用于读写。
```


#135.Linux命令重定向 > 和 >>
Linux 允许将命令执行结果 重定向到一个 文件

将本应显示在终端上的内容 输出／追加 到指定文件中

> 表示输出，会覆盖文件原有的内容

>> 表示追加，会将内容追加到已有文件的末尾

将 echo 输出的信息保存到 1.txt 里echo Hello Python > 1.txt

将 tree 输出的信息追加到 1.txt 文件的末尾tree >> 1.txt


#136.正则表达式匹配出<html><h1>www.itcast.cn</h1></html>
```
import re

labels = ["<html><h1>www.itcast.cn</h1></html>", "<html><h1>www.itcast.cn</h2></html>"]
for label in labels:
    ret = re.match(r"<(\w*)><(\w*)>.*?</\2></\1>", label)
    if ret:
        print("%s 是符合要求的标签" % ret.group())
    else:
        print("%s 不符合要求" % label)
```

#137.python传参数是传值还是传址？
Python中函数参数是引用传递（注意不是值传递）。对于不可变类型（数值型、字符串、元组），因变量不能修改，所以运算不会影响到变量自身；而对于可变类型（列表字典）来说，函数体运算可能会更改传入的参数变量。

#138.求两个列表的交集、差集、并集
```
l1 = [1, 2, 3, 4]
l2 = [3, 4, 5, 6]

res1 = [i for i in l1 if i in l2]
res2 = list(set(l1).intersection(set(l2)))
print("交集：", res1, res2)

res3 = list(set(l1).union(set(l2)))
print("并集：", res3)

res4 = list(set(l1).difference(set(l2)))  #l1中有而l2中没有的  非常高效
res5 = list(set(l2).difference(set(l1)))  #l2中有而l1中没有的  非常高效

print("差集：", res4, res5)
```

#139.生成0-100的随机数
random.random()生成0-1之间的随机小数，所以乘以100
```
import random

res1 = 100 * random.random()
print(res1)

res2 = random.choice(range(0, 101))
print(res2)

res3 = random.randrange(0, 101)
print(res3)

res4 = random.randint(0, 100)
print(res4)
```

#140.lambda匿名函数好处
1.精简代码
2.lambda省去了定义函数
3.map省去了写for循环过程
```
a = ["天水", "苏州", "柳州", "桂林", "玉门", "", "黑河", ""]
res = list(map(lambda x:"中国" if x=="" else x, a))
print(res)
```

#141.常见的网络传输协议
UDP、TCP、FTP、HTTP、SMTP等等

1. TCP/IP:互联网协议（Internet Protocol Suite）是一个网络通信模型，以及一整个网络传输协议家族，为互联网的基础通信架构。它常被通称为TCP/IP协议族（英语：TCP/IP Protocol Suite，或TCP/IP Protocols），简称TCP/IP,TCP/IP提供点对点的链接机制，将数据应该如何封装、定址、传输、路由以及在目的地如何接收，都加以标准化。它将软件通信过程抽象化为四个抽象层,
>常被视为是简化的七层OSI模型。
	1. 应用层
	2. 表示层
	3. 会话层
	4. 传输层
	5.  网络层
	6. 数据链路层
	7. 物理层

TCP是面向连接的通信协议，通过三次握手建立连接，通讯完成时要拆除连接，由于TCP是面向连接的所以只能用于端到端的通讯。是一种可靠的数据流服务
2. UDP:是面向无连接的通讯协议，UDP数据包括目的端口号和源端口号信息，由于通讯不需要连接，所以可以实现广播发送。
UDP通讯时不需要接收方确认，属于不可靠的传输，可能会出现丢包现象，实际应用中要求程序员编程验证。

UDP主要用于那些面向查询---应答的服务，例如NFS。相对于FTP或Telnet，这些服务需要交换的信息量较小。使用UDP的服务包括NTP（网络时间协议）和DNS（DNS也使用TCP）

FTP:FTP（File Transfer Protocol，文件传输协议） 是 TCP/IP 协议组中的协议之一。FTP协议包括两个组成部分，其一为FTP服务器，其二为FTP客户端
FTP支持两种模式，一种方式叫做Standard (也就是 PORT方式，主动方式)，一种是 Passive(也就是PASV，被动方式)。 Standard模式 FTP的客户端发送 PORT 命令到FTP服务器。Passive模式FTP的客户端发送 PASV命令到 FTP Server。

Port
FTP 客户端首先和FTP服务器的TCP 21端口建立连接，通过这个通道发送命令，客户端需要接收数据的时候在这个通道上发送PORT命令。 PORT命令包含了客户端用什么端口接收数据。在传送数据的时候，服务器端通过自己的TCP 20端口连接至客户端的指定端口发送数据。 FTP server必须和客户端建立一个新的连接用来传送数据。
Passive
在建立控制通道的时候和Standard模式类似，但建立连接后发送的不是Port命令，而是Pasv命令。FTP服务器收到Pasv命令后，随机打开一个高端端口（端口号大于1024）并且通知客户端在这个端口上传送数据的请求，客户端连接FTP服务器此端口，通过三次握手建立通道，然后FTP服务器将通过这个端口进行数据的传送。
很多防火墙在设置的时候都是不允许接受外部发起的连接的，所以许多位于防火墙后或内网的FTP服务器不支持PASV模式，因为客户端无法穿过防火墙打开FTP服务器的高端端口；而许多内网的客户端不能用PORT模式登陆FTP服务器，因为从服务器的TCP 20无法和内部网络的客户端建立一个新的连接，造成无法工作。

FTP的传输有两种方式：ASCII传输模式和二进制数据传输模式。


HTTP:超文件传输协议
HTTP（HyperText Transfer Protocol）协议是基于TCP的应用层协议
	1. HTTP协议是无状态的
	2. 多次HTTP请求
	3. 基于TCP协议

HTTP请求方法

　　请求方法是客户端用来告知服务器其动作意图的方法。就像下达命令一样。在HTTP1.1版本中支持GET、POST等近10种方法。需要注意的是方法名区分大小写，需要用大写字母。下面详细说明。

　　1.GET：获取资源

　　GET方法用来请求访问已被URI识别的资源。也就是指定了服务器处理请求之后响应的内容。

　　2.POST：传输实体主体

　　POST方法用来传输实体主体。POST与GET的区别之一就是目的不同，二者之间的区别会在文章的最后详细说明。虽然GET方法也可以传输，但是一般不用，因为GET的目的是获取，POST的目的是传输。

　　3.PUT：传输文件

　　PUT方法用来传输文件。类似FTP协议，文件内容包含在请求报文的实体中，然后请求保存到URL指定的服务器位置。

　　4.HEAD：获得报文首部

　　HEAD方法类似GET方法，但是不同的是HEAD方法不要求返回数据。用于确认URI的有效性及资源更新时间等。

　　5.DELETE：删除文件

　　DELETE方法用来删除文件，是与PUT相反的方法。DELETE是要求返回URL指定的资源。

　　6.OPTIONS：询问支持的方法

　　因为并不是所有的服务器都支持规定的方法，为了安全有些服务器可能会禁止掉一些方法例如DELETE、PUT等。那么OPTIONS就是用来询问服务器支持的方法。

　　7.TRACE：追踪路径

　　TRACE方法是让Web服务器将之前的请求通信环回给客户端的方法。这个方法并不常用。

　　8.CONNECT：要求用隧道协议连接代理

　　CONNECT方法要求在与代理服务器通信时建立隧道，实现用隧道协议进行TCP通信。主要使用SSL/TLS协议对通信内容加密后传输。

![演示](https://images2015.cnblogs.com/blog/735119/201612/735119-20161222203657557-1281147259.png "演示")


HTTP有60多种状态码
1. 200：OK

　　这个没有什么好说的，是代表请求被正常的处理成功了。

　　2. 204：No Content

　　请求处理成功，但是没有数据实体返回，也不允许有实体返回。比如说HEAD请求，可能就会返回204 No Content，因为HEAD就是只获取头信息。这里简单提一下205 Reset Content，和204 No Content的区别是不但没有数据实体返回，而且还需要重置表单，方便用户再次输入。

　　3. 206：Partial Content

　　这是客户端使用Content-Range指定了需要的实体数据的范围，然后服务端处理请求成功之后返回用户需要的这一部分数据而不是全部，执行的请求就是GET。返回码就是206：Partial Content。

　　4. 301 ： Moved Permanently

　　代表永久性定向。该状态码表示请求的资源已经被分配了新的URL，以后应该使用资源现在指定的URL。也就是说如果已经把资源对应的URL保存为书签了，这是应该按照Location首部字段提示的URL重新保存。

　　5. 302：Found

　　代表临时重定向。该状态码表示请求的资源已经被分配了新的URL，但是和301的区别是302代表的不是永久性的移动，只是临时的。就是说这个URL还可能会发生改变。如果保存成书签了也不会更新。

　　6. 303：See Other

　　和302的区别是303明确规定客户端应当使用GET方法。

　　7. 304：Not Modified

　　该状态码表示客户端发送附带条件请求时，服务器端允许请求访问资源，但是没有满足条件。304状态码返回时不包含任何数据实体。304虽然被划分在3XX中但是和重定向没有关系。

　　8. 307：Temporary Redirect

　　临时重定向，与302 Found相同，但是302会把POST改成GET，而307就不会。

　　9.  400：Bad Request

　　400表示请求报文中存在语法错误。需要修改后再次发送。

　　10. 401：Unauthorized

　　该状态码表示发送的请求需要有通过HTTP认证的认证信息。

　　11. 403：Forbidden

　　表明请求访问的资源被拒绝了。没有获得服务器的访问权限，IP被禁止等。

　　12. 404：Not Found

　　表明请求的资源在服务器上找不到。当然也可以在服务器拒绝请求且不想说明理由时使用。

　　13. 408：Request Timeout

　　表示客户端请求超时，就是在客户端和服务器建立连接后服务器在一定时间内没有收到客户端的请求。

　　14. 500：Internal Server Error

　　表明服务器端在执行请求时发生了错误，很有可能是服务端程序的Bug或者临时故障。

　　15. 503：Service Unavailable

　　表明服务器暂时处于超负载或正在进行停机维护，现在无法处理请求。如果事先得知解除以上状况需要的时间，最好写入Retry-After字段再返回给客户端。

　　16. 504：Getaway Timeout

　　网关超时，是代理服务器等待应用服务器响应时的超时，和408 Request Timeout的却别就是504是服务器的原因而不是客户端的原因


SMTP:简单邮件传输协议 (Simple Mail Transfer Protocol, SMTP) 是在Internet传输email的事实标准。

SMTP是一个相对简单的基于文本的协议。SMTP使用TCP端口25，SMTP是一个“推”的协议，它不允许根据需要从远程服务器上“拉”来消息。要做到这点，邮件客户端必须使用POP3或IMAP。另一个SMTP服务器可以使用ETRN在SMTP上触发一个发送。

最初的SMTP的局限之一在于它没有对发送方进行身份验证的机制。因此，后来定义了SMTP-AUTH扩展。
尽管有了身份认证机制，垃圾邮件仍然是一个主要的问题。但由于庞大的SMTP安装数量带来的网络效应，大刀阔斧地修改或完全替代SMTP被认为是不现实的。Internet Mail 2000就是一个替代SMTP的建议方案。
因此，出现了一些同SMTP工作的辅助协议。IRTF的反垃圾邮件研究小组正在研究一些建议方案，以提供简单、灵活、轻量级的、可升级的源端认证。最有可能被接受的建议方案是发件人策略框架协议。


#142.单引号、双引号、三引号用法
1、单引号和双引号没有什么区别，不过单引号不用按shift，打字稍微快一点。表示字符串的时候，单引号里面可以用双引号，而不用转义字符,反之亦然。

'She said:"Yes." ' or  "She said: 'Yes.' "

2、但是如果直接用单引号扩住单引号，则需要转义，像这样：

 ' She said:'Yes.' '

3、三引号可以直接书写多行，通常用于大段，大篇幅的字符串

"""

hello
world

"""

#143.python垃圾回收机制
python垃圾回收主要以引用计数为主，标记-清除和分代清除为辅的机制，其中标记-清除和分代回收主要是为了处理循环引用的难题。
引用计数算法
当有1个变量保存了对象的引用时，此对象的引用计数就会加1

当使用del删除变量指向的对象时，如果对象的引用计数不为1，比如3，那么此时只会让这个引用计数减1，即变为2，当再次调用del时，变为1，如果再调用1次del，此时会真的把对象进行删除
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135507540-983217503.png "演示")

#144.HTTP请求中get和post区别
1、GET请求是通过URL直接请求数据，数据信息可以在URL中直接看到，比如浏览器访问；而POST请求是放在请求头中的，我们是无法直接看到的；

2、GET提交有数据大小的限制，一般是不超过1024个字节，而这种说法也不完全准确，HTTP协议并没有设定URL字节长度的上限，而是浏览器做了些处理，所以长度依据浏览器的不同有所不同；POST请求在HTTP协议中也没有做说明，一般来说是没有设置限制的，但是实际上浏览器也有默认值。总体来说，少量的数据使用GET，大量的数据使用POST。

3、GET请求因为数据参数是暴露在URL中的，所以安全性比较低，比如密码是不能暴露的，就不能使用GET请求；POST请求中，请求参数信息是放在请求头的，所以安全性较高，可以使用。在实际中，涉及到登录操作的时候，尽量使用HTTPS请求，安全性更好。


#145.python中读取Excel文件的方法
应用数据分析库pandas
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630135520476-1250869352.png "演示")

#146.python正则中search和match
```
import re
s = "小明年龄18岁 工资10000"
res = re.search(r"\d+",s).group()
print("search结果", res)

res = re.findall(r"\d+", s)
print("findall结果", res)

res = re.match("小明", s).group()  #匹配以小明开头的字符串,并匹配出小明
print("match的结果", res)

res = re.match(r"\d+", s)
print("试错，不加group为none，匹配不到", res)

# res = re.match("工资", s).group() #工资不是字符串，匹配不到，报错
# print("match的结果", res)

打印：
search结果 18
findall结果 ['18', '10000']
match的结果 小明
试错，不加group为none，匹配不到 None
```

#147.python中的解释器都有哪些？
1. CPython
官方标准实现
2. IPython
是在CPython基础之上在交互式方面得到增强的解释器
3. Jython
是专门为Java平台设计的Python解释器，它把Python代码编译成java字节码执行
4. PyPy
是Python的一种快速、兼容的替代实现，以速度快著称

#148.http协议解析
##http协议的演进
HTTP（HyperText Transfer Protocol）协议是基于TCP的应用层协议，它不关心数据传输的细节，主要是用来规定客户端和服务端的数据传输格式，最初是用来向客户端传输HTML页面的内容。默认端口是80。
1. HTTP 0.9版本　　1991年

这个版本就是最初用来向客户端传输HTML页面的，所以只有一个GET命令，然后服务器返回客户端一个HTML页面，不能是其他格式。利用这个版本完全可以构建一个简单的静态网站了。

2. HTTP 1.0版本　　1996年

1.0版本是改变比较大的，奠定了现在HTTP协议的基础。这个版本的协议不仅可以传输HTML的文本页面，还可以传输其他二进制文件，例如图片、视频。而且还增加了现在常用的POST和HEAD命令。请求消息和响应消息也不是单一的了，规定了一些元数据字段。例如字符集、编码、状态响应码等。

3.HTTP 1.1版本　　1997年

实际上是在1.0版本之后半年时间又发布了一个版本，这个版本在1.0版本的基础上更加完善了。这个版本增加了持久连接，就是说之前版本的协议一次请求就是一次TCP连接，请求完成后这个连接就关闭掉了。众所周知TCP协议是可靠的，建立连接需要3次握手，断开连接需要4次挥手，并且TCP有流量控制和拥塞控制，有慢开始机制，刚建立连接时传输比较慢，这是比较耗费资源的。一个丰富的页面会有许多图片、表单和超链接。这样的话就会有多次的HTTP请求，所以在这个版本上默认不关闭TCP连接也不用声明Connection: keep-alive字段。如果确实要关闭可以指定Connection: close字段。还引入了管道机制，就是说在一个TCP连接里可以同时发送多个HTTP请求，而不必等待上一个请求响应成功再发送。还增加了PUT、PATCH、HEAD、 OPTIONS、DELETE等命令，丰富了客户端和服务端交互动作。还增加了Host字段。

4.HTTP 2版本　　2015年

这个版本也是随着互联网的发展，有了新的需求制定了新的功能还有对上一个版本的完善。1.1版本有了管道机制，但是正在服务端还是要对请求进行排队处理。这个版本可以多工的处理。还有了头信息压缩和服务器的主动推送。

5.HTTPS

HTTPS是HTTP协议的安全版本，HTTP协议的数据传输是明文的，是不安全的，HTTPS使用了SSL/TLS协议进行了加密处理。

关于HTTP协议历史演进的详细介绍请参考：http://www.ruanyifeng.com/blog/2016/08/http.html

##HTTP协议的特点
1.HTTP协议是无状态的

就是说每次HTTP请求都是独立的，任何两个请求之间没有什么必然的联系。但是在实际应用当中并不是完全这样的，引入了Cookie和Session机制来关联请求。

2.多次HTTP请求

在客户端请求网页时多数情况下并不是一次请求就能成功的，服务端首先是响应HTML页面，然后浏览器收到响应之后发现HTML页面还引用了其他的资源，例如，CSS，JS文件，图片等等，还会自动发送HTTP请求这些需要的资源。现在的HTTP版本支持管道机制，可以同时请求和响应多个请求，大大提高了效率。

3.基于TCP协议

HTTP协议目的是规定客户端和服务端数据传输的格式和数据交互行为，并不负责数据传输的细节。底层是基于TCP实现的。现在使用的版本当中是默认持久连接的，也就是多次HTTP请求使用一个TCP连接。

##HTTP报文
>请求报文

![请求报文](https://images2015.cnblogs.com/blog/735119/201612/735119-20161222192403854-1215865074.png "请求报文")

```
eg:
GET /wxisme HTTP/1.1  
Host: www.cnblogs.com 
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.8.1) Gecko/20061010 Firefox/2.0  
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5  
Accept-Language: en-us,zh-cn;q=0.7,zh;q=0.3  
Accept-Encoding: gzip,deflate  
Accept-Charset: gb2312,utf-8;q=0.7,*;q=0.7  
Keep-Alive: 300  
Proxy-Connection: keep-alive  
Cookie: ASP.NET_SessionId=ey5drq45lsomio55hoydzc45
Cache-Control: max-age=0
```
简单来说请求报文就是由请求行、请求头、内容实体组成的，注意，每一行的末尾都有回车和换行，在内容实体和请求头之间另有一个空行。其中请求行指定的是请求方法、请求URL、协议版本；请求头是键值对的形式存在的，就是字段名：值；内容实体就是要传输的数据。稍后会对方法、请求头字段做详细的说明。

>响应报文

![请求报文](https://images2015.cnblogs.com/blog/735119/201612/735119-20161222194943854-529251231.png "请求报文")
```
eg:
HTTP/1.1 200 OK
Date: Tue, 12 Jul 2016 21:36:12 GMT
Content-Length: 563
Content-Type: text/html

<html>
    <body>
    Hello http!
    </body>
</html>
```
简单来说响应报文由状态行、响应首部字段（响应头）、响应实体组成，其中第一行是状态行，依次包含HTTP版本，状态码和状态短语组成；在一个回车换行之后是响应头，也是键值对的形式，字段名：值；然后会有一个空行也包含回车换行，之后是响应实体，就是要传输的数据。在上面的例子当中就是一个非常简单的HTML页面。对于响应状态码，首部字段键值对稍后会有更加详细的说明。

##HTTP请求方法
请求方法是客户端用来告知服务器其动作意图的方法。就像下达命令一样。在HTTP1.1版本中支持GET、POST等近10种方法。需要注意的是方法名区分大小写，需要用大写字母。下面详细说明。

1.GET：获取资源

　　GET方法用来请求访问已被URI识别的资源。也就是指定了服务器处理请求之后响应的内容。

2.POST：传输实体主体

　　POST方法用来传输实体主体。POST与GET的区别之一就是目的不同，二者之间的区别会在文章的最后详细说明。虽然GET方法也可以传输，但是一般不用，因为GET的目的是获取，POST的目的是传输。

3.PUT：传输文件

　　PUT方法用来传输文件。类似FTP协议，文件内容包含在请求报文的实体中，然后请求保存到URL指定的服务器位置。

4.HEAD：获得报文首部

　　HEAD方法类似GET方法，但是不同的是HEAD方法不要求返回数据。用于确认URI的有效性及资源更新时间等。

5.DELETE：删除文件

　　DELETE方法用来删除文件，是与PUT相反的方法。DELETE是要求返回URL指定的资源。

6.OPTIONS：询问支持的方法

　　因为并不是所有的服务器都支持规定的方法，为了安全有些服务器可能会禁止掉一些方法例如DELETE、PUT等。那么OPTIONS就是用来询问服务器支持的方法。

7.TRACE：追踪路径

　　TRACE方法是让Web服务器将之前的请求通信环回给客户端的方法。这个方法并不常用。

8.CONNECT：要求用隧道协议连接代理

　　CONNECT方法要求在与代理服务器通信时建立隧道，实现用隧道协议进行TCP通信。主要使用SSL/TLS协议对通信内容加密后传输。

汇总：

![汇总](https://images2015.cnblogs.com/blog/735119/201612/735119-20161222203657557-1281147259.png "汇总")

##HTTP的响应状态码
状态码是用来告知客户端服务器端处理请求的结果。凭借状态码用户可以知道服务器是请求处理成功、失败或者是被转发；这样出现了错误也好定位。状态码是由3位数字加原因短语组成。3位数字中的第一位是用来指定状态的类别。共有5种。

![汇总](https://images2015.cnblogs.com/blog/735119/201612/735119-20161223094511729-996071705.png "汇总")

HTTP状态码一共有60多种，但是不用全部都记住，因为大部分在工作当中是不经常使用的。经常使用的大概就是16种，下面来详细介绍。（其实最最常用的也就8种，下面有背景色的就是）

1. 200：OK

　　这个没有什么好说的，是代表请求被正常的处理成功了。

2. 204：No Content

　　请求处理成功，但是没有数据实体返回，也不允许有实体返回。比如说HEAD请求，可能就会返回204 No Content，因为HEAD就是只获取头信息。这里简单提一下205 Reset Content，和204 No Content的区别是不但没有数据实体返回，而且还需要重置表单，方便用户再次输入。

3. 206：Partial Content

　　这是客户端使用Content-Range指定了需要的实体数据的范围，然后服务端处理请求成功之后返回用户需要的这一部分数据而不是全部，执行的请求就是GET。返回码就是206：Partial Content。

4. 301 ： Moved Permanently

　　代表永久性定向。该状态码表示请求的资源已经被分配了新的URL，以后应该使用资源现在指定的URL。也就是说如果已经把资源对应的URL保存为书签了，这是应该按照Location首部字段提示的URL重新保存。

5. 302：Found

　　代表临时重定向。该状态码表示请求的资源已经被分配了新的URL，但是和301的区别是302代表的不是永久性的移动，只是临时的。就是说这个URL还可能会发生改变。如果保存成书签了也不会更新。

6. 303：See Other

　　和302的区别是303明确规定客户端应当使用GET方法。

7. 304：Not Modified

　　该状态码表示客户端发送附带条件请求时，服务器端允许请求访问资源，但是没有满足条件。304状态码返回时不包含任何数据实体。304虽然被划分在3XX中但是和重定向没有关系。

8. 307：Temporary Redirect

　　临时重定向，与302 Found相同，但是302会把POST改成GET，而307就不会。

9.  400：Bad Request

　　400表示请求报文中存在语法错误。需要修改后再次发送。

10. 401：Unauthorized

　　该状态码表示发送的请求需要有通过HTTP认证的认证信息。

11. 403：Forbidden

　　表明请求访问的资源被拒绝了。没有获得服务器的访问权限，IP被禁止等。

12. 404：Not Found

　　表明请求的资源在服务器上找不到。当然也可以在服务器拒绝请求且不想说明理由时使用。

13. 408：Request Timeout

　　表示客户端请求超时，就是在客户端和服务器建立连接后服务器在一定时间内没有收到客户端的请求。

14. 500：Internal Server Error

　　表明服务器端在执行请求时发生了错误，很有可能是服务端程序的Bug或者临时故障。

15. 503：Service Unavailable

　　表明服务器暂时处于超负载或正在进行停机维护，现在无法处理请求。如果事先得知解除以上状况需要的时间，最好写入Retry-After字段再返回给客户端。

16. 504：Getaway Timeout

　　网关超时，是代理服务器等待应用服务器响应时的超时，和408 Request Timeout的却别就是504是服务器的原因而不是客户端的原因

　　更加详细的状态码请参考：http://tool.oschina.net/commons?type=5

##HTTP的首部字段
HTTP首部字段是构成HTTP报文最重要的元素之一。在客户端与服务端之前进行信息传递的时候请求和响应都会使用首部字段，会传递一些重要的元信息。首部字段是以键值对的形式存在的。包含报文的主体大小、语言、认证信息等。HTTP首部字段包含4种类型：

**通用首部字段（General Header Fields）**

　　代表请求报文和响应报文都会使用的字段

**请求首部字段（Request Header Fields）**

　　是客户端向服务端发送请求时使用的首部字段。包含请求的附加内容、客户端信息、响应内容相关优先级等信息。

**响应首部字段（Response Header Fields）**

　　是服务端向客户端返回响应时使用的首部字段，包含响应的附加内容，可能也会要求客户端附加额外的内容信息。

**实体首部字段（Entity Header Fields）**

　　是针对请求报文和响应报文的实体部分使用的首部。包含资源内容更新时间等和实体有关的信息。

在HTTP/1.1种规定了47种首部字段（图表参考《图解HTTP》，感谢作者。）

**通用首部字段**

![通用首部字段](https://images2015.cnblogs.com/blog/735119/201612/735119-20161223145334839-1996412478.png "通用首部字段")

**请求首部字段**
![请求首部字段](https://images2015.cnblogs.com/blog/735119/201612/735119-20161223145540682-785036654.png "请求首部字段")

**响应首部字段**
![响应首部字段](https://images2015.cnblogs.com/blog/735119/201612/735119-20161223150131386-2024915441.png "响应首部字段")

**实体首部字段**
![实体首部字段](https://images2015.cnblogs.com/blog/735119/201612/735119-20161223150312932-2091828241.png "实体首部字段")

**其他首部字段**

 Cookie、Set-Cookie、Content-Disposition、Connection、Keep-Alive、Proxy-Authenticate、Proxy-Authorization、Trailer、TE、Transfer-Encoding、Upgrade etc...

这么多的首部字段，估计如果不是很了解会被吓着，但是根本不用全部记住，其实字段的名字就说明了作用，看一眼就大概知道是干啥的了，只不过有些类似的字段要区分一下就好了。只要深刻理解了HTTP的设计思路就没有大问题了，熟悉常见的就可以了。用到的时候想了解细节再去查。

关于首部字段的细节请参考《图解HTTP》或者《HTTP权威指南》的首部字段部分。够再写一篇长博客的了~

以上就把HTTP协议的重点内容——报文格式、方法、状态码、首部字段介绍完了，可以说对HTTP协议有了一些了解。下面就工作中的常见问题（或者说面试中的）做一个总结。^_^

##关于HTTP的常见问题及解答
*1.GET和POST的区别*

　　A. 从字面意思和HTTP的规范来看，GET用于获取资源信息而POST是用来更新资源信息。

　　B. GET提交请求的数据实体会放在URL的后面，用?来分割，参数用&连接，举个栗子：/index.html?name=wang&login=1

　　C. GET提交的数据长度是有限制的，因为URL长度有限制，具体的长度限制视浏览器而定。而POST没有。

　　D. GET提交的数据不安全，因为参数都会暴露在URL上。

*2.408 Request Timeout和504 Gateway Timeout的区别*

408是说请求超时，就是建立连接之后再约定的时间内客户端没有发送请求到服务端。本质上原因在于客户端或者网络拥塞。

504是网关超时，是说代理服务器把客户端请求转发到应用服务器后再约定的时间内没有收到应用服务器的响应。本质上原因在于服务端的响应过慢，也有可能是网络问题。

3.Cookie和Session的区别和联系

Cookie和Session都是为了保存客户端和服务端之间的交互状态，实现机制不同，各有优缺点。首先一个最大的区别就是Cookie是保存在客户端而Session就保存在服务端的。Cookie是客户端请求服务端时服务器会将一些信息以键值对的形式返回给客户端，保存在浏览器中，交互的时候可以加上这些Cookie值。用Cookie就可以方便的做一些缓存。Cookie的缺点是大小和数量都有限制；Cookie是存在客户端的可能被禁用、删除、篡改，是不安全的；Cookie如果很大，每次要请求都要带上，这样就影响了传输效率。

Session是基于Cookie来实现的，不同的是Session本身存在于服务端，但是每次传输的时候不会传输数据，只是把代表一个客户端的唯一ID（通常是JSESSIONID）写在客户端的Cookie中，这样每次传输这个ID就可以了。Session的优势就是传输数据量小，比较安全。但是Session也有缺点，就是如果Session不做特殊的处理容易失效、过期、丢失或者Session过多导致服务器内存溢出，并且要实现一个稳定可用安全的分布式Session框架也是有一定复杂度的。在实际使用中就要结合Cookie和Session的优缺点针对不同的问题来设计解决方案。

#149.dict to json, obj to json, json to dict, json to obj
在json模块有2个方法，

+ loads()：将json数据转化成dict数据
+ dumps()：将dict数据转化成json数据
+ load()：读取json文件数据，转成dict数据
+ dump()：将dict数据转化成json数据后写入json文件

##dict字典转json数据
```
import json

def dict_to_json():
    dict = {}
    dict['name'] = 'many'
    dict['age'] = 10
    dict['sex'] = 'male'
    print(dict)  # 输出：{'name': 'many', 'age': 10, 'sex': 'male'}
    j = json.dumps(dict)
    print(j)  # 输出：{"name": "many", "age": 10, "sex": "male"}


if __name__ == '__main__':
    dict_to_json()
```

##对象转json数据
```
import json

def obj_to_json():
    stu = Student('007', '007', 28, 'male', '13000000000', '123@qq.com')
    print(type(stu))  # <class 'json_test.student.Student'>
    stu = stu.__dict__  # 将对象转成dict字典
    print(type(stu))  # <class 'dict'>
    print(stu)  # {'id': '007', 'name': '007', 'age': 28, 'sex': 'male', 'phone': '13000000000', 'email': '123@qq.com'}
    j = json.dumps(obj=stu)
    print(j)  # {"id": "007", "name": "007", "age": 28, "sex": "male", "phone": "13000000000", "email": "123@qq.com"}


if __name__ == '__main__':
    obj_to_json()
```

##json数据转成dict字典
```
import json

def json_to_dict():
    j = '{"id": "007", "name": "007", "age": 28, "sex": "male", "phone": "13000000000", "email": "123@qq.com"}'
    dict = json.loads(s=j)
    print(dict)  # {'id': '007', 'name': '007', 'age': 28, 'sex': 'male', 'phone': '13000000000', 'email': '123@qq.com'}


if __name__ == '__main__':
    json_to_dict()
```

##json数据转成对象
```
import json

def json_to_obj():
    j = '{"id": "007", "name": "007", "age": 28, "sex": "male", "phone": "13000000000", "email": "123@qq.com"}'
    dict = json.loads(s=j)
    stu = Student()
    stu.__dict__ = dict
    print('id: ' + stu.id + ' name: ' + stu.name + ' age: ' + str(stu.age) + ' sex: ' + str(
        stu.sex) + ' phone: ' + stu.phone + ' email: ' + stu.email)  # id: 007 name: 007 age: 28 sex: male phone: 13000000000 email: 123@qq.com


if __name__ == '__main__':
    json_to_obj()
```

##json的load()与dump()方法的使用
###dump()方法的使用
```

import json

def dict_to_json_write_file():
    dict = {}
    dict['name'] = 'many'
    dict['age'] = 10
    dict['sex'] = 'male'
    print(dict)  # {'name': 'many', 'age': 10, 'sex': 'male'}
    with open('1.json', 'w') as f:
        json.dump(dict, f)  # 会在目录下生成一个1.json的文件，文件内容是dict数据转成的json数据


if __name__ == '__main__':
    dict_to_json_write_file()
```

###load()的使用
```
import json

def json_file_to_dict():
    with open('1.json', 'r') as f:
        dict = json.load(fp=f)
        print(dict)  # {'name': 'many', 'age': 10, 'sex': 'male'}


if __name__ == '__main__':
    json_file_to_dict()
```

150. Django vs Flask vs Tornado

>1. Django：Python 界最全能的 web 开发框架，battery-include 各种功能完备，可维护性和开发速度一级棒。常有人说 Django 慢，其实主要慢在 Django ORM 与数据库的交互上，所以是否选用 Django，取决于项目对数据库交互的要求以及各种优化。而对于 Django 的同步特性导致吞吐量小的问题，其实可以通过 Celery 等解决，倒不是一个根本问题。Django 的项目代表：Instagram，Guardian。

>2. Tornado：天生异步，性能强悍是 Tornado 的名片，然而 Tornado 相比 Django 是较为原始的框架，诸多内容需要自己去处理。当然，随着项目越来越大，框架能够提供的功能占比越来越小，更多的内容需要团队自己去实现，而大项目往往需要性能的保证，这时候 Tornado 就是比较好的选择。Tornado项目代表：知乎。

>3. Flask：微框架的典范，号称 Python 代码写得最好的项目之一。Flask 的灵活性，也是双刃剑：能用好 Flask 的，可以做成 Pinterest，用不好就是灾难（显然对任何框架都是这样）。Flask 虽然是微框架，但是也可以做成规模化的 Flask。加上 Flask 可以自由选择自己的数据库交互组件（通常是 Flask-SQLAlchemy），而且加上 celery +redis 等异步特性以后，Flask 的性能相对 Tornado 也不逞多让，也许Flask 的灵活性可能是某些团队更需要的。

    Tornado 的好成绩得益于其自带的异步特性，而 Django 与 Flask 是同步框架，在处理请求时性能受限。但是实际使用中，一般是 Django/Flask + Celery + Redis/Memchaned/RabbitMQ 的模式，由此带上了异步处理的能力。

151. 什么是闭包函数？

>成为闭包函数必须满足两个条件：
1. 函数内部定义自己的函数；
2. 包含对外部变量（作用域）而非全局变量（作用域）的引用

>闭包函数的特性：
1. 自带作用域
2. 延迟计算
```
eg1:
def outer():
    x = 100
    y = 200
    def inner():
        print('exec inner', 'x=%s, y=%s' % (x, y))

    print('exec outer')
    print(inner.__closure__)
    return inner  # 返回内部函数名

outer()

eg2:
from urllib.request import urlopen
def fetch(url):
    def get():
        return urlopen(url).read()
    return get

baidu = fetch("http://www.baidu.com") # 返回的是get函数的地址
print(baidu()) # 执行get函数《并且将返回的结果打印出来
```

152. 装饰器？
装饰器的本质是一个闭包函数,他的作用就是让其他函数在不需要做任何代码修改的前提下增加额外功能,装饰器的返回值也是一个函数对象

通常在一些有切面需求的场景,比如:插入日志,性能测试,事务处理,缓存,权限校验等场景,有了装饰器我们就可以少写很多重复代码,提高工作效率.

装饰器：外部函数传入被装饰函数名，内部函数返回装饰函数名
特性：
1. 不修改被装饰函数的调用方式
2. 不修改被装饰函数的源代码

a. 无参装饰器
```
源代码函数：
import time, random
def index():
    time.sleep(random.randrange(1, 5))
    print('welcome to index page')


```
>有如下实例，我们需要计算一下上述代码执行的时间
使用装饰器
```
def outer(func):   # 将index的地址传递给func
    def inner():
        start_time = time.time()
        func() # fun = index  即func保存了外部index函数的地址
        end_time = time.time()
        print("运行时间为%s"%(end_time - start_time))

    return inner  # 返回inner的地址


index = outer(index) # 这里返回的是inner的地址，并重新赋值给index
index()
```
b. 有参装饰器
```
# 被装饰的函数无返回值
import time, random
def outer(func): # 将index的地址传递给func
    def inner(*args, **kwargs):
        start_time = time.time()
        func(*args, **kwargs) # fun = index  即func保存了外部index函数的地址
        end_time = time.time()
        print("运行时间为%s" % (end_time - start_time))

    return inner # 返回inner的地址

def index():
    time.sleep(random.randrange(1, 5))
    print('welcome to index page')
```

```
# 被装饰的函数有返回值
import time, random
def timmer(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        res = func(*args, **kwargs) # fun = index  即func保存了外部index函数的地址
        stop_time = time.time()
        print("运行时间为%s" % (stop_time - start_time))
        return res
    return wrapper

def home(name):
    time.sleep(random.randrange(1, 5))
    print('welcome to %s page' % name)
    return 123123123213123

my_res = timmer(home)
```
home = timmer(home)  # 等式右边返回的是wrapper的内存地址,再将其赋值给home，这里的home不在是原来的的那个函数,而是被装饰以后的函数了。
像home = timmer(home)这样的写法,python给我们提供了一个便捷的方式------语法糖@
以后我们在被装饰的函数之前写上@timmer,它的效果就和home = timmer(home)是一样的。

如果一个函数被多个装饰器装饰,那么执行顺序是怎样的。
```
import time, random

def timmer(func):
    def wrapper():
        start_time = time.time()
        func()
        end_time = time.time()
        print('run time is %s' %(end_time-start_time))

    return wrapper

def auth(func):
    def validate():
        name = input('name:')
        password = input('password:')
        if name == 'root' and password == '123':
            print('login successful')
            func()
        else:
            print('login fail')
    return validate

@auth       # index = auth(timmer(index)) 
@timmer     # index = timmer(index)
def index():
    time.sleep(3)
    print('welcome to index page')

index()
```
##### 实验结果表明,多个装饰器装饰一个函数,其执行顺序是从下往上

关于装饰器的一些高级用法
c. 类装饰器
类装饰器不仅可以是函数，还可以是类，相比函数装饰器，类装饰器具有灵活度大，高内聚，封装性等优点，使用类装饰器主要依靠类的__call__方法，当使用 @ 形式将装饰器附加到函数上时，就会调用此方法

```
class Foo(object):
    def __init__(self, func):
        self.func = func

    def __call__(self):
        print('class decorator runing')
        self._func()
        print('class decorator ending')

@Foo        # bar = Foo(test)
def test():
    print('test')

test()  # Foo(test)()

# 结果
# class decorator runing
# test
# class decorator ending
```

```
class Foo(object):
    def __init__(self):
        pass
    def __call__(self, func):
        def _call(*args, **kwargs):
            print('class decorator runing')
            return func(*args, **kwargs)
        return _call

class Test(object):
    @Foo()
    def test(self, name, ids):  # bar = Foo()(bar)
        print('test')

Test().test('aa', 'ids')
```

153. 迭代器
迭代器是一中访问可迭代对象的方式,通常从第一个元素开始访问,知道所有的元素都被访问完才结束,迭代器只能前进不能后退,使用迭代器可以不用事先准备好带跌过程中的所有元素,仅仅是在迭代到该元素的时候才计算该元素,而在这之前的元素则是被销毁,因此迭代器适合遍历一些数据量巨大的无限的序列.迭代器的本质就是调用__iter__方法,每次调用的时候返回一个元素,当没有下一个元素的时候会抛出StopIteration异常

154. python适合的场景有哪些？当遇到计算密集型任务怎么办？
适用场景:网站运维,金融分析,服务器编写,爬虫

当遇到io密集型任务时,涉及到的大多是网络,磁盘等任务,这一类任务的特性是cpu消耗低,使用多线程.

计算密集型的任务主要是消耗cpu性能,谁要运用多进程,当然运用python语言的运行效率很低,所以一般对于计算密集型任务,可以使用c语言编写

155. 谈谈mysql字符集和排序规则
字符集，即用于定义字符在数据库中的编码的集合。 常见的字符集：utf-8 gbk 等
排序规则，就是指字符比较时是否区分大小写，以及是按照字符编码进行比较还是直接用二进制数据比较。

156. 说一下线程、进程、协程？
进程是具有一定独立功能的程序关于某个数据集合上的一 次运行活动,进程是系统进行资源分配和调度的一个独立单位。每个进程都有自己的独立内存空间，不同进程通过进程间通信来通信。由于进程比较重量，占据独立的内存，所以上下文进程间的切换开销(栈、寄存器、虚拟内存、文件句柄等)比较大，但相对比较稳定安全

线程是进程的一个实体,是 CPU 调度和分派的基本单位, 它是比进程更小的能独立运行的基本单位.线程自己基本上不拥有系统资源,只拥有一点在运行中必不可少的资源(如程序计数器,一组寄存器和栈),但是它可与同属一个进程的其他的线程共享进程所拥有的全部资源。线程间通信主要通过共享内存， 上下文切换很快，资源开销较少，但相比进程不够稳定容易丢失数据。

协程是一种用户态的轻量级线程，协程的调度完全由用户控制。协程拥有自己的寄存器上下文和栈。协程调度切换时,将寄存器上下文和栈保存到其他地方，在切回来的时候，恢复先前保存的寄存器上下文和栈，直接操作栈则基本没有内核切换的开销，可以不加锁的访问全局变量，所以上下文的切换非常快。

最好说一下在项目中如何使用，举个例子




157. 如何解决线程安全？
线程安全是在多线程的环境下，能够保证多个线程同时执行时程序依旧运行正确, 而且要保证对于共享的数据可以由多个线程存取，但是同一时刻只能有一个线程进行存取。多线程环境下解决资源竞争问题的办法是加锁来保证存取操作的唯一性。如何加锁？ 分布式 负载均衡

158. 常用的linux命令
ls,cd,more,clear,mkdir,pwd,rm,grep,find,mv,su,date等等

159. 什么是面向对象编程?
答技巧:说一下什么事面向对象编程，再说说为什么要面向对象编程，面向对象特性。
回答：
面向对象编程是一种解决软件复用的设计和编程方法。 这种方法把软件系统中相近相似的操作逻辑和操作应用数据、状态,以类的型式 述出来,以对象实例的形式在软件系统中复用,以达到高软件开发效率的作用。封装,继承多态.

160. 如何提高 Python 的运行效率，请说出不少于 2 种提高运行效率的方法？
1. 使用生成器
2. 关键代码使用外部功能包:Cython、Pylnlne、PyPy、Pyrex
3. 针对循环的优化——尽量避免在循环中访问变量的属性;

161. 说一下 MySQL 数据库存储的原理?
回答技巧:先回答一下mysql的原理，拓展一下它的有点，或者mysql你是怎么用的？

MySQL的优点：
1． 它使用的核心线程是完全多线程，支持多处理器。
2． 有多种列类型：1、2、3、4、和8字节长度自有符号／无符号整数、FLOAT、DOUBLE、CHAR、VARCHAR、TEXT、BLOB、DATE、TIME、DATETIME、 TIMESTAMP、YEAR、和ENUM类型。 
3． 它通过一个高度优化的类库实现SQL函数库并像他们能达到的一样快速，通常在查询初始化后不该有任何内存分配。没有内存漏洞。 
4． 全面支持SQL的GROUP BY和ORDER BY子句，支持聚合函数(COUNT()、COUNT(DISTINCT)、AVG()、STD()、SUM()、MAX()和MIN())。你可以在同一查询中混来自不同数据库的表。 
5． 支持ANSI SQL的LEFT 0UTER JOIN和ODBC。 
6． 所有列都有缺省值。你可以用INSERT插入一个表列的子集，那些没用明确给定值的列设置为他们的决省值。 
7． MySQL可以工作在不同的平台上。支持C、C＋＋、Java、Perl、PHP、Python和TCL API。 

MySQL的缺点： 
1、 MySQL最大的缺点是其安全系统，主要是复杂而非标准，另外只有到调用mysqladmin来重读用户权限时才发生改变。 
2、 MySQL的另一个主要的缺陷之一是缺乏标准的RI（Referential Integrity-RI）机制；Rl限制的缺乏(在给定字段域上的一种固定的范围限制)可以通过大量的数据类型来补偿。 
3、 MySQL没有一种存储过程(Stored Procedure)语言，这是对习惯于企业级数据库的程序员的最大限制。 
4、 MySQL不支持热备份。 
5、 MySQL的价格随平台和安装方式变化。

回答：储存过程是一个可编程的函数，它在数据库中创建并保存。它可以有 SQL 语句和一些特殊的控制结构组成。当希望在不同的应用程序或平台上执行相同的函数，或者封装特定功能时，存储过程是非常有用的。数据库中的存储过程可以看做是对编程中面向对象方法的模拟。它允许控制数据的访问方式。 

存储过程通常有以下优点:
1)存储过程能实现较快的执行速度。
2)存储过程允许标准组件是编程。
3)存储过程可以用流控制语句编写，有很强的灵活性，可以完成复杂的判断和较复杂的运算。
4)存储过程可被作为一种安全机制来充分利用。
5)存储过程能过减少网络流量

162. 你工作中遇到哪些bug,怎么解决的?
回答技巧:不要聊一些小bug，聊一些印象深刻。或者可以把这道题转化成你遇到什么困难
回答:
1.刚入行的时候，对业务不太熟悉，加上给的业务文档不清晰，导致加班很多。或者第一次代码合并，python版本更新带来问题等等
2.项目中第一次做登录模块/支付模块，不太熟悉，吃了很多苦头
3.平时敲代码中积累的bug

163. 说一下事务的特性？
1．原子性(Atomicity):事务中的全部操作在数据库中是不可分割的，要么全部完成，要么均不执行。
2．一致性(Consistency):几个并行执行的事务，其执行结果必须与按某一顺序串行执行的结果相一致。
3．隔离性(Isolation):事务的执行不受其他事务的干扰，事务执行的中间结果对其他事务必须是透明的。
4. 持久性(Durability):对于任意已交事务，系统必须保证该事务对数据库的改变不被丢失，即使数据库出

164. redis 和 mysql 的区别？
回答技巧:回答题目有什么区别，然后其中一个举例子，你是如何使用？
回答:
redis 是内存数据库，数据保存在内存中，速度快。
mysql 是关系型数据库，持久化存储，存放在磁盘里面， 功能强大。检索的话，会涉及到一定的 IO，数据访问也就慢。
我比较常用是mysql，主要创建数据库，创建表，数据操作，增删改查，我做的比较多是查，例如在xxx项目中，有个搜索模块，当时我做比较简单就是用模糊匹配去做搜索。

165. redis 受攻击怎么办?
回答：
在工作防止redis受攻击，我都会做一下措施：
1.主从
2.持久化存储Redis 不以 root 账户启动
3.设置复杂密码
4.不允许 key 方式登录

166. 说一下mongoDB你是如何使用？
回答技巧:回答mongoDB什么,优缺点，平时怎么用的？
MongoDB是一个面向文档的数据库系统。使用C++编写，不 支持 SQL，但有自己功能强大的查询语法。
MongoDB 使用 BSON 作为数据存储和传输的格式。BSON 是 一种类似 JSON 的、二进制序列化文档，支持嵌套对象和数组。
MongoDB 很像 MySQL，document 对应 MySQL 的 row， collection 对应- MySQL 的 table
缺点:不支持事务，MongoDB 占用空间过大，维护工具不够成熟
应用场景:
1.网站数据:mongo 非常适合实时的插入，更新与查询， 并具备网站实时数据存储所需的复制及高度伸缩性。
2.缓存:由于性能很高，mongo 也适合作为信息基础设 施的缓存层。在系统重启之后，由 mongo 搭建的持久化缓存可 以避免下层的数据源过载。
3.大尺寸、低价值的数据:使用传统的关系数据库存储 一些数据时可能会比较贵，在此之前，很多程序员往往会选择 传统的文件进行存储。
4.高伸缩性的场景:mongo 非常适合由数十或者数百台 服务器组成的数据库。
5.用于对象及 JSON 数据的存储:mongo 的 BSON 数据格 式非常适合文档格式化的存储及查询。
6.重要数据:mysql，一般数据:mongodb，临时数据: memcache

167. Redis与mongodb的优缺点？
回答技巧:先说一下两者区别，再说它们优缺点
回答: MongoDB 和 Redis 都是 NoSQL，采用结构型数据存储。二者在使用场景中，存在一定的区别，这也主要由于二者在内存映射的处理过程，持久化的处理方法不同。MongoDB 建议集群部署，更多的考虑到集群方案，Redis 更偏重于进程顺序写入， 虽然支持集群，也仅限于主-从模式.
Redis 优点:
1 读写性能优异
2 支持数据持久化，支持 AOF 和 RDB 两种持久化方式
3 支持主从复制，主机会自动将数据同步到从机，可以进 行读写分离。
4 数据结构丰富:除了支持 string 类型的 value 外还支 持 string、hash、set、sortedset、list 等数据结构。
缺点:
1 Redis 不具备自动容错和恢复功能，主机从机的宕机都 会导致前端部分读写请求失败，需要等待机器重启或者手动切 换前端的 IP 才能恢复。
2 主机宕机，宕机前有部分数据未能及时同步到从机，切 换 IP 后还会引入数据不一致的问题，降低了系统的可用性。
Redis 较难支持在线扩容，在集群容量达到上限时在线 扩容会变得很复杂。为避免这一问题，运维人员在系统上线时 必须确保有足够的空间，这对资源造成了很大的浪费.避免这一问题，运维人员在系统上线时 必须确保有足够的空间，这对资源造成了很大的浪费。
mongodb的优缺点：
优点:弱一致性(最终一致)，更能保证用户的访问速度 文档结构的存储方式，能够更便捷的获取数 频)
内置 GridFS，高效存储二进制大对象 (比如照片和视
支持复制集、主备、互为主备、自动分片等特性 动态查询 全索引支持,扩展到内部对象和内嵌数组
缺点:不支持事务MongoDB 占用空间过大，维护工具不够成熟

168. 数据库怎么优化查询效率？
回答技巧:有条理按照题目回答即可
回答：
1.储存引擎选择:如果数据表需要事务处理，应该考虑使用 InnoDB，因为它完全符合ACID 特性。如果不需要事务处理，使用默认存储引擎MyISAM 是比较明智的
2.分表分库，主从
3.对查询进行优化，要尽量避免全表扫 ，首先应考虑在 where 及 order by 涉及的列上建立索引
4.应尽量避免在 where 子句中对字段进行 null 值判断， 否则将导致引擎放弃使用索引而进行全表扫
5.应尽量避免在 where 子句中使用 != 或 <> 操作符， 否则将引擎放弃使用索引而进行全表扫
6.应尽量避免在 where 子句中使用 or 来连接条件，如果 一个字段有索引，一个字段没有索引，将导致引擎放弃使用索 引而进行全表扫
7.Update语句，如果只更改1、2 个字段，不要Update全部字段，否则频繁调用会引起明显的性能消耗，同时带来大 量日志

169. 数据库优化方案？
回答技巧:如题回答即可
1.优化索引、SQL 语句、分析慢查询;
2.设计表的时候严格根据数据库的设计范式来设计数据库;
3.使用缓存，把经常访问到的数据而且不需要经常变化的 数据放在缓存中，能节约磁盘 IO;
4.优化硬件;采用 SSD，使用磁盘队列技术 (RAID0,RAID1,RDID5)等;
5.采用 MySQL 内部自带的表分区技术，把数据分层不同 的文件，能够 高磁
盘的读取效率;
6.垂直分表;把一些不经常读的数据放在一张表里，节约 磁盘 I/O;
7.主从分离读写;采用主从复制把数据库的读操作和写入 操作分离开来;
8.分库分表分机器(数据量特别大)，主要的的原理就是数据路由;
9.选择合适的表引擎，参数上的优化;
10.进行架构级别的缓存，静态化和分布式;
11.不采用全文索引;
12.采用更快的存储方式，例如 NoSQL 存储经常访问的数

170. redis 基本类型、相关方法？
回答技巧:先回答问题所问的，找其中一个说明一下如何使用，在拓展一下redis如何使用的
回答: Redis支持五种数据类型:string(字符串)、hash(哈希)、list(列表)、set (集合)及zset(sorted set:有序集合)。
String是Redis最为常用的一种数据类型，String的数据结构为key/value类型，String 可以包含任何数据。常用命令: set,get,decr,incr,mget 等

171. redis 的使用场景有哪些?
回答技巧:优点， 如题回答即可
回答：
-1.取最新 N 个数据的操作
-2.排行榜应用,取 TOP N 操作
-3.需要精准设定过期时间的应用
-4.计数器应用
-5.uniq 操作,获取某段时间所有数据排重值
-6.Pub/Sub 构建实时消息系统
-7.构建队列系统
-8.缓存

172. 说一下冒泡排序？
回答技巧:回答冒泡原理，最好能手写，拓展一下其他排序？
冒泡排序的思想: 每次比较两个相邻的元素, 如果他们的顺序错误就把他们交换位置。
def bubble_improve(l): print l
flag = 1
for index in range(len(l) - 1, 0 , -1):
if flag:
flag = 0 for two_index in range(index):
if l[two_index] > l[two_index + 1]:
l[two_index], l[two_index + 1] = l[two_index + 1], l[two_index]
flag = 1
else: break
print ll = [10, 20, 40, 50, 30, 60] bubble_improve(l)

173. 说一下 Django，MIDDLEWARES 中间件的作用?
回答技巧:如题回答即可。
回答: 中间件是介于 request 与 response 处理之间的一道 处理过程，相对比较轻量级，并且在全局上改变 django 的输入与输出。

174. 说一下mvvm ?
回答技巧:说一下MVVM，然后拓展回熟悉的MVT？
MVVM:将“数据模型数据双向绑定”的思想作为核心，在 View 和 Model 之间没有联系，通过 ViewModel进行交互，而且 Model 和 ViewModel之间的交互是双向的，因此视图的数据的变化会同时修改数据源，而数据源数据的变化也会立即反应到View上。

175. 你对 Django 的认识？
回答技巧:说一下Django是什么，然后说一下它的优缺点，再说说项目怎么用？
回答: Django 是走大而全的方向，它最出名的是其全自动化的管理后台:只需要使用起 ORM，做简单的对象定义，它就能自动生成数据库结构、以及全功能的管理后台。
优点：
超高的开发效率。
适用的是中小型的网站，或者是作为大型网站快速，实现产品雏形的工具。
彻底的将代码、样式分离; Django 从根本上杜绝在模板中进行编码、处理数据的可能。
缺点：
其性能扩展有限;
采用Django的项目，在流量达到一定规模后，都需要对其进行重构，才能满足性能的要求。
Django 内置的 ORM 跟框架内的其他模块耦合程度高。

176. 说一下Jieba 分词？
回答技巧:jieba分词有哪些，作用是什么？
回答：
Jieba 分词支持三种分词模式:
精确模式：试图将句子最精确地切开，适合文本分析;
全局模式：把句子中所有的可以成词的词语都扫出来, 速度非常快，但是不能解决歧义;
搜索引擎模式：在精确模式的基础上，对长词再次切分，高召回率，适合用于搜索引擎分词
功能:
分词，添加自定义词典，关键词取，词性标注，并行分词，Tokenize:返回词语在原文的起始位置，ChineseAnalyzer for Whoosh 搜索引擎

177. Django 重定向你是如何实现的?用的什么状态码?
回答技巧:如题回答即可
使用 HttpResponseRedirect>redirect>和>reverse ，状态码:302,301

178. 爬取下来的数据如何去重，说一下具体的算法依据?
回答技巧:如题回答即可
答:
1.通过 MD5 生成电子指纹来判断页面是否改变
2.nutch 去重。nutch 中 digest 是对采集的每一个网页内 容的 32 位哈希值，如果两个网页内容完全一样，它们的 digest 值肯定会一样。

179. 写爬虫是用多进程好?还是多线程好? 为什么?
回答技巧:就是对比多线程与多进程爬虫的优缺点
回答：IO 密集型代码(文件处理、网络爬虫等)，多线程能够有效升效率(单线程下有 IO 操作会进行 IO 等待，造成不必要的时间浪费，而开启多线程能在线程 A 等待时，自动切换到线程B可以不浪费CPU的资源，从而能升程序执行效率)。在实际的数据采集过程中，既考虑网速和响应的问题，也需要考虑自身机器的硬件情况，来设置多进程或多线程。

180. 说一下 numpy 和 pandas 的区别?分别的应用场景?
回答技巧:如题回答就好
Numpy 是数值计算的扩展包，纯数学。
ePandas做数据处理以矩阵为基础的数学计算模块。供了一套名为 DataFrame 的数据结构，比较契合统计分析中的表结构，并且供了计算接口，可用Numpy 或其它方式进行计算。

181. 验证码如何处理？
回答技巧:如题回答
1．Scrapy 自带处理验证码
2．获取到验证码图片的url，调用第三方付费借口破解验证码

182. 动态的股票信息如何抓取？
回答技巧:先说一下抓取方法，然后举个例子
股票数据的获取目前有如下两种方法可以获取:
1.http/JavaScript 接口取数据
2.web-service 接口
Sina 股票数据接口
以大秦铁路(股票代码:601006)为例，如果要获取它的 最新行情，只需访问新浪的股票数据
接口:http://hq.sinajs.cn/list=sh601006 这个 url 会返回一串文本，例如 var hq_str_sh601006="大秦铁路, 27.55, 27.25, 26.91, 27.55, 26.20, 26.91, 26.92, 22114263, 589824680, 4695, 26.91, 57590, 26.90, 14700, 26.89, 14300,
26.88, 15100, 26.87, 3100, 26.92, 8900, 26.93, 14230, 26.94, 25150, 26.95, 15220, 26.96, 2008-01-11, 15:05:32";

183. scrapy 去重？
回答技巧:从各个方面有条理去回答
数据量不大时，可以直接放在内存里面进行去重，python 可以使用 set()进行去重。
当去重数据需要持久化时可以使用 redis 的 set 数据结构。
当数据量再大一点时，可以用不同的加密算法先将长字符 串压缩成 16/32/40 个字符，再使用上面两种方法去重;
当数据量达到亿(甚至十亿、百亿)数量级时，内存有限， 必须用“位”来去重，才能够满足需求。Bloomfilter 就是将 去重对象映射到几个内存“位”，通过几个位的 0/1 值来判断一个对象是否已经存在。 然而 Bloomfilter 运行在一台机器的内存上，不方便持久化(机器 down 掉就什么都没啦)，也不方便分布式爬虫的统一去重。如果可以在 Redis 上申请内存进行 Bloomfilter，以上两个问题就都能解决了。
simhash 最牛逼的一点就是将一个文档，最后转换成一个 64 位的字节，暂且称之为特征字，然后判断重复只需要判断他们的特征字的距离是不是小于n(根据经验这个 n 一般取值为3)，就可以判断两个文档是否相似。

184. 分布式有哪些方案，哪一种最好?
回答技巧:先说一下有什么方案，分析哪一个好？
celery、beanstalk，gearman个人认为 gearman 比较好。
原因主要有以下几点:
1).技术类型简单，维护成本低。
2).简单至上。能满足当前的技术需求即可 (分布式任务处理、异步同步任务同时支持、任务队列的持久化、维护部署简单)。
3).有成熟的使用案例。instagram 就是使用的 gearman 来完成图片的处理的相关任务，有成功的经验，我们当然应该借鉴。

185. Post 和 get 区别？
回答技巧:有条理从各方面去回答即可
1、GET请求，请求的数据会附加在URL之后，以分割 URL 和传输数据，多个参数用&连接。URL的编码格式采用的是 ASCII 编码，而不是 uniclde，即是说所有的非ASCII字符都要编码之后再传输。
POST 请求:POST请求会把请求的数据放置在HTTP请求包的包体中。上面的 item=bandsaw 就是实际的传输数据。因此，GET 请求的数据会暴露在地址栏中，而 POST 请求则不会。
2、传输数据的大小
在HTTP规范中，没有对 URL 的长度和传输的数据大小进行限制。但是在实际开发过程中，对于 GET，特定的浏览器和服务器对 URL 的长度有限制。因此，在使用GET请求时，传输数据会受到URL长度的限制。

186. 谈一谈你对 Selenium 和 PhantomJS 了解？
回答技巧：如何回答即可
Selenium 是一个 Web 的自动化测试工具，可以根据我们的指令，让 浏览器自动加载页面，获取需要的数据，甚至页面截屏，或者判断网 站上某些动作是否发生。Selenium 自己不带浏览器，不支持浏览器 的功能，它需要与第三方浏览器结合在一起才能使用。但是我们有时 候需要让它内嵌在代码中运行，所以我们可以用一个叫 PhantomJS 的工具代替真实的浏览器。Selenium 库里有个叫 WebDriver 的 API。 WebDriver 有点儿像可以加载网站的浏览器，但是它也可以像 BeautifulSoup 或者其他 Selector 对象一样用来查找页面元素，与 页面上的元素进行交互 (发送文本、点击等)，以及执行其他动作来 运行网络爬虫。
PhantomJS 是一个基于Webkit的“无界面”(headless)浏览器， 它会把网站加载到内存并执行页面上的 JavaScript，因为不会展示 图形界面，所以运行起来比完整的浏览器要高效。
如果我们把 Selenium 和 PhantomJS 结合在一起，就可以运行一 个非常强大的网络爬虫了，这个爬虫可以处理 JavaScrip、Cookie、 headers，以及任何我们真实用户需要做的事情。

187. 常用的反爬虫措施?
回答技巧: 有条理从各方面去回答即可
回答: 1.添加代理 2.降低访问频率 3.User-Agent4. 动态 HTML 数据加载 5. 验证码处理6. Cookie

188. 常见的反爬虫的应对方法?
回答技巧:有条理从各方面去回答即可
1).通过 Headers 反爬虫，从用户请求的 Headers 反爬虫是最常见的反爬虫策略。很多网站都 会对 Headers 的 User-Agent 进行检测，还有一部分网站会对 Referer 进行检测(一些资源网站的防盗链就是检测 Referer)。如果遇到了 这类反爬虫机制，可以直接在爬虫中添加 Headers，将浏览器的 User-Agent 复制到爬虫的 Headers 中;或者将 Referer 值修改为目 标网站域名。对于检测 Headers 的反爬虫，在爬虫中修改或者添加 Headers 就能很好的绕过。
2).基于用户行为反爬虫
还有一部分网站是通过检测用户行为，例如同一IP 短时间内多次访问同一页面，或者同一账户短时间内多次进行相同操作。 大多数网站都是前一种情况，对于这种情况，使用 IP 代理就可以 解决。可以专门写一个爬虫，爬取网上公开的代理 ip，检测后全部 保存起来。这样的代理 ip 爬虫经常会用到，最好自己准备一个。有 了大量代理 ip 后可以每请求几次更换一个 ip，这在 requests或者 urllib2 中很容易做到，这样就能很容易的绕过第一种反爬虫。
对于第二种情况，可以在每次请求后随机间隔几秒再进行下一次请 求。有些有逻辑漏洞的网站，可以通过请求几次，退出登录，重新登 录，继续请求来绕过同一账号短时间内不能多次进行相同请求的限制。
3).动态页面的反爬虫
上述的几种情况大多都是出现在静态页面，还有一部分网站，我们 需要爬取的数据是通过 ajax 请求得到，或者通过 JavaScript 生成的。 首先用 Fiddler 对网络请求进行分析。如果能够找到 ajax 请求，也 能分析出具体的参数和响应的具体含义，我们就能采用上面的方法，直接利用 requests 或者 urllib2 模拟 ajax 请求，对响应的 json 进 行分析得到需要的数据。
能够直接模拟 ajax 请求获取数据固然是极好的，但是有些网站把 ajax 请求的所有参数全部加密了。我们根本没办法构造自己所需要 的数据的请求。这种情况下就用 selenium+phantomJS，调用浏览器 内核，并利用 phantomJS 执行 js 来模拟人为操作以及触发页面中的 js 脚本。从填写表单到点击按钮再到滚动页面，全部都可以模拟， 不考虑具体的请求和响应过程，只是完完整整的把人浏览页面获取数 据的过程模拟一遍。
用这套框架几乎能绕过大多数的反爬虫，因为它不是在伪装成浏览 器来获取数据(上述的通过添加 Headers 一定程度上就是为了伪装 成浏览器)，它本身就是浏览器，phantomJS 就是一个没有界面的浏览器，只是操控这个浏览器的不是人。利selenium+phantomJS 能干很多事情，例如识别点触




189. 

#200.结束语
https://blog.csdn.net/weixin_41666747/article/details/79942847
***
https://www.cnblogs.com/shengyang17/p/9240907.html