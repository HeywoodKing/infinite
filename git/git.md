#git常用命令
命令行里git的命令列表以及解释 
```
git clone <address> 复制代码库到本地。
git add <file> ... 添加文件到代码库中。
git rm <file> ... 删除代码库的文件。
git commit -m <message> 提交更改，在修改了文件以后，使用这个命令提交修改。
git pull 从远程同步代码库到本地。相当于是从远程获取最新版本并merge到本地
git pull origin dev 本地分支与远程分支相关联
git pull origin master (该命令其实相当于git fetch 和 git merge
在实际使用中，git fetch更安全一些)
git push 推送代码到远程代码库。
git push origin test 这样远程仓库中也就创建了一个test分支
git push origin dev:dev # 同步dev分支的代码到远程服务器
git branch 查看当前分支。带*是当前分支。
git branch <branch-name> 新建一个分支。
git branch -d <branch-name> #删除一个本地分支。（首先要切换到其他分支，然后进行删除操作）
git branch -a 查看远程分支  git branch --all 查看远程分支
git checkout <branch-name> 切换到指定分支。
git checkout -b feature-catelog origin/feature-catelog 新建并切换到本地feature-catelog分支
git checkout -b test 在本地创建test分支
git checkout master 切换回master分支
git log 查看提交记录（即历史的 commit 记录）。
git status 当前修改的状态，是否修改了还没提交，或者那些文件未使用。
git reset <log> 恢复到历史版本。
git reset <log> --hard 恢复到制定的版本
git reset HEAD 恢复到上一个提交的版本

git push origin :dev # 删除远程dev分支，危险命令哦
git remote -v 查看远程仓库
git fetch origin master:temp 从远程的origin仓库的master分支下载到本地，并新建一个temp分支
git diff temp 查看temp分支与本地原有分支的不同
git merge temp 将temp分支和本地分支合并

相当于是从远程获取最新版本到本地，不会自动merge
git fetch 更新git remote 中所有的远程仓库所包含分支的最新commit-id, 将其记录到.git/FETCH_HEAD文件中
git fetch remote_repo 更新名称为remote_repo 的远程repo上的所有branch的最新commit-id，将其记录。
git fetch remote_repo remote_branch_name 更新名称为remote_repo 的远程repo上的分支： remote_branch_name
git fetch remote_repo remote_branch_name:local_branch_name 更新名称为remote_repo 的远程repo上的分支： remote_branch_name ，并在本地创建local_branch_name 本地分支保存远端分支的所有数据。

eg:
git fetch origin master 远程的origin的master主分支下载最新的版本到origin/master分支上
git log -p master..origin/master 比较本地的master分支和origin/master分支的差别
git merge origin/master 进行合并

git merge br1 br2
git rebase br1 br2 
以上命令本地将几个分支合并到一个临时分支tmp 


```

FETCH_HEAD： 是一个版本链接，记录在本地的一个文件中，指向着目前已经从远程仓库取下来的分支的末端版本。


##第一个 如果功能开发完成了，可以合并主分支
原来在开发分支上开发的
>git checkout master # 切换到主分支
>git merge dev # 把dev分支的更改和master合并
>git push # 提交主分支代码远程
>git checkout dev # 切换到dev分支
>git push # 提交dev分支到远程 || git push origin master:master

##第二个 如果功能没有完成，可以直接推送
在当前开发分支上
>git push # 提交到dev远程分支
##### 注意 在分支切换之前最好先commit全部的改变，除非你真的知道自己在做什么

清除本地废弃或者不用的分支
git remote prune origin

cd project_directory
git init

克隆项目
git clone git@xxx.com:model/xxx.git
推送项目
git push git@xxx.com:model/xxx.git master

查看项目状态
git status

增加文件
git add . | git add a.txt
git commit –m "add a.txt"

修改文件
git add a.txt
git commit –m "xx" | git commit –am "xx"

将文件从本地删除
git rm a.txt
git commit –m "delete a.txt"
将文件从版本库删除
git rm --cached a.txt
git commit -m "xx"

恢复文件
git reset HEAD a.txt

将文件从版本库中删除,保留本地文件
git rm –-cached a.txt
git commit –m "delete a.txt"
git status

查看分支
git branch | git branch -a

创建分支
git branch branchName

切换分支
git checkout branchName（务必先commit）
git checkout master


从当前分支创建同时切换分支
git checkout –b branchName
git checkout –b developer

删除分支
git branch –d branchName



直接拉取并合并最新代码
git pull <remote> <branch>
git pull origin master [示例1：拉取远端origin/master分支并合并到当前分支]
git pull origin developer [示例2：拉取远端origin/developer分支并合并到当前分支]


合并分支到当前分支
1.切换分支到master
git checkout master
2.合并developer分支到master分支
git merge developer
3.切换到developer分支上继续开发
git checkout developer


将本地当前分支提交到服务器的origin/dev分支
git push origin developer [示例2：将当前分支提交到远端origin/dev分支]


查看已并入当前分支的分支
git branch --merged

查看尚未并入当前分支的分支
git branch --no-merged

图形化界面查看
gitk

设置远程跟踪分支
git branch --set-upstream-to=origin/<branch> develop

解决冲突的办法：
查找处于冲突状态的文件，逐一进行修改
git status
git add [conflictFiles]
git commit –m "resolve conflict resulting from merging A and B"


