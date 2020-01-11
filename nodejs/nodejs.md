## NodeJS


### 安装 node 版本管理 nvm
nvm是一个非常不错的node版本管理器，类似于ruby的[rvm](https://github.com/creationix/nvm "nvm")
1. 首先下载 nvm，然后执行以下命令从git载入nvm
```
git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
```
2. 下载之后，进入目录执行nvm安装命令
```
./install.sh
```

3. 安装之后输入nvm还是提示没有这时候需要执行以下命令或者关闭终端重新开启
```
source ./nvm.sh
```

### 安装 nodejs
1. 查看已安装 node.js 版本
```
nvm ls
```
2. 查看可安装的 node.js 版本
```
nvm ls-remote
```
3. 安装长期支持版 v8.10.0   (Latest LTS: Carbon)
```
nvm install v8.10.0
```
4. 切换已安装的node.js版本
```
nvm use 版本号
```


### 安装 npm
由于新版的nodejs已经集成了npm，所以之前npm也一并安装好了
查看 npm 版本
```
npm -v
```
更新到最新版本
```
npm install npm -g
```


### 设置淘宝 npm 镜像 cnpm
国内直接使用 npm 的官方镜像是非常慢的，这里推荐使用淘宝 NPM 镜像,淘宝 NPM 镜像是一个完整 npmjs.org 镜像，可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步。
+ 搭建环境时通过如下代码将npm设置成淘宝镜像
```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```

+  安装淘宝 NPM 镜像
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
这样就可以使用 cnpm 命令来安装模块了：
cnpm install [name]
```

+ 查看镜像的配置结果
```
npm config get registry
npm config get disturl 
```

+ 安装第三方模块或者库
```
npm install express          # 本地安装
npm install express -g       # 全局安装
```

+ 如果出现以下错误：
```
npm err! Error: connect ECONNREFUSED 127.0.0.1:8087 
解决办法为：
npm config set proxy null
```

+ 查看安装信息
```
npm list -g
npm ls
```

+ 查看某个模块的版本号
```
npm list grunt
```

+ 卸载模块
```
npm uninstall express
```

+ 更新模块
```
npm update express
```

+ 搜索模块
```
npm search express
```

+ 创建模块
```
npm init
```

+  npm 资源库中注册用户
```
npm adduser
```

+  来发布模块
```
npm publish
```

>如果你以上的步骤都操作正确，你就可以跟其他模块一样使用 npm 来安装

+  其他命令
```
使用npm help <command>可查看某条命令的详细帮助，例如npm help install。
在package.json所在目录下使用npm install . -g可先在本地安装当前命令行程序，可用于发布前的本地测试
使用npm update <package>可以把当前目录下node_modules子目录里边的对应模块更新至最新版本。
使用npm update <package> -g可以把全局安装的对应命令行程序更新至最新版
使用npm cache clear可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。
使用npm unpublish <package>@<version>可以撤销发布自己发布过的某个版本代码。

```

### 安装 nrm
nrm(npm registry manager )是npm的镜像源管理工具，有时候国外资源太慢，那么我们可以用这个来切换镜像源。（一般情况下可以直接使用上面安装的cnpm就可以了）

1. 安装全局 nrm
```
npm install -g nrm
```
2. 安装完后 列出可用的源:
```
nrm ls

会出现下面几个源：
npm ---- https://registry.npmjs.org/
cnpm --- http://r.cnpmjs.org/
taobao - https://registry.npm.taobao.org/
nj ----- https://registry.nodejitsu.com/
rednpm - http://registry.mirror.cqupt.edu.cn/
npmMirror  https://skimdb.npmjs.com/registry/
edunpm - http://registry.enpmjs.org/
```
3. 我们选用国内的淘宝源
```
nrm use taobao
```


+ 输入以下命令来启动 Node 的终端
```
node

ctrl + c - 退出当前终端。
ctrl + c 按下两次 - 退出 Node REPL。
ctrl + d - 退出 Node REPL.
向上/向下 键 - 查看输入的历史命令
tab 键 - 列出当前命令
.help - 列出使用命令
.break - 退出多行表达式
.clear - 退出多行表达式
.save filename - 保存当前的 Node REPL 会话到指定文件
.load filename - 载入当前 Node REPL 会话的文件内容。
```

+ 


