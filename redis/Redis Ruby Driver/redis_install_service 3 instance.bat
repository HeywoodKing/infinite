@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis����װ
echo ----------------------------------------------------------

echo ���ڰ�װredis����

echo ��װredis.6380����
redis-server.exe --service-install redis.windows-service.6380.conf --service-name redis.6380
echo redis.6380 install success
echo ----------------------------------------------------------

echo ��װredis.6381����
redis-server.exe --service-install redis.windows-service.6381.conf --service-name redis.6381
echo redis.6381 install success
echo ----------------------------------------------------------

echo ��װredis.6382����
redis-server.exe --service-install redis.windows-service.6382.conf --service-name redis.6382
echo redis.6382 install success
echo ----------------------------------------------------------

echo ��װredis�������

echo ----------------------------------------------------------

echo ��������redis��Ⱥ����

echo ����redis.6380����
redis-server.exe --service-start --service-name redis.6380
echo ----------------------------------------------------------


echo ����redis.6381����
redis-server.exe --service-start --service-name redis.6381
echo ----------------------------------------------------------


echo ����redis.6382����
redis-server.exe --service-start --service-name redis.6382
echo ----------------------------------------------------------

echo redis��Ⱥ�����������

pause