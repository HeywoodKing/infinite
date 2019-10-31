# Nginx

```
nginx version: nginx/1.14.0 (Ubuntu)
Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /usr/share/nginx/)
  -c filename   : set configuration file (default: /etc/nginx/nginx.conf)
  -g directives : set global directives out of configuration file

```

### 安装Nginx
```
sudo apt-get update
sudo apt-get install nginx

Ubuntu安装之后的文件结构大致为：
1. 所有的配置文件都在/etc/nginx下，并且每个虚拟主机已经安排在了/etc/nginx/sites-available下
2. 程序文件在/usr/sbin/nginx
3. 日志放在了/var/log/nginx中
4. 并已经在/etc/init.d/下创建了启动脚本nginx
5. 默认的虚拟主机的目录设置在了/var/www/nginx-default (有的版本 默认的虚拟主机的目录设置在了/var/www, 请参考/etc/nginx/sites-available里的配置)
```

### 卸载Nginx
```
sudo apt-get uninstall nginx
```

### 安装完成后，检查Nginx服务的状态：
```
sudo systemctl status nginx
```

### 查看nginx
`nginx`

### 检查Nginx服务的状态和版本：
```
sudo nginx -v
```

### 注：不仅仅使用systemctl可管理Nginx服务

### 启动nginx
```
sudo systemctl start nginx
sudo /etc/init.d/nginx start
service nginx start
```

### 停止nginx
```
sudo systemctl stop nginx
sudo /etc/init.d/nginx stop
service nginx stop
```

### 重启nginx
```
sudo systemctl restart nginx
sudo /etc/init.d/nginx restart
service nginx restart
```

### 查看错误日志
```
grep /var/log/nginx/error.log
```

### 打开nginx.conf配置文件编辑
```
vim /etc/nginx/nginx.conf
或者
vi /etc/nginx/nginx.conf
```

### nginx配置文件修改重载
```
sudo nginx -s reload
或者
sudo systemctl reload nginx
```

### 禁用Nginx服务在启动时启动
```
sudo systemctl disable nginx
```

### 启用Nginx服务在启动时启动
```
sudo systemctl enable nginx
```

### 修复错误
`nginx -t -c /etc/nginx/nginx.conf`

### 验证
`nginx -c /etc/nginx/nginx.conf`

### 测试nginx
`nginx -t`

### 查看80进程
`sudo lsof -i：80`

### 配置防火墙
>
```
如果您正在运行防火墙，则还需要打开端口80和443。
sudo ufw allow 'Nginx Full'
验证更改
sudo ufw status
测试安装
在您选择的浏览器中打开localhost
https://www.linuxidc.com/upload/2018_05/18050708325033.png
```

## 假定一个场景：某个网站它可能不希望被网络爬虫抓取，例如测试环境不希望被抓取，以免对用户造成误导，那么需要在该网站中申明，本站不希望被抓取。有如下方法：

### 方法一：修改nginx.conf，禁止网络爬虫的ua，返回403。
```
server { 
  listen 80; 
  server_name 127.0.0.1; 
  # 添加如下内容即可防止爬虫
  if ($http_user_agent ~* "qihoobot|Baiduspider|Googlebot|Googlebot-Mobile|Googlebot-Image|Mediapartners-Google|Adsbot-Google|Feedfetcher-Google|Yahoo! Slurp|Yahoo! Slurp China|YoudaoBot|Sosospider|Sogou spider|Sogou web spider|MSNBot|ia_archiver|Tomato Bot") 
  { 
    return 403; 
  } 
  
  ...
}
``` 

### 方法2：网站更目录下增加Robots.txt，放在站点根目录下。
限制浏览器访问：
```
if ($http_user_agent ~* "Firefox|MSIE")
{
     return 403;
}
```

