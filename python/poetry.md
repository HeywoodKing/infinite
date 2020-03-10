# Poetry

Poetry 是一个Python虚拟环境和依赖管理工具，另外它还提供了包管理功能，比如打包和发布。
可以用来管理python库和python程序

Python 项目所需的所有文件也可能很麻烦：setup.py, requirements.txt, setup.cfg, MANIFEST.in 和新添加的 Pipfile.

### 安装 Poetry
要求 Python 2.7 or 3.4+
```
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
```
要激活 poetry 命令，请运行以下命令
```
source $HOME/.poetry/env
```

### pip安装
```
pip3 install --user poetry
```

### 确认是否安装成功以及查看版本号
现在，poetry 命令应该可用。让我们检查一下安装的 Poetry 版本
```
poetry --version
```

### 创建一个新项目
```
poetry new project_name

项目结构是这样的。

$ cd project_name
$ tree

project_name
├── README.rst
├── project_name
│   └── __init__.py
├── pyproject.toml
└── tests
    ├── __init__.py
    └── test_project_name.py

```
让我们来看看 pyproject.toml
```
[tool.poetry]
name = "project_name"
version = "1.0.5"
description = ""
authors = ["hywell <opencoding@hotmail.com>"]

[tool.poetry.dependencies]
python = "^3.6"

[tool.poetry.dev-dependencies]
pytest = "^3.0"

[build-system]
requires = ["poetry>=0.12"]
build-backend = "poetry.masonry.api"
```

#### 结构介绍
```
*pyproject.toml *: 使用此文件管理依赖列表和项目的各种meta信息，用来替代 Pipfile、requirements.txt、setup.py、setup.cfg、MANIFEST.in 等等各种配置文件
```


### 现有项目中使用Poetry
如果是在已有项目中使用poetry，你只需要执行一下命令来创建一个pyproject.toml文件即可
```
poetry init
```

### 创建虚拟环境
确保当前目录存在pyproject.toml文件
```
poetry install
```
这个命令会读取pyproject.toml中的所有依赖并安装（包括开发依赖），如果不想安装开发依赖可以附加：--no-dev 选项。如果项目根目录有 poetry.lock 文件，会安装这个文件中列出的锁定版本的依赖。如果执行 add/remove 命令的时候没有检测到虚拟环境，也会为当前目录自动创建虚拟

### 激活虚拟环境
```
poetry shell
```

### 查看python版本
```
poetry run python -V
```

### 执行脚本
```
poetry run python app.py
```

### 安装包 添加依赖
```
poetry add flask
```
此外，还会创建 poetry.lock

添加--dev参数为开发依赖
```
poetry add flask --dev
```

### 追踪 & 更新包
```
poetry show

添加--tree 参数选项可以查看依赖关系
poetry show --tree

查看可以更新的依赖
poetry show --outdated
```

### 更新所有锁定版本的依赖
```
poetry update
```

### 更新某个指定的依赖
```
poetry update dep_name (依赖名字）
```

### 卸载包
```
poetry remove dep_name
```

### 让poetry使用python3
```
poetry env use python3.7
```
