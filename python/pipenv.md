# pipenv

## pipenv所要解决的问题是不确定构建的问题
pipenv 是 Pipfile 主要倡导者、requests 作者 Kenneth Reitz 写的一个命令行工具，主要包含了Pipfile、pip、click、requests和virtualenv。Pipfile和pipenv本来都是Kenneth Reitz的个人项目，后来贡献给了pypa组织。Pipfile是社区拟定的依赖管理文件，用于替代过于简陋的 requirements.txt 文件。

Python开发者应该听过pip、easy_install和virtualenv，应该还知道 virtualenvwrapper、virtualenv-burrito和autoenv，再加上pyvenv、venv（Python 3标准库）、pyenv…额，是不是有种发懵的感觉？那么现在有个好消息，你可以只使用终极方案: pipenv + autoenv（可选）。

```
Usage: pipenv [OPTIONS] COMMAND [ARGS]...

Options:
  --where             Output project home information.
  --venv              Output virtualenv information.
  --py                Output Python interpreter information.
  --envs              Output Environment Variable options.
  --rm                Remove the virtualenv.
  --bare              Minimal output.
  --completion        Output completion (to be eval'd).
  --man               Display manpage.
  --support           Output diagnostic information for use in GitHub issues.
  --site-packages     Enable site-packages for the virtualenv.  [env var:
                      PIPENV_SITE_PACKAGES]
  --python TEXT       Specify which version of Python virtualenv should use.
  --three / --two     Use Python 3/2 when creating virtualenv.
  --clear             Clears caches (pipenv, pip, and pip-tools).  [env var:
                      PIPENV_CLEAR]
  -v, --verbose       Verbose mode.
  --pypi-mirror TEXT  Specify a PyPI mirror.
  --version           Show the version and exit.
  -h, --help          Show this message and exit.


Usage Examples:
   Create a new project using Python 3.7, specifically:
   $ pipenv --python 3.7

   Remove project virtualenv (inferred from current directory):
   $ pipenv --rm

   Install all dependencies for a project (including dev):
   $ pipenv install --dev

   Create a lockfile containing pre-releases:
   $ pipenv lock --pre

   Show a graph of your installed dependencies:
   $ pipenv graph

   Check your installed dependencies for security vulnerabilities:
   $ pipenv check

   Install a local setup.py into your virtual environment/Pipfile:
   $ pipenv install -e .

   Use a lower-level pip command:
   $ pipenv run pip freeze

Commands:
  check      Checks for security vulnerabilities and against PEP 508 markers
             provided in Pipfile.
  clean      Uninstalls all packages not specified in Pipfile.lock.
  graph      Displays currently-installed dependency graph information.
  install    Installs provided packages and adds them to Pipfile, or (if no
             packages are given), installs all packages from Pipfile.
  lock       Generates Pipfile.lock.
  open       View a given module in your editor.
  run        Spawns a command installed into the virtualenv.
  shell      Spawns a shell within the virtualenv.
  sync       Installs all packages specified in Pipfile.lock.
  uninstall  Un-installs a provided package and removes it from Pipfile.
  update     Runs lock, then sync.
```

## Pipfile的基本理念是：
Pipfile 文件是 TOML 格式而不是 requirements.txt 这样的纯文本。
一个项目对应一个 Pipfile，支持开发环境与正式环境区分。默认提供 default 和 development 区分。
提供版本锁支持，存为 Pipfile.lock。
click是Flask作者 Armin Ronacher 写的命令行库，现在Flask已经集成了它。


### windows修改创建的虚拟环境存放路径

修改pipenv虚拟环境安装位置
在系统变量中创建 WORKON_HOME 变量
值填写 存放位置
```
WORKON_HOME
D:\workspace\virtualbox_env

以后所有的虚拟环境都会放在这个目录里
要想把虚拟环境放入项目文件夹
值填写：PIPENV_VENV_IN_PROJECT
```

### linux修改创建的虚拟环境存放路径
运行python -m site --user-base指令来查看自身电脑的用户基础目录的路径

然后，我们需要将/home/flack/.local/bin添加到 PATH 中。为了一劳永逸，我们可以通过 修改 ~/.profile 永久地设置 PATH。（python3对应需要添加/home/flack/./local/lib/python3.6/bin）
通过命令：$ gedit ~/.profile打开prfile文件，然后在最后一行添加字符的用户基础目录路径
```
export PATH=$PATH:/home/flack/.local/bin
```
添加成功后保存并退出profile文件。
最后注意此时系统并没有自动的更新PATH，所以我们需要运行$ source ~/.profile来手动更新：
此时，可以在命令行中键入$ pipenv来测试是否配置成功


