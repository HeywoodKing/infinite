@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis服务卸载
echo ----------------------------------------------------------


echo 正在停止redis单实例服务

echo 停止redis.6379单实例服务
redis-server.exe --service-stop --service-name redis.6379
echo ----------------------------------------------------------

echo redis单实例服务已停止


echo ----------------------------------------------------------


echo 正在卸载redis单实例服务

echo 卸载redis.6379单实例服务
redis-server.exe --service-uninstall redis.windows-service.conf --service-name redis.6379
echo redis.6379 install success
echo ----------------------------------------------------------

echo 卸载redis单实例服务完毕


pause