查看历史根据commit message找commit对象的SHA1
git log
git checkout SHA1（历史不可重写）
git checkout –b newBranch（可以从历史中新建分支重写）


查看标签
git tag

创建附注型标签
git tag –a "v1.0.0" –m "basic version"

创建轻量型标签
git tag "v1.0.0"

回溯到指定标签
git checkout v1.0.0

从当前分支创建分支
git checkout –b branchName


一键获取自某标签开始到现在的所有提交消息
git shortlog master –-not v1.0.5


会自动将git@xxx.com:model/xxx.git 加入本地库的远端分支并起名为origin
以后可以git push origin [branchName]

查看远程库
git remote –v

添加远程库
git remote add [shortName] [url]

删除远程库
git remote rm [shortName]

重命名远程库
git remote rename [oldName] [newName]


推送指定分支
git push [remoteLib] [branchName]

推送指定tag
git push [remoteLib] [tag]

推送所有tag
git push [remoteLib] –-tags

删除远程分支
git push [remoteLib] :[remoteBranch]

远程master分支无法删除，除非服务端做特殊配置
删除远程tag
git push [remoteLib] :[remoteTag]

一键推送多个远端库：
编辑本地仓库的.git/config文件
[remote "all"]
url = [url1]
url = [url2]
git push all [branchName]



===============================================================
我的GitHub仓库A，朋友的GitHub仓库B，B fork A的项目
然后在B上配置：
（1）首先在终端中配置原仓库的位置，进入项目目录，执行一下命令：
git remote -v
输出：
origin  https://github.com/HeywoodKing/chf-project.git (fetch)
origin  https://github.com/HeywoodKing/chf-project.git (push)

（2）配置原仓库的路径：
添加主repo为上游代码库
注意一定要cd到你自己fork出来的库里面去，比如工程名叫luoluo，那要先cd到luoluo中去，然后才能操作
git remote add upstream 项目地址

（3）再次查看远程目录的位置：
git remote -v


（4）抓取原仓库的修改文件：
git fetch upstream

（5）切换到master分支。
切换到master分支。
git checkout master

（6）合并远程的master分支：
下面这行代码执行结束之后，本地代码会立刻和主库保持同步，非常神奇
git merge upstream/master

（7）此时，你的本地库已经和原仓库已经完全同步了。但是注意，此时只是你电脑上的本地库和远程的github原仓库同步了，你自己的github仓库还没有同步，此时需要使用“git push”命令把你本地的仓库提交到github中。
git push origin master


其实(4)(5)(6)可以合并成一条命令
git pull upstream master
第一个参数upstream 表示远程主repo
第二个参数master 表示自己fork库的master分支

===============================================================



将gitLab 上的dev分支拉取到本地
1》与远程仓库建立连接：git remote add origin XXXXX.git
2》使用git branch 查看本地是否具有dev分支
3》如果没有 git fetch origin dev
4》git checkout -b dev origin/dev在本地创建分支dev并切换到该分支
5》git pull origin dev就可以把gitLab上dev分支上的内容都拉取到本地了



t常用操作命令收集：
1) 远程仓库相关命令
检出仓库：$ git clone git://github.com/jquery/jquery.git
查看远程仓库：$ git remote -v
添加远程仓库：$ git remote add [name] [url]
删除远程仓库：$ git remote rm [name]
修改远程仓库：$ git remote set-url --push[name][newUrl]
拉取远程仓库：$ git pull [remoteName] [localBranchName]
推送远程仓库：$ git push [remoteName] [localBranchName]
 
2）分支(branch)操作相关命令
查看本地分支：$ git branch
查看远程分支：$ git branch -r
创建本地分支：$ git branch [name] ----注意新分支创建后不会自动切换为当前分支
切换分支：$ git checkout [name]
创建新分支并立即切换到新分支：$ git checkout -b [name]
删除分支：$ git branch -d [name] ---- -d选项只能删除已经参与了合并的分支，对于未有合并的分支是无法删除的。如果想强制删除一个分支，可以使用-D选项
合并分支：$ git merge [name] ----将名称为[name]的分支与当前分支合并
创建远程分支(本地分支push到远程)：$ git push origin [name]
删除远程分支：$ git push origin :heads/[name]
我从master分支创建了一个issue5560分支，做了一些修改后，使用git push origin master提交，但是显示的结果却是'Everything up-to-date'，发生问题的原因是git push origin master 在没有track远程分支的本地分支中默认提交的master分支，因为master分支默认指向了origin master 分支，这里要使用git push origin issue5560：master 就可以把issue5560推送到远程的master分支了。

如果想把本地的某个分支test提交到远程仓库，并作为远程仓库的master分支，或者作为另外一个名叫test的分支，那么可以这么做。

$ git push origin test:master         // 提交本地test分支作为远程的master分支 //好像只写这一句，远程的github就会自动创建一个test分支
$ git push origin test:test              // 提交本地test分支作为远程的test分支

如果想删除远程的分支呢？类似于上面，如果:左边的分支为空，那么将删除:右边的远程的分支。

$ git push origin :test              // 刚提交到远程的test将被删除，但是本地还会保存的，不用担心
3）版本(tag)操作相关命令
查看版本：$ git tag
创建版本：$ git tag [name]
删除版本：$ git tag -d [name]
查看远程版本：$ git tag -r
创建远程版本(本地版本push到远程)：$ git push origin [name]
删除远程版本：$ git push origin :refs/tags/[name]
 
