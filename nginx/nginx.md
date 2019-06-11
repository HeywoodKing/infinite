# Nginx

## 安装Nginx
```
sudo apt-get update
sudo apt-get install nginx
```

## 安装完成后，检查Nginx服务的状态：
```
sudo systemctl status nginx
```

## 检查Nginx服务的状态和版本：
```
sudo nginx -v
```

## 配置防火墙
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

## 使用systemctl管理Nginx服务
```
您可以像任何其他systemd单位一样管理Nginx服务。 要停止Nginx服务，请运行
sudo systemctl stop nginx
sudo /etc/init.d/nginx stop

sudo systemctl start nginx
sudo /etc/init.d/nginx start

sudo systemctl restart nginx
sudo /etc/init.d/nginx restart
```

## 在进行一些配置更改后重新加载Nginx服务
```
sudo systemctl reload nginx
```

## 禁用Nginx服务在启动时启动
```
sudo systemctl disable nginx
```

## 重新启用它
```
sudo systemctl enable nginx
```

