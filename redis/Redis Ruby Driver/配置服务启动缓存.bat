@echo off
@echo off

echo ----------------------------------------------------------
echo                          ����װ
echo ----------------------------------------------------------

cd D:/Redis/

D:/Redis/redis-server.exe --service-install D:/Redis/redis.6379.conf --service-name redis6379

D:/Redis/redis-server.exe --service-start --service-name Redis6379