4) 子模块(submodule)相关操作命令
添加子模块：$ git submodule add [url] [path]
如：$ git submodule add git://github.com/soberh/ui-libs.git src/main/webapp/ui-libs
初始化子模块：$ git submodule init ----只在首次检出仓库时运行一次就行
更新子模块：$ git submodule update ----每次更新或切换分支后都需要运行一下
删除子模块：（分4步走哦）
1)$ git rm --cached [path]
2) 编辑“.gitmodules”文件，将子模块的相关配置节点删除掉
3) 编辑“.git/config”文件，将子模块的相关配置节点删除掉
4) 手动删除子模块残留的目录
 
5）忽略一些文件、文件夹不提交
在仓库根目录下创建名称为“.gitignore”的文件，写入不需要的文件夹名或文件，每个元素占一行即可，如
target
bin
*.db
 


git删除文件
rm add2.txt

git rm add2.txt
git commit -m "rm test"
git push web

 

-----------at server
cd /var/www/foo.git;sudo git update-server-info

 

------------检查删除效果
cd;rm foo3 -rf;git clone http://[某ip]/foo.git foo3

 

------------更新已经存在的local code
cd;cd foo2
git remote add web [某user]@[某ip]:/var/www/foo.git/
git pull web master



git clone git@github.com:512439130/512439130.github.io.git (http,在你的download下复制)
git clone https://github.com/512439130/512439130.github.io.git (ssh，同理)

//将工作文件修改提交到本地暂存区
git add <文件名.后缀>
git add . //当前仓库下所有更新的文件
//删除本地，并将任务提交到缓存区
git rm <文件名.后缀>

//查看项目状态(未提交)
git status

//准备提交
git commit -m "更新记录(此处随便写，就是记录你更新的日志)"

//正式提交
git push

//查看更新日志
git log

//更新远程仓库到本地
git pull



====================================================================================
git中文显示乱码问题：
git 默认中文文件名是 \xxx\xxx 等八进制形式，是因为 对0x80以上的字符进行quote
只需要设置core.quotepath设为false，就不会对0x80以上的字符进行quote。中文显示正常
git config --global core.quotepath false

解决git指令更新远程仓库github时每次都要输入用户名和密码问题

设置记住密码(默认15分钟)
git config –global credential.helper cache

如果想自己设置时间，这样就设置一个小时之后失效，可以这样做
git config credential.helper 'cache –timeout=3600'

长期存储密码
git config -global credential.helper store


使用ssh方式(推荐)
在每次push 的时候，都要输入用户名和密码，是不是很麻烦?原因是使用了https方式 push，
在git bash里边输入 git remote -v 可以查看到使用的是http or ssh


git空文件夹不能提交的问题
在该空文件夹下使用命令：touch .gitkeep文件即可提交，或者手动创建文件

在根目录下最好添加要给忽略文件 touch .gitignore 或者直接vim .gitignore
输入以下内容：
# Ignore everything in this directory
*
# Except this file
!.gitignore


.idea //忽略.idea文件夹及文件夹下文件
*.iml //忽略以.iml结尾的文件

　　

【例子】
# 忽略*.o和*.a文件
*.[oa]
# 忽略*.b和*.B文件，my.b除外
*.[bB]
!my.b
# 忽略dbg文件和dbg目录
dbg
# 只忽略dbg目录，不忽略dbg文件
dbg/
# 只忽略dbg文件，不忽略dbg目录
dbg
!dbg/
# 只忽略当前目录下的dbg文件和目录，子目录的dbg不在忽略范围内
/dbg
# 以'#'开始的行，被视为注释.
* ？：代表任意的一个字符
* ＊：代表任意数目的字符
* {!ab}：必须不是此类型
* {ab,bb,cx}：代表ab,bb,cx中任一类型即可
* [abc]：代表a,b,c中任一字符即可
* [ ^abc]：代表必须不是a,b,c中任一字符
git update-index --assume-unchanged PATH    在PATH处输入要忽略的文件。




=============================================
生成ssh 公钥和私钥
打开git bash终端
输入：
ssh-keygen -t rsa -C "opencoding@hotmail.com"
添加你的SSH公钥(email是你github注册账号的邮箱)

第一次出现：Enter file in which to save the key (/root/.ssh/id_rsa): 直接按回车就行
第二次出现：Enter passphrase (empty for no passphrase): 第一次输入公钥密码(推荐不用输入，直接回车，以便在clone、pull、push等不用输入公钥密码)
第三次出现：Enter same passphrase again: 再次输入公钥密码：直接按回车就行
公钥创建成功，位置在你使用 git bush 的当前项目目录下(xx.pub)
公钥和私钥配对，接下来去C盘找你的私钥
私钥一般在你的用户文件夹的 .ssh下，打开xx.pub,复制全部内容，在github中创建ssh keys



