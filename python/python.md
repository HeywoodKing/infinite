#1. Python 的特点和优点是什么?
Python具备以下特质：
>1. 解释性
>2. 动态特性
>3. 面向对象
>4. 语法简洁
>5. 开源
>6. 丰富的社区资源

#2. 深拷贝和浅拷贝的区别是什么？
深拷贝是将对象本身复制给另一个对象。这意味着如果对对象的副本进行更改时不会影响原对象。在 Python 中，我们使用 deepcopy（）函数进行深拷贝，使用方法如下：
```
import copy
l = [1, 2, 3, "ok"]
c = copy.deepcopy(l)

l = [1, 2, 3, "ok"]
c = l.copy()
```

浅拷贝是将对象的引用复制给另一个对象。因此，如果我们在副本中进行更改，则会影响原对象。使用 copy（）函数进行浅拷贝，使用方法如下
```
import copy
l = [1, 2, 3, "ok"]
c = copy.copy(l)

c = l.copy()
```
#3.列表和元组有什么不同？
主要区别在于列表是可变的，元组是不可变的。

#4.解释 Python 中的三元表达式
与 C++不同, 在 Python 中我们不需要使用 ? 符号，而是使用如下语法：
`[on true] if [expression] else [on false]`

eg:如果 [expression] 为真, 则 [on true] 部分被执行。如果表示为假则 [on false] 部分被执行

#5.Python 中如何实现多线程？
线程是轻量级的进程，多线程允许一次执行多个线程。众所周知，Python是一种多线程语言，它有一个多线程包。

GIL（全局解释器锁）确保一次执行单个线程。一个线程保存 GIL 并将其传递给下一个线程之前执行一些操作，这就产生了并行执行的错觉。但实际上，只是线程轮流在 CPU 上。当然，所有传递都会增加执行的开销。

#6.解释继承
一个类继承自另一个类，也可以说是一个孩子类/派生类/子类，继承自父类/基类/超类，同时获取所有的类成员（属性和方法）。

继承使我们可以重用代码，并且还可以更方便地创建和维护代码。Python 支持以下类型的继承：
>1. 单继承- 一个子类继承自单个基类
>2. 多重继承- 一个子类继承自多个基类
>3. 多级继承- 一个子类继承自一个基类，而基类继承自另一个基类
>4. 分层继承- 多个子类继承自同一个基类
>5. 混合继承- 两种或两种以上继承类型的组合

#7.什么是 Flask？
Flask 是一个使用 Python 编写的轻量级 Web 应用框架，使用 BSD 授权。其 WSGI 工具箱采用 Werkzeug，模板引擎则使用 Jinja2。除了 Werkzeug 和 Jinja2 以外几乎不依赖任何外部库。因为 Flask 被称为轻量级框架。Flask 的会话会话使用签名 cookie 来允许用户查看和修改会话内容。它会记录从一个请求到另一个请求的信息。但如果要修改会话，则必须有密钥 Flask.secret_key。

#8.如何在 Python 中管理内存?
Python 用一个私有堆内存空间来放置所有对象和数据结构，我们无法访问它。由解释器来管理它。不过使用一些核心 API，我们可以访问一些 Python 内存管理工具控制内存分配。

#9.解释 Python 中的 help() 函数和 dir() 函数。
help() 函数返回帮助文档和参数说明：

运行结果如下:

Help on function copy in module copy

copy(x)

Shallow copy operation on arbitrary Python objects.

See the module』s __doc__ string for more info.

dir() 函数返回对象中的所有成员 (任何类型)

#10.当退出 Python 时是否释放所有内存分配？
答案是否定的。那些具有对象循环引用或者全局命名空间引用的变量，在 Python 退出是往往不会被释放,另外不会释放 C 库保留的部分内容。

#11.什么是猴子补丁？
---
在运行时动态修改类和模块

![图片](https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=702257389,1274025419&fm=27&gp=0.jpg "猴子补丁")

