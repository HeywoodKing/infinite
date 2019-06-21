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
```

### 卸载Nginx
```

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