生成多个私钥
如果你已经有了一套名为 id_rsa 的公秘钥，将要生成另外一个公钥，比如 aysee ，你也可以使用任何你喜欢的名字。
1、生成一个新的自定义名称的公钥和私钥：
ssh-keygen -t rsa -C "YOUR_EMAIL@YOUREMAIL.COM" -f ~/.ssh/aysee
```
eg:
$ ssh-keygen -t rsa -C "opencoding@hotmail.com" -f D:/Flack/Work/.ssh/aysee
```
执行完成后，会在 ~/.ssh/目录下生成一个 aysee 和 aysee.pub 文件。
2、在 SSH 用户配置文件 ~/.ssh/config 中指定对应服务所使用的公秘钥名称，如果没有 config 文件的话就新建一个，并输入以下内容：
Host github.com www.github.com
IdentityFile ~/.ssh/aysee
3、添加 aysee.pub 到你的git服务器网站上。
4、测试配置文件是否正常工作
ssh -T git@gitcafe.com
如果，正常的话，会出现如下提示：
Hi USERNAME! You've successfully authenticated, but github does not provide shell access.

多用户时出现权限问题的原因：
github使用SSH与客户端连接。如果是单用户（first），生成密钥对后，将公钥保存至 GitHub ，每次连接时SSH客户端发送本地私钥（默认~/.ssh/id_rsa）到服务端验证。单用户情况下，连接的服务器上保存的公钥和发送的私钥自然是配对的。但是如果是 多用户 （first，second），我们在连接到second的帐号时，second保存的是自己的公钥，但是SSH客户端依然发送默认私钥，即first的私钥，那么这个验证自然无法通过。
解决ssh权限问题（）:
通常一台电脑生成一个ssh不会有这个问题，当一台电脑生成多个ssh的时候，就可能遇到这个问题，解决步骤如下：
1、查看系统ssh-key代理,执行如下命令
ssh-add -l
以上命令如果输出  The agent has no identities. 则表示没有代理。如果系统有代理，可以执行下面的命令清除代理:
ssh-add -D
2、然后依次将不同的ssh添加代理，执行命令如下：
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/aysee
你会分别得到如下提示：
2048 8e:71:ad:88:78:80:b2:d9:e1:2d:1d:e4:be:6b:db:8e /Users/aysee/.ssh/id_rsa (RSA)
和
2048 8e:71:ad:88:78:80:b2:d9:e1:2d:1d:e4:be:6b:db:8e /Users/aysee/.ssh/id_rsa (RSA)
2048 a7:f4:0d:f1:b1:76:0b:bf:ed:9f:53:8c:3f:4c:f4:d6 /Users/aysee/.ssh/aysee (RSA)
如果使用 ssh-add ~/.ssh/id_rsa的时候报如下错误，则需要先运行一下 ssh-agent bash 命令后再执行 ssh-add ...等命令
Could not open a connection to your authentication agent.

3、配置 ~/.ssh/config 文件
如果没有就在~/.ssh/目录创建config文件，该文件用于配置私钥对应的服务器
# Default github user(first@mail.com)
 
Host github.com
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/id_rsa
 
# aysee (company_email@mail.com)
Host github-aysee
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/aysee

Host随意即可，方便自己记忆，后续在添加remote是还需要用到。 配置完成后，在连接非默认帐号的github仓库时，远程库的地址要对应地做一些修改，比如现在添加second帐号下的一个仓库test，则需要这样添加：

git remote add test git@github-aysee:ay-seeing/test.git
#并非原来的git@github.com:ay-seeing/test.git

ay-seeing 是github的用户名

4、测试 ssh
ssh -T git@github.com

你会得到如下提示，表示这个ssh公钥已经获得了权限
Hi USERNAME! You've successfully authenticated, but github does not provide shell access.

=============================================

结果示例展示：
$ ssh-keygen -t rsa -C "chenhongwu@huachunnet.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/HC001/.ssh/id_rsa):
Created directory '/c/Users/HC001/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/HC001/.ssh/id_rsa.
Your public key has been saved in /c/Users/HC001/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:SMGmRw5bMwOQbkQk2P9jjzrhydruTwpVGlxytuFCtG0 chenhongwu@huachunnet.com
The key's randomart image is:
+---[RSA 2048]----+
|o+++=o*          |
|..+o.OO+         |
| o .=OE+         |
|  o +Bo.         |
| .  oo. S        |
|   .. +          |
|  .o +.+         |
|   o=o. .        |
|  .+*+.          |
+----[SHA256]-----+






Git global setup
git config --global user.name "flack.chen"
git config --global user.email "flack.chen@icmofang.com"

Create a new repository
git clone git@gitlab:icmofang/moli_restapi.git
cd moli_restapi
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

Existing folder
cd existing_folder
git init
git remote add origin git@gitlab:icmofang/moli_restapi.git
git add .
git commit -m "Initial commit"
git push -u origin master

Existing Git repository
cd existing_repo
git remote rename origin old-origin
git remote add origin git@gitlab:icmofang/moli_restapi.git
git push -u origin --all
git push -u origin --tags



