@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis服务安装
echo ----------------------------------------------------------

echo 正在安装redis单实例服务

echo 安装redis.6379单实例服务
redis-server.exe --service-install redis.windows-service.conf --service-name redis.6379
echo redis.6379 install success
echo ----------------------------------------------------------


echo 安装redis单实例服务完毕

echo ----------------------------------------------------------

echo 正在启动redis单实例服务

echo 启动redis.6379单实例服务
redis-server.exe --service-start --service-name redis.6379
echo ----------------------------------------------------------

echo redis单实例服务启动完毕

pause