# Python 打包发布pypi流程


将代码打包并上传到pypi上，大体上分为以下几步：

### 整理代码的目录结构
```
faketranslate
├── LICENSE
├── README.md
├── Pipfile
├── Pipfile.lock
├── setup.py
├── setup.cfg
├──faketranslate
│   ├──__init__.py
│   ├──metadata.py
│   ├──translate.py
│   └──setting.py

LICENSE:		文件是授权文件，比如：MIT license， APACHE license
README.md:		文件想必大家都不陌生，其实就是项目介绍和使用说明
README.rst: 	文件想必大家都不陌生，其实就是项目介绍和使用说明
Pipfile:		版本依赖关系以及第三方库
Pipfile.lock:	版本依赖关系以及第三方库
setup.cfg:		fake-translate的全局配置文件
setup:			文件才是重点，是python模块安装所需要的文件，它的格式如下:
```

### setup.py模块文件
```
# -*- encoding: utf-8 -*-
from __future__ import with_statement
from __future__ import print_function
import sys
from codecs import open

if sys.version_info < (2, 5):
    sys.exit('Python 2.5 or greater is required.')

import os
import re

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup, find_packages

BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# with open(os.path.join(BASE_DIR, 'faketranslate', 'metadata.py')) as f:
#     meta_file = f.read()
# # 读取metadata.py文件内容
# md = dict(re.findall(r"__([a-z]+)__\s*=\s*'([^']+)'", meta_file))

# with open(os.path.join(BASE_DIR, 'README.md'), 'r', encoding='utf-8') as f:
#     long_description = f.read()


try:
    from pypandoc import convert


    def read_md(f):
        return convert(f, 'rst')
except ImportError:
    convert = None
    print('warning:pypandoc not found')

README = os.path.join(os.path.dirname(__file__), 'README.md')


def get_version(version_tuple):
    if not isinstance(version_tuple[-1], int):
        return '.'.join(map(str, version_tuple[:-1])) + version_tuple[-1]

    return '.'.join(map(str, version_tuple))


init = os.path.join(os.path.dirname(__file__), 'faketranslate', '__init__.py')

version_line = list(
    filter(lambda l: l.startswith("VERSION"), open(init))
)[0]

VERSION = get_version(eval(version_line.split('=')[-1]))

setup(
    name='fake-translate',
    version=VERSION,
    description='An efficient and practical translation tool',
    long_description=read_md(README),
    long_description_content_type='text/markdown',
    author='hywell',
    author_email='opencoding@hotmail.com',
    maintainer='hywell',
    maintainer_email='opencoding@hotmail.com',
    url='https://github.com/HeywoodKing/faketranslate',
    download_url='https://github.com/HeywoodKing/faketranslate',
    license='AGPLv3+',
    keywords='python translate',
    project_urls={
        'Documentation': 'https://packaging.python.org/tutorials/distributing-packages/',
        'Funding': 'https://donate.pypi.org',
        'Source': 'https://github.com/pypa/sampleproject/',
        'Tracker': 'https://github.com/pypa/sampleproject/issues',

    },
    # py_modules=['faketranslate'],
    # packages=['faketranslate'],
    packages=find_packages(exclude=['contrib', 'docs', 'tests']),
    platforms=["all"],
    install_requires=[
        'requests>=2.22.0',
        'fake_useragent>=0.1.11',
    ],
    python_requires='>=2.6',
    zip_safe=False,
    include_package_data=True,
    # entry_points={
    #     'console_scripts': [
    #         'faketranslate=faketranslate:main'
    #     ],
    # },
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Environment :: Web Environment',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU Affero General Public License v3 or later (AGPLv3+)',
        'Natural Language :: Chinese (Simplified)',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3',
        'Topic :: Utilities',
    ],
)

classifiers:
文中的classifiers的内容并不是随便填写的，你需要参照本文参考文档中的[PyPI Classifiers](https://pypi.org/classifiers/ "PyPI Classifiers")来写

```

### setup.cfg
```
[global]
quiet = 1

[sdist]
formats = zip,tar

[bdist_wheel]
universal = 1

[metadata]
description-file = README.md
```

### 开始使用Distutils进行打包
为了保证效果，在打包之前我们可以验证setup.py的正确性，执行下面的代码
```
python setup.py check

输出:running check
表示没有任何问题
如果没有问题，那么就可以正式打包，执行下面的步骤
```