[百度](https://www.baidu.com "百家号")
[AForge](https://www.aforge.cn "AForge")

Hi, monkey

#12.什么是 Python 字典？
它拥有键-值对

字典是可变的，我们也可以用推导式的方式创建它
`{25: 5, 16: 4, 9: 3, 4: 2, 1: 1}`

#13.能否解释一下\*args 和 **kwargs?
1. 如果我们不知道将多少个参数传递给函数，比如当我们想传递一个列表或一个元组值时，就可以使用*args
2. 当我们不知道将会传入多少关键字参数时，使用**kwargs 会收集关键字参数。
3. 使用 args 和 kwargs 作为参数名只是举例，可以任意替换

#14.编程实现计算文件中的大写字母数
```
import os
os.chdir('c:\\Users\\flack\\desktop')
with open ('today.txt') as f:
    count = 0
    for i in f.read():
        if i.isupper():
            count += i
    print(count)
```

#15.什么是负索引？
与正索引不同，负索引是从右边开始检索。同样可以用于列表的切片

#16.如何随机打乱列表中元素，要求不引用额外的内存空间？
我们用 random 包中的 shuffle() 函数来实现。
shuffle:将序列中的元素随机排序
[3, 4, 8, 0, 5, 7, 6, 2, 1]

#17.解释 Python 中的 join() 和 split() 函数
join() 函数可以将指定的字符添加到字符串中。
‘1,2,3,4,5’

split() 函数可以用指定的字符分割字符串[‘1’, ‘2’, ‘3’, ‘4’, ‘5’]

#18.Python 区分大小写吗？
Python 是区分大小的语言

Python 是否区分大小写的方法是测试 myname 和 Myname 在程序中是不是算同一个标识符。观察以下代码的返回结果：

Myname

NameError: name ‘Myname’ is not defined

如你所见，这里出现了 NameError，所以 Python 是区分大小的语言。

#19.Python 中标识符的命名规则？
Python 中的标识符可以是任意长度，但必须遵循以下命名规则:

1. 只能以下划线或者 A-Z/a-z 中的字母开头。

2. 其余部分只能使用 A-Z/a-z/0-9。

3. Python 标识符区分大小写。

4. 关键字不能作为标识符。Python 有以下这些关键字：
![Python关键字](https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1852287917,3164344774&fm=173&app=25&f=JPEG?w=639&h=232&s=4CA03C7287744C225EFD41DA000080B1 "Python关键字")

#20.如何删除字符串中的前置空格？
前置空格是第一个非空格字符前的所有空格，使用 lstrip() 函数来删除.

‘Ayushi ‘

如图这个字符串既包含前置空格也包含后置空格. 调用 lstrip() 函数去除了前置空格。如果想去除后置空格，使用 rstrip() 函数。

‘ Ayushi’


#21.如何将字符串转换为小写？
使用 lower() 函数

‘ayushi’

转换为大写用 upper() 函数

‘AYUSHI’

要检查字符串是否为全大写或全小写，使用 isupper() 和 islower() 函数
`'Flack'.isupper()`
`'FLACK'.isupper()`
`'F@*L-ACK'.islower()`
`'F@*L-ACK'.isupper()`
像 @ 和$这样的字符即满足大写也满足小写。

istitle() 可以检查字符串是否是标题格式

#22.Python 中的 pass 语句有什么作用？
我们在写代码时，有时可能只写了函数声明而没想好函数怎么写，但为了保证语法检查的正确必须输入一些东西。在这种情况下，我们使用 pass 语句。

#23.请解释 Python 中的闭包？
如果在一个内部函数里。对在外部作用域（但不是在全局作用域）的变量进行引用，那么内部函数就是一个闭包。

#24.解释 Python 中的//，％和**运算符
//运算符执行地板除法，返回结果的整数部分 (向下取整)。用/符号除法结果为 3.5。

% 是取模符号。返回除法后的余数。

**符号表示取幂. a**b 返回 a 的 b 次方

#25.Python 中有多少种运算符，解释算术运算符。
在 Python 中我们有 7 中运算符:算术运算符、关系 (比较) 运算符、赋值运算符、逻辑运算符、位运算符、成员运算符、身份运算符。

1. 加号 (+) 将两个对象的值相加。
2. 减号 (-) 将第一个对象的值减去第二个对象的值
3. 乘号 (*) 将两个对象的值相乘。
4. 除号 (/) 将第一个对象的值除以第二个对象的值。
5. % 是取模符号。返回除法后的余数。
6. \*\*符号表示取幂. a**b 返回 a 的 b 次方
7. //运算符执行地板除法，返回结果的整数部分 (向下取整)。用/符号除法结果为 3.5。
关于地板除法、取模和取

#26.解释 Python 中的关系运算符。
关系运算符用来比较两个对象。

1. 判断小于 (<)：如果符号左边的值比右边小则返回 True。
False
2. 判断大于 (>)：如果符号左边的值比右边大则返回 True。
True
出现上面的错误结果是因为 Python 的浮点运算存在一些 Bug。
3. 判断小于等于 (<=)：如果符号左边的值小于或等于右边则返回 True。
True
4. 大判断于等于 (>=)：如果符号左边的值大于或等于右边则返回 True。
True
5. 判断等于 (==) 如果符号两边的值相等则返回 True。
True
6. 判断不等于 (!=) 如果符号两边的值不等则返回 True。
True

#27.解释 Python 中的赋值和算数运算符？
![算数运算符](https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2729444636,1810293528&fm=173&app=25&f=JPEG?w=640&h=678&s=4DA03D724B4B616C085540DA0000C0B2 "算数运算符")

#28.解释 Python 中的逻辑运算符
Python 中有三个逻辑运算符：and、or、not
![逻辑运算符](https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3235591225,3667496947&fm=173&app=25&f=JPEG?w=640&h=232&s=ADA27C324B22672408D580DA0000D0B2 "逻辑运算符")

#29.解释 Python 中的成员运算符
使用 in 和 not in 运算符我们可以判断某个值是否在成员中。
![成员运算符](https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=199026845,1220078765&fm=173&app=25&f=JPEG?w=639&h=158&s=05F4EC324B624D245EE194DA0000C0B3 "成员运算符")

#30.解释 Python 中的身份运算符
is 和 is not 运算符可以判断两个对象是否相同
![身份运算符](https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3430271699,763681838&fm=173&app=25&f=JPEG?w=640&h=155&s=05A67C324F62472408FDA5DA0000C0B2 "身份运算符")

#31.解释 Python 中的位运算符
此运算符按二进制位对值进行操作。
>1. 与 (&) 返回按位与结果
2. 或 (|) 返回按位或结果
3. 异或 (^) 返回按位异或结果
4. 取反 (~) 返回按位取反结果
5. 左移位 (<<) 将符号左边数的二进制左移右边数位
eg.1 的二级制 0001 左移 2 位变成 0100 也即十进制的 4
6. 右移位 (>>)

#32.如何在 Python 使用多进制数字？
除十进制以外，在 Python 中还可以使用二进制、八进制、十六进制。
>1. 二进制数有 0 和 1 组成，我们使用 0b 或 0B 前缀表示二进制数 eg:"0b1111"
2. 使用 bin() 函数可以将数字转换为二进制
3. 八进制数由数字 0-7 组成，使用前缀 0o 或 0O 表示 8 进制数 eg:"0o10"
4. 十六进数由数字 0-15 组成，使用前缀 0x 或者 0X 表示 16 进制数 eg:"0x10","0xf"

#33.如何获取字典中的所有键？
使用 keys() 来获取字典中的所有键

#34.问什么标识符不建议使用下划线开头？
因为在 Python中以下划线开头的变量为私有变量，如果你不想让变量私有，就不要使用下划线开头。

#35.如何声明多个变量并赋值？
有两种方式：
>1. a,b,c = 10,20,30
2. a = 0  b = 0  c = 0

#36.什么是元组的解封装？
首先我们来介绍元组封装：(3, 4, 5)将 3，4，5 封装到元组 mytuple 中
现在我们要将这些值解封装到变量 x，y，z 中
tup = (3,4,5)
x,y,z = tup

#37.一行代码实现1—100之和
`print(math.fsum(range(1, 101)))`

#38.如何在一个函数内部修改全局变量
global a
a = 10

#39.列出5个python标准库字典
1. os：提供了不少与操作系统相关联的函数
2. sys：通常用于命令行参数
3. re：正则匹配
4. math：数学运算
5. datetime：处理日期时间

#40.如何删除键和合并两个字典
```
del dict['a']

dict(dict1.items() + dict2.items())

dict(dict1, **dict2)

dict3 = dict1.copy()
dict3.update(dict2)
```
这种方法使用的是dict()工厂方法（Python2.2以上版本）,允许接受字典或关键字参数字典进行调用

#41.谈下python的GIL
全局解析器锁，python其实没有定义GIL, 这玩意其实是Python解析器CPython用来做多线程控制和调度的全局锁，Python还有一些别的解析器，比如JPython, Pypy等，其中JPython就没有GIL。但是CPython现在已经成为Python的实际标准，各种Linux和其它OS默认集成的Python, 以及从官方网站上下载的Python，还有各种相关的工具如pip等都在使用CPython，所以GIL问题自然也就成为了Python语言的问题了


#42.python实现列表去重的方法
* 转换为集合数据类型; set(列表)
```
li = [1, 2, 3, 4, 1, 2]
s = set(li)
li = list(s)
print li
#[1, 2, 3, 4]
```
* 字典的fromkeys方法实现;
```
li = [1, 2, 3, 4, 1, 2]
d = {}.fromkeys(li)
print d.keys()
#[1, 2, 3, 4]
```

#43.fun(\*args, \*\*kwargs)中的\*args,\*\*kwargs什么意思？
一个星号\*的作用是将tuple或者list中的元素进行unpack，分开传入，作为多个参数；两个星号\*\*的作用是把dict类型的数据作为参数传入。
kwargs是keyword argument的缩写，args就是argument,在Python中有两种参数，一种叫位置参数（positional argument），一种叫关键词参数（keyword argument），关键词参数只需要用 keyword = somekey 的方法即可传参，而位置参数只能由参数位置决定。	


#44.python2和python3的range（100）的区别
python2返回列表，python3返回迭代器，节约内存

#45.一句话解释什么样的语言能够用装饰器?
函数可以作为参数传递的语言，可以使用装饰器

#46.python内建数据类型有哪些
- 整型--int
- 布尔型--bool
- 字符串--str
- 列表--list
- 元组--tuple
- 字典--dict
- 集合--set

#47.简述面向对象中__new__和__init__区别
>1. __new__至少要有一个参数cls，代表当前类，此参数在实例化时由Python解释器自动识别
2. __new__必须要有返回值，返回实例化出来的实例，这点在自己实现__new__时要特别注意，可以return父类(通过super(当前类名, cls)).__new__出来的实例，或者直接是object的__new__出来的实例
3. __init__有一个参数self，就是这个__new__返回的实例，__init__在__new__的基础上可以完成一些其它初始化的动作，__init__不需要返回值
4. 如果__new__创建的是当前类的实例，会自动调用__init__函数，通过return语句里面调用的__new__函数的第一个参数是cls来保证是当前类实例，如果是其他类的类名，；那么实际创建返回的就是其他类的实例，其实就不会调用当前类的__init__函数，也不会调用其他类的__init__函数。

![演示](https://img-blog.csdn.net/20180414170345846 "演示")

#48.简述with方法打开处理文件帮我我们做了什么？
打开文件在进行读写的时候可能会出现一些异常状况，如果按照常规的f.open，我们需要try,except,finally，做异常判断，并且文件最终不管遇到什么情况，都要执行finally f.close()关闭文件，with方法帮我们实现了finally中f.close

#49.列表[1,2,3,4,5],请使用map()函数输出[1,4,9,16,25]，并使用列表推导式提取出大于10的数，最终输出[16,25]
```
li = [1,2,3,4,5]
def fn(x):
	return x**2

# map（）函数第一个参数是fun，第二个参数是一般是list，
# 第三个参数可以写list，也可以不写，根据需求
res = map(fn, li)
print(res)

res = [x**2 for x in li if x > 3]
print(res)

# 结果：
[16, 25]
```

#50.python中生成随机整数、随机小数、0--1之间小数方法
import random

随机整数：random.randint(a,b),生成区间内的整数，random.randrange(10),生成区间内的整数,random.randrange(0, 10, 2),生成区间内的整数

随机小数：习惯用numpy库，利用np.random.randn(5)生成5个随机小数

0-1随机小数：random.random(),括号中不传参
![演示](https://img-blog.csdn.net/2018041417044944 "演示")

返回一个介于a和b之间的浮点数。如果a>b，则是b到a之间的浮点数。这里的a和b都有可能出现在结果中

random.uniform(a, b)

#51.避免转义给字符串加哪个字母表示原始字符串？
r：表示需要原始字符串，不转义特殊字符

#52.`<div class="nam">中国</div>`，用正则匹配出标签里面的内容（“中国”），其中class的类名是不确定的
![演示](https://img-blog.csdn.net/20180414170544935 "演示")

#53.python中断言方法举例
assert（）方法，断言成功，则程序继续执行，断言失败，则程序报错
![演示](https://img-blog.csdn.net/20180414170557810 "演示")

#54.数据表student有id,name,score,city字段，其中name中的名字可有重复，需要消除重复行,请写sql语句
select  distinct  name  from  student

#55.10个Linux常用命令
pwd,dir,ls,la,touch,rm,mkdir,tree,cp, mv,cat, more,grep,echo

#56.python2和python3区别？列举5个
>1. Python3 使用 print 必须要以小括号包裹打印内容，比如 print('hi')
Python2 既可以使用带小括号的方式，也可以使用一个空格来分隔打印内容，比如 print 'hi'
2. python2 map和range(1,10)返回列表，python3中返回迭代器，节约内存
3. python2中使用ascii编码，python中使用utf-8编码
4. python2中unicode表示字符串序列，str表示字节序列
python3中str表示字符串序列，byte表示字节序列
5. python2中为正常显示中文，引入coding声明，python3中不需要
6. python2中是raw_input()函数，python3中是input()函数

#57.列出python中可变数据类型和不可变数据类型，并简述原理
不可变数据类型：数值型、字符串型string和元组tuple
不允许变量的值发生变化，如果改变了变量的值，相当于是新建了一个对象，而对于相同的值的对象，在内存中则只有一个对象（一个地址），如下图用id()方法可以打印对象的id
![演示](https://img-blog.csdn.net/20180414170826450 "演示")

可变数据类型：列表list和字典dict；
允许变量的值发生变化，即如果对变量进行append、+=等这种操作后，只是改变了变量的值，而不会新建一个对象，变量引用的对象的地址也不会变化，不过对于相同的值的不同对象，在内存中则会存在不同的对象，即每个对象都有自己的地址，相当于内存中对于同值的对象保存了多份，这里不存在引用计数，是实实在在的对象。
![演示](https://img-blog.csdn.net/20180414170833690 "演示")

#58.s = "ajldjlajfdljfddd"，去重并从小到大排序输出"adfjl"
```
s = "ajldjlajfdljfddd"
s = set(s)
s = list(s)
s.sort(reverse=False)
res = "".join(s)
print(res)
```
![演示](https://img-blog.csdn.net/20180414170845877 "演示")

#59.用lambda函数实现两个数相乘
```
mul = lambda a,b:a*b
print(mul(4,5))
```
![演示](https://img-blog.csdn.net/2018041417085541 "演示")

#60.字典根据键从小到大排序dict={"name":"zs","age":18,"city":"深圳","tel":"1362626627"}
```
dict={"name":"zs","age":18,"city":"深圳","tel":"1362626627"}

li = sorted(dict.items(), key=lambda i:i[0], reverse=False)
print(li)
new_dict = {}
for i in li:
    new_dict[i[0]] = i[1]

print(new_dict)
```
![演示](https://img-blog.csdn.net/20180414170906525 "演示")

#61.利用collections库的Counter方法统计字符串每个单词出现的次数"kjalfj;ldsjafl;hdsllfdhg;lahfbl;hl;ahlf;h"
```
from collections import Counter

a = "kjalfj;ldsjafl;hdsllfdhg;lahfbl;hl;ahlf;h"
res = Counter(a)
print(res)
```

#62.字符串a = "not 404 found 张三 99 深圳"，每个词中间是空格，用正则过滤掉英文和数字，最终输出"张三  深圳"
```
import re
a = "not 404 found 张三 99 深圳"

li = a.split(' ')
res = re.findall('\d+|[a-zA-Z]+', a)
for i in res:
    if i in li:
        li.remove(i)

new_str = " ".join(li)
print(res)
print(new_str)

```

顺便贴上匹配小数的代码，虽然能匹配，但是健壮性有待进一步确认
```
import re
a = "not 404 found 张三 99 深圳"

li = a.split(' ')
res = re.findall('\d+\.?\d*|[a-zA-Z]+', a)
for i in res:
    if i in li:
        li.remove(i)

new_str = " ".join(li)
print(res)
print(new_str)
```
#63.filter方法求出列表所有奇数并构造新列表，a =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
filter() 函数用于过滤序列，过滤掉不符合条件的元素，返回由符合条件元素组成的新列表。该接收两个参数，第一个为函数，第二个为序列，序列的每个元素作为参数传递给函数进行判，然后返回 True 或 False，最后将返回 True 的元素放到新列表
```
a =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# def fn(x):
#     if x % 2 == 0:
#         return False
#     else:
#         return True

def fn(x):
    return x % 2 == 1

res = list(filter(fn, a))
print(res)
```

#64.列表推导式求列表所有奇数并构造新列表，a =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
a =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
res = [i for i in a if i % 2 == 1]
print(res)
```

#65.正则re.complie作用
re.compile是将正则表达式编译成一个对象，加快速度，并重复使用

#66.a=（1，）b=(1)，c=("1") 分别是什么类型的数据？
```
print(type((1,)))
print(type((1)))
print(type(("1")))

<class 'tuple'>
<class 'int'>
<class 'str'>
```

#67.两个列表[1,5,7,9]和[2,2,6,8]合并为[1,2,2,3,6,7,8,9]
```
a = [1,5,7,9]
b = [2,2,6,8]
l = sorted(a + b)
print(l)

l = a.copy()
l.extend(b)
l = sorted(l)
print(l)

a += b
print(sorted(a))
```

#68.用python删除文件和用linux命令删除文件方法
```
os.remove(path)

import os, sys
dirPath = "test/"
print '移除前test目录下有文件：%s' %os.listdir(dirPath)
#判断文件是否存在
if(os.path.exists(dirPath+"foo.txt")):
　　os.remove(dirPath+"foo.txt")
　　print '移除后test 目录下有文件：%s' %os.listdir(dirPath)
else:
　　print "要删除的文件不存在！"
```

#69.log日志中，我们需要用时间戳记录error,warning等的发生时间，请用datetime模块打印当前时间戳 “2018-04-01 11:38:54”
```
import datetime
now_time = datetime.datetime.now()
print(now_time.strftime('%Y-%m-%d %H:%M:%S'))


import time
import datetime

def yes_time():
    #获取当前时间
    now_time = datetime.datetime.now()
    #当前时间减去一天 获得昨天当前时间
    yes_time = now_time + datetime.timedelta(days=-1)
    #格式化输出
    yes_time_str = yes_time.strftime('%Y-%m-%d %H:%M:%S')
    print yes_time_str  # 2017-11-01 22:56:02

def dif_time():
    #计算两个时间之间差值
    now_time = datetime.datetime.now()
    now_time = now_time.strftime('%Y-%m-%d %H:%M:%S')
    d1 = datetime.datetime.strptime('2017-10-16 19:21:22', '%Y-%m-%d %H:%M:%S')
    d2 = datetime.datetime.strptime(now_time, '%Y-%m-%d %H:%M:%S')
    #间隔天数
    day = (d2 - d1).days
    #间隔秒数
    second = (d2 - d1).seconds
    print day   #17
    print second  #13475  注意这样计算出的秒数只有小时之后的计算额 也就是不包含天之间差数

def unix_time():
    #将python的datetime转换为unix时间戳
    dtime = datetime.datetime.now()
    un_time = time.mktime(dtime.timetuple())
    print un_time  #1509636609.0
    #将unix时间戳转换为python  的datetime
    unix_ts = 1509636585.0
    times = datetime.datetime.fromtimestamp(unix_ts)
    print times  #2017-11-02 23:29:45
```

#70.数据库优化查询方法
(外键、索引、联合查询、选择特定字段等等)
1. 储存引擎选择，如果数据表需要事务处理，应该考虑使用InnoDB, 因为它完成兼容 ACID 特性，如果不需要事务处理，使用默认储存引擎 MyISQM 比较明智
    1.innodn 是 mysql 的数据库引擎之一，最大特色支持 ACID 兼容的事务功能（即事务的四大特性）
    2.MyISAM 默认存储引擎，使用高级缓存和索引机制
2. 对查询进行优化，尽量避免全表扫描，可以考虑再 where 及 order by 涉及的列上建立索引
3. 应尽量避免在 where 子句中对字段进行 null 值判断，否则将导则引擎放弃使用索引而进行全表扫描
4. 应尽量避免在 where 子句中使用 ！= 或 < > 操作符，否则将引擎放弃使用索引而进行全表扫描
5. 应尽量避免在 where 子句中使用 or 来连接条件， 如果一个字段有索引，一个字段没有索引，将导致引擎放弃使用索引而进行全表扫描
6. 使用 Update 语句， 如果只更改 1、2 个字段，不要 update 全部字段，否则频繁调用会引起明显的性能小号，同时带来大量日志
7. 对于多张大数据量的表 JINO，要先分页再 JOIN, 否则逻辑读会很高，性能差
8. 尽量使用表变量来代替临时表。如果表变量包含大量数据，请注意索引非常有限（只有主键索引）
9. 避免频繁创建和删除临时表，以减少系统表资源的消耗。

1）数据库设计方面： 
a. 对查询进行优化，应尽量避免全表扫描，首先应考虑在 where 及 order by 涉及的列上建立索引。 
b. 应尽量避免在 where 子句中对字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描，如： select id from t where num is null 可以在num上设置默认值0，确保表中num列没有null值，然后这样查询： select id from t where num=0
​c. 并不是所有索引对查询都有效，SQL是根据表中数据来进行查询优化的，当索引列有大量数据重复时,查询可能不会去利用索引，如一表中有字段sex，male、female几乎各一半，那么即使在sex上建了索引也对查询效率起不了作用。
​d. 索引并不是越多越好，索引固然可以提高相应的 select 的效率，但同时也降低了 insert 及 update 的效率，因为 insert 或 update 时有可能会重建索引，所以怎样建索引需要慎重考虑，视具体情况而定。一个表的索引数最好不要超过6个，若太多则应考虑一些不常使用到的列上建的索引是否有必要。
e. 应尽可能的避免更新索引数据列，因为索引数据列的顺序就是表记录的物理存储顺序，一旦该列值改变将导致整个表记录的顺序的调整，会耗费相当大的资源。若应用系统需要频繁更新索引数据列，那么需要考虑是否应将该索引建为索引。
f. 尽量使用数字型字段，若只含数值信息的字段尽量不要设计为字符型，这会降低查询和连接的性能，并会增加存储开销。这是因为引擎在处理查询和连接时会逐个比较字符串中每一个字符，而对于数字型而言只需要比较一次就够了。
g. 尽可能的使用 varchar/nvarchar 代替 char/nchar ，因为首先变长字段存储空间小，可以节省存储空间，其次对于查询来说，在一个相对较小的字段内搜索效率显然要高些。
h. 尽量使用表变量来代替临时表。如果表变量包含大量数据，请注意索引非常有限（只有主键索引）。
i. 避免频繁创建和删除临时表，以减少系统表资源的消耗。
j. 临时表并不是不可使用，适当地使用它们可以使某些例程更有效，例如，当需要重复引用大型表或常用表中的某个数据集时。但是，对于一次性事件，最好使用导出表。
k. 在新建临时表时，如果一次性插入数据量很大，那么可以使用 select into 代替 create table，避免造成大量 log ，以提高速度；如果数据量不大，为了缓和系统表的资源，应先create table，然后insert。
l. 如果使用到了临时表，在存储过程的最后务必将所有的临时表显式删除，先 truncate table ，然后 drop table ，这样可以避免系统表的较长时间锁定。

2)SQL语句方面：
​ a. 应尽量避免在 where 子句中使用!=或<>操作符，否则将引擎放弃使用索引而进行全表扫描。
​ b. 应尽量避免在 where 子句中使用 or 来连接条件，否则将导致引擎放弃使用索引而进行全表扫描，如：
select id from t where num=10 or num=20
可以这样查询：
select id from t where num=10 union all select id from t where num=20
​ c. in 和 not in 也要慎用，否则会导致全表扫描，如：
select id from t where num in(1,2,3)
对于连续的数值，能用 between 就不要用 in 了：
select id from t where num between 1 and 3
​ d. 下面的查询也将导致全表扫描：
select id from t where name like ‘%abc%’
​ e. 如果在 where 子句中使用参数，也会导致全表扫描。因为SQL只有在运行时才会解析局部变量，但优化程序不能将访问计划的选择推迟到运行时；它必须在编译时进行选择。
​ 然而，如果在编译时建立访问计划，变量的值还是未知的，因而无法作为索引选择的输入项。如下面语句将进行全表扫描：
select id from t where num=@num
可以改为强制查询使用索引：
select id from t with(index(索引名)) where num=@num
​ f. 应尽量避免在 where 子句中对字段进行表达式操作，这将导致引擎放弃使用索引而进行全表扫描。如：
select id from t where num/2=100
应改为:
select id from t where num=100*2
​ g. 应尽量避免在where子句中对字段进行函数操作，这将导致引擎放弃使用索引而进行全表扫描。如：
select id from t where substring(name,1,3)=’abc’
–name以abc开头的id
select id from t where datediff(day,createdate,’2005-11-30′)=0
–‘2005-11-30’生成的id
应改为:
select id from t where name like ‘abc%’ select id from t where createdate>=’2005-11-30′ and createdate<’2005-12-1′
​ h. 不要在 where 子句中的“=”左边进行函数、算术运算或其他表达式运算，否则系统将可能无法正确使用索引。
​ i. 不要写一些没有意义的查询，如需要生成一个空表结构：
select col1,col2 into #t from t where 1=0
这类代码不会返回任何结果集，但是会消耗系统资源的，应改成这样：
create table #t(…)
​ j. 很多时候用 exists 代替 in 是一个好的选择：
select num from a where num in(select num from b)
用下面的语句替换：
select num from a where exists(select 1 from b where num=a.num)
​ k. 任何地方都不要使用 select * from t ，用具体的字段列表代替“*”，不要返回用不到的任何字段。
​ l. 尽量避免使用游标，因为游标的效率较差，如果游标操作的数据超过1万行，那么就应该考虑改写。
​ m. 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理。
​ n. 尽量避免大事务操作，提高系统并发能力。

#71.InnoDB和MyISAM存储引擎的区别是什么？
MyISAM是MySQL的默认数据库引擎（5.5版之前）,由早期的ISAM（Indexed Sequential Access Method：有索引的顺序访问方法）所改良。虽然性能极佳，但却有一个缺点：不支持事务处理（transaction）。不过，在这几年的发展下，MySQL也导入了InnoDB（另一种数据库引擎），以强化参考完整性与并发违规处理机制，后来就逐渐取代MyISAM。

InnoDB，是MySQL的数据库引擎之一，为MySQL AB发布binary的标准之一。InnoDB由Innobase Oy公司所开发，2006年五月时由甲骨文公司并购。与传统的ISAM与MyISAM相比，InnoDB的最大特色就是支持了ACID兼容的事务（Transaction）功能，类似于PostgreSQL。目前InnoDB采用双轨制授权，一是GPL授权，另一是专有软件授权。

MyISAM和InnoDB两者之间有着明显区别，简单梳理如下:
1) 事务支持
MyISAM不支持事务，而InnoDB支持。InnoDB的AUTOCOMMIT默认是打开的，即每条SQL语句会默认被封装成一个事务，自动提交，这样会影响速度，所以最好是把多条SQL语句显示放在begin和commit之间，组成一个事务去提交。

MyISAM是非事务安全型的，而InnoDB是事务安全型的，默认开启自动提交，宜合并事务，一同提交，减小数据库多次提交导致的开销，大大提高性能。

2) 存储结构
MyISAM：每个MyISAM在磁盘上存储成三个文件。第一个文件的名字以表的名字开始，扩展名指出文件类型。.frm文件存储表定义。数据文件的扩展名为.MYD (MYData)。索引文件的扩展名是.MYI (MYIndex)。
InnoDB：所有的表都保存在同一个数据文件中（也可能是多个文件，或者是独立的表空间文件），InnoDB表的大小只受限于操作系统文件的大小，一般为2GB。

3) 存储空间
MyISAM：可被压缩，存储空间较小。支持三种不同的存储格式：静态表(默认，但是注意数据末尾不能有空格，会被去掉)、动态表、压缩表。
InnoDB：需要更多的内存和存储，它会在主内存中建立其专用的缓冲池用于高速缓冲数据和索引。

4) 可移植性、备份及恢复
MyISAM：数据是以文件的形式存储，所以在跨平台的数据转移中会很方便。在备份和恢复时可单独针对某个表进行操作。
InnoDB：免费的方案可以是拷贝数据文件、备份 binlog，或者用 mysqldump，在数据量达到几十G的时候就相对痛苦了。

5) 事务支持
MyISAM：强调的是性能，每次查询具有原子性,其执行数度比InnoDB类型更快，但是不提供事务支持。
InnoDB：提供事务支持事务，外部键等高级数据库功能。 具有事务(commit)、回滚(rollback)和崩溃修复能力(crash recovery capabilities)的事务安全(transaction-safe (ACID compliant))型表。

6) AUTO_INCREMENT
MyISAM：可以和其他字段一起建立联合索引。引擎的自动增长列必须是索引，如果是组合索引，自动增长可以不是第一列，他可以根据前面几列进行排序后递增。
InnoDB：InnoDB中必须包含只有该字段的索引。引擎的自动增长列必须是索引，如果是组合索引也必须是组合索引的第一列。

7) 表锁差异
MyISAM：只支持表级锁，用户在操作myisam表时，select，update，delete，insert语句都会给表自动加锁，如果加锁以后的表满足insert并发的情况下，可以在表的尾部插入新的数据。
InnoDB：支持事务和行级锁，是innodb的最大特色。行锁大幅度提高了多用户并发操作的新能。但是InnoDB的行锁，只是在WHERE的主键是有效的，非主键的WHERE都会锁全表的。

MyISAM锁的粒度是表级，而InnoDB支持行级锁定。简单来说就是, InnoDB支持数据行锁定，而MyISAM不支持行锁定，只支持锁定整个表。即MyISAM同一个表上的读锁和写锁是互斥的，MyISAM并发读写时如果等待队列中既有读请求又有写请求，默认写请求的优先级高，即使读请求先到，所以MyISAM不适合于有大量查询和修改并存的情况，那样查询进程会长时间阻塞。因为MyISAM是锁表，所以某项读操作比较耗时会使其他写进程饿死。

8) 全文索引
MyISAM：支持(FULLTEXT类型的)全文索引
InnoDB：不支持(FULLTEXT类型的)全文索引，但是innodb可以使用sphinx插件支持全文索引，并且效果更好。

全文索引是指对char、varchar和text中的每个词（停用词除外）建立倒排序索引。MyISAM的全文索引其实没啥用，因为它不支持中文分词，必须由使用者分词后加入空格再写到数据表里，而且少于4个汉字的词会和停用词一样被忽略掉。

另外，MyIsam索引和数据分离，InnoDB在一起，MyIsam天生非聚簇索引，最多有一个unique的性质，InnoDB的数据文件本身就是主键索引文件，这样的索引被称为“聚簇索引”

9) 表主键
MyISAM：允许没有任何索引和主键的表存在，索引都是保存行的地址。
InnoDB：如果没有设定主键或者非空唯一索引，就会自动生成一个6字节的主键(用户不可见)，数据是主索引的一部分，附加索引保存的是主索引的值。InnoDB的主键范围更大，最大是MyISAM的2倍。

10) 表的具体行数
MyISAM：保存有表的总行数，如果select count(*) from table;会直接取出出该值。
InnoDB：没有保存表的总行数(只能遍历)，如果使用select count(*) from table；就会遍历整个表，消耗相当大，但是在加了wehre条件后，myisam和innodb处理的方式都一样。

11) CURD操作
MyISAM：如果执行大量的SELECT，MyISAM是更好的选择。
InnoDB：如果你的数据执行大量的INSERT或UPDATE，出于性能方面的考虑，应该使用InnoDB表。DELETE 从性能上InnoDB更优，但DELETE FROM table时，InnoDB不会重新建立表，而是一行一行的删除，在innodb上如果要清空保存有大量数据的表，最好使用truncate table这个命令。

12) 外键
MyISAM：不支持
InnoDB：支持

13) 查询效率
没有where的count(*)使用MyISAM要比InnoDB快得多。因为MyISAM内置了一个计数器，count(*)时它直接从计数器中读，而InnoDB必须扫描全表。所以在InnoDB上执行count(*)时一般要伴随where，且where中要包含主键以外的索引列。为什么这里特别强调“主键以外”？因为InnoDB中primary index是和raw data存放在一起的，而secondary index则是单独存放，然后有个指针指向primary key。所以只是count(*)的话使用secondary index扫描更快，而primary key则主要在扫描索引同时要返回raw data时的作用较大。MyISAM相对简单，所以在效率上要优于InnoDB，小型应用可以考虑使用MyISAM。

通过上述的分析，基本上可以考虑使用InnoDB来替代MyISAM引擎了，原因是InnoDB自身很多良好的特点，比如事务支持、存储 过程、视图、行级锁定等等，在并发很多的情况下，相信InnoDB的表现肯定要比MyISAM强很多。另外，任何一种表都不是万能的，只用恰当的针对业务类型来选择合适的表类型，才能最大的发挥MySQL的性能优势。如果不是很复杂的Web应用，非关键应用，还是可以继续考虑MyISAM的，这个具体情况可以自己斟酌。

MyISAM和InnoDB两者的应用场景：
1) MyISAM管理非事务表。它提供高速存储和检索，以及全文搜索能力。如果应用中需要执行大量的SELECT查询，那么MyISAM是更好的选择。
2) InnoDB用于事务处理应用程序，具有众多特性，包括ACID事务支持。如果应用中需要执行大量的INSERT或UPDATE操作，则应该使用InnoDB，这样可以提高多用户并发操作的性能。

但是实际场景中，针对具体问题需要具体分析，一般而言可以遵循以下几个问题：
-  数据库是否有外键？ 
-  是否需要事务支持？ 
-  是否需要全文索引？ 
-  数据库经常使用什么样的查询模式？在写多读少的应用中还是Innodb插入性能更稳定，在并发情况下也能基本，如果是对读取速度要求比较快的应用还是选MyISAM。 
-  数据库的数据有多大？ 大尺寸倾向于innodb，因为事务日志，故障恢复。

#72.请列出你会的任意一种统计图（条形图、折线图等）绘制的开源库，第三方也行
pychart、matplotlib(经常使用到的是pylab和pyplot)、

1. matplotlib,官网：http://matplotlib.sourceforge.net/，Matplotlib 是一个由 John Hunter 等开发的，用以绘制二维图形的 Python 模块。它利用了 Python 下的数值计算模块 Numeric 及 Numarray，克隆了许多 Matlab 中的函数， 用以帮助用户轻松地获得高质量的二维图形。Matplotlib 可以绘制多种形式的图形包括普通的线图，直方图，饼图，散点图以及误差线图等；可以比较方便的定制图形的各种属性比如图线的类型，颜色，粗细，字体的大小 等；它能够很好地支持一部分 TeX 排版命令，可以比较美观地显示图形中的数学公式。个人比较推荐这个类库。查看例子。
2. Cairoplot,官网：http://linil.wordpress.com/2008/09/16/cairoplot-11/，(友情提示：需要FanQiang)。Cairoplot在网页上的表现力堪比flex中的图表图形效果。但是这个似乎只能跑在linux平台上。所以很多windows用户估计要失望了。
3. Chaco, 官网：http://code.enthought.com/chaco/，Chaco是一个2D的绘图库。其中文简单教程参考：http://hyry.dip.jp/pydoc/chaco_intro.html
4. Python Google Chart,官网：http://pygooglechart.slowchop.com/。从命名方式来看，这个肯定与google chart扯上了关系。所以该类库是对Google chart API的一个完整封装。
5. PyCha,官网：https://bitbucket.org/lgs/pycha/wiki/Home。PyCha可是说是Cairo 类库的一个简单封装，为了是实现轻量级，以及容易使用，当然还做了一些优化等。
6. pyOFC2，官网：http://btbytes.github.com/pyofc2/。它是Open Falsh Library的Python类库。所以图形具有Flash效果，可以随鼠标移动动态显示图标中信息，这是优越于其他静态图示的。
7. Pychart，官网：http://home.gna.org/pychart/。pyChart是用于创建高品质封装的PostScript，PDF格式，PNG，或SVG图表Python库。
8. PLPlot,官网：http://plplot.sourceforge.net/。PLPlot是用于创建科学图表的跨平台软件包。以C类库为核心，支持各种语言绑定(C, C++, Fortran, Java, Python, Perl etc.)。开源免费。
9. reportlab,官网：http://www.reportlab.com/software/opensource/。这个我们之前介绍过，参考http://www.codecho.com/installation-and-example-of-reportlab-in-python/。这个类库支持在pdf中画图表。
10. Vpython,官网：http://www.vpython.org/index.html，VPython是Visual Python的简写，Visual是由Carnegie Mellon University（卡耐基-梅隆大学）在校学生David Scherer于2000年撰写的一个Python 3D绘图模块。

#73.写一段自定义异常代码
```
def fn():
    try:
        for i in rang(5):
            if i > 2:
                raise Exception("数字大于2了！")
    except Exception as e:
        print(e)
```

#74.正则表达式匹配中，（.*）和（.*?）匹配区别？
（.*）是贪婪匹配，会把满足正则的尽可能多的往后匹配
（.*?）是非贪婪匹配，会把满足正则的尽可能少匹配
```
import re
s = "<a>哈哈</a><a>嘿嘿</a>"
res1 = re.findall("<a>(.*)</a>", s)
print("贪婪匹配", res1)
res2 = re.findall("<a>(.*?)</a>", s)
print("非贪婪匹配", res2)
```
贪婪匹配 ['哈哈</a><a>嘿嘿']
非贪婪匹配 ['哈哈', '嘿嘿']

#75.简述Django的orm
ORM，全拼Object-Relation Mapping，意为对象-关系映射
实现了数据模型与数据库的解耦，通过简单的配置就可以轻松更换数据库，而不需要修改代码只需要面向对象编程,orm操作本质上会根据对接的数据库引擎，翻译成对应的sql语句,所有使用Django开发的项目无需关心程序底层使用的是MySQL、Oracle、sqlite....，如果数据库迁移，只需要更换Django的数据库引擎即可
![演示](https://images2018.cnblogs.com/blog/1247221/201806/1247221-20180630124323399-979526741.png "演示")

#76.[[1,2],[3,4],[5,6]]一行代码展开该列表，得出[1,2,3,4,5,6]
运行过程：for i in a ,每个i是【1,2】，【3,4】，【5,6】，for j in i，每个j就是1,2,3,4,5,6,合并后就是结果
```
a = [[1,2],[3,4],[5,6]]
print([x for y in a for x in y])
```
将列表转成numpy矩阵，通过numpy的flatten（）方法，代码永远是只有更骚，没有最骚
```
import numpy as np
b = np.array(a).flatten().tolist()
print(b)
```

#77.x="abc",y="def",z=["d","e","f"],分别求出x.join(y)和x.join(z)返回的结果
```
x="abc"
y="def"
z=["d","e","f"]

m = x.join(y)
print(m)

n = x.join(z)
print(n)

r = " ".join(x)
print(r)

r = "|".join(y)
print(r)

r = "+".join(z)
print(r)

# 结果：
dabceabcf
dabceabcf
a b c
d|e|f
d+e+f
```
#78.举例说明异常模块中try except else finally的相关意义
1. try...except:try 后面写正常运行的程序代码，except即为异常情况
2. try ....except...else 语句，当没有异常发生时，else中的语句将会被执行,发生异常时，else的语句没有被运行
3. 当执行try ...finally 语句时，无论异常是否发生，在程序结束前，finally中的语句都会被执行。
4. raise引发一个异常，比如，当一个条件不满足用户意愿时引发一个异常

#79.python中交换两个数值
```
a,b = 3,4
print("交换前：", a, b)

a,b = b,a
print("交换后：", a, b)

交换前： 3 4
交换后： 4 3
```

#80.举例说明zip（）函数用法
函数用于将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。如果各个迭代器的元素个数不一致，则返回列表长度与最短的对象相同，利用 * 号操作符，可以将元组解压为列表

函数用于将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的对象，这样做的好处是节约了不少的内存。

```
a = [1,2,3]
b = [4,5,6]
c = [4,5,6,7,8]

zipped = zip(a, b)
print(list(zipped))
# print(list(zip(*zipped)))

zipped = zip(a, c)
print(list(zipped))
# print(list(zip(*zipped)))


l = ['a', 'b', 'c', 'd', 'e','f']
print(list(zip(l[:-1],l[1:])))

[(1, 4), (2, 5), (3, 6)]
[(1, 4), (2, 5), (3, 6)]
[('a', 'b'), ('b', 'c'), ('c', 'd'), ('d', 'e'), ('e', 'f')]
```


#81.a="张明 98分"，用re.sub，将98替换为100
python re.sub属于python正则的标准库,主要是的功能是用正则匹配要替换的字符串
然后把它替换成自己想要的字符串的方法
命令：re.sub(pattern, repl, string, count=0, flags=0)
re.sub 用于替换字符串的匹配项。如果没有匹配到规则，则原字符串不变。
    第一个参数：规则 
    第二个参数：替换后的字符串 
    第三个参数：字符串 
    第四个参数：替换个数。默认为0，表示每个匹配项都替换
```
import re
a="张明 98分"
pattern = re.compile(r'\d+')
pattern.findall(a)
out = re.sub(pattern, '100', a)
print(out)
```

#82.写5条常用sql语句
```
show databases;
show tables;
desc 表明;
select * from 表明;
update 表明 set 字段=值 where 字段=值;
update students set gender=0,hometown="北京" where id=5
delete from 表名 where id=5;
insert into 表明（字段1，字段2，...） values(值1，值2，...)
```

#83.a="hello"和b="你好"编码成bytes类型
```
a = b"hello"
b = "你好".encode()
print(a, b)
print(type(a), type(b))
```

#84.[1,2,3]+[4,5,6]的结果是多少？
```
a = [1,2,3]
b = [4,5,6]
print(a+b)

[1, 2, 3, 4, 5, 6]

```

#85.提高python运行效率的方法
python是一门解释性语言(高级语言可以按照翻译成机器语言的不同方式分为编译性语言和解释性语言，编译性语言指的是运行的时候先经过编译，即生成一个可执行文件，如.exe，以后运行这个.exe的时候就不用经过编译了，效率高。解释性语言指的是翻译的方式是解释，就是不经过编译，但是每一次运行都要解释一次，运行效率比编译性语言低)，因此需要尽可能地避免造成运行效率低的情况。

1、使用生成器，因为可以节约大量内存
2、循环代码优化，避免过多重复代码的执行
3、核心模块用Cython  PyPy等，提高效率
4、多进程、多线程、协程
5、多个if elif条件判断，可以把最有可能先发生的条件放到前面写，这样可以减少程序判断的次数，提高效率

1.数据结构一定要选对
能用字典就不用列表：字典在索引查找和排序方面远远高于列表。我的数据集比较大，有百万个数据，有一部分代码是我要进行排序，一开始我选择的是列表，但是排序完成之后需要8分钟，这样真的太慢了，后来我选用了字典之后，只用了十几秒就出了结果。这个效果是令我震惊的。

2.多用python中封装好的模块库
我现在用的主要的模块有numpy,matplotlib,pandas这三个。matplotlib是绘图库,numpy和pandas是很强大的,

numpy主要是用于计算的，里面有一个数据类型叫numpy.ndarray。ndarray 是一个多维的数组对象，具有矢量算术运算能力和复杂的广播能力，并具有执行速度快和节省空间的特点。

ndarray 的一个特点是同构：即其中所有元素的类型必须相同。

list是python基本数据类型，它的元素类型可以不同
ndarray是numpy的一种数据类型，它所包含的元素必须相同

ndarray类型拥有很多便捷的函数可以进行矩阵运算，而pandas在大数据的处理方面有更加强大的能力。我在这方面的主要应用是将数据保存成.csv文件和从.csv文件中读入的时候用到了这个模块，用到了pandas中的Dataframe和Series

1.1.1. 找出速度瓶颈
先学会怎么去找出速度瓶颈: Python 自带有profile模块
import profile
profile.run (’想要检查的函数名()’)
就会打印出那个函数里调用了几次其它函数, 各用了多少时间, 总共用了多少时间等信息,
也可以用time模块中的time() 来显示系统时间, 减去上次的time()就是与它的间隔秒数了.

1.1.2. 字串相并
longStr = "".join(shortStrs)
但如果shortStrs里面不都是字串, 而包含了些数 字呢 ? 直接用join就会出错. 不怕, 这样来
shortStrs = [str(s) for s in shortStrs[i]]
longStr = "".join(shortStrs)
对少数几个字串相并, 应避免用: all = str0 + str1 + str2 + str3 而用: all = ‘%s%s%s%s’ % (str0, str1, str2, str3)

1.1.3. 数列排序
list.sort ()
你可以按特定的函数来: list.sort( 函数 ), 只要这个函数接受 两参数, 并按特定规则返回1, 0, -1就可以. — 很方便吧? 但 会大大减慢运行速度. 下面的方法, 俺举例子来说明可能更容易 明白.

比方说你的数列是 l = ['az', 'by'], 你想以第二个字母来排序. 先取出你的关键词, 并与每个字串组成一个元组: new = map (lambda s: (s[1], s), l )

于是new变成[('z', 'az'), ('y', 'by')], 再把new排一下序: new.sort()

则new就变成 [('y', 'by'), ('z', 'az')], 再返回每个元组中 的第二个字串: sorted = map (lambda t: t[1], new)
于是sorted 就是: ['by', 'az']了. 这里的lambda与map用得很好.

1.1.4. 循环
比如for循环. 当循环体很简单时, 则循环的调用前头(overhead) 会显得很臃肿, 此时map又可以帮忙了. 比如你想把一个长数列 l=['a', 'b', ...]中的每个字串变成大写, 可能会用:
import string
l=['a', 'b', ...]
newL = []
for s in l: 
    newL.append(string.upper(s))

用map就可以省去for循环的前头
import string
l=['a', 'b', ...]
newL = map(string.upper, l)

1.1.5. 局域变量 及 ‘.’
象上面,若用 append = newL.append, 及换种import方法:
import string
append = newL.append
for s in l: append (string.upper(s))
会比在for中运行newL.append快一些, 为啥? 局域变量容易寻找.

基本循环: 3.47秒
去点用局域变量: 1.79秒
使用map: 0.54秒

1.1.6. try的使用
比如你想计算一个字串数列: l = ['I', 'You', 'Python ', 'Perl', ...] 中每个词出现的次数, 你可能会:
count = {}
for s in l:
    if not count.has_key(s): 
        count[s] = 0
    else: 
        count[s] += 1

由于每次都得在count中寻找是否已有同名关键词, 会很费时间. 而用try:
count = {}
for s in l:
    try: count[s] += 1
    except KeyError: count[s] = 0
就好得多. 当然若经常出现例外时, 就不要用try了.

1.1.7. import语句
这好理解. 就是避免在函数定义中来import一个模块, 应全在 全局块中来import

1.1.8. 大量数据处理
由于Python 中的函数调用前头(overhead)比较重, 所以处理大量 数据时, 应:
def f():
    for d in hugeData:
        ...
f()
而不要:
def f(d):
    for d in hugeData: 
        f(d)
这点好象对其它语言也适用, 差不多是放之四海而皆准, 不过对 解释性语言就更重要了.

1.1.9. 减少周期性检查
这是Python 的本征功能: 周期性检查有没有其它绪(thread)或系 统信号(signal)等要处理.
可以用sys模块中的setcheckinterval 来设置每次检查的时间间隔.
缺省是10, 即每10个虚拟指令 (virtual instruction)检查一次.
当你不用绪并且也懒得搭理 系统信号时, 将检查周期设长会增加速度, 有时还会很显著.
—编/译完毕. 看来Python 是易学难精了, 象围棋?

我们自个儿的体悟
在“大量数据处理”小节里，是不是说，不要再循环体内部调用函数，应该把函数放到外面？
从Python2.2开始,”找出速度瓶颈”,已经可以使用hotshot模块了,据说对程序运行效率的影响要比profile小. — jacobfan

“由于Python 中的函数调用前头(overhead)比较重, 所以处理大量 数据时, 应: ” 这句译文中,overhead翻译成”前头”好象不妥.翻译成”由于Python 中函数调用的开销比较大,…”要好些 — jacobfan 

数组排序中讲的方法真的会快点吗? 真的快到我们值得放弃直接用sort得到得可读性吗?值得怀疑 — hoxide

Python2.4以后 sort和sorted的使用更加灵活，link已经加到文中，我没有比较过效率。-yichun

关于 “try的使用”：
其实setdefault方法就是为这个目的设的：
count = {}
for s in l:
    count.setdefault(s, 0) += 1
这个其实能做更多。通常遇到的问题是要把类似的东西group起来，所以你可能想用：
count = {}
for s in l:
    count.setdefault(s, []).append(s)
但是这样你只能把同样的东西hash起来，而不是一类东西。比如说你有一个dict构成的list叫sequence，需要按这些dict的某个key value分类，你还要对分类后的每个类别里面的这些dict各作一定的操作，你就需要用到Raymond实现的这个groupby，你就可以写:
totals = dict((key, group)
    for key, group in groupby(sequence, lambda x: x.get(’Age’)))

说明：增加代码的描述力，可以成倍减少你的LOC，做到简单，并且真切有力
观点：少打字＝多思考＋少出错，10代码行比50行更能让人明白，以下技巧有助于提高5倍工作效率



1. 交换变量值时避免使用临时变量：(cookbook1.1)
老代码：我们经常很熟练于下面的代码
temp = x
x = y
y = temp
代码一：
u, v, w = w, v, u  
有人提出可以利用赋值顺序来简化上面的三行代码成一行
代码二：
u, v = v, u  
其实利用Python元组赋值的概念，可更简明 -- 元组初始化 + 元组赋值

2. 读字典时避免判断键值是否存在：(cookbook1.2)
d = { 'key': 'value' }
老代码：
if 'key' in d: print d['key']
else: print 'not find'
新代码：
print d.get('key', 'not find')   

3. 寻找最小值和位置的代码优化：
s = [ 4,1,8,3 ]
老代码：
mval, mpos = MAX, 0
for i in xrange(len(s)): 
    if s[i ] 
观点一：用Python编程，需要有“一字千金”的感觉；既然选择了Python，就不要在意单条语句的效率。
上面几点例子很基础，实际中将原始代码压缩1/5并不是不可能，我们之前一个子项目，C++代码270K，重构后Python代码只有67K，当然使用python的日志模块（logging），读写表格文本（csv）等，也功不可末，最终代码变成原来的1/4，我觉得自己的寿命延长了三倍。。。下面优化几个常用代码：

4. 文件读取工作的最简单表达：
老代码：我们需要将文本文件读入到内存中
line = ''
fp = open('text.txt', 'r')
for line in fp: text += line
代码一：
text = string.join([ line for line in open('text.txt')], ''] 
代码二：
text = ''.join([ line for line in open('text.txt')])    
代码三：
text = file('text.txt').read()  
新版本的Python可以让你写出比1，2漂亮的代码（open是file的别名，这里file更直观）

5. 如何在Python实现三元式：
老代码：用惯C++,Java,C#不喜欢写下面代码
if n >= 0: print 'positive'
else: print 'negitive'
代码一：该技巧在 Lua里也很常见
print (n >= 0) and 'positive' or 'negitive'
说明：这里的'and'和'or'相当于C中的':'和'?'的作用，道理很简单，因为如果表达式为真了那么后面的or被短路，取到'positive'；否则，and被短路，取到'negitive'
代码二：
print (n >= 0 and ['positive'] or ['negitive])[0]
说明：将两个值组装成元组，即使'positive'是None, '', 0 之类整句话都很安全
代码三：
print ('negitive', 'positive')[n >= 0]
说明：(FalseValue, TrueValue)[Condition] 是利用了 元组访问 + True=1 两条原理

6. 避免字典成员是复杂对象的初始化：(cookbook1.5)
老代码：
if not y in d: d[y] = { }
d[y][x] = 3
新代码：
d.setdefault(y, { })[x] = 3
如果成员是列表的话也一样: d.setdefault(key, []).append(val)
上面六点技巧加以发挥，代码已经很紧凑了，但是还没有做到“没有一句废话”可能有人怀疑真的能减少1/5的代码么？？我要说的是1/5其实很保守，Thinking in C++的作者后来用了Python以后觉得Python甚至提高了10倍的工作效率。下面的例子可以进一步说明：
例子1：把文本的IP地址转化为整数
说明：需要将类似'192.168.10.214'的IP地址转化为 0x0C0A80AD6，在不用 inet_aton情况下。当C++/Java程序员正为如何进行文本分析，处理各种错误输入烦恼时，Python程序员已经下班：
f = lambda ip: sum( [ int(k)*v for k, v in zip(ip.split('.'), [1
首先ip.split('.')得到列表['192','168','10','214']，经过zip一组装，就变成
[('192',0x1000000),('168',0x10000),('10',0x100),('214',1)] 
接着for循环将各个元组的两项做整数乘法，最后将新列表的值用sum求和，得到结果
C++程序员不肖道：“你似乎太相信数据了，根本没有考虑道错误的输入”
Python程序员回答：“外面的try/except已帮我完成所有异常处理，不必担心越界崩溃而无法捕获”
Java程序员得意的看着自己百行代码：“我想知道你如何让你的同事来理解你的杰作？你有没有考虑过将类似gettoken之类的功能独立处理，让类似问题可以复用？我的代码说明了如何充分发挥Reflection和interface的优秀特性，在增加重用性的同时，提供清晰可读的代码”
Python无奈道：“这是‘纯粹的代码’，意思是不可修改，类似正则表达式，只要让人明白他的功能就行了，要修改就重写。再我能用三行代码完成以内绝不会有封装的想法，况且熟悉Python者也不觉得难读啊？”
C++程序员抛出杀手简：“如果让你一秒钟处理10w个ip转化的话怎么办？”
Python程序员觉得想睡觉：“你觉得我会蠢到还用Python做这样的事情么？”
此时C++程序员似乎并没听到，反而开始认真的思考起自己刚才提出问题来，一会只见他轻藐的看了另外两人一眼，然后胸有成竹的转到电脑前，开始往屏幕上输入： “template <....”
小笑话：封装的陷阱，让人一边喊着“封装”或“复用”，一边在新项目中，全部打破重写，并解释为--重构
观点二：简单即是美，把一个东西设计复杂了，本身就是有问题的
思考题：上面的程序，如果反过来，将ip的整数形式转化为字符串，各位该如何设计呢？？
例子2：输出一个对象各个成员的名称和值
g = lambda m: '\n'.join([ '%s=%s'%(k, repr(v)) for k, v in m.__dict__.iteritems() ])
用法：print g(x)
延伸：上面两个例子熟悉了lambda以后，建议可以尝试使用下 yield

观点总结
Q:“怎样才算做到注重What you think多于What you are writing”
A:“就是说你手上打着第1页需求的代码，眼睛却在看着第2页需求的内容，心里想着如何应对5-10页的东西”
国外多年前废除PASCAL改用Python做科研教学是有道理的，关于精简代码的例子举不胜举，用它编码时应该有“一字千金”的感觉，否则最终写出来的，还是“伪装成Python的C++程序”。
编程本来就是快乐的，避免过多的体力劳动，赢得更多思考的时间。
思考题：到底是封装呢？还是放弃封装？
思考题：“more than one way to do it”是不是就是好事？它的反面是什么？

#86.简述mysql和redis区别
redis： 内存型非关系数据库，数据保存在内存中，速度快
mysql：关系型数据库，数据保存在磁盘中，检索的话，会有一定的Io操作，访问速度相对慢

#87.遇到bug如何处理
1、细节上的错误，通过print（）打印，能执行到print（）说明一般上面的代码没有问题，分段检测程序是否有问题，如果是js的话可以alert或console.log
2、如果涉及一些第三方框架，会去查官方文档或者一些技术博客。
3、对于bug的管理与归类总结，一般测试将测试出的bug用teambin等bug管理工具进行记录，然后我们会一条一条进行修改，修改的过程也是理解业务逻辑和提高自己编程逻辑缜密性的方法，我也都会收藏做一些笔记记录。
4、导包问题、城市定位多音字造成的显示错误问题

#88.正则匹配，匹配日期2018-03-20

其实匹配并不难，提取一段特征语句，用（.*?）匹配即可
```
import re
url='https://sycm.taobao.com/bda/tradinganaly/overview/get_summary.json?dateRange=2018-03-20%7C2018-03-20&dateType=recent1&device=1&token=ff25b109b&_=1521595613462'
result = re.findall(r'dateRange=(.*?)%7C(.*?)&', url)
print(result)
```

#89.list=[2,3,5,4,9,6]，从小到大排序，不许用sort，输出[2,3,4,5,6,9]
利用min()方法求出最小值，原列表删除最小值，新列表加入最小值，递归调用获取最小值的函数，反复操作
```
# 第一版
li = [2,3,5,4,9,6]

res = []
for i in range(len(li)):
    min_value = li[i]
    for j in li[i + 1:len(li)]:
        if min_value > j:
            li[i + 1] = min_value
            min_value = j

    res.append(min_value)

print(res)

# 第二版
li = [2,3,5,4,9,6]
res = []
def get_min(l):
    a = min(l)
    l.remove(a)
    res.append(a)
    if len(l) > 0:
        get_min(l)
    return res
res = get_min(li)
print(res)
```


#90.写一个单列模式
因为创建对象时__new__方法执行，并且必须return 返回实例化出来的对象所cls.__instance是否存在，不存在的话就创建对象，存在的话就返回该对象，来保证只有一个实例对象存在（单列），打印ID，值一样，说明对象同一个
```
class Singleton(object):
    __instance = None

    def __new__(cls, *args, **kwargs):
        # 如果类属性__instance=None,那么就创建一个对象，并且赋值为这个对象的引用，保证下次调用这个方法
        # 能够知道之前已经创建过对象了，这样就保证了只有1个对象
        if not cls.__instance:
            cls.__instance = object.__new__(cls)
        return cls.__instance

a = Singleton(10, "aaa")
b = Singleton(20, "bbb")

print(id(a))
print(id(b))
```

#91.保留两位小数
题目本身只有a="%.03f"%1.3335,让计算a的结果，为了扩充保留小数的思路，提供round方法（数值，保留位数）
```
a="%.03f" % 1.3335
print(a, type(a))
b = round(float(a), 1)
print(b)
b = round(float(a), 2)
print(b)

# 结果：
1.333 <class 'str'>
1.3
1.33
```

#92.求三个方法打印结果
fn("one",1）直接将键值对传给字典；
fn("two",2)因为字典在内存中是可变数据类型，所以指向同一个地址，传了新的参数后，会相当于给字典增加键值对
fn("three",3,{})因为传了一个新字典，所以不再是原先默认参数的字典
```
def fn(k, v, dic={}):
    dic[k] = v
    print(dic)

fn("one", 1)
fn("two", 2)
fn("three", 3, {})

# 结果：
{'one': 1}
{'one': 1, 'two': 2}
{'three': 3}
```


#93.列出常见的状态码和意义
200 OK 请求正常处理完毕
204 No Content 请求成功处理，没有实体的主体返回
206 Partial Content GET范围请求已成功处理
301 Moved Permanently 永久重定向，资源已永久分配新URI
302 Found 临时重定向，资源已临时分配新URI
303 See Other 临时重定向，期望使用GET定向获取
304 Not Modified 发送的附带条件请求未满足
307 Temporary Redirect 临时重定向，POST不会变成GET
400 Bad Request 请求报文语法错误或参数错误
401 Unauthorized 需要通过HTTP认证，或认证失败
403 Forbidden 请求资源被拒绝
404 Not Found 无法找到请求资源（服务器无理由拒绝）
500 Internal Server Error 服务器故障或Web应用故障
503 Service Unavailable 服务器超负载或停机维护


#94.分别从前端、后端、数据库阐述web项目的性能优化
前端优化：
1、减少http请求、例如制作精灵图
2、html和CSS放在页面上部，javascript放在页面下面，因为js加载比HTML和Css加载慢，所以要优先加载html和css,以防页面显示不全，性能差，也影响用户体验差

后端优化：
1、缓存存储读写次数高，变化少的数据，比如网站首页的信息、商品的信息等。应用程序读取数据时，一般是先从缓存中读取，如果读取不到或数据已失效，再访问磁盘数据库，并将数据再次写入缓存。
2、异步方式，如果有耗时操作，可以采用异步，比如celery
3、代码优化，避免循环和判断次数太多，如果多个if else判断，优先判断最有可能先发生的情况

数据库优化：
1、如有条件，数据可以存放于redis，读取速度快
2、建立索引、外键等


#95.使用pop和del删除字典中的"name"字段，dic={"name":"zs","age":18}
```
dic={"name":"zs","age":18}
# dic.pop("name")
# print(dic)

del dic["name"]
print(dic)
```

#96.列出常见MYSQL数据存储引擎
InnoDB：支持事务处理，支持外键，支持崩溃修复能力和并发控制。如果需要对事务的完整性要求比较高（比如银行），要求实现并发控制（比如售票），那选择InnoDB有很大的优势。如果需要频繁的更新、删除操作的数据库，也可以选择InnoDB，因为支持事务的提交（commit）和回滚（rollback）。 

MyISAM：插入数据快，空间和内存使用比较低。如果表主要是用于插入新记录和读出记录，那么选择MyISAM能实现处理高效率。如果应用的完整性、并发性要求比 较低，也可以使用。

MEMORY：所有的数据都在内存中，数据的处理速度快，但是安全性不高。如果需要很快的读写速度，对数据的安全性要求较低，可以选择MEMOEY。它对表的大小有要求，不能建立太大的表。所以，这类数据库只使用在相对较小的数据库表。


#97.计算代码运行结果，zip函数历史文章已经说了，得出[("a",1),("b",2)，("c",3),("d",4),("e",5)]
```
a = zip(("a", "b", "c", "d", "e"), (1, 2, 3, 4, 5))
a0 = dict(a)
a1 = range(10)
a2 = [i for i in a1 if i in a0]
a3 = [a0[s] for s in a0]
a4 = list(a)

print("a0", a0)
print("a1", a1)
print("a2", a2)
print("a3", a3)
print("a4", a4)
print(list(zip(("a", "b", "c", "d", "e"), (1, 2, 3, 4, 5))))

# 结果：
a0 {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5}
a1 range(0, 10)
a2 []
a3 [1, 2, 3, 4, 5]
a4 []
[('a', 1), ('b', 2), ('c', 3), ('d', 4), ('e', 5)]

```

#98.简述同源策略
同源策略需要同时满足以下三点要求： 
1）协议相同 
2）域名相同 
3）端口相同
http:www.test.com与https:www.test.com 不同源——协议不同 
http:www.test.com与http:www.admin.com 不同源——域名不同 
http:www.test.com与http:www.test.com:8081 不同源——端口不同
只要不满足其中任意一个要求，就不符合同源策略，就会出现“跨域”

#99.简述cookie和session的区别
1. session 在服务器端，cookie 在客户端（浏览器）
2. session 的运行依赖 session id，而 session id 是存在 cookie 中的，也就是说，如果浏览器禁用了 cookie ，同时 session 也会失效，存储Session时，键与Cookie中的sessionid相同，值是开发人员设置的键值对信息，进行了base64编码，过期时间由开发人员设置
3. cookie安全性比session差


#100.简述多线程、多进程
进程：
1. 操作系统进行资源分配和调度的基本单位，多个进程之间相互独立
2. 稳定性好，如果一个进程崩溃，不影响其他进程，但是进程消耗资源大，开启的进程数量有限制

线程：
1. CPU进行资源分配和调度的基本单位，线程是进程的一部分，是比进程更小的能独立运行的基本单位，一个进程下的多个线程可以共享该进程的所有资源
2. 如果IO操作密集，则可以多线程运行效率高，缺点是如果一个线程崩溃，都会造成进程的崩溃

应用：
IO密集的用多线程，在用户输入，sleep 时候，可以切换到其他线程执行，减少等待的时间
CPU密集的用多进程，因为假如IO操作少，用多线程的话，因为线程共享一个全局解释器锁，当前运行的线程会霸占GIL，其他线程没有GIL，就不能充分利用多核CPU的优势










