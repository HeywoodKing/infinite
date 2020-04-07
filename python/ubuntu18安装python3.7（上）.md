# ubuntu18安装python3.7（上）

## 安装之前首先更新系统依赖包
```
sudo apt-get update
sudo apt-get upgrade
```

## 安装第三方工具
```
sudo apt-get install vim
sudo apt-get install git
```

## 安装python3和pip

建议使用非root用户，部署时最好使用python虚拟环境,安装python3-pip、python3-setuptools、gcc、python3-dev、wheel：
（缺一不可，不然之后用pip安装uwsgi会有各种各样的报错）
```
sudo apt-get install python3 (如果有python环境可以不装)
sudo apt-get install python3-pip  (如果有pip可以不装)
sudo apt-get install python3-dev #类库和头文件单独的包
sudo apt-get install python-setuptools 
sudo apt-get install wheel
sudo apt-get install gcc

以下如果项目中用不到可以不用安装
sudo apt-get install libxml* #解析xml文件的库
sudo apt-get install net-tools #网络管理命令如:ifconfig是查看本地ip
sudo apt-get install lsof #列出打开文件工具
```

## 安装python3.7
```
1. 直接使用apt-get安装python3.7失败:
sudo apt-get install python3.7

2. 改为手动安装
步骤1：在python官网找到python-3.7.1.tgz的地址：https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

步骤2：下载安装包
wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz

步骤3：解压安装包
tar -zxvf Python-3.7.1.tgz

步骤4：切换到解压后的目录下
cd Python-3.7.1

步骤5：./configure（也可以./configure --prefix=/usr/local/python3.7.1）
./configure
若执行的是 ./configure，则安装后
可执行文件默认放在/usr/local/bin
库文件默认放在/usr/local/lib
配置文件默认放在/usr/local/include
其它的资源文件放在/usr/local/share
# 或者
./configure --prefix=/usr/local/python3.7.1
若执行的是./configure --prefix=/usr/local/python3.7.1，则安装后
可执行文件放在/usr/local/python3.7.1/bin
库文件放在/usr/local/python3.7.1/lib
配置文件放在/usr/local/python3.7.1/include
其它的资源文件放在/usr/local/python3.7.1/share

步骤6：编译make（没有安装make的安装一下）
make

步骤7：测试make test
make test
关于make test命令出现ModuleNotFoundError: No module named ‘_ctypes’ 错误，请移步到大牛的一遍博文https://blog.csdn.net/u014775723/article/details/85224447

步骤8：安装sudo make install
sudo make install

步骤9：
若步骤5执行的式./configure --prefix=/usr/local/python3.7.1，则需要添加环境变量
添加环境变量
PATH=$PATH:$HOME/bin:/usr/local/python3.7.1/bin

若步骤5执行的是./configure的跳过此步骤

步骤10：查看安装目录
查看环境变量
echo $PATH
若步骤5执行的是./configure
可以看到此时python3.7安装到了/usr/local/lib/

若步骤5执行的是./configure --prefix=/usr/local/python3.7.1，
python3.7安装到了/usr/local/python3.7.1/lib/

步骤11：测试，输入python3.7

```

## 更新python默认指向为python3.7
```
步骤1：查看python命令指向
ls -l /usr/bin | grep python

步骤2：若如步骤1的图，若要安装python3.4则，由于python3.4为系统自带的，直接使用以下命令并跳过步骤3：
删除原有链接
rm /usr/bin/python 

建立新链接
ln -s /usr/bin/python3.4 /usr/bin/python

步骤3：由于python3.7是自己安装的，不在/usr/bin下，而在usr/local/bin或者/usr/local/python3.7.1/bin下（取决于前面执行的./configure还是./configure --prefix=/usr/local/python3.7.1。

因此需要先加一条软链接并且把之前的python命令改为python.bak，同时pip也需要更改。依次执行以下命令

若python3.7安装时，执行的是./configure，则：
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/bin/python3 /usr/bin/python

mv /usr/bin/pip /usr/bin/pip.bak
ln -s /usr/local/bin/pip3 /usr/bin/pip

若python3.7安装时，执行的是./configure --prefix=/usr/local/python3.7.1，则为：
mv /usr/bin/python /usr/bin/python.bak
ln -s /usr/local/python3.7.1/bin/python3.7 /usr/bin/python

mv /usr/bin/pip /usr/bin/pip.bak
ln -s /usr/local/python3.7.1/bin/pip3 /usr/bin/pip

步骤4：此时输入python验证

```

## 测试python是否安装完成，如果原来是python但是版本低，需要设置python默认优先级
```
查看python指向
ls -l /usr/bin | grep python

调整优先级
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --config python3
```