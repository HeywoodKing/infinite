@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis服务安装
echo ----------------------------------------------------------

echo 正在安装redis服务

echo 安装redis.6380服务
redis-server.exe --service-install redis.windows-service.6380.conf --service-name redis.6380
echo redis.6380 install success
echo ----------------------------------------------------------

echo 安装redis.6381服务
redis-server.exe --service-install redis.windows-service.6381.conf --service-name redis.6381
echo redis.6381 install success
echo ----------------------------------------------------------

echo 安装redis.6382服务
redis-server.exe --service-install redis.windows-service.6382.conf --service-name redis.6382
echo redis.6382 install success
echo ----------------------------------------------------------

echo 安装redis服务完毕

echo ----------------------------------------------------------

echo 正在启动redis集群服务

echo 启动redis.6380服务
redis-server.exe --service-start --service-name redis.6380
echo ----------------------------------------------------------


echo 启动redis.6381服务
redis-server.exe --service-start --service-name redis.6381
echo ----------------------------------------------------------


echo 启动redis.6382服务
redis-server.exe --service-start --service-name redis.6382
echo ----------------------------------------------------------

echo redis集群服务启动完毕

pause