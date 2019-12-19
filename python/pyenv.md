# pyenv 
## python版本管理工具
### 安装pyenv
```
参考地址：https://github.com/pyenv/pyenv#basic-github-checkout

1.Check out pyenv where you want it installed. A good place to choose is $HOME/.pyenv (but you can install it somewhere else).
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv

2.Define environment variable PYENV_ROOT to point to the path where pyenv repo is cloned and add $PYENV_ROOT/bin to your $PATH for access to the pyenv command-line utility.
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

3.Add pyenv init to your shell to enable shims and autocompletion. Please make sure eval "$(pyenv init -)" is placed toward the end of the shell configuration file since it manipulates PATH during the initialization.
$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc

4.Restart your shell so the path changes take effect. You can now begin using pyenv.
$ exec "$SHELL" -l
```

### 安装python3.7.3之前先安装依赖
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install build-essential python-dev python-setuptools python-pip python-smbus
sudo apt-get install libncursesw5-dev libgdbm-dev libc6-dev
sudo apt-get install zlib1g-dev libsqlite3-dev tk-dev
sudo apt-get install libssl-dev openssl
sudo apt-get install libffi-dev
```

### 安装python3.7.3
`pyenv install 3.7.3`

### 安装完成之后，需要使用如下命令对数据库进行更新
`pyenv rehash`

### 查看已经安装的python版本：
`pyenv versions`

### 设置全局python版本
`pyenv global 3.7.0 `

### 这个时候用python -V 查询,就是最新的3.7.0, 而不是python 2.7.12了
`python -V`

### 更新pyenv
`pyenv update`

### 
```
pyenv install --list

```

```
ubuntu@VM-0-4-ubuntu:~$ pyenv --help
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   commands    List all available pyenv commands
   local       Set or show the local application-specific Python version
   global      Set or show the global Python version
   shell       Set or show the shell-specific Python version
   install     Install a Python version using python-build
   uninstall   Uninstall a specific Python version
   rehash      Rehash pyenv shims (run this after installing executables)
   version     Show the current Python version and its origin
   versions    List all Python versions available to pyenv
   which       Display the full path to an executable
   whence      List all Python versions that contain the given executable

See `pyenv help <command>' for information on a specific command.
```

### pyenv 安装

首先把项目克隆下来，放在家目录下的隐藏文件夹中：.pyenv
```
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```
然后配置环境变量
如果你使用 bash，就依次执行如下命令：
```
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
```

如果你使用 zsh，就依次执行如下命令：
```
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.zshrc
```

echo 命令的含义是：将引号中内容写入某文件中
请注意，以上的三条 echo 命令的最后一条长长的命令，请你保证它引号中的内容处于 ~/.bashrc 或者 ~/.zshrc 的最底部。
因为在 pyenv 初始化期间会操作 path 环境变量，导致不可预测的行为。
查看文件的底部内容，可以使用 tail 命令，用法：tail ~/.bashrc 或者 tail ~/.zshrc，编辑文件可以使用 vim 或者 vscode

最后，在使用 pyenv 之前，重新初始化 shell 环境，执行如下命令
```
exec $SHELL
```
不执行该命令也是完全可以的，你可以关闭当前的终端窗口，重新启动一个就可以了。
此时，你已经完成了 pyenv 的安装了，你使用可以它的全部命令了，但是我建议你先别急着用，一口气装完 pyenv 的一个插件，那就是 pyenv-virtualenv

### 安装 pyenv-virtualenv
把插件克隆在刚才已经安装完毕的 pyenv 的 plugins 文件夹中
```
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
```

然后配置环境变量
如果你使用 bash，就执行如下命令：
```
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
```

如果你使用 zsh，就执行如下命令：
```
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```
最后，在使用 pyenv 之前，重新初始化 shell 环境，执行如下命令
```
exec $SHELL
```
不执行该命令也是完全可以的，你可以关闭当前的终端窗口，重新启动一个就可以了。
到此，我们的所有重要安装已经全部完成了，可以开始体验了。


### 安装 3.7.4 版本的 python
```
pyenv install 3.7.4
```

这里有个问题，某些情况下会安装失败，报错就告诉你 Build failed

这个时候，pyenv 已经在它的 github wiki 里面为我们准备了一篇错误应对方案，原文地址 https://github.com/pyenv/pyenv/wiki

大意如下，只需要执行对应的命令即可：