```
来查看python3 的路径
python3 -m site --user-base

```


### 首先要安装pip才能运行以下命令
`pip install pipenv`

### 在指定目录下创建虚拟环境,首先进入到项目根目录下，会使用本地默认版本的python
`pipenv install`

### 创建一个基于Python2.7的虚拟环境
`pipenv --two`

### 使用当前系统的Python3创建环境
`pipenv --three`

### 如果要指定版本创建环境，可以使用如下命令，当然前提是本地启动目录能找到该版本的python
`pipenv --python 3.7`

### 激活虚拟环境
`pipenv shell`

### 卸载包
`pipenv uninstall numpy`

### 显示虚拟环境信息
`pipenv --venv`

### 显示目录信息
`pipenv --where`

### 显示Python解释器信息
`pipenv --py`

### 安装第三方模块, 运行后会生成Pipfile和Pipfile.lock文件
```
pipenv install requests 安装相关模块并加入到Pipfile
pipenv install flask=0.12.1 安装固定版本模块并加入到Pipfile
pipenv install django 当然也可以不指定版本
pipenv install pytest --dev 如果想只安装在开发环境才使用的包
```
不用管子依赖包，只会把我项目中实际用到的包放进去，子依赖包在pipenv install package的时候自动安装或更新。

无论是生产环境还是开发环境的包安装都会写入一个Pipfile里面，而如果是用传统方法，需要2个文件：dev-requirements.txt 和 test-requirements.txt。
接下来如果在开发环境已经完成开发，如何构建生产环境的东东呢？这时候就要使用Pipfile.lock了，运行以下命令，把当前环境的模块lock住, 它会更新Pipfile.lock文件，该文件是用于生产环境的，你永远不应该编辑它。
```
pipenv lock
```

然后只需要把代码和Pipfile.lock放到生产环境，运行下面的代码，就可以创建和开发环境一样的环境咯，Pipfile.lock里记录了所有包和子依赖包的确切版本，因此是确定构建：
```
pipenv install --ignore-pipfile
```

如果要在另一个开发环境做开发，则将代码和Pipfile复制过去，运行以下命令：
```
pipenv install --dev
```

由于Pipfile里面没有所有子依赖包或者确定的版本，因此该安装可能会更新未指定模块的版本号，这不仅不是问题，还解决了一些其他问题，我在这里做一下解释：
假如该命令更新了一些依赖包的版本，由于我肯定还会在新环境做单元测试或者功能测试，因此我可以确保这些包的版本更新是不会影响软件功能的；然后我会pipenv lock并把它发布到生产环境，因此我可以确定生产环境也是不会有问题的。这样一来，我既可以保证生产环境和开发环境的一致性，又可以不用管理众多依赖包的版本，完美的解决方案！

### 查看目前安装的库及其依赖
```
pipenv graph
举个栗子：
Flask==0.12.1
  - click [required: >=2.0, installed: 6.7]
  - itsdangerous [required: >=0.21, installed: 0.24]
  - Jinja2 [required: >=2.4, installed: 2.10]
    - MarkupSafe [required: >=0.23, installed: 1.0]
  - Werkzeug [required: >=0.7, installed: 0.14.1]
numpy==1.14.1
pytest==3.4.1
  - attrs [required: >=17.2.0, installed: 17.4.0]
  - funcsigs [required: Any, installed: 1.0.2]
  - pluggy [required: <0.7,>=0.5, installed: 0.6.0]
  - py [required: >=1.5.0, installed: 1.5.2]
  - setuptools [required: Any, installed: 38.5.1]
  - six [required: >=1.10.0, installed: 1.11.0]
requests==2.18.4
  - certifi [required: >=2017.4.17, installed: 2018.1.18]
  - chardet [required: >=3.0.2,<3.1.0, installed: 3.0.4]
  - idna [required: >=2.5,<2.7, installed: 2.6]
  - urllib3 [required: <1.23,>=1.21.1, installed: 1.22]

```

### 检查安全漏洞
```
pipenv check

Checking PEP 508 requirements…
Passed!
Checking installed package safety…
All good! 
```

