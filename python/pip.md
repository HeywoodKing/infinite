# pip

## 获取帮助
```
pip --help
```

## 升级 pip
```
pip install -U pip
pip install --upgrade pip
```

## 安装包
```
pip install SomePackage

安装使用清华源
pip install package_name -i https://pypi.tuna.tsinghua.edu.cn/simple

安装使用豆瓣源
pip install package_name --trusted-host pypi.douban.com -i https://pypi.douban.com/simple

pip --default-timeout=100 install package_name
```

## 卸载包 
```
pip uninstall SomePackage
```

## 升级指定的包
```
升级指定包
pip install -U package_name
或
pip install --upgrade package_name

从豆瓣源升级指定包
pip install package_name -i http://e.pypi.python.org --trusted-host e.pypi.python.org --upgrade
```

## 搜索包
```
pip search SomePackage
```

## 查看指定包的详细信息
```
pip show -f SomePackage
```

## 列出已安装的包
```
pip freeze or pip list
```

## 查看可升级的包
```
pip list -o
```

内存检测工具

对于python代码的内存占用问题，对于代码进行内存监控十分必要。这里笔者这里推荐两个小工具来检测python代码的内存占用
```
pip install memory_profiler

memory_profiler是利用python的装饰器工作的，所以我们需要在进行测试的函数上添加装饰器。

from hashlib import sha1
import sys

@profile
def my_func():
    sha1Obj = sha1()
    with open(sys.argv[1], 'rb') as f:
        while True:
            buf = f.read(10 * 1024 * 1024)
            if buf:
                sha1Obj.update(buf)
            else:
                break

    print(sha1Obj.hexdigest())


if __name__ == '__main__':
    my_func()

之后在运行代码时加上** -m memory_profiler**
就可以了解函数每一步代码的内存占用了

guppy
依样画葫芦，仍然是通过pip先安装guppy

pip install guppy
之后可以在代码之中利用guppy直接打印出对应各种python类型（list、tuple、dict等）分别创建了多少对象，占用了多少内存。

from guppy import hpy
import sys


def my_func():
    mem = hpy()
    with open(sys.argv[1], 'rb') as f:
        while True:
            buf = f.read(10 * 1024 * 1024)
            if buf:
                print(mem.heap())
            else:
                break

通过上述两种工具guppy与memory_profiler可以很好地来监控python代码运行时的内存占用问题
```


