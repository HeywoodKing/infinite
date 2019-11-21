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
```

## 卸载包 
```
pip uninstall SomePackage
```

## 升级指定的包
```
pip install -U SomePackage
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

### 通过pip发布python程序
#### pypi

写过 Python 程序的小伙伴们都知道，需要 import 个非 Python 自带的软件包时，都要用到 pip 这个程序。平时我们都是用 pip，如果我们写好了一个程序，想让大家都能用的到，那么是不是也可以通过 pip 发布出去呢？

答案当然是可以了，这篇文章我们就来看看如何用 pip 发布一个 python 程序。

1. 环境准备
要用 pip 发布 python 程序，首先当然是要安装 Python 和 pip 这两个软件了，以 Ubuntu 16.04 为例：
```
$ sudo apt update 
$ sudo apt install -y python python-pip
```
CentOS 和 RedHat 因为 RPM 体系需要依赖于 python，更是默认就安装好了。
另外发布 Pypi，还需要安装一个发布工具，twine，以及其所依赖的 setuptools、wheel：
`$ sudo pip install --upgrade twine setuptools wheel`
好，到这环境就已经就绪了。

2. 注册帐号
pip 上传代码包是最终保存在 https://pypi.org 这个网站上的，所以要用 pip 发布程序，就需要在这个网站上注册一个帐号。
访问该网址进行注册：https://pypi.org/account/register/
 [图片上传失败...(image-68efd2-1537870722761)]
 注册后还需要进行邮箱验证，流程和普通网站没有任何区别，所以具体步骤就不在这里详细介绍了。

3. 代码结构
要发布 Python 程序，程序的结构必须符合特定的要求，假设要发布的程序名为 example-pkg，基本的目录结构如下：
```
/example-pkg
  /example-pkg
    __init__.py
  setup.py
  LICENSE
  README.md

说一下目录和文件的含义：

首先最外层要建立一个和发出程序同名的文件夹：/example-pkg 
该文件夹下还要再创建一个同名文件夹，用来存放程序代码：/example-pkg/example-pkg 
Python 的老规矩，example-pkg/example-pkg 目录下当然要有一个 __init__.py 文件。
 /example-pkg 目录下要有一个叫 setup.py 的文件，如果下载过 Python 代码包，应该都知道这个文件，需要通过这个文件进行 Python 代码的编译（可能会有依赖的其他代码包或者依赖的 C 文件）和安装。
LICENSE 文件：这个文件就是用来保存代码所使用的开源许可证。
README.md：这个是软件通信的管理了，帮助文档。

对于 setup.py 文件，还有必要好好说说，先贴个例子，下面这个例子中，主要是实现了从 /example-pkg/example-pkg/init.py 文件中读取 version 参数，来配置当前软件的版本，并指定了代码包名（name）、作者（author）、邮箱（author_email）、描述信息（long_description、long_description_content_type）、依赖（install_requires），以及哪些文件不会被打包到程序中（exclude_package_data）。

另外需要提醒大家一点，给程序起名字不要带下划线（_），python import 代码包时是不支持下划线，出现这种情况就比较尴尬了，代码装上了，还是用不了。
```
#!/usr/bin/env python

import re
import setuptools

version = ""
with open('example-pkg/__init__.py', 'r') as fd:
    version = re.search(r'^__version__\s*=\s*[\'"]([^\'"]*)[\'"]',
                        fd.read(), re.MULTILINE).group(1)

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="example-pkg",
    version=version,
    author="example",
    author_email="author@example.com",
    description="This is the SDK for example.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="http://example.com",
    install_requires=[
        'requests!=2.9.0',
        'lxml>=4.2.3',
        'monotonic>=1.5',
    ],
    packages=setuptools.find_packages(exclude=("test")),
    classifiers=(
        "License :: OSI Approved :: MIT License",
        "Intended Audience :: Developers",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.6",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.3",
        "Programming Language :: Python :: 3.4",
        "Programming Language :: Python :: 3.5"
    ),
    exclude_package_data={'': ["example-pkg/test.py", "example-pkg/config.txt"]},
)
```

4. 上传和检查
一切准备就绪，下面就可以执行打包命令，产生要上传的代码包了：
`$ python setup.py sdist bdist_wheel`
执行结束后，会产生如下目录和文件：
```
/example-pkg/dist/
  example-pkg-0.0.1-py3-none-any.whl
  example-pkg-0.0.1.tar.gz
````
包有了，就差上传了，执行第一步中安装的 twine 命令：
```
$ twine upload dist/*
Uploading distributions to https://upload.pypi.org/legacy/
Enter your username: <your pypi.org username>
Enter your password: <your pypi.org password>
Uploading example-pkg-0.0.1-py3-none-any.whl
100%|45.0k/45.0k [00:01<00:00, 24.0kB/s]
Uploading example-pkg-0.0.1.tar.gz
100%|43.8k/43.8k [00:00<00:00, 46.2kB/s]
```
上传完毕！不过这里有一点需要注意，上传新版本后，很可能 pip search 还没法查到版本的更新，这是正常的，我理解是
 pip search 命令依赖于缓存，所以不会立刻生效。

接下来就让我们下载自己刚刚上传的 python 试试吧：
```
$ pip install example-pkg
$ python
>>> import example-pkg
>>> example-pkg.name
'example-pkg'
```

5. 参考文档
[Packaging Python Projects]('https://packaging.python.org/tutorials/packaging-projects/' Packaging Python Projects)

6. 
