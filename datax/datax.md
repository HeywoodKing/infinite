### DataX 简介
DataX 是阿里巴巴集团内被广泛使用的离线数据同步工具/平台，实现包括 MySQL、Oracle、SqlServer、Postgre、HDFS、Hive、ADS、HBase、TableStore(OTS)、MaxCompute(ODPS)、DRDS 等各种异构数据源之间高效的数据同步功能。

![DataX3.0概览](https://cloud.githubusercontent.com/assets/1067175/17850533/3300d80e-6890-11e6-9c5a-cff9483b4bbf.png "DataX3.0概览")

### Features
DataX 本身作为数据同步框架，将不同数据源的同步抽象为从源头数据源读取数据的 Reader 插件，以及向目标端写入数据的 Writer 插件，理论上 DataX 框架可以支持任意数据源类型的数据同步工作。同时 DataX 插件体系作为一套生态系统, 每接入一套新数据源该新加入的数据源即可实现和现有的数据源互通。

+ 设计理念
为了解决异构数据源同步问题，DataX将复杂的网状的同步链路变成了星型数据链路，DataX作为中间传输载体负责连接各种数据源。当需要接入一个新的数据源的时候，只需要将此数据源对接到DataX，便能跟已有的数据源做到无缝数据同步

+ 当前使用现状
DataX在阿里巴巴集团内被广泛使用，承担了所有大数据的离线同步业务，并已持续稳定运行了6年之久。目前每天完成同步8w多道作业，每日传输数据量超过300TB

此前已经开源DataX1.0版本，此次介绍为阿里巴巴开源全新版本DataX3.0，有了更多更强大的功能和更好的使用体验。Github主页地址：https://github.com/alibaba/DataX

![DataX3.0框架设计](https://cloud.githubusercontent.com/assets/1067175/17850789/6b4e8976-6891-11e6-9355-8df609536bbf.png "DataX3.0框架设计")

DataX本身作为离线数据同步框架，采用Framework + plugin架构构建。将数据源读取和写入抽象成为Reader/Writer插件，纳入到整个同步框架中。
+ Reader：Reader为数据采集模块，负责采集数据源的数据，将数据发送给Framework。
+ Writer： Writer为数据写入模块，负责不断向Framework取数据，并将数据写入到目的端。
+ Framework：Framework用于连接reader和writer，作为两者的数据传输通道，并处理缓冲，流控，并发，数据转换等核心技术问题


### DataX详细介绍
#### DataX3.0插件体系
经过几年积累，DataX目前已经有了比较全面的插件体系，主流的RDBMS数据库、NOSQL、大数据计算系统都已经接入。DataX目前支持数据如下：

#### 核心模块介绍：
1. DataX完成单个数据同步的作业，我们称之为Job，DataX接受到一个Job之后，将启动一个进程来完成整个作业同步过程。DataX Job模块是单个作业的中枢管理节点，承担了数据清理、子任务切分(将单一作业计算转化为多个子Task)、TaskGroup管理等功能。
2. DataXJob启动后，会根据不同的源端切分策略，将Job切分成多个小的Task(子任务)，以便于并发执行。Task便是DataX作业的最小单元，每一个Task都会负责一部分数据的同步工作。
3. 切分多个Task之后，DataX Job会调用Scheduler模块，根据配置的并发数据量，将拆分成的Task重新组合，组装成TaskGroup(任务组)。每一个TaskGroup负责以一定的并发运行完毕分配好的所有Task，默认单个任务组的并发数量为5。
4. 每一个Task都由TaskGroup负责启动，Task启动后，会固定启动Reader—>Channel—>Writer的线程来完成任务同步工作。
5. DataX作业运行起来之后， Job监控并等待多个TaskGroup模块任务完成，等待所有TaskGroup任务完成后Job成功退出。否则，异常退出，进程退出值非0

### DataX调度流程：
举例来说，用户提交了一个DataX作业，并且配置了20个并发，目的是将一个100张分表的mysql数据同步到odps里面。 DataX的调度决策思路是：

1. DataXJob根据分库分表切分成了100个Task。
2. 根据20个并发，DataX计算共需要分配4个TaskGroup。
3. 4个TaskGroup平分切分好的100个Task，每一个TaskGroup负责以5个并发共计运行25个Task。


请参考：https://github.com/alibaba/DataX/blob/master/introduction.md
DataX Framework提供了简单的接口与插件交互，提供简单的插件接入机制，只需要任意加上一种插件，就能无缝对接其他数据源。详情请看：
[DataX数据源指南](https://github.com/alibaba/DataX/wiki/DataX-all-data-channels "DataX数据源指南")


### DataX3.0核心架构
DataX 3.0 开源版本支持单机多线程模式完成同步作业运行，本小节按一个DataX作业生命周期的时序图，从整体架构设计非常简要说明DataX各个模块相互关系。
![DataX3.0核心架构](https://cloud.githubusercontent.com/assets/1067175/17850849/aa6c95a8-6891-11e6-94b7-39f0ab5af3b4.png "DataX3.0核心架构")


### 安装
将下载后的压缩包直接解压后可用，前提是对应的 java 及 python 环境满足要求。
```
System Requirements
Linux
JDK(1.8以上，推荐1.8)
Python(推荐Python2.6.X)
Apache Maven 3.x (Compile DataX)
```

+ windows 安装jdk1.8+


+ linux 安装jdk1.8+


+ 下载DataX源码：
```
git clone git@github.com:alibaba/DataX.git
```

+ 通过maven打包：
```
cd  {DataX_source_code_home}
yum install -y maven
mvn -U clean package assembly:assembly -Dmaven.test.skip=true
```
打包成功后的DataX包位于 {DataX_source_code_home}/target/datax/datax/ ，结构如下：
```
cd  {DataX_source_code_home}
ls ./target/datax/datax/
bin             conf            job             lib             log             log_perf
```

### mysql数据传输到oracle
+ 生成mysql到oracle的配置文件：
```
[root@iZ2zeh44pi6rlahxj7s9azZ bin]# python datax.py -r mysqlreader -w oraclewriter

DataX (DATAX-OPENSOURCE-3.0), From Alibaba !
Copyright (C) 2010-2016, Alibaba Group. All Rights Reserved.

Please refer to the mysqlreader document:
     https://github.com/alibaba/DataX/blob/master/mysqlreader/doc/mysqlreader.md

Please refer to the oraclewriter document:
     https://github.com/alibaba/DataX/blob/master/oraclewriter/doc/oraclewriter.md

Please save the following configuration as a json file and  use
     python {DATAX_HOME}/bin/datax.py {JSON_FILE_NAME}.json
to run the job.

{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "column": [],
                        "connection": [
                            {
                                "jdbcUrl": [],
                                "table": []
                            }
                        ],
                        "password": "",
                        "username": "",
                        "where": ""
                    }
                },
                "writer": {
                    "name": "oraclewriter",
                    "parameter": {
                        "column": [],
                        "connection": [
                            {
                                "jdbcUrl": "",
                                "table": []
                            }
                        ],
                        "password": "",
                        "preSql": [],
                        "username": ""
                    }
                }
            }
        ],
        "setting": {
            "speed": {
                "channel": ""
            }
        }
    }
}
```

+ 传输文件配置
```
[root@iZ2zeh44pi6rlahxj7s9azZ bin]# vim ../job/myor.json

{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "column": ["id","qiye","diqu"],
                        "connection": [
                            {
                                "jdbcUrl": ["jdbc:mysql://[HOST_NAME]:PORT/[DATABASE_NAME]"],
                                "table": ["***"]
                            }
                        ],
                        "password": "***",
                        "username": "***",
                        "where": ""
                    }
                },
                "writer": {
                    "name": "oraclewriter",
                    "parameter": {
                        "column": ["id","qiye","diqu"],
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:oracle:thin:@[HOST_NAME]:PORT:[DATABASE_NAME]",
                                "table": ["***"]
                            }
                        ],
                        "password": "***",
                        "preSql": ["delete from ceshi"],
                        "username": "***"
                    }
                }
            }
        ],
        "setting": {
            "speed": {
                "channel": "1"
            }
        }
    }
}
```

### 执行传输过程
```
[root@iZ2zeh44pi6rlahxj7s9azZ bin]# python datax.py ../job/myor.json
```

### 验证传输是否成功
登录oralce查询对应的表数据



### Quick Start
1. 工具部署
+ 方法一、直接下载DataX工具包：DataX下载地址(http://datax-opensource.oss-cn-hangzhou.aliyuncs.com/datax.tar.gz)
下载后解压至本地某个目录，进入bin目录，即可运行同步作业：
```
$ cd  {YOUR_DATAX_HOME}/bin
$ python datax.py {YOUR_JOB.json}
```
自检脚本：python {YOUR_DATAX_HOME}/bin/datax.py {YOUR_DATAX_HOME}/job/job.json

+ 方法二、下载DataX源码，自己编译：DataX源码(https://github.com/alibaba/DataX)
- (1)、下载源码
`git clone git@github.com:alibaba/DataX.git`
- (2)、通过maven打包：
```
$ cd  {DataX_source_code_home}
$ mvn -U clean package assembly:assembly -Dmaven.test.skip=true
```
打包成功，日志显示如下：
```
[INFO] BUILD SUCCESS
[INFO] -----------------------------------------------------------------
[INFO] Total time: 08:12 min
[INFO] Finished at: 2015-12-13T16:26:48+08:00
[INFO] Final Memory: 133M/960M
[INFO] -----------------------------------------------------------------
打包成功后的DataX包位于 {DataX_source_code_home}/target/datax/datax/ ，结构如下：
$ cd  {DataX_source_code_home}
$ ls ./target/datax/datax/
bin		conf		job		lib		log		log_perf	plugin		script		tmp
```

2. 配置示例：从stream读取数据并打印到控制台
+ 第一步、创建创业的配置文件（json格式）
可以通过命令查看配置模板： python datax.py -r {YOUR_READER} -w {YOUR_WRITER}
```
$ cd  {YOUR_DATAX_HOME}/bin
$  python datax.py -r streamreader -w streamwriter
DataX (UNKNOWN_DATAX_VERSION), From Alibaba !
Copyright (C) 2010-2015, Alibaba Group. All Rights Reserved.
Please refer to the streamreader document:
    https://github.com/alibaba/DataX/blob/master/streamreader/doc/streamreader.md 

Please refer to the streamwriter document:
     https://github.com/alibaba/DataX/blob/master/streamwriter/doc/streamwriter.md 
 
Please save the following configuration as a json file and  use
     python {DATAX_HOME}/bin/datax.py {JSON_FILE_NAME}.json 
to run the job.

{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "streamreader", 
                    "parameter": {
                        "column": [], 
                        "sliceRecordCount": ""
                    }
                }, 
                "writer": {
                    "name": "streamwriter", 
                    "parameter": {
                        "encoding": "", 
                        "print": true
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel": ""
            }
        }
    }
}
```

根据模板配置json如下：
```
#stream2stream.json
{
  "job": {
    "content": [
      {
        "reader": {
          "name": "streamreader",
          "parameter": {
            "sliceRecordCount": 10,
            "column": [
              {
                "type": "long",
                "value": "10"
              },
              {
                "type": "string",
                "value": "hello，你好，世界-DataX"
              }
            ]
          }
        },
        "writer": {
          "name": "streamwriter",
          "parameter": {
            "encoding": "UTF-8",
            "print": true
          }
        }
      }
    ],
    "setting": {
      "speed": {
        "channel": 5
       }
    }
  }
}
```

+ 第二步：启动DataX
```
$ cd {YOUR_DATAX_DIR_BIN}
$ python datax.py ./stream2stream.json 
```
同步结束，显示日志如下：
```
...
2015-12-17 11:20:25.263 [job-0] INFO  JobContainer - 
任务启动时刻                    : 2015-12-17 11:20:15
任务结束时刻                    : 2015-12-17 11:20:25
任务总计耗时                    :                 10s
任务平均流量                    :              205B/s
记录写入速度                    :              5rec/s
读出记录总数                    :                  50
读写失败总数                    :                   0
```


### json配置文件例子
```
{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "column": ["id","kwargs_list"],
                        "connection": [
                            {
                                "jdbcUrl": ["jdbc:mysql://121.201.107.32:3306/db_electron?characterEncoding=utf8"],
                                "table": ["tb_electron_hot_kwargs"]
                            }
                        ],
                        "splitPK": "id",
                        "password": "Magic_ro.mofang123",
                        "username": "magic_ro",
                        "where": "create_time > FROM_UNIXTIME(${create_time}) and create_time < FROM_UNIXTIME(${end_time})"
                    }
                },
                "writer": {
                    "name": "mysqlwriter",
                    "parameter": {
                        "column": ["id","kwargs_list"],
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://192.168.1.163:3306/db_electron_online?characterEncoding=utf8",
                                "table": ["tb_electron_hot_kwargs"]
                            }
                        ],
                        "password": "mofang123",
                        "preSql": [
                            "truncate table tb_electron_hot_kwargs"
                        ],
                        "session": [],
                        "username": "root",
                        "writeMode": "insert",
                    }
                }
            }
        ],
        "setting": {
            "speed": {
                "channel": "5"
            },
            "errorLimit": [
            	"record": 0,
            	"percentage": 0.02
            ]
        }
    }
}
```



### 配置参数
全局调优
```
{
   "core":{
        "transport":{
            "channel":{
                "speed":{
                    "channel": 2, ## 此处为数据导入的并发度，建议根据服务器硬件进行调优
                    "record":-1,##此处解除对读取行数的限制
                    "byte":-1,##此处解除对字节的限制
                    "batchSize":2048 ##每次读取batch的大小
                } 
            } 
        } 
    },	
}
```

局部调优
```

"setting": 
{
	"speed": {
		"channel": 2, ## 此处为数据导入的并发度，建议根据服务器硬件进行调优
		"record":-1, ##此处解除对读取行数的限制
		"byte":-1, ##此处解除对字节的限制
		"batchSize":2048 ##每次读取batch的大小
	}

}

```




### 问题及解决

1. Python 版本要为 2，原因前面已经说过了，可手动修改为 3 的语法
2. cmd 乱码解决：输入 CHCP 65001
3. 数据库中的数据中文乱码解决：在 json 文件中 jdbcUrl 项加上：?characterEncoding=utf8
eg: "jdbcUrl": ["jdbc:mysql://127.0.0.1:3306/dq?characterEncoding=utf8"]


windows下乱码修复
我把这个工具迁移到一台windows主机上使用时候看到控制台友好的中文提示居然都变成了乱码了（话说有中文提示也是我选择他很重要的理由啊）。还好官方也给出了解决方案：

打开CMD.exe命令行窗口
通过 chcp命令改变代码页，UTF-8的代码页为65001
​ chcp 65001
执行该操作后，代码页就被变成UTF-8了。但是，在窗口中仍旧不能正确显示UTF-8字符。
修改窗口属性，改变字体
​ 在命令行标题栏上点击右键，选择"属性"->"字体"，将字体修改为True Type字体"Lucida Console"，然后点击确定将属性应用到当前窗口。


