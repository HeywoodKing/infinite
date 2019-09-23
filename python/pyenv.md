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