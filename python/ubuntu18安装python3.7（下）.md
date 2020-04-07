# ubuntu18安装python3.7（下）

上篇安装python3.7版本太麻烦，为了更好的管理python多个版本，推荐使用pyenv版本管理工具

## 使用pyenv管理Python版本
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


接下来你就可以自如的安装你想要的版本了
```
pyenv install 3.7.3
```

## 查看已经安装的python版本：
`pyenv versions`
