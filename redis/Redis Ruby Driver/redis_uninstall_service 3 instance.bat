@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis服务卸载
echo ----------------------------------------------------------


echo 正在停止redis集群服务

echo 停止redis.6380服务
redis-server.exe --service-stop --service-name redis.6380
echo ----------------------------------------------------------


echo 停止redis.6381服务
redis-server.exe --service-stop --service-name redis.6381
echo ----------------------------------------------------------


echo 停止redis.6382服务
redis-server.exe --service-stop --service-name redis.6382
echo ----------------------------------------------------------

echo redis集群服务已停止


echo ----------------------------------------------------------


echo 正在卸载redis服务

echo 卸载redis.6380服务
redis-server.exe --service-uninstall redis.windows-service.6380.conf --service-name redis.6380
echo redis.6380 install success
echo ----------------------------------------------------------

echo 卸载redis.6381服务
redis-server.exe --service-uninstall redis.windows-service.6381.conf --service-name redis.6381
echo redis.6381 install success
echo ----------------------------------------------------------

echo 卸载redis.6382服务
redis-server.exe --service-uninstall redis.windows-service.6382.conf --service-name redis.6382
echo redis.6382 install success
echo ----------------------------------------------------------

echo 卸载redis服务完毕


pause