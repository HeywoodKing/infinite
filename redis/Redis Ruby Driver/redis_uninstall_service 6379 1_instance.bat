@echo off
@echo off

echo ----------------------------------------------------------
echo                        redis����ж��
echo ----------------------------------------------------------


echo ����ֹͣredis��ʵ������

echo ֹͣredis.6379��ʵ������
redis-server.exe --service-stop --service-name redis.6379
echo ----------------------------------------------------------

echo redis��ʵ��������ֹͣ


echo ----------------------------------------------------------


echo ����ж��redis��ʵ������

echo ж��redis.6379��ʵ������
redis-server.exe --service-uninstall redis.windows-service.conf --service-name redis.6379
echo redis.6379 install success
echo ----------------------------------------------------------

echo ж��redis��ʵ���������


pause