#git常用命令
命令行里git的命令列表以及解释 
```
git clone <address> 复制代码库到本地。
git add <file> ... 添加文件到代码库中。
git rm <file> ... 删除代码库的文件。
git commit -m <message> 提交更改，在修改了文件以后，使用这个命令提交修改。
git pull 从远程同步代码库到本地。相当于是从远程获取最新版本并merge到本地
git pull origin dev 本地分支与远程分支相关联
git pull origin master (该命令其实相当于git fetch 和 git merge
在实际使用中，git fetch更安全一些)
git push 推送代码到远程代码库。
git push origin test 这样远程仓库中也就创建了一个test分支
git push origin dev:dev # 同步dev分支的代码到远程服务器
git branch 查看当前分支。带*是当前分支。
git branch <branch-name> 新建一个分支。
git branch -d <branch-name> #删除一个本地分支。（首先要切换到其他分支，然后进行删除操作）
git branch -a 查看远程分支  git branch --all 查看远程分支
git checkout <branch-name> 切换到指定分支。
git checkout -b feature-catelog origin/feature-catelog 新建并切换到本地feature-catelog分支
git checkout -b test 在本地创建test分支
git checkout master 切换回master分支
git log 查看提交记录（即历史的 commit 记录）。
git status 当前修改的状态，是否修改了还没提交，或者那些文件未使用。
git reset <log> 恢复到历史版本。
git reset <log> --hard 恢复到制定的版本
git reset HEAD 恢复到上一个提交的版本

git push origin :dev # 删除远程dev分支，危险命令哦
git remote -v 查看远程仓库
git fetch origin master:temp 从远程的origin仓库的master分支下载到本地，并新建一个temp分支
git diff temp 查看temp分支与本地原有分支的不同
git merge temp 将temp分支和本地分支合并

相当于是从远程获取最新版本到本地，不会自动merge
git fetch 更新git remote 中所有的远程仓库所包含分支的最新commit-id, 将其记录到.git/FETCH_HEAD文件中
git fetch remote_repo 更新名称为remote_repo 的远程repo上的所有branch的最新commit-id，将其记录。
git fetch remote_repo remote_branch_name 更新名称为remote_repo 的远程repo上的分支： remote_branch_name
git fetch remote_repo remote_branch_name:local_branch_name 更新名称为remote_repo 的远程repo上的分支： remote_branch_name ，并在本地创建local_branch_name 本地分支保存远端分支的所有数据。

eg:
git fetch origin master 远程的origin的master主分支下载最新的版本到origin/master分支上
git log -p master..origin/master 比较本地的master分支和origin/master分支的差别
git merge origin/master 进行合并

git merge br1 br2
git rebase br1 br2 
以上命令本地将几个分支合并到一个临时分支tmp 


```

FETCH_HEAD： 是一个版本链接，记录在本地的一个文件中，指向着目前已经从远程仓库取下来的分支的末端版本。


##第一个 如果功能开发完成了，可以合并主分支
原来在开发分支上开发的
>git checkout master # 切换到主分支
>git merge dev # 把dev分支的更改和master合并
>git push # 提交主分支代码远程
>git checkout dev # 切换到dev分支
>git push # 提交dev分支到远程 || git push origin master:master

##第二个 如果功能没有完成，可以直接推送
在当前开发分支上
>git push # 提交到dev远程分支
##### 注意 在分支切换之前最好先commit全部的改变，除非你真的知道自己在做什么

清除本地废弃或者不用的分支
git remote prune origin

cd project_directory
git init

克隆项目
git clone git@xxx.com:model/xxx.git
推送项目
git push git@xxx.com:model/xxx.git master

查看项目状态
git status

增加文件
git add . | git add a.txt
git commit –m "add a.txt"

修改文件
git add a.txt
git commit –m "xx" | git commit –am "xx"

将文件从本地删除
git rm a.txt
git commit –m "delete a.txt"
将文件从版本库删除
git rm --cached a.txt
git commit -m "xx"

恢复文件
git reset HEAD a.txt

将文件从版本库中删除,保留本地文件
git rm –-cached a.txt
git commit –m "delete a.txt"
git status

查看分支
git branch | git branch -a

创建分支
git branch branchName

切换分支
git checkout branchName（务必先commit）
git checkout master


从当前分支创建同时切换分支
git checkout –b branchName
git checkout –b developer

删除分支
git branch –d branchName



直接拉取并合并最新代码
git pull <remote> <branch>
git pull origin master [示例1：拉取远端origin/master分支并合并到当前分支]
git pull origin developer [示例2：拉取远端origin/developer分支并合并到当前分支]


合并分支到当前分支
1.切换分支到master
git checkout master
2.合并developer分支到master分支
git merge developer
3.切换到developer分支上继续开发
git checkout developer


将本地当前分支提交到服务器的origin/dev分支
git push origin developer [示例2：将当前分支提交到远端origin/dev分支]


查看已并入当前分支的分支
git branch --merged

查看尚未并入当前分支的分支
git branch --no-merged

图形化界面查看
gitk

设置远程跟踪分支
git branch --set-upstream-to=origin/<branch> develop

解决冲突的办法：
查找处于冲突状态的文件，逐一进行修改
git status
git add [conflictFiles]
git commit –m "resolve conflict resulting from merging A and B"


查看历史根据commit message找commit对象的SHA1
git log
git checkout SHA1（历史不可重写）
git checkout –b newBranch（可以从历史中新建分支重写）


查看标签
git tag

创建附注型标签
git tag –a "v1.0.0" –m "basic version"

创建轻量型标签
git tag "v1.0.0"

回溯到指定标签
git checkout v1.0.0

从当前分支创建分支
git checkout –b branchName


一键获取自某标签开始到现在的所有提交消息
git shortlog master –-not v1.0.5


会自动将git@xxx.com:model/xxx.git 加入本地库的远端分支并起名为origin
以后可以git push origin [branchName]

查看远程库
git remote –v

添加远程库
git remote add [shortName] [url]

删除远程库
git remote rm [shortName]

