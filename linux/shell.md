# shell

eg:
```
#!/bin/bash
add()
{
if [ -e $1/$2 ];then
read -p "$1/$2文件已存在,您要覆盖此文件吗?[y/n]:" a
  if [ $a="y" ];then
   touch $1/$2
   echo "$1/$2文件已被覆盖"
  else
   touch $2/$3
   echo "$2/$3文件已创建"
  fi
else
 touch $1/$2
 echo "$1/$2文件已创建"
fi
}
del()
{
if [ -e $1/$2 ];then
 read -p "您确定要删除$1/$2文件吗?[y/n]:" a
   if [ $a="y" ];then
   rm -rf $1/$2
   echo "$1/$2文件已删除"
   fi
else
 echo "$1/$2文件不存在!"
fi
}
que()
{
find $1 -name $2

}

if [ "$#" -ne 3 ];then
 echo "必须是3个参数"
 exit 1
fi
#a=$1
#b=$2
#c=$3
#echo "$1,$2,$3"
#read a
#if [ "$a" -eq "a"]||[ "$a" -eq "d"]||[ "$a" -eq "q"];then
case $1 in
	add) add $2 $3
	;;
	del) del $2 $3
	;;
	que) que $2 $3
	;;
	*)echo "您输入有误,请重新输入!"
	exit 1
	;;
esac

```

```
#!/bin/sh
#监控系统资源消耗
monitordisk()
{
    LOOK_OUT=`df | grep /dev/sda1 | awk '{print $5}' | sed 's/%//g'`
    echo $LOOK_OUT
    until [ "$LOOK_OUT" -gt "90" ]
do
    LOOK_OUT=`df | grep /logs | awk '{print $5}' | sed 's/%//g'`
    echo "Filesystem .. logs is nearly full" | mail root
    sleep 5
    exit 0
done     
}

monitorsinglecpu()
{
    CPU_USE=`ps auwx | grep vmstat | awk '{print $4 $5 $6}'`

}
#if FLAG is MEM,monitor the memory,if flag is CPU,monitor the cpu,else is wrong
FLAG=$1
#the process name 
NAME=$2
#监控的频度
#监控的次数
#判断参数的个数，如果个数少于1的话，输出相应的错误信息
#输出欢迎提示信息
echo "欢迎使用本监控脚本，现在开始监控"
if [ $# -lt 1 ]; then
    echo "参数个数少于1，请检查您的参数"
else
    #先判断当前用户是不是root用户
    IS_ROOT=`whoami | grep root`
    if [ $IS_ROOT != root ]; then
        echo "当前用户不是root用户,请切换用户执行脚本"
    else
        #先判断第二个参数是不是为空，如果为空，则监控整个系统资源消耗
        if [ $NAME = '']; then 
            #监控整个系统资源，使用vmstat命令
            #如果是监控内存
            if [ $FLAG = MEM ]; then
                vmstat 2 10 | awk '{print $5}' | sed -n '3,13p' > /usr/twf/vmstat_mem.log &
            #如果是监控CPU
            elif [ $FLAG = CPU ]; then
                vmstat 2 10 | awk '{print $16}' | sed -n '3,13p' > /usr/twf/vmstat_cpu.log &
            #如果是监控磁盘利用率
            elif [ $FLAG = DISK ]; then
                monitordisk
            #其他异常情况
            else
                echo "参数1不是MEM、CPU和DISK中的一个，请重新输入参数"
                exit 1
            fi           
        else
            #第二个参数不为空的情况
            #如果监控的是内存
            if [ $FLAG = MEM ]; then
                #调用监控单个进程内存函数
                
            elif [ $FLAG = CPU ]; then
            else

            echo "其他情况"
        fi
    fi
fi
```

```
add()
{
echo $1 + $2
}

add 4 5
```

```
dir=$2
filename=$3
add()
{
	echo $dir/$filename
}
```

