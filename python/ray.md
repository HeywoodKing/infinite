# Ray


## Ray概述


## Ray系统架构

![ray架构图](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pbWFnZXMyMDE4LmNuYmxvZ3MuY29tL2Jsb2cvNDA1ODc3LzIwMTcxMS80MDU4NzctMjAxNzExMjYyMzU2MTU2MjUtMTE2NTE3NjgyNS5wbmc "ray架构图")

作为分布式计算系统，Ray仍旧遵循了典型的Master-Slave的设计：Master负责全局协调和状态维护，Slave执行分布式计算任务。不过和传统的分布式计算系统不同的是，Ray使用了混合任务调度的思路。在集群部署模式下，Ray启动了以下关键组件：

1. GlobalScheduler：Master上启动了一个全局调度器，用于接收本地调度器提交的任务，并将任务分发给合适的本地任务调度器执行。
2. RedisServer：Master上启动了一到多个RedisServer用于保存分布式任务的状态信息（ControlState），包括对象机器的映射、任务描述、任务debug信息等。
3. LocalScheduler：每个Slave上启动了一个本地调度器，用于提交任务到全局调度器，以及分配任务给当前机器的Worker进程。
4. Worker：每个Slave上可以启动多个Worker进程执行分布式任务，并将计算结果存储到ObjectStore。
5. ObjectStore：每个Slave上启动了一个ObjectStore存储只读数据对象，Worker可以通过共享内存的方式访问这些对象数据，这样可以有效地减少内存拷贝和对象序列化成本。ObjectStore底层由Apache Arrow实现。
6. Plasma：每个Slave上的ObjectStore都由一个名为Plasma的对象管理器进行管理，它可以在Worker访问本地ObjectStore上不存在的远程数据对象时，主动拉取其它Slave上的对象数据到当前机器。

需要说明的是，Ray的论文中提及，全局调度器可以启动一到多个，而目前Ray的实现文档里讨论的内容都是基于一个全局调度器的情况。我猜测可能是Ray尚在建设中，一些机制还未完善，后续读者可以留意此处的细节变化。


![Driver](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pbWFnZXMyMDE4LmNuYmxvZ3MuY29tL2Jsb2cvNDA1ODc3LzIwMTcxMS80MDU4NzctMjAxNzExMjYyMzU2MzU1MTUtMjExOTI3ODI1NS5wbmc "Driver")

Ray的Driver节点和和Slave节点启动的组件几乎相同，不过却有以下区别：

1. Driver上的工作进程DriverProcess一般只有一个，即用户启动的PythonShell。Slave可以根据需要创建多个WorkerProcess。
2. Driver只能提交任务，却不能接收来自全局调度器分配的任务。Slave可以提交任务，也可以接收全局调度器分配的任务。
3. Driver可以主动绕过全局调度器给Slave发送Actor调用任务（此处设计是否合理尚不讨论）。Slave只能接收全局调度器分配的计算任务。

## 核心操作




