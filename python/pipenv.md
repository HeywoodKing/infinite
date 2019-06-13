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
