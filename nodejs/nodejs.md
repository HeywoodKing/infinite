## NodeJS

###设置镜像
+ 搭建环境时通过如下代码将npm设置成淘宝镜像
```
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```

+  使用淘宝 NPM 镜像
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