重命名远程库
git remote rename [oldName] [newName]


推送指定分支
git push [remoteLib] [branchName]

推送指定tag
git push [remoteLib] [tag]

推送所有tag
git push [remoteLib] –-tags

删除远程分支
git push [remoteLib] :[remoteBranch]

远程master分支无法删除，除非服务端做特殊配置
删除远程tag
git push [remoteLib] :[remoteTag]

一键推送多个远端库：
编辑本地仓库的.git/config文件
[remote "all"]
url = [url1]
url = [url2]
git push all [branchName]



===============================================================
我的GitHub仓库A，朋友的GitHub仓库B，B fork A的项目
然后在B上配置：
（1）首先在终端中配置原仓库的位置，进入项目目录，执行一下命令：
git remote -v
输出：
origin  https://github.com/HeywoodKing/chf-project.git (fetch)
origin  https://github.com/HeywoodKing/chf-project.git (push)

（2）配置原仓库的路径：
添加主repo为上游代码库
注意一定要cd到你自己fork出来的库里面去，比如工程名叫luoluo，那要先cd到luoluo中去，然后才能操作
git remote add upstream 项目地址

（3）再次查看远程目录的位置：
git remote -v


（4）抓取原仓库的修改文件：
git fetch upstream

（5）切换到master分支。
切换到master分支。
git checkout master

（6）合并远程的master分支：
下面这行代码执行结束之后，本地代码会立刻和主库保持同步，非常神奇
git merge upstream/master

（7）此时，你的本地库已经和原仓库已经完全同步了。但是注意，此时只是你电脑上的本地库和远程的github原仓库同步了，你自己的github仓库还没有同步，此时需要使用“git push”命令把你本地的仓库提交到github中。
git push origin master


其实(4)(5)(6)可以合并成一条命令
git pull upstream master
第一个参数upstream 表示远程主repo
第二个参数master 表示自己fork库的master分支

===============================================================



将gitLab 上的dev分支拉取到本地
1》与远程仓库建立连接：git remote add origin XXXXX.git
2》使用git branch 查看本地是否具有dev分支
3》如果没有 git fetch origin dev
4》git checkout -b dev origin/dev在本地创建分支dev并切换到该分支
5》git pull origin dev就可以把gitLab上dev分支上的内容都拉取到本地了



t常用操作命令收集：
1) 远程仓库相关命令
检出仓库：$ git clone git://github.com/jquery/jquery.git
查看远程仓库：$ git remote -v
添加远程仓库：$ git remote add [name] [url]
删除远程仓库：$ git remote rm [name]
修改远程仓库：$ git remote set-url --push[name][newUrl]
拉取远程仓库：$ git pull [remoteName] [localBranchName]
推送远程仓库：$ git push [remoteName] [localBranchName]
 
2）分支(branch)操作相关命令
查看本地分支：$ git branch
查看远程分支：$ git branch -r
创建本地分支：$ git branch [name] ----注意新分支创建后不会自动切换为当前分支
切换分支：$ git checkout [name]
创建新分支并立即切换到新分支：$ git checkout -b [name]
删除分支：$ git branch -d [name] ---- -d选项只能删除已经参与了合并的分支，对于未有合并的分支是无法删除的。如果想强制删除一个分支，可以使用-D选项
合并分支：$ git merge [name] ----将名称为[name]的分支与当前分支合并
创建远程分支(本地分支push到远程)：$ git push origin [name]
删除远程分支：$ git push origin :heads/[name]
我从master分支创建了一个issue5560分支，做了一些修改后，使用git push origin master提交，但是显示的结果却是'Everything up-to-date'，发生问题的原因是git push origin master 在没有track远程分支的本地分支中默认提交的master分支，因为master分支默认指向了origin master 分支，这里要使用git push origin issue5560：master 就可以把issue5560推送到远程的master分支了。

    如果想把本地的某个分支test提交到远程仓库，并作为远程仓库的master分支，或者作为另外一个名叫test的分支，那么可以这么做。

$ git push origin test:master         // 提交本地test分支作为远程的master分支 //好像只写这一句，远程的github就会自动创建一个test分支
$ git push origin test:test              // 提交本地test分支作为远程的test分支

如果想删除远程的分支呢？类似于上面，如果:左边的分支为空，那么将删除:右边的远程的分支。

$ git push origin :test              // 刚提交到远程的test将被删除，但是本地还会保存的，不用担心
3）版本(tag)操作相关命令
查看版本：$ git tag
创建版本：$ git tag [name]
删除版本：$ git tag -d [name]
查看远程版本：$ git tag -r
创建远程版本(本地版本push到远程)：$ git push origin [name]
删除远程版本：$ git push origin :refs/tags/[name]
 
4) 子模块(submodule)相关操作命令
添加子模块：$ git submodule add [url] [path]
如：$ git submodule add git://github.com/soberh/ui-libs.git src/main/webapp/ui-libs
初始化子模块：$ git submodule init ----只在首次检出仓库时运行一次就行
更新子模块：$ git submodule update ----每次更新或切换分支后都需要运行一下
删除子模块：（分4步走哦）
1)$ git rm --cached [path]
2) 编辑“.gitmodules”文件，将子模块的相关配置节点删除掉
3) 编辑“.git/config”文件，将子模块的相关配置节点删除掉
4) 手动删除子模块残留的目录
 
