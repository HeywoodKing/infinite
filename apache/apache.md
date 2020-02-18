# apache

## 常见的web服务器
常见的web服务器有Apache、ngnix、IIS
1. Apache
Apache音译为阿帕奇, 是全世界最受欢迎的web服务器，因其快速、可靠并且可通过简单的API扩充，能将Python\Perl等解释器部署在其上面等优势，受到广泛的关注与使用。
2. Ngnix
Apache的致命缺陷就是在同时处理大量的（一万个以上）请求时，显得有些吃力，所以“战斗民族”的人设计的一款轻量级的web服务器——Ngnix, 在高并发下nginx 能保持比Apache低资源低消耗高性能
3. IIS
iis是Internet Information Services的缩写，意为互联网信息服务，是由微软公司提供的基于运行Microsoft Windows的互联网基本服务,

### 下面我们来看看新版的Apache2 web服务器的安装
1. 安装
sudo apt install apache2 -y
2. 检查是否启动了Apache服务
systemctl status apache2
3. 操作Apache的常用命令
```
/etc/init.d/apache2 start    //启动Apache服务
/etc/init.d/apache2 stop    //停止Apache服务
/etc/init.d/apache2 restart    //重启Apache服务
```

```
The configuration layout for an Apache2 web server installation on Ubuntu systems is as follows:

/etc/apache2/
|-- apache2.conf
|       `--  ports.conf
|-- mods-enabled
|       |-- *.load
|       `-- *.conf
|-- conf-enabled
|       `-- *.conf
|-- sites-enabled
|       `-- *.conf
```

### 安装apache
```
sudo apt-get install apache2
service apache2 status
service apache2 start
service apache2 stop
service apache2 restart

sudo systemctl status apache2
sudo systemctl start apache2
sudo systemctl stop apache2
sudo systemctl restart apache2
```

### 卸载apache
```
sudo apt-get remove apache*
sudo apt-get --purge remove apache2
sudo apt-get --purge remove apache2.2-common
sudo apt-get autoremove
```
