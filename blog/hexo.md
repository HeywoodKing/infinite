# Hexo

### 搭建步骤
```
安装 hexo
npm install -g hexo
注意：-g是指全局安装hexo

创建Hexo文件夹
mkdir hexo

进入目录
cd hexo

初始化 hexo
hexo init

安装依赖包
npm install

本地查看
生成
hexo g
或
hexo generate

启动服务器
hexo s
或
hexo server

完成部署
为了使用hexo d来部署到git上，需要安装
npm install hexo-deployer-git --save
hexo generate
hexo deploy
或
hexo d

访问预览
http://heywoodking.github.io/


注意：每次修改本地文件后，需要键入hexo generate才能保存。每次使用命令时，都要在项目Hexo目录下。
每次想要上传文件到Github时，就应该先键入hexo generate保存之后，再键入hexo deploy


为了建立RSS订阅，需要安装
npm install hexo-generator-feed --save
为了建立站点地图，需要安装
npm install hexo-generator-sitemap --save
```

### 常用命令
```
hexo new "name"       # 新建文章
hexo new page "name"  # 新建页面
hexo g                # 生成页面
hexo d                # 部署
hexo g -d             # 生成页面并部署
hexo s                # 本地预览
hexo clean            # 清除缓存和已生成的静态文件
hexo help             # 帮助
```
