
## MongoDB

### 安装
管理员模式进入cmd
```
C:\Windows\system32>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install -serviceName "MongoDB"
2019-04-24T13:06:38.318+0800 I CONTROL  [main] Automatically disabling TLS 1.0,
to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'

D:\MongoDB\bin>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install --serviceName "MongoDB"
这个时候服务里面已经安装好了

关于命令中的参数说明

参数 　　　　　　　　　　　描述
--bind_ip　　 　　　　　　绑定服务IP，若绑定127.0.0.1，则只能本机访问，不指定默认本地所有IP
--logpath	　　　　　　　　定MongoDB日志文件，注意是指定文件不是目录
--logappend	　　 　　　　 使用追加的方式写日志
--dbpath	　　　　　　　　 指定数据库路径
--port	　　　　　 　　　　 指定服务端口号，默认端口27017
--serviceName    　　　　  指定服务名称
--serviceDisplayName	　　指定服务名称，有多个mongodb服务时执行。
--install	　　　　　　　　   指定作为一个Windows服务安装。
```

### 连接
连接MongoDB
```
mongo 192.168.99.100/admin -u root -p
```

### 基本使用
查看所有数据库列表
```
show dbs
```

切换到创建用户
```
use Admn
```

使用数据库、创建数据库
```
use douban
```

创建数据库
```
db.douban
```

创建用户
```
db.addUser("flack", "123456")
db.createUser(
        {
	user: "flack",
	pwd: "123456",
	roles: [{role: "userAdmin", db: "test"}]
        }
)
```

设置用户为允许连接的用户
```
db.auth("flack", "123456")
```

创建表
```
db.createCollection("userinfo")
```

查看表是否创建成功
```
show collections
```


添加数据
```
db.userinfo.save({age: 1})
```

查询所有记录
```
db.userinfo.find()
```

显示当前的数据集合
```
show collections
```

删除数据库
```
db.dropDatabase()
```

删除集合，删除指定的集合 删除表
```
db.userinfo.drop()
```


插入一条数据
插入数据，随着数据的插入，数据库创建成功了，集合也创建成功了。
```
db.userinfo.insert({"name":"xiaoming"})
db.userinfo.insert(
{
	"_id": ObjectId("57172b0f657f8bbb34d70144"),
	"name": "测试"
})
```

查找数据
查询所有记录
```
db.userinfo.find()
相当于：select* from userInfo; 
```

查询去掉后的当前聚集集合中的某列的重复数据
```
db.userinfo.distinct("name")
会过滤掉 name 中的相同数据 相当于：select distict name from userinfo;
```

查询 age = 22 的记录
```
db.userinfo.find({"age": 22})
相当于： select * from userInfo where age = 22; 
```

查询 age > 22 的记录
```
db.userinfo.find({age:{$gt: 22}})
相当于：select * from userInfo where age >22;
```

查询 age < 22 的记录
```
db.userinfo.find({age: {$lt: 22}})
相当于：select * from userInfo where age <22; 
```

查询 age >= 25 的记录
```
db.userinfo.find({age: {$gte: 25}})
相当于：select * from userInfo where age >= 25; 
```

查询 age <= 25 的记录
```
db.userinfo.find({age: {$lte: 25}})
相当于：select * from userInfo where age <= 25; 
```

查询 age >= 23 并且 age <= 26
```
db.userinfo.find({age: {$gte: 23, $lte: 26}})
相当于：select * from userInfo where age >= 23 and age <= 26; 
```

查询 name 中包含 mongo 的数据
```
模糊查询用于搜索
db.userinfo.find({name: /mongo/})
相当于%% select * from userInfo where name like '%mongo%'; 
```

查询 name 中以 mongo 开头的
```
db.userinfo.find({name: /^mongo/})
相当于：select * from userInfo where name like 'mongo%'; 
```

查询指定列 name、age 数据
```
db.userinfo.find({}, {name: 1, age: 1})
或者
db.userinfo.find({}, {name: true, age: true})
当然 name 也可以用 true 或 false,当用 ture 的情况下河 name:1 效果一样，如果用 false 就 是排除 name，显示 name 以外的列信息
```

查询指定列 name、age 数据, age > 25
```
db.userinfo.find({age:{$gt: 25}}, {name:1, age: 1})
相当于：select name, age from userInfo where age >25; 
```

按照年龄排序 1 升序 -1 降序
```
升序：db.userinfo.find().sort({age: 1})
降序：db.userinfo.find().sort({age: -1})
```

