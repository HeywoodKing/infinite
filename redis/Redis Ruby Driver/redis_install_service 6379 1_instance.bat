@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis����װ
echo ----------------------------------------------------------

echo ���ڰ�װredis��ʵ������

echo ��װredis.6379��ʵ������
redis-server.exe --service-install redis.windows-service.conf --service-name redis.6379
echo redis.6379 install success
echo ----------------------------------------------------------


echo ��װredis��ʵ���������

echo ----------------------------------------------------------

echo ��������redis��ʵ������

echo ����redis.6379��ʵ������
redis-server.exe --service-start --service-name redis.6379
echo ----------------------------------------------------------

echo redis��ʵ�������������

pause