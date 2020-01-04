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