### Nginx防盗链的3种方法 文件防盗链 图片防盗链 视频防盗链 linux防盗链
能够支持高达 50,000 个并发连接数的响应, 感谢Nginx为我们选择了 epoll and kqueue作为开发模型. 目前中国大陆使用nginx网站用户有：新浪、网易、 腾讯,另外知名的微网志Plurk也使用nginx。

一般常用的方法是在server或者location段中加入!
`valid_referers   none  blocked  www.hihi123.com  hihi123.com;`

none 表示空的来路，也就是直接访问，比如直接在浏览器打开一个图片
blocked 表示被防火墙标记过的来路
server_names 也就是域名了。0.5.33以后的版本中，可以用*.hihi123.com来表示所有的二级域名
```
location ~ .*\.(wma|wmv|asf|mp3|mmf|zip|rar|jpg|gif|png|swf|flv)$ {
     valid_referers none blocked *.765h.com 765h.com;
     if ($invalid_referer) {
     #rewrite ^/ http://www.765h.com/error.html;
     return 403;
      }
}

第一行：wma|gif|jpg|png|swf|flv
表示对wma、gif、jpg、png、swf、flv后缀的文件实行防盗链

第二行：*.765h.com 765h.com
表示对*.765h.com 765h.com这2个来路进行判断(*代表任何，任何的二级域名)，你可以添加更多
if{}里面内容的意思是，如果来路不是指定来路就跳转到403错误页面，当然直接返回404也是可以的，也可以是图片。
```

```
location /img/ {
    root /data/img/;
    valid_referers none blocked *.765h.com 765h.com;
    if ($invalid_referer) {
                   rewrite  ^/  http://www.765h.com/images/error.gif;
                   #return   403;
    }
}
以上是nginx自带的防盗链功能。
```

### nginx 的第三方模块ngx_http_accesskey_module 来实现下载文件的防盗链
安装Nginx和nginx-http-access模块
```
#tar zxvf nginx-0.7.61.tar.gz
#cd nginx-0.7.61/
#tar xvfz nginx-accesskey-2.0.3.tar.gz
#cd nginx-accesskey-2.0.3 
#vi config
#把HTTP_MODULES="$HTTP_MODULES $HTTP_ACCESSKEY_MODULE" 修改成HTTP_MODULES="$HTTP_MODULES ngx_http_accesskey_module" (这是此模块的一个bug)
#./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --add-module=/root/nginx-accesskey-2.0.3

编译成功后，在主配置文件加入类似下面的代码：
server{ 
..... 
    location /download { 
        accesskey             on;
        accesskey_hashmethod  md5;
        accesskey_arg         "key";
        accesskey_signature   "mypass$remote_addr";
    } 
}
/download 为你下载的目录。
```

前台php产生的下载路径格式是：

1.http://*****.com/download/1.zip?key=<?php echo md5('mypass'.$_SERVER["REMOTE_ADDR"]);?>
这样，当访问没有跟参数一样时，其他用户打开时，就出现：403

 

NginxHttpAccessKeyModule第三方模块，实现方法如下：

1. 下载Nginx HttpAccessKeyModule模块文件：Nginx-accesskey-2.0.3.tar.gz；

 

2. 解压此文件后，找到nginx-accesskey-2.0.3下的config文件。编辑此文件：替换其中的"$HTTP_ACCESSKEY_MODULE"为"ngx_http_accesskey_module"；

 

3. 用一下参数重新编译nginx：

./configure --add-module=path/to/nginx-accesskey

4. 修改nginx的conf文件，添加以下几行：

location /download {
  accesskey             on;
  accesskey_hashmethod  md5;
  accesskey_arg         "key";
  accesskey_signature   "mypass$remote_addr";
}

其中：
accesskey为模块开关；
accesskey_hashmethod为加密方式MD5或者SHA-1；
accesskey_arg为url中的关键字参数；
accesskey_signature为加密值，此处为mypass和访问IP构成的字符串。

