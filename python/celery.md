## Celery

高性能分布式非阻塞框架

```
命令：
celery [command] [options]

options:
-h, --help
--version

-A app, --app app
-b BROKER, --broker BROKER
--result-backend RESULT_BACKEND
--loader LOADER
--config CONFIG
--workdir WORKDIR
--no-color, -C
--quiet, -q

command:
celery worker
celery events
celery beat
celery shell
celery multi
celery amqp

remote control:
celery status
celery inspect --help
celery inspect active
celery inspect active_queues
celery inspect clock
celery inspect conf [include_default=False]
celery inspect memdump [n_samples=10]
celery inspect memsample
celery inspect objgraph [object_type=Request] [num=20 [max_depth=20]]
celery inspect ping
celery inspect query_task [id1 [id2 [... [idN]]]]
celery inspect registered [attr1 [attr2 [...[attrN]]]]
celery inspect report
celery inspect reserved
celery inspect revoked
celery inspect scheduled
celery inspect stats

celery control --help
celery control add_consumer <queue> [exchange [type [routing_key]]]
celery control autoscale [max [min]]
celery control cancel_consumer <queue>
celery control disable_events
celery control election
celery control enable_events
celery control heartbeat
celery control pool_grow [N=1]
celery control pool_restart
celery control pool_shrink [N=1]
celery control rate_limit <task_name> <rate_limit (e.g., 5/s | 5/m | 5/h)>
celery control revoke [id1 [id2 [... [idN]]]]
celery control shutdown
celery control terminate <signal> [id1 [id2 [... [idN]]]]
celery control time_limit <task_name> <soft_secs> [hard_secs]

util:
celery purge
celery list
celery call
celery result
celery migrate
celery graph
celery upgrade

debugging:
celery report
celery logtool [options] <action> [args]
celery logtool stats [file1|file2|...]
celery logtool traces [file1|file2|...]
celery logtool errors [file1|file2|...]
celery logtool incomplete [file1|file2|...]
celery logtool debug [file1|file2|...]
```

```
启动celery服务
celery -A FastCelery worker -l info

为了解决win10 报错，
Task handler raised error: ValueError('not enough values to unpack (expected 3, got 0)')
安装eventlet 并且启动的时候增加-P eventlet
celery -A <mymodule> worker -l info -P eventlet
celery -A FastCelery worker -l info -P eventlet

启动定时任务服务
celery beat -A FastCelery.tasks -l info

分布式部署
在A机器上启动 worker@%h
celery -A FastCelery worker -l info -n worker.%h -Q for_task_add

在B机器上启动
celery -A FastCelery worker -l info -n worker.%h -Q for_task_minus

没有指定这个任务route到那个Queue中去执行则会route到Celery默认的名字叫做celery的队列中去
celery -A FastCelery worker -l info -n worker.%h -Q celery 

监控状态命令，需要安装flower
pipenv install flower --dev
+ broker是redis
celery flower --broker=redis://192.168.99.100:6379/0
+ broker是rabbitmq
celery flower --broker=amqp://admin:123456@192.168.99.100:5672/myvhost

然后打开
查看监控状态
http://localhost:5555
```