archlinux 用户
```
sudo pacman -S base-devel openssl zlib
```
mac 用户
```
brew install openssl readline sqlite3 xz zlib
```
Ubuntu/Debian/Mint 用户
```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev
```
CentOS/Fedora <= 21 用户，请你保证已经安装了 xz 工具
```
sudo yum install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel
```
Fedora >= 22 用户，请你保证已经安装了 xz 工具
```
sudo dnf install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel
```
openSUSE 用户
```
zypper install gcc automake openssl-devel ncurses-devel readline-devel zlib-devel tk-devel
```
Solus 用户
```
sudo eopkg it -c system.devel
sudo eopkg install git gcc make zlib-devel bzip2-devel readline-devel sqlite3-devel openssl-devel tk-devel
```
Linuxbrew 用户
```
brew install bzip2 openssl readline sqlite xz
```

安装完这些补充的工具之后，再次执行：
```
pyenv install 3.7.4
```

就可以成功了，你可以不断的使用
```
pyenv versions
```
来查看被 pyenv 托管的 python 版本

而且你想装什么版本就装什么版本，想装几个装几个，都是完美共存，完美隔离，你可以在终端里输入
```
pyenv install
```
然后按下 tab 键，就可以看到所有可选的安装版本了

使用刚才安装的 python 3.7.4
首先我们需要明确一个概念，pyenv 和 pyenv-virtualenv 他们是如何协作的，你可以这么认为：

pyenv 托管 python 版本，virtualenv 使用 python 版本

好了，之前已经装好了版本，那么现在就来使用吧


### pyenv virtualenv

1. 创建虚拟环境
首先需要创建一个虚拟环境，执行命令：
```
pyenv virtualenv 3.6.6 my-env
```
它的格式就是这样固定的，最后一个是你自己想要的环境的名字，可以随便取。稍等片刻，你将会看到：
```
Looking in links: /tmp/tmp0eywgc7v
Requirement already satisfied: setuptools in /home/joit/.pyenv/versions/3.6.6/envs/my-env/lib/python3.6/site-packages (39.0.1)
Requirement already satisfied: pip in /home/joit/.pyenv/versions/3.6.6/envs/my-env/lib/python3.6/site-packages (10.0.1)
```
类似于这样的回显信息，说明环境已经创建成功了，它还告诉了你，该虚拟环境的绝对路径，如果你进去看了，你就会发现，所谓的虚拟环境，就是把 python 装在 pyenv 的安装目录的某个文件夹中，以供它自己调用。

2. 激活虚拟环境
在任意目录下，执行命令：
```
pyenv activate my-env
```
你会发现，在你的终端里面，多了一个类似于 (my-env) 这样的一个东西，这时候你如果执行：
```
python --version
```
那就是 python 3.6.6 了
如果你执行：
```
pip --version
```
它会告诉你 pip 包安装的绝对路径，也是 pyenv 安装目录下的某个文件夹

如果你关掉了终端，那么下次启动你又得重新激活一次了，你可以使用如下命令：

首先 cd 到某一个目录，比如 ~/test
```
cd ~/test
```
然后在该目录下执行：
```
pyenv local my-env
```
你会发现已经被激活了，那么 local 命令和刚才有啥不同呢。如果你执行：
```
ls -al
```
你就会发现，在 ~/test 目录下，有个隐藏文件 .python-version，你可以看到这个文件里面，只写了一句话 my-env

这样你只要进入 ~/test 目录，就会自动激活虚拟环境
在虚拟环境下，你如果直接执行
```
python
```
就会进入到 python 的交互环境如果你写了一个文件，名字叫做 app.py ，里面的内容只有一句代码：print(1)
然后执行：
```
python app.py
```
这时候，系统就会调用虚拟环境中的 python 解释器来执行这些代码了


3. 更新 pyenv
由于我们是 git 克隆的，所以更新非常简单
```
cd ~/.pyenv 或者 cd $(pyenv root)
git pull
```

4. 卸载 pyenv
由于 pyenv 把一切都放在 ~/.pyenv 下了，所以卸载很方便，两个步骤就行了
首先你需要删除环境变量
然后你需要执行：
```
rm -rf ~/.pyenv 或者 rm -rf $(pyenv root)
```



### pyenv install 3.7.3的坑
```
1. can't decompress data; zlib not available
一般位于编译安装时出错
缺少zlib的相关工具包，安装即可
sudo apt-get install zlibc zlib1g-dev
或者
sudo apt-get install zlib*

原因：zipimport.ZipImportError: can't decompress data; zlibnotavailable
执行：vim ~/.bashrc
将以下语句加入到最后
```
# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
```
或者在终端输入：
```
echo 'export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"' >> ~/.bashrc
echo 'export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"' >> ~/.bashrc
echo 'export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"' >> ~/.bashrc
```

2. ModuleNotFoundError: No module named '_ctypes'
Makefile:1130: recipe for target 'install' failed
`sudo apt-get install libffi-dev`

```