访问测试脚本download.php：
```
<?
$ipkey= md5("mypass".$_SERVER['REMOTE_ADDR']);
$output_add_key="<a href=http://www.example.cn/download/G3200507120520LM.rar?key=".$ipkey.">download_add_key</a><br />";
$output_org_url="<a href=http://www.example.cn/download/G3200507120520LM.rar>download_org_path</a><br />";
echo $output_add_key;
echo $output_org_url;
?>
```

访问第一个download_add_key链接可以正常下载，第二个链接download_org_path会返回403 Forbidden错误。

如果不怕麻烦，有条件实现的话，推荐使用Nginx HttpAccessKeyModule这个东西。

他的运行方式是：如我的download 目录下有一个 file.zip 的文件。对应的URI 是http://www.765h.com/download/file.zip
使用ngx_http_accesskey_module 模块后http://www.765h.com/download/file.zip?key=09093abeac094. 只有给定的key值正确了，才能够下载download目录下的file.zip。而且 key 值是根据用户的IP有关的，这样就可以避免被盗链了。

据说Nginx HttpAccessKeyModule现在连迅雷都可以防了，可以尝试一下。




### 配置多站点步骤

1. 安装Nginx
```
sudo apt-get install Nginx
```

2. 创建项目文件路径
```
sudo mkdir -p /var/www/chfweb
sudo mkdir -p /var/www/qshweb
```
3. 再将这两个文件夹给定权限和所有权
```
sudo chown -R www-data:www-data /var/www/chfweb
sudo chown -R www-data:www-data /var/www/qshweb
```

4. 创建不同的配置文件
安装完 Nginx 之后，其实 Nginx 的默认配置文件实在 /etc/nginx/sites-available/default
但是我们要配置多站点的话，可以这样：
```
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/chfweb
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/qshweb
```

5. 然后编辑配置文件
```
sudo vim /etc/nginx/sites-available/chfweb
删除原来所有的配置内容，添加下面的配置：
server{
  listen 80;
  listen [::]:80;

  server_name chf.com www.chf.com;

  charset utf-8;
  client_max_body_size 75M;

  # root /var/www/domain-two.com/html;
  # index index.html index.htm index.nginx-debian.html;
  
  # location / {
  #   try_files $uri $uri/ =404;
  # }


  location /static {
    alias /var/www/chfweb/static;
  }

  location /media {
    alias /var/www/chfweb/uploads;
  }

  location / {
    uwsgi_pass 127.0.0.1:8020;
    include /etc/nginx/uwsgi_params;
  }
}


sudo vim /etc/nginx/sites-available/qshweb
删除原来所有的配置内容，添加下面的配置：
server{
  listen 80;
  listen [::]:80;

  server_name qsh.com www.qsh.com;

  charset utf-8;
  client_max_body_size 75M;

  # root /var/www/domain-two.com/html;
  # index index.html index.htm index.nginx-debian.html;

  # location / {
  #   try_files $uri $uri/ =404;
  # }


  location /static {
    alias /var/www/qshweb/static;
  }

  location /media {
    alias /var/www/qshweb/uploads;
  }

  location / {
    uwsgi_pass 127.0.0.1:8020;
    include /etc/nginx/uwsgi_params;
  }
}


```

6. 最后我们需要将原来 Nginx 的 default 配置删除或将default内容注释
```
sudo rm etc/nginx/sites-available/default
```

7. 建立软链接
有了 chf.com 和 qsh.com 的配置之后，我们需要把这两个配置告知 Nginx 
```
sudo ln -s /etc/nginx/sites-available/chfweb /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/qshweb /etc/nginx/sites-enabled/
```

8. 执行上面的命令之后，我们再使用 nginx -t 检测 Nginx 的配置文件是否有错
```
sudo nginx -t
```

9. 如果你没有看到报错，就可以直接重启 Nginx 服务了
```
sudo service nginx start
sudo service nginx restart
sudo service nginx stop
```

10. 到此就大功告成啦！访问你的域名试试咯！
