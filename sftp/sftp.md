# sftp

sftp是Secure File TransferProtocol的缩写，安全文件传送协议。可以为传输文件提供一种安全的加密方法。sftp与 ftp有着几乎一样的语法和功能。SFTP为 SSH的一部分，是一种传输档案至Blogger伺服器的安全方式。其实在SSH软件包中，已经包含了一个叫作SFTP(Secure File Transfer Protocol)的安全文件传输子系统，SFTP本身没有单独的守护进程，它必须使用sshd守护进程（端口号默认是22）来完成相应的连接操作，所以从某种意义上来说，SFTP并不像一个服务器程序，而更像是一个客户端程序。SFTP同样是使用加密传输认证信息和传输的数据，所以，使用SFTP是非常安全的。但是，由于这种传输方式使用了加密/解密技术，所以传输效率比普通的FTP要低得多，如果您对网络安全性要求更高时，可以使用SFTP代替FTP

```
bye                                Quit sftp
cd path                            Change remote directory to 'path'
chgrp grp path                     Change group of file 'path' to 'grp'
chmod mode path                    Change permissions of file 'path' to 'mode'
chown own path                     Change owner of file 'path' to 'own'
df [-hi] [path]                    Display statistics for current directory or
                                   filesystem containing 'path'
exit                               Quit sftp
get [-afPpRr] remote [local]       Download file
reget [-fPpRr] remote [local]      Resume download file
reput [-fPpRr] [local] remote      Resume upload file
help                               Display this help text
lcd path                           Change local directory to 'path'
lls [ls-options [path]]            Display local directory listing
lmkdir path                        Create local directory
ln [-s] oldpath newpath            Link remote file (-s for symlink)
lpwd                               Print local working directory
ls [-1afhlnrSt] [path]             Display remote directory listing
lumask umask                       Set local umask to 'umask'
mkdir path                         Create remote directory
progress                           Toggle display of progress meter
put [-afPpRr] local [remote]       Upload file
pwd                                Display remote working directory
quit                               Quit sftp
rename oldpath newpath             Rename remote file
rm path                            Delete remote file
rmdir path                         Remove remote directory
symlink oldpath newpath            Symlink remote file
version                            Show SFTP version
!command                           Execute 'command' in local shell
!                                  Escape to local shell
?                                  Synonym for help
```

```
sftp-- help 
可用命令： 
cd 路径                        更改远程目录到“路径” 
lcd 路径                       更改本地目录到“路径” 
chgrp group path               将文件“path”的组更改为“group” 
chmod mode path                将文件“path”的权限更改为“mode” 
chown owner path               将文件“path”的属主更改为“owner” 
exit                           退出 sftp 
help                           显示这个帮助文本 
get 远程路径                   下载文件 
ln existingpath linkpath       符号链接远程文件 
ls [选项] [路径]               显示远程目录列表 
lls [选项] [路径]              显示本地目录列表 
mkdir 路径                     创建远程目录 
lmkdir 路径                    创建本地目录 
mv oldpath newpath             移动远程文件 
open [用户@]主机[:端口]        连接到远程主机 
put 本地路径                   上传文件 
pwd                            显示远程工作目录 
lpwd                           打印本地工作目录 
quit                           退出 sftp 
rmdir 路径                     移除远程目录 
lrmdir 路径                    移除本地目录 
rm 路径                        删除远程文件 
lrm 路径                       删除本地文件 
symlink existingpath linkpath  符号链接远程文件 
version                        显示协议版本
```

我们主要用到的就是一下六个命令:
```
cd 路径                        更改远程目录到“路径” 
lcd 路径                       更改本地目录到“路径” 
ls [选项] [路径]               显示远程目录列表 
lls [选项] [路径]              显示本地目录列表 
put 本地路径                   上传文件 
get 远程路径                   下载文件 
```

```
#!/bin/bash

SCRIPT_NAME=`basename $0`
CURRENT_DIR=$(cd "$(dirname "$0")";pwd)

execute_sftp_cmd()
{
    local host_ip=$1
    local user_name=$2
    local user_password=$3
    local file_name=$4
    local file_dir=$5
    local cmd=$6
 
    local log_file=${CURRENT_DIR}/execute_sftp_cmd.log
    # 如果密码中包含$符号，需要转义以下
    user_password=`echo ${user_password} | sed 's/\\$/\\\\$/g'`

    /usr/bin/expect <<EOF > ${log_file}
    set timeout -1
    spawn sftp ${user_name}@${host_ip}:${file_dir}
    expect {
        "(yes/no)?"
        {
            send "yes\n"
            expect "*password:" { send "${user_password}\n"}
        }
        "*assword:"
        {
            send "${user_password}\n"
        }
    }
    expect "Changing to:*"
    send "${cmd} ${file_name}\n"
    expect "100%"
    send "exit\n"
    expect eof
EOF
   cat ${log_file} | grep -iE "denied|error|failed" >/dev/null
   if [ $? -eq 0 ];then
        echo "Script execute failed!"
        return 1
   fi
   return 0
}
execute_sftp_cmd "$@"

```