pipenv依赖分析详解
pipenv每次安装核心包时，都会检测所有核心包的子依赖包，对不满足的子依赖包会做更新。如果核心包package_a和package_b依赖有矛盾，比如(package_a依赖package_c>2.0, package_b依赖package_c<1.9），则会有警告提示。

```
Pipfile
举个栗子，它是 TOML 格式的：
[[source]]
url = "https://pypi.python.org/simple"
verify_ssl = true
name = "pypi"

[dev-packages]
pytest = "*"

[packages]
flask = "==0.12.1"
numpy = "*"
requests = {git = "https://github.com/requests/requests.git", editable = true}

[requires]
python_version = "3.6"


Pipfile.lock
举个栗子，它是JSON格式的，它包含了所有子依赖包的确定版本：
{
    "_meta": {
        ...
    },
    "default": {
        "flask": {
            "hashes": [
                "sha256:6c3130c8927109a08225993e4e503de4ac4f2678678ae211b33b519c622a7242",
                "sha256:9dce4b6bfbb5b062181d3f7da8f727ff70c1156cbb4024351eafd426deb5fb88"
            ],
            "version": "==0.12.1"
        },
        "requests": {
            "editable": true,
            "git": "https://github.com/requests/requests.git",
            "ref": "4ea09e49f7d518d365e7c6f7ff6ed9ca70d6ec2e"
        },
        "werkzeug": {
            "hashes": [
                "sha256:d5da73735293558eb1651ee2fddc4d0dedcfa06538b8813a2e20011583c9e49b",
                "sha256:c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"
            ],
            "version": "==0.14.1"
        }
        ...
    },
    "develop": {
        "pytest": {
            "hashes": [
                "sha256:8970e25181e15ab14ae895599a0a0e0ade7d1f1c4c8ca1072ce16f25526a184d",
                "sha256:9ddcb879c8cc859d2540204b5399011f842e5e8823674bf429f70ada281b3cc6"
            ],
            "version": "==3.4.1"
        },
        ...
    }
}
```

我永远也不应该编辑Pipfile.lock, 它只应该由pipenv lock生成。

### 卸载全部包并从Pipfile中移除
```
pipenv uninstall --all

Found 5 installed package(s), purging…
Uninstalling certifi-2017.11.5:
  Successfully uninstalled certifi-2017.11.5
Uninstalling chardet-3.0.4:
  Successfully uninstalled chardet-3.0.4
Uninstalling idna-2.6:
  Successfully uninstalled idna-2.6
Uninstalling requests-2.18.4:
  Successfully uninstalled requests-2.18.4
Uninstalling urllib3-1.22:
  Successfully uninstalled urllib3-1.22
```


旧项目的requirments.txt转化为Pipfile
使用pipenv install会自动检测当前目录下的requirments.txt, 并生成Pipfile, 我也可以再对生成的Pipfile做修改。
此外以下命令也有同样效果, 可以指定具体文件名：
```
pipenv install -r requirements.txt
```

如果我有一个开发环境的requirent-dev.txt, 可以用以下命令加入到Pipfile:
```
pipenv install -r dev-requirements.txt --dev
```

是否要将Pipfile加入到版本管理
按照上文分析，代码和Pipfile都应该加入版本管理，Pipfile.lock就见仁见智了，我倾向于不加入到版本管理，因为Pipfile.lock在不同的操作系统，不同的开发阶段都可能发生变化。

# Windows
1. pip install --user pipenv安装pipenv在用户目录下

2. py -m site --user-site通过此命令找到用户基础目录，结果为C:\Users\u14e\AppData\Roaming\Python\Python35\site-packages

3. 将用户基础目录结尾的site-packages换成Scripts，即C:\Users\u14e\AppData\Roaming\Python\Python35\Scripts，然后将这一路径添加到系统变量中

4. 重新打开命令行工具，如cmd，pipenv --version检查是否安装成功

5. pipenv install创建一个虚拟环境

6. pipenv shell激活虚拟环境，exit推出虚拟环境

7. pipenv install requests安装python包，pipenv install django==1.11.7安装制定版本的包，pipenv uninstall requests卸载包

8. pipenv graph查看安装的包，以及依赖的其他包



# 总序
## Pipenv & 虚拟环境

#### 本教程将引导您完成安装和使用 Python 包。

它将向您展示如何安装和使用必要的工具，并就最佳做法做出强烈推荐。请记住， Python 用于许多不同的目的。准确地说，您希望如何管理依赖项可能会根据 您如何决定发布软件而发生变化。这里提供的指导最直接适用于网络服务 （包括 Web 应用程序）的开发和部署，但也非常适合管理任意项目的开发和测试环境。

### 注解
本指南是针对 Python 3 编写。但如果您由于某种原因仍然使用 Python 2.7， 这些指引应该能够正常工作。

确保您已经有了 Python 和 pip
在您进一步之前，请确保您有 Python，并且可从您的命令行中获得。 您可以通过简单地运行以下命令来检查：

`$ python --version`
您应该得到像 3.6.2 之类的一些输出。如果没有 Python，请从 python.org 安装最新的 3.x 版本，或参考本指南的 安装 Python 一节。

### 注解
如果您是新手，您会得到如下错误：

>>> python
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'python' is not defined
这是因为此命令要在 shell*（也称为 *终端 或 控制台）中运行。有关使用操作系统的 shell 并和 Python 进行交互的介绍，请参阅面向 Python 新手的 入门教程。

另外，您需要确保 pip 是可用的。您可以通过运行以下命令来检查：

`$ pip --version`
如果您使用 python.org 或 Homebrew 的安装程序来安装 Python，您应该已经有 pip 了。 如果您使用的是Linux，并使用操作系统的包管理器进行安装，则可能需要单独 安装 pip。

### 安装 Pipenv
Pipenv 是 Python 项目的依赖管理器。如果您熟悉 Node.js 的 npm 或 Ruby 的 bundler，那么它们在思路上与这些工具类似。尽管 pip 可以安装 Python 包， 但仍推荐使用 Pipenv，因为它是一种更高级的工具，可简化依赖关系管理的常见使用情况。

### 使用 pip 来安装 Pipenv：

`$ pip install --user pipenv`
### 注解
这进行了 用户安装，以防止破坏任何系统范围的包。如果安装后, shell 中没有 pipenv，则需要将 用户基础目录 的 二进制文件目录添加到 PATH 中。

在 Linux 和 macOS 上，您可以通过运行 python -m site --user-base 找到 用户基础目录，然后把 bin 加到目录末尾。比如，上述命令典型地会打印出 ~/.local``（ ``~ 会扩展为您的家目录的局对路径），然后将 ~/.local/bin 添加到 PATH 中。您可以通过 修改 ~/.profile 永久地设置 PATH。

在 Windows 上，您通过运行 py -m site --user-site 找到用户基础目录，然后 将 site-packages 替换为 Scripts。比如，上述命令可能返回为 C:\Users\Username\AppData\Roaming\Python36\site-packages，然后您需要在 PATH 中包含 C:\Users\Username\AppData\Roaming\Python36\Scripts。 您可以在 控制面板 中永久设置用户的 PATH。您可能需要登出 PATH 更改才能生效。

为您的项目安装包
Pipenv 管理每个项目的依赖关系。要安装软件包时，请更改到您的项目目录（或只是本教程中的 一个空目录）并运行：
```
$ cd myproject
$ pipenv install requests
Pipenv 将在您的项目目录中安装超赞的 Requests 库并为您创建一个 Pipfile。 Pipfile 用于跟踪您的项目中需要重新安装的依赖，例如在与他人共享项目时。 您应该得到类似的输出（尽管显示的确切路径会有所不同）：

Creating a Pipfile for this project...
Creating a virtualenv for this project...
Using base prefix '/usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6'
New python executable in ~/.local/share/virtualenvs/tmp-agwWamBd/bin/python3.6
Also creating executable in ~/.local/share/virtualenvs/tmp-agwWamBd/bin/python
Installing setuptools, pip, wheel...done.

Virtualenv location: ~/.local/share/virtualenvs/tmp-agwWamBd
Installing requests...
Collecting requests
  Using cached requests-2.18.4-py2.py3-none-any.whl
Collecting idna<2.7,>=2.5 (from requests)
  Using cached idna-2.6-py2.py3-none-any.whl
Collecting urllib3<1.23,>=1.21.1 (from requests)
  Using cached urllib3-1.22-py2.py3-none-any.whl
Collecting chardet<3.1.0,>=3.0.2 (from requests)
  Using cached chardet-3.0.4-py2.py3-none-any.whl
Collecting certifi>=2017.4.17 (from requests)
  Using cached certifi-2017.7.27.1-py2.py3-none-any.whl
Installing collected packages: idna, urllib3, chardet, certifi, requests
Successfully installed certifi-2017.7.27.1 chardet-3.0.4 idna-2.6 requests-2.18.4 urllib3-1.22

Adding requests to Pipfile's [packages]...
P.S. You have excellent taste! ✨ 🍰 ✨
使用安装好的包
现在安装了 Requests，您可以创建一个简单的 main.py 文件来使用它：

import requests

response = requests.get('https://httpbin.org/ip')

print('Your IP is {0}'.format(response.json()['origin']))
然后您就可以使用 pipenv run 运行这段脚本：

$ pipenv run python main.py
您应该获取到类似的输出：

Your IP is 8.8.8.8
使用 $ pipenv run 可确保您的安装包可用于您的脚本。我们还可以生成一个新的 shell， 确保所有命令都可以使用 $ pipenv shell 访问已安装的包。
```

下一步
恭喜，您现在知道如何安装和使用Python包了！ ✨ 🍰 ✨

更低层次: virtualenv
virtualenv 是一个创建隔绝的Python环境的 工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需的包。

它可以独立使用，代替Pipenv。

通过pip安装virtualenv：

`$ pip install virtualenv`
测试您的安装：

`$ virtualenv --version`
基本使用
为一个工程创建一个虚拟环境：
`$ cd my_project_folder`
`$ virtualenv venv`
virtualenv venv 将会在当前的目录中创建一个文件夹，包含了Python可执行文件， 以及 pip 库的一份拷贝，这样就能安装其他包了。虚拟环境的名字（此例中是 venv ） 可以是任意的；若省略名字将会把文件均放在当前目录。

在任何您运行命令的目录中，这会创建Python的拷贝，并将之放在叫做 venv 的文件中。

您可以选择使用一个Python解释器（比如``python2.7``）：

`$ virtualenv -p /usr/bin/python2.7 venv`
或者使用``~/.bashrc``的一个环境变量将解释器改为全局性的：

`$ export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7`
要开始使用虚拟环境，其需要被激活：
`$ source venv/bin/activate`
当前虚拟环境的名字会显示在提示符左侧（比如说 (venv)您的电脑:您的工程 用户名$） 以让您知道它是激活的。从现在起，任何您使用pip安装的包将会放在 ``venv 文件夹中， 与全局安装的Python隔绝开。

像平常一样安装包，比如：

`$ pip install requests`
如果您在虚拟环境中暂时完成了工作，则可以停用它：
`$ deactivate`
这将会回到系统默认的Python解释器，包括已安装的库也会回到默认的。

要删除一个虚拟环境，只需删除它的文件夹。（要这么做请执行 rm -rf venv ）

然后一段时间后，您可能会有很多个虚拟环境散落在系统各处，您将有可能忘记它们的名字或者位置。

其他注意事项
运行带 --no-site-packages 选项的 virtualenv 将不会包括全局安装的包。 这可用于保持包列表干净，以防以后需要访问它。（这在 virtualenv 1.7及之后是默认行为）

为了保持您的环境的一致性，“冷冻住（freeze）”环境包当前的状态是个好主意。要这么做，请运行：

`$ pip freeze > requirements.txt`
这将会创建一个 requirements.txt 文件，其中包含了当前环境中所有包及 各自的版本的简单列表。您可以使用 pip list 在不产生requirements文件的情况下， 查看已安装包的列表。这将会使另一个不同的开发者（或者是您，如果您需要重新创建这样的环境） 在以后安装相同版本的相同包变得容易。

`$ pip install -r requirements.txt`
这能帮助确保安装、部署和开发者之间的一致性。

最后，记住在源码版本控制中排除掉虚拟环境文件夹，可在ignore的列表中加上它。 （查看 版本控制忽略）

### virtualenvwrapper
virtualenvwrapper 提供了一系列命令使得和虚拟环境工作变得愉快许多。它把您所有的虚拟环境都放在一个地方。

安装（确保 virtualenv 已经安装了）：
```
$ pip install virtualenvwrapper
$ export WORKON_HOME=~/Envs
$ source /usr/local/bin/virtualenvwrapper.sh
(virtualenvwrapper 的完整安装指引.)
```
对于Windows，您可以使用 virtualenvwrapper-win 。

安装（确保 virtualenv 已经安装了）：

`$ pip install virtualenvwrapper-win`
在Windows中，WORKON_HOME默认的路径是 %USERPROFILE%\Envs 。

基本使用
创建一个虚拟环境：
`$ mkvirtualenv my_project`
这会在 ~/Envs 中创建 my_project 文件夹。

在虚拟环境上工作：
`$ workon my_project`
或者，您可以创建一个项目，它会创建虚拟环境，并在 $WORKON_HOME 中创建一个项目目录。 当您使用 workon myproject 时，会 cd 到项目目录中。

`$ mkproject myproject`
virtualenvwrapper 提供环境名字的tab补全功能。当您有很多环境， 并且很难记住它们的名字时，这就显得很有用。

workon 也能停止您当前所在的环境，所以您可以在环境之间快速的切换。

停止是一样的：
`$ deactivate`
删除：
`$ rmvirtualenv my_project`
其他有用的命令
`lsvirtualenv`
列举所有的环境。
`cdvirtualenv`
导航到当前激活的虚拟环境的目录中，比如说这样您就能够浏览它的 site-packages 。
`cd sitepackages`
和上面的类似，但是是直接进入到 site-packages 目录中。
`ls sitepackages`
显示 site-packages 目录中的内容。
virtualenvwrapper 命令的完全列表 。

virtualenv-burrito
有了 virtualenv-burrito ， 您就能使用单行命令拥有virtualenv + virtualenvwrapper的环境。

autoenv
当您 cd 进入一个包含 .env 的目录中，就会 autoenv 自动激活那个环境。

使用 brew 在Mac OS X上安装它：

`$ brew install autoenv`
在Linux上:
```
$ git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv
$ echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc
```


先贴出命令
```
pip install --user --upgrade pipenv   # 用户安装pipenv

pipenv --three  # 会使用当前系统的Python3创建环境
pipenv --two  # 使用python2创建
pipenv --python 3.6 指定某一Python版本创建环境
pipenv --where 显示目录信息
pipenv --venv 显示虚拟环境信息
pipenv --py 显示Python解释器信息
pipenv run python 文件名
pipenv run pip ...  # 运行pip
pipenv shell 激活虚拟环境
pipenv install requests 安装相关模块并加入到Pipfile
pipenv install django==1.11 安装固定版本模块并加入到Pipfile
pipenv graph    # 显示依赖图
pipenv check    #检查安全漏洞
pipenv uninstall requests   # 卸载包并从Pipfile中移除
pipenv uninstall --all   # 卸载全部包
```

以前一直使用pip+virtualenv+virtualwrapper管理模块和环境， 但是virtualwrapper在windows上使用不太方便，而且包和环境分开管理确实经常不记得哪个是哪个了。 后来又出现一堆其他名字很像的虚拟环境管理，已经摸不清头脑了。

最后google了一下，总的来说发现，使用pipenv比较好， 它整合了 pip+virtualenv+Pipfile，能够自动处理好包的依赖问题和虚拟环境问题，是最推荐使用的虚拟环境管理。

安装pipenv:
```
$ pip install --user pipenv
```

升级pipenv
```
$ pip install --user --upgrade pipenv
```

使用pipenv

切换到项目文件夹，然后输入：
```
pipenv install requests
```
Pipenv是基于项目来管理依赖的，在安装requests依赖的时候，他会在项目文件夹中创建 Pipfile，用来track依赖，并且也是会分别创建一个virtualenv来运行这个项目。

写一个python文件：
```
import requests

response = requests.get('https://httpbin.org/ip')
print('Your IP is {0}'.format(response.json()['origin']))
```

使用pipenv管理的环境来运行：
```
pipenv run python main.py

这应该会输出类似的：
Your IP is 8.8.8.8
```

### ubuntu安装pipenv
```
全局安装
sudo pip3 install -H -U pipenv -i https://pypi.tuna.tsinghua.edu.cn/simple

当前用户安装
sudo pip3 install --user pipenv -i https://pypi.tuna.tsinghua.edu.cn/simple

pipenv install
pipenv：未找到命令
出现以上问题，需要进行一下操作
vim ~/.profile # 在底部添加以下语句

PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
PATH="$PATH:$PYTHON_BIN_PATH"
保存退出

执行
source ~/.profile
liuf2@liuf2-virtual-machine:pip3
Traceback (most recent call last):
  File "/usr/bin/pip3", line 9, in <module>
    from pip import main
ImportError: cannot import name 'main'
以上问题
sudo vim /usr/bin/pip3
将这一段代码
from pip import main
if __name__ == '__main__':
    sys.exit(main())

修改为：
from pip import __main__
if __name__ == '__main__':
    sys.exit(__main__._main())

保存退出

测试
pip3 --version


卸载pip3
sudo python3 -m pip uninstall pip3


安装pip3
sudo apt install python3-pip

升级pip3
python3 -m pip install --upgrade pip


```


