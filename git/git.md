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
#####注意 在分支切换之前最好先commit全部的改变，除非你真的知道自己在做什么