查询 name = zhangsan, age = 22 的数据
```
db.userinfo.find({name: "zhangsan", age: 22})
相当于：select * from userInfo where name = 'zhangsan' and age = '22'; 
```

查询前 5 条数据
```
db.userinfo.find().limit(5)
相当于：select top 5 * from userInfo; 
```

查询 10 条以后的数据
```
db.userinfo.find().skip(10)
相当于：select * from userInfo where id not in (  
selecttop 10 * from userInfo  
); 
```

查询在 5-10 之间的数据
```
db.userinfo.find().limit(10).skip(5)
可用于分页，limit 是 pageSize，skip 是第几页*pageSize 
```

or 与 查询
```
db.userinfo.find({$or: [{age: 22}, {age: 25}]})
相当于：select * from userInfo where age = 22 or age = 25; 
```

findOne 查询第一条数据
```
db.userinfo.findOne()
相当于：select top 1 * from userInfo;  
db.userInfo.find().limit(1);  
```

查询某个结果集的记录条数 统计数量
```
db.userinfo.find({age: {$gte: 20}}).count()
相当于：select count(*) from userInfo where age >= 20;  
如果要返回限制之后的记录数量，要使用 count(true)或者 count(非 0)  db.users.find().skip(10).limit(5).count(true);   
```

修改数据
```
update() 方法用于更新已存在的文档
update() 方法用于更新已存在的文档。语法格式如下：
update.collection.update(
<query>,
<update>,
{
	upsert:<boolean>,
	multi:<boolean>,
	writeConcern:<document>
}
)
query : update的查询条件，类似sql update查询内where后面的。
update : update的对象和一些更新的操作符（如,inc…）等，也可以理解为sql update查询内set后面的
upsert : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
writeConcern :可选，抛出异常的级别。
```

修改里面还有查询条件。你要修改谁，要告诉 mongo。 查找名字叫做小明的，把年龄更改为 16 岁：
```
db.userinfo.update({"name":"xiaoming"}, {$set: {"age": 16}})
```

查找数学成绩是 70，把年龄更改为 33 岁：
```
db.userinfo.update({"score.shuxue": 70}, {$set: {"age": 33}})
```

更改所有匹配项目： 
以上语句只会修改第一条发现的文档，如果你要修改多条相同的文档，则需要设置 multi 参数为 true。 
```
multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
db.userinfo.update({"sex": "男"}, {$set: {"age": 33}}, {multi: true})
```

完整替换，不出现$set 关键字了： 注意
```
db.userinfo.update({"name": "xiaoming"}, {"name": "daming", "age": 16})

db.userinfo.update({"name": "Lisi"}, {$inc: {age: 50}}, false, true)
相当于：update users set age = age + 50 where name = 'Lisi'; 

db.userinfo.update({"name": "Lisi"}, {$inc: {age: 50}, $set: {name: "hihi"}}, false, true)
相当于：update userinfo set age = age + 50,name = "hihi"
where name = "Lisi"
```

只更新第一条记录：
```
db.userinfo.update({"count": {$gt: 1}}, {$set: {"test2": "OK"}})
```

全部更新：
```
db.userinfo.update({"count": {$gt: 3}}, {$set: {"test2": "OK"}}, false, true)
```

只添加第一条：
```
db.userinfo.update({"count": {$gt: 4}}, {$set: {"test5": "OK"}}, true, false)
```

全部添加进去:
```
db.userinfo.update({"count": {$gt: 5}}, {$set: {"test5": "OK"}}, true, true)
```

全部更新：
```
db.userinfo.update({"count": {$gt: 15}}, {$inc: {"count": 1}}, false, true)
```

只更新第一条记录：
```
db.userinfo.update({"count": {$gt: 10}}, {$inc: {"count": 1}}, false, false)
```

在3.2版本开始，MongoDB提供以下更新集合文档的方法：
```
db.collection.updateOne() 向指定集合更新单个文档
db.collection.updateMany() 向指定集合更新多个文档
```

更新单个文档
```
db.userinfo.updateOne({"name": "abc"}, {$set: {"age": "28"}})
```

更新多个文档
```
db.userinfo.updateMany({"age": {$gt: "10"}}, {$set: {"status": "xyz"}})
```

删除数据
3.2版本之前
```
db.collection.remove()
```

3.2版本之后
```
db.collection.deleteMany() //删除匹配条件的多条记录
db.collection.deleteOne() //删除匹配条件的单条记录
```

