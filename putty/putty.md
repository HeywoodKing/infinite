# psftp

### 安装PSFTP
在PUTTY官方网站www.putty.org上可以下载PUTTY的所有工具，其中一项就是PSFTP。下载地址： 
http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html 
http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip

下载之后解压到文件夹目录，如 D:\putty\ 然后在我的电脑上右击，选择“属性”，“高级”选项卡，“环境变量”，在“系统变量”处，找到Path，双击一下弹出编辑系统变量的对话框，确认变量名为Path，然后在变量值后输入 ;D:\putty 注意前面有一个分号，分隔前面的变量，这样设置的原因是，设置之后你可以像使用系统命令cmd等一样，直接在命令中输入而不用切换路径。

### 启动PSFTP
打开“运行”，输入“psftp” 回车确定，或直接在D:\Putty\中找到psftp.exe双击打开。 
输入open命令登陆计算机： open 116.255.179.3 
会提示输入账号，输入账号回车键确认之后会提示输入密码，完成后提示登陆成功。（输入密码时光标不会移动，但数据已经输入）

### 使用PSFTP
文件名中有空格时使用双引号 如 “space name.txt”

>使用通配符
* * 代替任何字串
* ? 替代一个字母
* [abc] 在a b c范围内替代一个字母
* [a-z] 在a到z范围内替代一个字母
* [^abc] 替代一个字母，不包括a b cmatches a single character that is not a, b, or c.
* [-a] 代表连接号（-）
* [a^] 代表脱字符号（^）
* \ 放在上面的所有通配符之前，以取消其（通配符）涵义
（文件夹名称不支持通配符）

### open, quit, close, help命令
从名字就可以知道它们的作用了。其中quit是关闭PSFTP（bey和exit与quit相同），close是切断连接但不关闭PSFTP。

### cd, pwd, lcd, lpwd命令
你已经知道cd和pwd是干什么的了，lcd和lpwd是在cd和pwd前加了Local，就是本地机器的改变路径和显示路径。也可以用!cd, !pwd来实现lcd, lpwd。

### get, put命令 (拿和放)，代表下载和上传
```
et something.txt
get something.txt another.txt
```
上面的代码第一行代表下载something.txt，第二行代表下载something.txt，并重命名为another.txt。上传以此类推 
```
put something.txt 
put something.txt another.txt
```
如果是下载上传文件夹，加上递归符号 -r
```
get -r mydir newname
put -r mydir newname
```

### mget, mput, reget，reput命令
可以理解为Multiple get, Multiple put，用来一次下载或上传多个文件和文件夹。除了不可以重命名文件或文件夹，其它参数和get, put一样。 
re是resume的简写，那么它们就是续传命令了。

### dir, del, mkdir rmdir命令
dir就是ls；del是rm，但不可以删除文件夹；mkdir是建立文件夹的意思；rmdir是删除文件夹（某些亿恩科技服务器不允许删除非空文件夹，需要先删除其中的文件才行）。

### chmod命令
其参数u, g, o, a, +, -, r, w, x涵义分别是:
```
* u (the owning user)文档所有者
* g (members of the owning group)组成员
* o (everybody else - ‘others’)其它所有人
* a ('all',everyone)所有人
* + 加上（授予）
* - 减去（剥夺）
* r (permission to read the file)读
* w (permission to write to the file)写
* x (permission to execute the file）运行
chmod go-rwx,u+w privatefile
```
上面代码的涵义是剥夺组成员及其它任何人的读写运行权限，授予文件所有者写权限也（也就是私人文档） 
chmod a+r public * 
上面代码的涵义授予所有人读权限（也就是公开公开公开） 
直接用权限数字代码也可以 
chmod 640 groupfile1 groupfile2


### Putty远程连接Linux服务器出现乱码解决
1. 首先执行locale –a查看当前系统支持的字符编码；
2. 执行LANG=zh_CN.utf-8修改当前环境语言常量；
3. 点击Putty左上角的图标，找到Change Settings…
4. 找到Window------>Translation-------->Remote character set，把它改为你设置的字符集，这里以UTF-8为例。
5. 再次查看环境，就会发现乱码解决。（普通用户登录，通过 sudo setup查看所得）


putty的小兄弟psftp的使用
1、双击运行psftp.exe
双击直接运行psftp.exe程序 

2、open目标地址
运行psftp后，使用open指令连接目标机器，如：
psftp>open 127.0.0.1 

3、输入账号密码
输入open命令后会提示login as输入账号，输入账号后提示password输入密码，输入成功后会提示Remote working directory 

4、上传文件夹
put -r 本地目录 目标目录
用put命令上传文件夹，-r是递归上传。将本地目录下的东西上传到目标目录下面 

5、下载文件夹
get -r 本地目录 目标目录
用gut命令下载文件夹，-r是递归下载。将目标目录下面的东西下载到本地目录下

6 如果 
解决 psftp local: unable to open 的问题
把putty的安装目录移动到C盘下或者不包含中文，空格的目录就好了。微软不知道怎么考虑的，安装软件的目录中居然会有空格。
