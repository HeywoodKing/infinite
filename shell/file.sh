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