括号里面的参数是查询过滤器
```
{
  <field1>: <value1>,
  <field2>: { <operator>: <value> },
  ...
}
```
```
remove() 方法的基本语法格式如下所示：
db.collection.remove(
   <query>,
   <justOne>
)
如果你的 MongoDB 是 2.6 版本以后的，语法格式如下：
db.collection.remove(
   <query>,
   {
     justOne: <boolean>,
     writeConcern: <document>
   }
)
参数说明：

query :（可选）删除的文档的条件。
justOne : （可选）如果设为 true 或 1，则只删除一个文档。
writeConcern :（可选）抛出异常的级别。
```

```
db.userinfo.remove({"name": "manhattan"})
db.userinfo.remove({"age": 123})
db.userinfo.remove({"name": "newyork"}, {justOne: true})
```

删除test数据库中所有记录
```
db.test.deleteMany({})
{}表示没有约束条件。
```

删除test数据库中_id为5abb3b5bce69c048be080199的记录。
```
db.test.deleteMany({_id: ObjectId("5abb3b5bce69c048be080199")})
```

分组
```
db.NoDigikey.distinct('link_status');

db.NoDigikey.aggregate([
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
]);
db.orders.aggregate([
  { $match: { status: "A" } },
  { $group: { _id: "$cust_id", total: { $sum: "$amount" } } },
  { $sort: { total: -1 } }
])
db.NoDigikey.aggregate([
  {$match:{status:3}},
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
])
db.NoDigikey.aggregate([
  {$match:{link_status:{$ne:null},status:1}},
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
])
db.NoDigikey.aggregate([{$match:{status:{$in:[4,3,2]}}},{$group:{_id:'$link_status',total:{$sum:1}}},{$sort:{_id:1}}])
```

多条件查询
```
db.NoDigikey.find({status:1,link_status:{$ne:null}}).count()
db.NoDigikey.find({link_status:200,status:2}).count();
db.NoDigikey.find({link_status:{$ne:null}}).count();
db.NoDigikey.find({link_status:{$in:[301,302,404,403,905,908]}});
db.NoDigikey.find({link_status:{$ne:[200,301,302,404,403,905,908]}}).count();
db.NoDigikey.find({$and:[{link_status:{$ne: null},status:{$ne:1}]}).count();
db.NoDigikey.find({$or:[{status: 2},{status: 3}]}).count();
db.NoDigikey.aggregate([{$match:{status:4}},{$sample:{size:300}}])
```

更新
```
更新一条
db.NoDigikey.update({link_status:200,status:1},{$set:{link_status:null}});
更新多条
db.NoDigikey.update({link_status:200,status:1},{$set:{link_status:null}},{multi:true});
```


### 高级用法
导出mongodb数据库
```
mongodump -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件存储路径
如果没有用户，可以去掉 -u和-p
如果导出本机的数据库，可以去掉 -h
如果是默认端口，可以去掉 --port
如果想导出所有数据库，可以去掉 -d
eg:
mongodump -h IP --port 27017 -u flack -p 123456 -d test -o D:/MongoDB/Backups/  本地不用加:-h IP

导出指定数据库
mongodump -h IP -d test -o D:/MongoDB/Backups/ 

导入MongoDB数据库
mongorestore -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 --drop 文件存在路径
eg:
mongorestore -h IP --port 27017 -u flack -p 123456 -d test --drop D:/MongoDB/Backups/2019-04-27/test  本地不用加 -h IP
```

### 导出文档
```
mongoexport -h 192.168.1.141 --port 27018 -d configs -c NoDigikey --type=csv -q "{$and: [{link_status: {$ne: null}}, {link_status:{$gt: 200}}, {link_status:{$ne: 429}}, {link_status:{$ne: 908}}]}" -f _id,id,model_name,data_sheet,status,link_status -o D:/Flack/Work/nodigikey.csv
```


### python使用mongodb
```
pymongo

client = pymongo.MongoClient("127.0.0.1", 27017)
client = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = client["douban"]
mycol = mydb["userinfo"]

x = mycol.find_one()

for x in mycol.find():

for x in mycol.find({}, {"_id":0, "name":1, "alexa":1})

for x in mycol.find({}, {"alexa":0})

for x in mycol.find({ "name": { "$gt": "H" } })

for x in mycol.find({ "name": { "$regex": "^R" } })

for x in mycol.find().limit(3)
```




