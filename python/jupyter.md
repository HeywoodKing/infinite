# jupyter

### 安装
```
pip3 install jupyter notebook -i https://pypi.douban.com/simple
```


### jupyter notebook自动补全功能实现
Jupyter notebook使用默认的自动补全是关掉的。要打开自动补全，需修改默认配置
```
ipython profile create
会在~/.ipython/profile_default/目录下生成ipython_config.py和ipython_kernel_config.py
我们需要修改（ipython_config.py）的以下几行，将开启补全功能

c.Completer.greedy = True
c.Completer.jedi_compute_type_timeout = 400
c.Completer.use_jedi = True

重启jupyter后生效


```
以上操作后，在编写代码是发现不是自动不全，是要按下tab键才可以补全，所以还是有些不便，还好有插件，通过Hinterland插件即可解决自动补全问题了，安装配置步骤:

1、在命令行中激活代码补全环境（注：如果使用的是默认环境则不需要激活）

2、安装nbextensions（以下不截图了，在cmd环境中运行即可，在安装过程中如有提示缺少的库安装即可）
```
pip install jupyter_nbextensions_configurator
jupyter nbextensions_configurator enable –user
```

3、重启jupyter，在弹出的主页面里，能看到增加了一个Nbextensions标签页，在这个页面里，勾选Hinterland即启用了代码自动补全。
注：如果页面无Hinterland项，或者不全，命令行执行：
```
jupyter contrib nbextension install --user --skip-running-check
```
再次重启jupyter，Nbextensions标签页中数据将全部出现了