5）忽略一些文件、文件夹不提交
在仓库根目录下创建名称为“.gitignore”的文件，写入不需要的文件夹名或文件，每个元素占一行即可，如
target
bin
*.db
 
 


git删除文件
rm add2.txt

git rm add2.txt
git commit -m "rm test"
git push web

 

-----------at server
cd /var/www/foo.git;sudo git update-server-info

 

------------检查删除效果
cd;rm foo3 -rf;git clone http://[某ip]/foo.git foo3

 

------------更新已经存在的local code
cd;cd foo2
git remote add web [某user]@[某ip]:/var/www/foo.git/
git pull web master



git clone git@github.com:512439130/512439130.github.io.git (http,在你的download下复制)
git clone https://github.com/512439130/512439130.github.io.git (ssh，同理)

//将工作文件修改提交到本地暂存区
git add <文件名.后缀>
git add . //当前仓库下所有更新的文件
//删除本地，并将任务提交到缓存区
git rm <文件名.后缀>

//查看项目状态(未提交)
git status

//准备提交
git commit -m "更新记录(此处随便写，就是记录你更新的日志)"

//正式提交
git push

//查看更新日志
git log

//更新远程仓库到本地
git pull



====================================================================================
git中文显示乱码问题：
git 默认中文文件名是 \xxx\xxx 等八进制形式，是因为 对0x80以上的字符进行quote
只需要设置core.quotepath设为false，就不会对0x80以上的字符进行quote。中文显示正常
git config --global core.quotepath false

解决git指令更新远程仓库github时每次都要输入用户名和密码问题

设置记住密码(默认15分钟)
git config –global credential.helper cache

如果想自己设置时间，这样就设置一个小时之后失效，可以这样做
git config credential.helper 'cache –timeout=3600'

长期存储密码
git config -global credential.helper store


使用ssh方式(推荐)
在每次push 的时候，都要输入用户名和密码，是不是很麻烦?原因是使用了https方式 push，
在git bash里边输入 git remote -v 可以查看到使用的是http or ssh


git空文件夹不能提交的问题
在该空文件夹下使用命令：touch .gitkeep文件即可提交，或者手动创建文件

在根目录下最好添加要给忽略文件 touch .gitignore 或者直接vim .gitignore
输入以下内容：
# Ignore everything in this directory
*
# Except this file
!.gitignore


.idea //忽略.idea文件夹及文件夹下文件
*.iml //忽略以.iml结尾的文件

　　

【例子】
# 忽略*.o和*.a文件
*.[oa]
# 忽略*.b和*.B文件，my.b除外
*.[bB]
!my.b
# 忽略dbg文件和dbg目录
dbg
# 只忽略dbg目录，不忽略dbg文件
dbg/
# 只忽略dbg文件，不忽略dbg目录
dbg
!dbg/
# 只忽略当前目录下的dbg文件和目录，子目录的dbg不在忽略范围内
/dbg
# 以'#'开始的行，被视为注释.
* ？：代表任意的一个字符
* ＊：代表任意数目的字符
* {!ab}：必须不是此类型
* {ab,bb,cx}：代表ab,bb,cx中任一类型即可
* [abc]：代表a,b,c中任一字符即可
* [ ^abc]：代表必须不是a,b,c中任一字符
git update-index --assume-unchanged PATH    在PATH处输入要忽略的文件。




=============================================
生成ssh 公钥和私钥
打开git bash终端
输入：
ssh-keygen -t rsa -C "opencoding@hotmail.com"
添加你的SSH公钥(email是你github注册账号的邮箱)

第一次出现：Enter file in which to save the key (/root/.ssh/id_rsa): 直接按回车就行
第二次出现：Enter passphrase (empty for no passphrase): 第一次输入公钥密码(推荐不用输入，直接回车，以便在clone、pull、push等不用输入公钥密码)
第三次出现：Enter same passphrase again: 再次输入公钥密码：直接按回车就行
公钥创建成功，位置在你使用 git bush 的当前项目目录下(xx.pub)
公钥和私钥配对，接下来去C盘找你的私钥
私钥一般在你的用户文件夹的 .ssh下，打开xx.pub,复制全部内容，在github中创建ssh keys



生成多个私钥
如果你已经有了一套名为 id_rsa 的公秘钥，将要生成另外一个公钥，比如 aysee ，你也可以使用任何你喜欢的名字。
1、生成一个新的自定义名称的公钥和私钥：
ssh-keygen -t rsa -C "YOUR_EMAIL@YOUREMAIL.COM" -f ~/.ssh/aysee
执行完成后，会在 ~/.ssh/目录下生成一个 aysee 和 aysee.pub 文件。
2、在 SSH 用户配置文件 ~/.ssh/config 中指定对应服务所使用的公秘钥名称，如果没有 config 文件的话就新建一个，并输入以下内容：
Host github.com www.github.com
IdentityFile ~/.ssh/aysee
3、添加 aysee.pub 到你的git服务器网站上。
4、测试配置文件是否正常工作
ssh -T git@gitcafe.com
如果，正常的话，会出现如下提示：
Hi USERNAME! You've successfully authenticated, but github does not provide shell access.

