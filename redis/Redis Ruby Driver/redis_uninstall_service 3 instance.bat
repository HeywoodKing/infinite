@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis����ж��
echo ----------------------------------------------------------


echo ����ֹͣredis��Ⱥ����

echo ֹͣredis.6380����
redis-server.exe --service-stop --service-name redis.6380
echo ----------------------------------------------------------


echo ֹͣredis.6381����
redis-server.exe --service-stop --service-name redis.6381
echo ----------------------------------------------------------


echo ֹͣredis.6382����
redis-server.exe --service-stop --service-name redis.6382
echo ----------------------------------------------------------

echo redis��Ⱥ������ֹͣ


echo ----------------------------------------------------------


echo ����ж��redis����

echo ж��redis.6380����
redis-server.exe --service-uninstall redis.windows-service.6380.conf --service-name redis.6380
echo redis.6380 install success
echo ----------------------------------------------------------

echo ж��redis.6381����
redis-server.exe --service-uninstall redis.windows-service.6381.conf --service-name redis.6381
echo redis.6381 install success
echo ----------------------------------------------------------

echo ж��redis.6382����
redis-server.exe --service-uninstall redis.windows-service.6382.conf --service-name redis.6382
echo redis.6382 install success
echo ----------------------------------------------------------

echo ж��redis�������


pause