#### 构建源码包
```
python setup.py sdist
或者
python setup.py sdist build
执行完成后，会在顶层目录下生成dist目录和fake_translate.egg-info目录

faketranslate
├── dist
│   ├──fake-translate-0.1.3.linux-x86_64.tar.gz
├── fake_translate.egg-info
│   ├──dependency_links.txt
│   ├──not-zip-safe
│   ├──PKG-INFO
│   ├──requires.txt
│   ├──SOURCES.txt
│   ├──top_level.txt
├── LICENSE
├── README.md
├── Pipfile
├── Pipfile.lock
├── setup.py
├── setup.cfg
├──faketranslate
│   ├──__init__.py
│   ├──metadata.py
│   ├──translate.py
│   └──setting.py

```

#### 构建预览发行包
```
python setup.py bdist
执行完成后，会在顶层目录下生成build目录

faketranslate
├── build
│   ├──bdist.linux-x86_64
│   ├──lib  
│   │	├──faketranslate
│   │   │	├──__init__.py
│   │   │	├──metadata.py
│   │   │	├──translate.py
│   │   │	├──setting.py
├── dist
│   ├──fake-translate-0.1.3.linux-x86_64.tar.gz
├── fake_translate.egg-info
│   ├──dependency_links.txt
│   ├──not-zip-safe
│   ├──PKG-INFO
│   ├──requires.txt
│   ├──SOURCES.txt
│   ├──top_level.txt
├── LICENSE
├── README.md
├── Pipfile
├── Pipfile.lock
├── setup.py
├── setup.cfg
├──faketranslate
│   ├──__init__.py
│   ├──metadata.py
│   ├──translate.py
│   └──setting.py
```

#### 构建whl包
```
python setup.py bdist_wheel --universal

这样会在dist文件夹下生成一个whl文件

faketranslate
├── build
│   ├──bdist.linux-x86_64
│   ├──lib  
│   │	├──faketranslate
│   │   │	├──__init__.py
│   │   │	├──metadata.py
│   │   │	├──translate.py
│   │   │	├──setting.py
├── dist
│   ├──fake_translate-0.1.3-py2.py3-none-any.whl
│   ├──fake-translate-0.1.3.linux-x86_64.tar.gz
├── fake_translate.egg-info
│   ├──dependency_links.txt
│   ├──not-zip-safe
│   ├──PKG-INFO
│   ├──requires.txt
│   ├──SOURCES.txt
│   ├──top_level.txt
├── LICENSE
├── README.md
├── Pipfile
├── Pipfile.lock
├── setup.py
├── setup.cfg
├──faketranslate
│   ├──__init__.py
│   ├──metadata.py
│   ├──translate.py
│   └──setting.py
```

打包完成后就可以准备将打包好的模块上传到pypi了,首先你需要在pypi上进行注册，这里您可以注册同样的用户名和密码防止混乱遗忘
[pypi注册](https://pypi.org/account/register/ "pypi注册")   

[test pypi注册](https://test.pypi.org/account/register/ "test pypi注册")

注册完成后，你需要在本地创建好pypi的配置文件，不然有可能会出现使用http无法上传到pypi的问题
在用户的home目录下创建.pypirc文件
```
vim .pypirc
文件的内容如下:
[distutils]
index-servers=
	pypi
	pypitest

[pypi]
repository: https://upload.pypi.org/legacy/
username:xxx

[pypitest]
repository: https://test.pypi.org/legacy/
username:xxx

用户名分别是刚才注册的正式pypi和测试pypi用户账号

赋值权限
chmod 600 ~/.pypirc
```

### 网上说发布之前需要运行一下命令
```
但是我没有运行此命令依旧可以上传
python setup.py register -r pypi
```


### 发布到pypi
```

测试地址
python setup.py sdist upload -r pypitest
python setup.py bdist_wheel upload -r pypitest

-r pypitest
--repository pypitest
--repository-url https://test.pypi.org/legacy/


正式地址
python setup.py sdist upload
python setup.py bdist_wheel upload
或者
python setup.py sdist upload -r pypi
python setup.py bdist_wheel upload -r pypi

-r pypi
--repository pypi
--repository-url https://upload.pypi.org/legacy/
```
回车后会提示输入密码

以上方法不推荐，因为使用setuptools上传时，你的用户名和密码是明文或者未加密传输，安全起见还是使用twine吧


### 发布到pypi(twine)
```
pip3 install twine -i https://pypi.douban.com/simple
或
pipenv install twine

twine upload dist/* -r pypi
twine upload dist/* -r pypitest
或
twine upload dist/* --repository pypi
twine upload dist/* --repository pypitest
或
twine upload dist/* --repository-url https://upload.pypi.org/legacy
twine upload dist/* --repository-url https://test.pypi.org/legacy
```
回车后会提示输入密码





### 通过twine发布python程序
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