多用户时出现权限问题的原因：
github使用SSH与客户端连接。如果是单用户（first），生成密钥对后，将公钥保存至 GitHub ，每次连接时SSH客户端发送本地私钥（默认~/.ssh/id_rsa）到服务端验证。单用户情况下，连接的服务器上保存的公钥和发送的私钥自然是配对的。但是如果是 多用户 （first，second），我们在连接到second的帐号时，second保存的是自己的公钥，但是SSH客户端依然发送默认私钥，即first的私钥，那么这个验证自然无法通过。

解决ssh权限问题（）:
通常一台电脑生成一个ssh不会有这个问题，当一台电脑生成多个ssh的时候，就可能遇到这个问题，解决步骤如下：
1、查看系统ssh-key代理,执行如下命令
ssh-add -l
以上命令如果输出  The agent has no identities. 则表示没有代理。如果系统有代理，可以执行下面的命令清除代理:
ssh-add -D

2、然后依次将不同的ssh添加代理，执行命令如下：
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/aysee

你会分别得到如下提示：
2048 8e:71:ad:88:78:80:b2:d9:e1:2d:1d:e4:be:6b:db:8e /Users/aysee/.ssh/id_rsa (RSA)
和
2048 8e:71:ad:88:78:80:b2:d9:e1:2d:1d:e4:be:6b:db:8e /Users/aysee/.ssh/id_rsa (RSA)
2048 a7:f4:0d:f1:b1:76:0b:bf:ed:9f:53:8c:3f:4c:f4:d6 /Users/aysee/.ssh/aysee (RSA)

如果使用 ssh-add ~/.ssh/id_rsa的时候报如下错误，则需要先运行一下 ssh-agent bash 命令后再执行 ssh-add ...等命令
Could not open a connection to your authentication agent.

3、配置 ~/.ssh/config 文件
如果没有就在~/.ssh/目录创建config文件，该文件用于配置私钥对应的服务器
# Default github user(first@mail.com)
 
Host github.com
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/id_rsa
 
# aysee (company_email@mail.com)
Host github-aysee
HostName github.com
User git
IdentityFile C:/Users/username/.ssh/aysee

Host随意即可，方便自己记忆，后续在添加remote是还需要用到。 配置完成后，在连接非默认帐号的github仓库时，远程库的地址要对应地做一些修改，比如现在添加second帐号下的一个仓库test，则需要这样添加：

git remote add test git@github-aysee:ay-seeing/test.git
#并非原来的git@github.com:ay-seeing/test.git

ay-seeing 是github的用户名

4、测试 ssh
ssh -T git@github.com

你会得到如下提示，表示这个ssh公钥已经获得了权限
Hi USERNAME! You've successfully authenticated, but github does not provide shell access.

=============================================

结果示例展示：
$ ssh-keygen -t rsa -C "chenhongwu@huachunnet.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/HC001/.ssh/id_rsa):
Created directory '/c/Users/HC001/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/HC001/.ssh/id_rsa.
Your public key has been saved in /c/Users/HC001/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:SMGmRw5bMwOQbkQk2P9jjzrhydruTwpVGlxytuFCtG0 chenhongwu@huachunnet.com
The key's randomart image is:
+---[RSA 2048]----+
|o+++=o*          |
|..+o.OO+         |
| o .=OE+         |
|  o +Bo.         |
| .  oo. S        |
|   .. +          |
|  .o +.+         |
|   o=o. .        |
|  .+*+.          |
+----[SHA256]-----+




错误：   在终端（终端）下

执行git clone git@github.com：accountName / repository.git命令时不出错，

运行git push时出错，提示如下

权限被拒绝（publickey）。

致命：无法从远程存储库读取。

请确保您具有正确的访问权限并且存储库存在。



原因：   可能是没有与github上上的账号成功建立密钥对。



解决： 

【1】ssh-keygen -t rsa -C“youremail@example.com”

    注意，上述youremail@example.com是指GitHub的账户的注册邮箱

【2】ssh -v git@github.com

    上述命令执行后，出现的提示最后两句是

          没有更多的身份验证方法可以试

          权限被拒绝（publickey）。

【3】ssh-agent -s

    上述命令执行后，出现的提示最后两句是

          SSH_AUTH_SOCK = / TMP / SSH-GTpABX1a05qH / agent.404; export SSH_AUTH_SOCK;

          SSH_AGENT_PID = 13144; export SSH_AGENT_PID;

          echo agent pid 13144;

【4】ssh-add~ / .ssh / id_rsa  

    上述命令执行后，出现提示

          身份补充：。。。（这里是一些ssh key文件路径）

          无法打开与身份验证代理的连接。

【5】若【4】中出现上述提示，则执行此步骤，否则执行【6】

   eval`ssh-agent -s`回车

   ssh-add~ / .ssh / id_rsa回车

【6】cat~ / .ssh / id_rsa.pub（也可以用其他方式打开）  

    上述命令执行后id_rsa.pub文件内容将输出到终端，复制里面的密钥（内容一般是以ssh-rsa开头，以github账号的注册邮箱结尾的，全部复制下来）

【7】进入github账号，在设置下，选择SSH和GPG密钥，点击新的SSH密钥

点击新的SSH密钥后，在标题栏里自定义名字，然后将上一步复制的密钥（以及ssh-rsa开头，以及github账号的注册邮箱结尾的）粘贴到此处。

然后点击添加SSH密钥

【8】ssh -T git@github.com回车

提示：嗨---！您已成功通过身份验证，但GitHub不提供shell访问权限。