# MongoDB

### 安装
管理员模式进入cmd
```
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

### 配置本地和远程连接
```
A.安装mongodb支持本地服务
mongod --dbpath "D:\Program Files\MongoDB\Server\4.0\data" --logpath "D:\Program Files\MongoDB\Server\4.0\log\mongodb.log" --serviceName "mongodb" --serviceDisplayName "mongodb" --install

C:\Windows\system32>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install -serviceName "MongoDB"
或
D:\MongoDB\bin>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install --serviceName "MongoDB"
这个时候服务里面已经安装好了

B.安装mongodb支持本地和远程服务
1. 在安装路径D:\Program Files\MongoDB\Server\4.0\bin\mongod.cfg修改文件
net:
    bindIp: 127.0.0.1,0.0.0.0
    port: 27017
2. 关闭防火墙或者将端口加入到防火墙规则中让其通过
3. 以管理员身份在bin目录下执行如下命令，使配置生效
mongod --config "D:\Program Files\MongoDB\Server\4.0\bin\mongod.cfg" --install
4. cmd中重启服务
net stop mongodb
net start mongodb
5. 为了安全起见，还需要添加一层用户
这里虽然设置了0.0.0.0允许远程访问，还需要加一层验证，添加mongo用户
mongo 127.0.0.1:27017/admin
use admin
db.createUser({
    "user":"admin","pwd":"123456",
    "roles":[
        {role:"userAdminAnyDatabase", db: "admin"}, 
        {role:"readWriteAnyDatabase", db: "admin"} 
]});

创建管理员账号
db.createUser({user:"root",pwd:"123456",roles:["root"]})
db.auth("wuzeon","xxxxxx")

这里就添加了一个admin的用户，密码为123456
6. 修改一下注册表，添加auth参数
运行-> regedit-> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services->MongoDB（mongodb注册的名称，我的是MongoDB)
在它的ImgPath中，我们修改一下，加入 –auth
7. 连接服务
mongo 192.168.1.79:27017/mofang [-u root -p]
```

### 连接
连接MongoDB
```
mongo 192.168.99.100:27017/admin -u root -p
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
	roles: [{role: "userAdmin", db: "NoDigikey"}]
        }
)
```

设置用户为允许连接的用户
```
db.auth("flack", "123456")
```

创建表
```
db.createCollection("NoDigikey")
```

查看表是否创建成功
```
show collections
```

添加数据
```
db.NoDigikey.save({age: 1})
```

查询所有记录
```
db.NoDigikey.find()
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
db.NoDigikey.drop()
```


插入一条数据
插入数据，随着数据的插入，数据库创建成功了，集合也创建成功了。
```
db.NoDigikey.insert({"name":"xiaoming"})
db.NoDigikey.insert(
{
	"_id": ObjectId("57172b0f657f8bbb34d70144"),
	"name": "测试"
})
```

查找数据
查询所有记录
```
db.NoDigikey.find()
相当于：select* from NoDigikey; 
```

查询去掉后的当前聚集集合中的某列的重复数据
```
db.NoDigikey.distinct("name")
会过滤掉 name 中的相同数据 相当于：select distict name from NoDigikey;
```

查询 age = 22 的记录
```
db.NoDigikey.find({"age": 22})
相当于： select * from NoDigikey where age = 22; 
```

查询 age > 22 的记录
```
db.NoDigikey.find({age:{$gt: 22}})
相当于：select * from NoDigikey where age >22;
```

查询 age < 22 的记录
```
db.NoDigikey.find({age: {$lt: 22}})
相当于：select * from NoDigikey where age <22; 
```

查询 age >= 25 的记录
```
db.NoDigikey.find({age: {$gte: 25}})
相当于：select * from NoDigikey where age >= 25; 
```

查询 age <= 25 的记录
```
db.NoDigikey.find({age: {$lte: 25}})
相当于：select * from NoDigikey where age <= 25; 
```

查询 age >= 23 并且 age <= 26
```
db.NoDigikey.find({age: {$gte: 23, $lte: 26}})
相当于：select * from NoDigikey where age >= 23 and age <= 26; 
```

查询 name 中包含 mongo 的数据
```
模糊查询用于搜索
db.NoDigikey.find({name: /mongo/})
相当于%% select * from NoDigikey where name like '%mongo%'; 
```

查询 name 中以 mongo 开头的
```
db.NoDigikey.find({name: /^mongo/})
相当于：select * from NoDigikey where name like 'mongo%'; 
```

查询指定列 name、age 数据
```
db.NoDigikey.find({}, {name: 1, age: 1})
或者
db.NoDigikey.find({}, {name: true, age: true})
当然 name 也可以用 true 或 false,当用 ture 的情况下河 name:1 效果一样，如果用 false 就 是排除 name，显示 name 以外的列信息
```

查询指定列 name、age 数据, age > 25
```
db.NoDigikey.find({age:{$gt: 25}}, {name:1, age: 1})
相当于：select name, age from NoDigikey where age >25; 
```

按照年龄排序 1 升序 -1 降序
```
升序：db.NoDigikey.find().sort({age: 1})
降序：db.NoDigikey.find().sort({age: -1})
```

查询 name = zhangsan, age = 22 的数据
```
db.NoDigikey.find({name: "zhangsan", age: 22})
相当于：select * from NoDigikey where name = 'zhangsan' and age = '22'; 
```

查询前 5 条数据
```
db.NoDigikey.find().limit(5)
相当于：select top 5 * from NoDigikey; 
```

查询 10 条以后的数据
```
db.NoDigikey.find().skip(10)
相当于：select * from NoDigikey where id not in (  
selecttop 10 * from NoDigikey  
); 
```

查询在 5-10 之间的数据
```
db.NoDigikey.find().limit(10).skip(5)
可用于分页，limit 是 pageSize，skip 是第几页*pageSize 
```

or 与 查询
```
db.NoDigikey.find({$or: [{age: 22}, {age: 25}]})
相当于：select * from NoDigikey where age = 22 or age = 25; 
```

findOne 查询第一条数据
```
db.NoDigikey.findOne()
相当于：select top 1 * from NoDigikey;  
db.NoDigikey.find().limit(1);  
```

查询某个结果集的记录条数 统计数量
```
db.NoDigikey.find({age: {$gte: 20}}).count()
相当于：select count(*) from NoDigikey where age >= 20;  
如果要返回限制之后的记录数量，要使用 count(true)或者 count(非 0)  db.users.find().skip(10).limit(5).count(true);
以www.diodes.com开头
db.NoDigikey.find({data_sheet:/^www.diodes.com/})
以http://www.yageo.com开头
db.NoDigikey.find({data_sheet:'/^http://www.yageo.com/'})
以www.diodes.com结尾
db.NoDigikey.find({data_sheet:/www.diodes.com^/})
```

返回指定的字段
```
db.NoDigikey.find({zh_name:"张三"},{second_zh_name:1,third_zh_name:1,third_category_id:1});
db.category_zh.find({"second_zh_name":"风扇"},{_id:1,zh_name:1,second_zh_name:1,third_zh_name:1,third_category_id:1}).pretty();
```

限制要返回的字段
```
db.NoDigikey.find({zh_name:"张三"},{second_zh_name:0,third_zh_name:0});

错误的语句如下：
db.category_zh.find({"second_zh_name":"风扇"},{_id:1,zh_name:0,second_zh_name:0,third_zh_name:1,third_category_id:1}).pretty();
正确的语句如下：
db.category_zh.find({"second_zh_name":"风扇"},{_id:0,second_zh_name:0}).pretty();
```

```
上面两种模式不能混用，因为这样的话，MongoDB就无法推断其他键是否应该返回。即projection中的字段值，要么全是1，要么全是0。但是_id字段是个特例，在包含模式下，_id字段可以为0
```


限制数组中返回的内容
```
db.NoDigikey.find({zh_name:"张三"},{status:0,second_zh_name:{$slice:1}});
```

判断字段是否存在
```
db.NoDigikey.find({zh_name:{$exists:true}});
```

移除某个字段（删除某个字段）
```
db.NoDigikey.update({},{$unset:{zh_name:""}},{multi:true});
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
db.NoDigikey.update({"name":"xiaoming"}, {$set: {"age": 16}})
```

查找数学成绩是 70，把年龄更改为 33 岁：
```
db.NoDigikey.update({"score.shuxue": 70}, {$set: {"age": 33}})
```

更改所有匹配项目： 
以上语句只会修改第一条发现的文档，如果你要修改多条相同的文档，则需要设置 multi 参数为 true。 
```
multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
db.NoDigikey.update({"sex": "男"}, {$set: {"age": 33}}, {multi: true})
```

完整替换，不出现$set 关键字了： 注意
```
db.NoDigikey.update({"name": "xiaoming"}, {"name": "daming", "age": 16})

db.NoDigikey.update({"name": "Lisi"}, {$inc: {age: 50}}, false, true)
相当于：update users set age = age + 50 where name = 'Lisi'; 

db.NoDigikey.update({"name": "Lisi"}, {$inc: {age: 50}, $set: {name: "hihi"}}, false, true)
相当于：update NoDigikey set age = age + 50,name = "hihi"
where name = "Lisi"
```

只更新第一条记录：
```
db.NoDigikey.update({"count": {$gt: 1}}, {$set: {"NoDigikey2": "OK"}})
```

全部更新：
```
db.NoDigikey.update({"count": {$gt: 3}}, {$set: {"NoDigikey2": "OK"}}, false, true)
```

只添加第一条：
```
根据条件往表里插入一个字段
db.NoDigikey.update({"course_id":"5352d5ab92fc7705666ae8c9"},{$set:{"file_type":"PDF"}},{multi:true});
db.NoDigikey.update({"count": {$gt: 4}}, {$set: {"NoDigikey5": "OK"}}, true, false);
```

全部添加进去:
```
db.NoDigikey.update({"count": {$gt: 5}}, {$set: {"NoDigikey5": "OK"}}, true, true)
```

全部更新：
```
db.NoDigikey.update({"count": {$gt: 15}}, {$inc: {"count": 1}}, false, true)
```

只更新第一条记录：
```
db.NoDigikey.update({"count": {$gt: 10}}, {$inc: {"count": 1}}, false, false)
```

在3.2版本开始，MongoDB提供以下更新集合文档的方法：
```
db.collection.updateOne() 向指定集合更新单个文档
db.collection.updateMany() 向指定集合更新多个文档
```

更新单个文档
```
db.NoDigikey.updateOne({"name": "abc"}, {$set: {"age": "28"}})
```

更新多个文档
```
db.NoDigikey.updateMany({"age": {$gt: "10"}}, {$set: {"status": "xyz"}})
```
```
更新字段前缀+本身
db.NoDigikey.find({'status':{'$ne': 1}}).forEach(
  function(item){
    db.NoDigikey.update({'_id': item._id},{$set: {'date_sheet': 'http://www.ecliptek.com/SpecSheetGenerator/specific.aspx?PartNumber=' + item.model_name}})
  }
)

查询出hospitalName是xx医院和openId以2开头的所有记录，并且更新my_booking表中的payType为1
db.getCollection('my_booking').find({"hospitalName":/xx医院/,openId:/^2/}).forEach(
  function(item){                
    db.getCollection('my_booking').update({"_id":item._id},{$set:{"payType": "1"}})
  }
)

查询出hospitalName是xx医院和openId不以2开头的所有记录，并且更新my_booking表中的payType为2.
db.getCollection('my_booking').find({"hospitalName":/xx医院/,openId:{$not:/^2/}}).forEach(
   function(item){                
       db.getCollection('my_booking').update({"_id":item._id},{$set:{"payType": "2"}})
   }
)
查询出xx医院和不已2开头的openId的所有记录，并且将每条记录的outTradeNo2赋值给outTradeNo1.
db.getCollection('my_booking').find({"hospitalName":/xx医院/,openId:{$not:/^2/}}).forEach(
   function(item){                
       db.getCollection('my_booking').update({"_id":item._id},{$set:{"outTradeNo1": item.outTradeNo2}})
   }
)

db.Goods.find().forEach(
  function(item){
    if(!item.goodsCode.indexOf("ABCD")){
      var tempGoodId=item._id;
      var tempGoodCode=item.goodsCode;
      var temp=db.Goods.findOne({"goodsCode":{"$regex":"^"+tempGoodCode+".+"}});
      if(temp){
        // print(tempGoodCode+"="+item._id);
        var cursor=db.GoodAttr.find({"goodsId":tempGoodId});
          cursor.forEach(function(a){
            print(a);        
        })
      }
    }
  }
)
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
db.NoDigikey.remove({"name": "manhattan"})
db.NoDigikey.remove({"age": 123})
db.NoDigikey.remove({"name": "newyork"}, {justOne: true})
```

删除NoDigikey数据库中所有记录
```
db.NoDigikey.deleteMany({})
{}表示没有约束条件。
```

删除NoDigikey数据库中_id为5abb3b5bce69c048be080199的记录。
```
db.NoDigikey.deleteMany({_id: ObjectId("5abb3b5bce69c048be080199")})
```

分组
```
db.NoDigikey.distinct('link_status');

db.NoDigikey.aggregate([
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
]);

db.NoDigikey.aggregate([
  { $match: { status: "A" } },
  { $group: { _id: "$cust_id", total: { $sum: "$amount" } } },
  { $sort: { total: -1 } }
]);

db.NoDigikey.aggregate([
  {$match:{status:3}},
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
]);

db.NoDigikey.aggregate([
  {$match:{link_status:{$ne:null},status:1}},
  {$group:{_id:"$link_status",total:{$sum:1}}}, 
  {$sort:{_id:1}}
]);

db.NoDigikey.aggregate([
  {$match:{status:{$in:[4,3,2]}}},
  {$group:{_id:'$link_status',total:{$sum:1}}},
  {$sort:{_id:1}}
]);
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
db.NoDigikey.aggregate([{'$sample': {'size': count}}])
db.NoDigikey.aggregate([{$match:{status:4}},{$sample:{size:300}}])
```

更新
```
db.collection.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)
query : update的查询条件，类似sql update查询内where后面的。
update : update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的
upsert : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
writeConcern :可选，抛出异常的级别。

更新一条
db.NoDigikey.update({link_status:200,status:1},{$set:{link_status:null}});
更新多条
db.NoDigikey.update({link_status:200,status:1},{$set:{link_status:null}},{multi:true});
更新多条记录，将data_sheet=https://www.alliedelec.comhttps:开头的数据字段替换为https:
db.getCollection('NoDigikey').find({status:{$gt:1},data_sheet:{$regex:/^https:\/\/www.alliedelec.comhttps:/}}).forEach(
  function(item){
    item.data_sheet = item.data_sheet.replace('https://www.alliedelec.comhttps:', 'https:');
    print(item.data_sheet);
    db.getCollection('NoDigikey').update({_id:item._id},{$set:{data_sheet:item.data_sheet}});
  }
)
```

### 创建索引
```
MongoDB 创建索引的语法
1.为普通字段添加索引，并且为索引命名
db.集合名.createIndex( {"字段名": 1 },{"name":'idx_字段名'})

说明： 
（1）索引命名规范：idx_<构成索引的字段名>。如果字段名字过长，可采用字段缩写。
（2）字段值后面的 1 代表升序；如是 -1 代表 降序。

2.为内嵌字段添加索引
db.集合名.createIndex({"字段名.内嵌字段名":1},{"name":'idx_字段名_内嵌字段名'})


3.通过后台创建索引
db.集合名.createIndex({"字段名":1},{"name":'idx_字段名',background:true})


4:组合索引
db.集合名.createIndex({"字段名1":-1,"字段名2":1},{"name":'idx_字段名1_字段名2',background:true})


5.设置TTL 索引
db.集合名.createIndex( { "字段名": 1 },{ "name":'idx_字段名',expireAfterSeconds: 定义的时间,background:true} )
说明 ：expireAfterSeconds为过期时间（单位秒）  

6.createIndex() 接收可选参数汇总
Parameter Typ Description
background  Boolean 建索引过程会阻塞其它数据库操作，background可指定以后台方式创建索引，即增加 "background" 可选参数。 "background" 默认值为false。
unique  Boolean 建立的索引是否唯一。指定为true创建唯一索引。默认值为false.
name  string  索引的名称。如果未指定，MongoDB的通过连接索引的字段名和排序顺序生成一个索引名称。
sparse  Boolean 对文档中不存在的字段数据不启用索引；这个参数需要特别注意，如果设置为true的话，在索引字段中不会查询出不包含对应字段的文档.。默认值为 false.
expireAfterSeconds  integer 指定一个以秒为单位的数值，完成 TTL设定，设定集合的生存时间。
weights document  索引权重值，数值在 1 到 99,999 之间，表示该索引相对于其他索引字段的得分权重。
default_language  string  对于文本索引，该参数决定了停用词及词干和词器的规则的列表。 默认为英语
```


## 高级用法
### 导出文档
```
mongoexport -h 192.168.1.141 --port 27018 -d configs -c NoDigikey --csv -q "{$and: [{link_status: {$ne: null}}, {link_status:{$gt: 200}}, {link_status:{$ne: 429}}, {link_status:{$ne: 908}}]}" -f _id,id,model_name,data_sheet,status,link_status -o D:/Flack/Work/nodigikey.csv

mongoexport --host 192.168.1.141 --port 27018 -d configs -c digikey -u king -p king@2016 -q "{$or:[{status:2},{status:3},{status:4}]}" --out D:\flack\work\digikey.json
mongoexport --host 192.168.1.163 --port 27017 -d configs -c digikey2 -u king -p king@2016 -q "{$or:[{status:2},{status:20}]}" --out D:\flack\work\digikey2.json
mongoexport --host 192.168.1.163 --port 27017 -d configs -c digikey3 -u king -p king@2016 -q "{$or:[{status:2},{status:10}]}" --out D:\flack\work\digikey3.json

参数说明：
-h：数据库宿主机的IP
-u：数据库用户名
-p：数据库密码
-d：数据库名字
-c：集合的名字
-f：导出的列名
-q：导出数据的过滤条件
--csv：导出格式为csv
```

### 导入文档
```
mongoimport --host 192.168.1.163 --port 27017 -d configs -c digikey -u king -p king@2016 --numInsertionWorkers 50 --file export/digikey.json
mongoimport --host 127.0.0.1 --port 27017 -d mofang -c digikey --numInsertionWorkers 50 --file digikey2.json
mongoimport --host 127.0.0.1 --port 27017 -d mofang -c digikey --numInsertionWorkers 80 --file digikey3.json
mongoimport -h 127.0.0.1 -p 27017 -d mofang -c digikey --numInsertionWorkers 80 --file digikey3.json
mongoimport --host 127.0.0.1 --port 27017 -d wc -c male --numInsertionWorkers 8 --file "digikey - NoDigikey.json"
mongoimport -h 127.0.0.1 -p 27017 -d mofang -c digikey --numInsertionWorkers 80 --file digikey3.json

参数说明：
-h:指明数据库宿主机的IP
-u:指明数据库的用户名
-p:指明数据库的密码
-d:指明数据库的名字
-c:指明collection的名字
-f:指明要导入那些列
```


### 备份MongoDB数据库
```
导出指定数据库
mongodump -h IP --port 27017 -u flack -p 123456 -d NoDigikey -o D:/MongoDB/Backups/  本地不用加:-h IP
mongodump -h IP -d NoDigikey -o D:/MongoDB/Backups/ 

mongodump -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 -o 文件存储路径
如果没有用户，可以去掉 -u和-p
如果导出本机的数据库，可以去掉 -h
如果是默认端口，可以去掉 --port
如果想导出所有数据库，可以去掉 -d
```

### 还原MongoDB数据库
```
mongorestore -h IP --port 端口 -u 用户名 -p 密码 -d 数据库 --drop 文件存在路径
mongorestore -h IP --port 27017 -u flack -p 123456 -d NoDigikey --drop D:/MongoDB/Backups/2019-04-27/NoDigikey  本地不用加 -h IP
```

### 修改数据库名
```
拷贝数据库后，删除原来的数据库
db.copyDatabase('old_name', 'new_name'); 
use old_name 
db.dropDatabase();

利用renameCollection命令
db.adminCommand({renameCollection: "db1.NoDigikey1", to: "db2.NoDigikey2"})
```

### 修改表名
```
db.category.renameCollection("category_zh");
或
db.getCollection('category').renameCollection("category_zh");
```

### 修改表的字段名
```
db.getCollection('category_zh').update({},{$rename:{"son_zh_name":"third_zh_name"}}, false, true);
或
db.category_zh.update({},{$rename:{"son_zh_name":"third_zh_name"}}, false, true);

db.collection.update(criteria,objNew,upsert,multi)
参数说明：
criteria：查询条件
objNew：update对象和一些更新操作符
upsert：如果不存在update的记录，是否插入objNew这个新的文档，true为插入，默认为false，不插入。
multi：默认是false，只更新找到的第一条记录。如果为true，把按条件查询出来的记录全部更新。
```

### mongodb 修改 collection 的字段名
```
db.category_zh.update({},{$rename:{"sub_zh_name":"second_zh_name","sub_zh_url":"second_zh_url","son_zh_name":"third_zh_name","son_zh_url":"third_zh_url","son_category_id":"third_category_id"}}, false, true);
db.category_en.update({},{$rename:{"sub_en_name":"second_en_name","sub_en_url":"second_en_url","son_en_name":"third_en_name","son_en_url":"third_en_url","son_category_id":"third_category_id"}}, false, true);
```

### mongodb 增加 data_version 和 create_time 字段
```
db.category_zh.update({},{$set:{"data_version":"20200103","create_time":"2020-01-03 18:30:30"}},{multi:true});
db.category_en.update({},{$set:{"data_version":"20200103","create_time":"2020-01-03 18:30:30"}},{multi:true});

db.category_zh.update({},{$set:{"second_category_id":""}},{multi:true});
db.category_en.update({},{$set:{"second_category_id":""}},{multi:true});

db.categorykwargs_zh.update({},{$set:{"data_version":"20200103","create_time":"2020-01-03 18:30:30"}},{multi:true});
db.categorykwargs_en.update({},{$set:{"data_version":"20200103","create_time":"2020-01-03 18:30:30"}},{multi:true});
```


### 根据条件删除字段
```
把 from这个数组有hengduan这个值，并且zhLatin是空的数据的zhLatin字段删除
db.getCollection('category_zh').update({"from":"hengduan","zhLatin":null},{$unset:{'zhLatin':''}}, false, true);
```



## python使用mongodb
```
pymongo

client = pymongo.MongoClient("127.0.0.1", 27017)
client = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = client["douban"]
mycol = mydb["NoDigikey"]

x = mycol.find_one()

for x in mycol.find():

for x in mycol.find({}, {"_id":0, "name":1, "alexa":1})

for x in mycol.find({}, {"alexa":0})

for x in mycol.find({ "name": { "$gt": "H" } })

for x in mycol.find({ "name": { "$regex": "^R" } })

for x in mycol.find().limit(3)
```


## MongoDB常用命令大全
```
show dbs                     show database names  
show collections             show collections in current database  
show users                   show users in current database  
show profile                 show most recent system.profile entries with time >= 1ms  
use <db name>                set curent database to <db name>  
db.help()                    help on DB methods  
db.foo.help()                help on collection methods  
db.foo.find()                list objects in collection foo  
db.foo.find( { a : 1 } )     list objects in foo where a == 1  
it                           result of the last line evaluated; use to further iterate  
system.indexes


do.help()
db.adminCommand(nameOrDocument) - switches to 'admin' db, and runs command [just calls db.runCommand(...)]
db.aggregate([pipeline], {options}) - performs a collectionless aggregation on this database; returns a cursor
db.auth(username, password)
db.cloneDatabase(fromhost) - deprecated
db.commandHelp(name) returns the help for the command
db.copyDatabase(fromdb, todb, fromhost) - deprecated
db.createCollection(name, {size: ..., capped: ..., max: ...})
db.createView(name, viewOn, [{$operator: {...}}, ...], {viewOptions})
db.createUser(userDocument)
db.currentOp() displays currently executing operations in the db
db.dropDatabase()
db.eval() - deprecated
db.fsyncLock() flush data to disk and lock server for backups
db.fsyncUnlock() unlocks server following a db.fsyncLock()
db.getCollection(cname) same as db['cname'] or db.cname
db.getCollectionInfos([filter]) - returns a list that contains the names and options of the db's collections
db.getCollectionNames()
db.getLastError() - just returns the err msg string
db.getLastErrorObj() - return full status object
db.getLogComponents()
db.getMongo() get the server connection object
db.getMongo().setSlaveOk() allow queries on a replication slave server
db.getName()
db.getPrevError()
db.getProfilingLevel() - deprecated
db.getProfilingStatus() - returns if profiling is on and slow threshold
db.getReplicationInfo()
db.getSiblingDB(name) get the db at the same server as this one
db.getWriteConcern() - returns the write concern used for any operations on this db, inherited from server object if set
db.hostInfo() get details about the server's host
db.isMaster() check replica primary status
db.killOp(opid) kills the current operation in the db
db.listCommands() lists all the db commands
db.loadServerScripts() loads all the scripts in db.system.js
db.logout()
db.printCollectionStats()
db.printReplicationInfo()
db.printShardingStatus()
db.printSlaveReplicationInfo()
db.dropUser(username)
db.repairDatabase()
db.resetError()
db.runCommand(cmdObj) run a database command.  if cmdObj is a string, turns it into {cmdObj: 1}
db.serverStatus()
db.setLogLevel(level,<component>)
db.setProfilingLevel(level,slowms) 0=off 1=slow 2=all
db.setWriteConcern(<write concern doc>) - sets the write concern for writes to the db
db.unsetWriteConcern(<write concern doc>) - unsets the write concern for writes to the db
db.setVerboseShell(flag) display extra information in shell output
db.shutdownServer()
db.stats()
db.version() current version of the server


db.user.help();  user为表名
db.foo.count()                统计表的行数  
db.foo.dataSize()        统计表数据的大小  
db.foo.distinct( key ) - eg. db.foo.distinct( 'x' )                按照给定的条件除重  
db.foo.drop() drop the collection 删除表  
db.foo.dropIndex(name)  删除指定索引  
db.foo.dropIndexes() 删除所有索引  
db.foo.ensureIndex(keypattern,options) - options should be an object with these possible fields: name, unique, dropDups  增加索引  
db.foo.find( [query] , [fields]) - first parameter is an optional query filter. second parameter is optional set of fields to return. 
通过条件查询： 
db.foo.find( { x : 77 } , { name : 1 , x : 1 } ) 

db.foo.find(...).count() 
db.foo.find(...).limit(n) 根据条件查找数据并返回指定记录数 
db.foo.find(...).skip(n) 
db.foo.find(...).sort(...) 查找排序 
db.foo.findOne([query]) 根据条件查询只查询一条数据 
db.foo.getDB() get DB object associated with collection  返回表所属的库 
db.foo.getIndexes() 显示表的所有索引 
db.foo.group( { key : ..., initial: ..., reduce : ...[, cond: ...] } ) 根据条件分组 
db.foo.mapReduce( mapFunction , reduceFunction , <optional params> ) 
db.foo.remove(query) 根据条件删除数据 
db.foo.renameCollection( newName ) renames the collection  重命名表  修改表名
db.foo.renameCollection("foo_001");
db.foo.save(obj) 保存数据 
db.foo.stats()  查看表的状态 
db.foo.storageSize() - includes free space allocated to this collection 查询分配到表空间大小 
db.foo.totalIndexSize() - size in bytes of all the indexes 查询所有索引的大小 
db.foo.totalSize() - storage allocated for all data and indexes 查询表的总大小 
db.foo.update(query, object[, upsert_bool]) 根据条件更新数据 
db.foo.validate() - SLOW 验证表的详细信息 
db.foo.getShardVersion() - only for use with sharding


mongodump --help
删除user表  
db.user.drop(); 



1. 超级用户相关： 
#增加或修改用户密码 
db.addUser('admin','pwd') 

#查看用户列表 
db.system.users.find() 

#用户认证 
db.auth('admin','pwd') 

#删除用户
db.removeUser('mongodb') 

#查看所有用户 
show users 

#查看所有数据库 
show dbs 

#查看所有的collection 
show collections 

#查看各collection的状态 
db.printCollectionStats() 

#查看主从复制状态 
db.printReplicationInfo() 

#修复数据库 
db.repairDatabase() 

#设置记录profiling，0=off 1=slow 2=all 
db.setProfilingLevel(1) 

#查看profiling 
show profile 

#拷贝数据库（复制数据库）
db.copyDatabase('mail_addr','mail_addr_tmp') 

拷贝表(复制表)
db.category（原表）.find().forEach(function(x){
  db.category_merge_20200203（新表）.insert(x)
});
db.category.find().forEach(function(x){
  db.category_merge_20200203.insert(x)
});

#删除collection 
db.mail_addr.drop() 

#删除当前的数据库 
db.dropDatabase() 


2. 客户端连接 
/usr/local/mongodb/bin/mongo user_addr -u user -p 'pwd' 


3. 增删改 
#存储嵌套的对象 
db.foo.save({'name':'ysz','address':{'city':'beijing','post':100096},'phone':[138,139]}) 

#存储数组对象 
db.user_addr.save({'Uid':'yushunzhi@sohu.com','Al':['NoDigikey-1@sohu.com','NoDigikey-2@sohu.com']}) 

#根据query条件修改，如果不存在则插入，允许修改多条记录 
db.foo.update({'yy':5},{'$set':{'xx':2}},upsert=true,multi=true) 

#删除yy=5的记录 
db.foo.remove({'yy':5}) 

#删除所有的记录
db.foo.remove() 


4. 索引 

增加索引：1(ascending),-1(descending) 
db.things.ensureIndex({firstname: 1, lastname: 1}, {unique: true}); 

#索引子对象 
db.user_addr.ensureIndex({'Al.Em': 1}) 

#查看索引信息 
db.deliver_status.getIndexes() 
db.deliver_status.getIndexKeys() 

#根据索引名删除索引
db.user_addr.dropIndex('Al.Em_1') 

5. 查询 

查找所有 
db.foo.find() 

#查找一条记录 
db.foo.findOne() 

#根据条件检索10条记录 
db.foo.find({'msg':'Hello 1'}).limit(10) 

#sort排序 
db.deliver_status.find({'From':'yushunzhi@sohu.com'}).sort({'Dt',-1}) 
db.deliver_status.find().sort({'Ct':-1}).limit(1) 

#count操作 
db.user_addr.count() 

#distinct操作 
db.foo.distinct('msg') 

#>操作 
db.foo.find({"timestamp": {"$gte" : 2}}) 

#子对象的查找 
db.foo.find({'address.city':'beijing'}) 

6. 管理 

查看collection数据的大小 
db.deliver_status.dataSize() 

#查看colleciont状态 
db.deliver_status.stats() 

#查询所有索引的大小 
db.deliver_status.totalIndexSize() 
```

### pymongo
```
import pymongo
con = pymongo.Connection('localhost', 27017)

mydb = con.mydb # new a database
mydb.add_user('NoDigikey', 'NoDigikey') # add a user
mydb.authenticate('NoDigikey', 'NoDigikey') # check auth

muser = mydb.user # new a table
 
muser.save({'id':1, 'name':'NoDigikey'}) # add a record

muser.insert({'id':2, 'name':'hello'}) # add a record
muser.find_one() # find a record

muser.find_one({'id':2}) # find a record by query
 
muser.create_index('id')

muser.find().sort('id', pymongo.ASCENDING) # DESCENDING
# muser.drop() delete table
muser.find({'id':1}).count() # get records number

muser.find({'id':1}).limit(3).skip(2) # start index is 2 limit 3 records

muser.remove({'id':1}) # delet records where id = 1
 
muser.update({'id':2}, {'$set':{'name':'haha'}}) # update one recor
```


```
下面再贴一些类似非python的api参考： 
mongo -path
db.AddUser(username,password) 添加用户
db.auth(usrename,password) 设置数据库连接验证
db.cloneDataBase(fromhost) 从目标服务器克隆一个数据库
db.commandHelp(name) returns the help for the command
db.copyDatabase(fromdb,todb,fromhost) 复制数据库fromdb—源数据库名称，todb—目标数据库名称，fromhost—源数据库服务器地址
db.createCollection(name,{size:3333,capped:333,max:88888}) 创建一个数据集，相当于一个表
db.currentOp() 取消当前库的当前操作
db.dropDataBase() 删除当前数据库
db.eval_r(func,args) run code server-side
db.getCollection(cname) 取得一个数据集合，同用法：db['cname'] or db.cname
db.getCollenctionNames() 取得所有数据集合的名称列表
db.getLastError() 返回最后一个错误的提示消息
db.getLastErrorObj() 返回最后一个错误的对象
db.getMongo() 取得当前服务器的连接对象get the server connection object
db.getMondo().setSlaveOk() allow this connection to read from then nonmaster membr of a replica pair
db.getName() 返回当操作数据库的名称
db.getPrevError() 返回上一个错误对象
db.getProfilingLevel() ?什么等级
db.getReplicationInfo() ?什么信息
db.getSisterDB(name) get the db at the same server as this onew
db.killOp() 停止（杀死）在当前库的当前操作
db.printCollectionStats() 返回当前库的数据集状态
db.printReplicationInfo()
db.printSlaveReplicationInfo()
db.printShardingStatus() 返回当前数据库是否为共享数据库
db.removeUser(username) 删除用户
db.repairDatabase() 修复当前数据库
db.resetError()
db.runCommand(cmdObj) run a database command. if cmdObj is a string, turns it into {cmdObj:1}
db.setProfilingLevel(level) 0=off,1=slow,2=all
db.shutdownServer() 关闭当前服务程序
db.version() 返回当前程序的版本信息
db.linlin.find({id:10}) 返回linlin数据集ID=10的数据集
db.linlin.find({id:10}).count() 返回linlin数据集ID=10的数据总数
db.linlin.find({id:10}).limit(2)返回linlin数据集ID=10的数据集从第二条开始的数据集
db.linlin.find({id:10}).skip(8) 返回linlin数据集ID=10的数据集从0到第八条的数据集
db.linlin.find({id:10}).limit(2).skip(8) 返回linlin数据集ID=1=的数据集从第二条到第八条的数据
db.linlin.find({id:10}).sort() 返回linlin数据集ID=10的排序数据集
db.linlin.findOne([query]) 返回符合条件的一条数据
db.linlin.getDB() 返回此数据集所属的数据库名称
db.linlin.getIndexes() 返回些数据集的索引信息
db.linlin.group({key:…,initial:…,reduce:…[,cond:...]})
db.linlin.mapReduce(mayFunction,reduceFunction,
)
db.linlin.remove(query) 在数据集中删除一条数据
db.linlin.renameCollection(newName) 重命名些数据集名称
db.linlin.save(obj) 往数据集中插入一条数据
db.linlin.stats() 返回此数据集的状态
db.linlin.storageSize() 返回此数据集的存储大小
db.linlin.totalIndexSize() 返回此数据集的索引文件大小
db.linlin.totalSize() 返回些数据集的总大小
db.linlin.update(query,object[,upsert_bool])在此数据集中更新一条数据
db.linlin.validate() 验证此数据集
db.linlin.getShardVersion() 返回数据集共享版本号
db.linlin.find({‘name’:'foobar’}) select * from linlin where name=’foobar’
db.linlin.find() select * from linlin
db.linlin.find({‘ID’:10}).count() select count(*) from linlin where ID=10
db.linlin.find().skip(10).limit(20) 从查询结果的第十条开始读20条数据 select * from linlin limit 10,20 ———-mysql
db.linlin.find({‘ID’:{$in:[25,35,45]}}) select * from linlin where ID in (25,35,45)
db.linlin.find().sort({‘ID’:-1}) select * from linlin order by ID desc
db.linlin.distinct(‘name’,{‘ID’:{$lt:20}}) select distinct(name) from linlin where ID<20
db.linlin.group({key:{'name':true},cond:{'name':'foo'},reduce:function(obj,prev){prev.msum+=obj.marks;},initial:{msum:0}})
select name,sum(marks) from linlin group by name
db.linlin.find('this.ID<20′,{name:1}) select name from linlin where ID<20
db.linlin.insert({'name':'foobar’,'age':25}) insert into linlin ('name','age’)values('foobar',25)
db.linlin.insert({'name':'foobar’,'age':25,’email’:'cclove2@163.com’})
db.linlin.remove({}) delete * from linlin
db.linlin.remove({'age':20}) delete linlin where age=20
db.linlin.remove({'age':{$lt:20}}) delete linlin where age<20
db.linlin.remove({'age':{$lte:20}}) delete linlin where age<=20
db.linlin.remove({'age':{$gt:20}}) delete linlin where age>20
db.linlin.remove({‘age’:{$gte:20}}) delete linlin where age>=20
db.linlin.remove({‘age’:{$ne:20}}) delete linlin where age!=20
db.linlin.update({‘name’:'foobar’},{‘$set’:{‘age’:36}}) update linlin set age=36 where name=’foobar’
db.linlin.update({‘name’:'foobar’},{‘$inc’:{‘age’:3}}) update linlin set age=age+3 where name=’foobar’
```

```
eg:
db.deliveries.aggregate([
  { $project : { city_state : { $split: ["$city", ", "] }, qty : 1 } },
  { $unwind : "$city_state" },
  { $match : { city_state : /[A-Z]{2}/ } },
  { $group : { _id: { "state" : "$city_state" }, total_qty : { "$sum" : "$qty" } } },
  { $sort : { total_qty : -1 } }
]);


{ "_id" : 1, "city" : "Berkeley, CA", "qty" : 648 }
{ "_id" : 2, "city" : "Bend, OR", "qty" : 491 }
{ "_id" : 3, "city" : "Kensington, CA", "qty" : 233 }
{ "_id" : 4, "city" : "Eugene, OR", "qty" : 842 }
{ "_id" : 5, "city" : "Reno, NV", "qty" : 655 }
{ "_id" : 6, "city" : "Portland, OR", "qty" : 408 }
{ "_id" : 7, "city" : "Sacramento, CA", "qty" : 574 }

db.digikey_param_zh.aggregate([
  { $project : { city_state : { $split: ["$city", ", "] }, qty : 1 } },
  { $unwind : "$city_state" },
  { $match : { city_state : /[A-Z]{2}/ } },
  { $group : { _id: { "state" : "$city_state" }, total_qty : { "$sum" : "$qty" } } },
  { $sort : { total_qty : -1 } }
]);


{ "_id" : { "state" : "OR" }, "total_qty" : 1741 }
{ "_id" : { "state" : "CA" }, "total_qty" : 1455 }
{ "_id" : { "state" : "NV" }, "total_qty" : 655 }
```


### mongodb性能监控
```
mongostat --host 192.168.1.169:27017
mongostat --host 192.168.1.169 --port 27017

Usage:
  mongostat <options> <polling interval in seconds>

Monitor basic MongoDB server statistics.

See http://docs.mongodb.org/manual/reference/program/mongostat/ for more information.

general options:
      --help                                      print usage
      --version                                   print the tool version and exit

verbosity options:
  -v, --verbose=<level>                           more detailed log output (include multiple times for more verbosity, e.g.
                                                  -vvvvv, or specify a numeric value, e.g. --verbose=N)
      --quiet                                     hide all log output

connection options:
  -h, --host=<hostname>                           mongodb host(s) to connect to (use commas to delimit hosts)
      --port=<port>                               server port (can also use --host hostname:port)

authentication options:
  -u, --username=<username>                       username for authentication
  -p, --password=<password>                       password for authentication
      --authenticationDatabase=<database-name>    database that holds the user's credentials
      --authenticationMechanism=<mechanism>       authentication mechanism to use

uri options:
      --uri=mongodb-uri                           mongodb uri connection string

stat options:
  -o=<field>[,<field>]*                           fields to show. For custom fields, use dot-syntax to index into
                                                  serverStatus output, and optional methods .diff() and .rate() e.g.
                                                  metrics.record.moves.diff()
  -O=<field>[,<field>]*                           like -o, but preloaded with default fields. Specified fields inserted after
                                                  default output
      --humanReadable=                            print sizes and time in human readable format (e.g. 1K 234M 2G). To use the
                                                  more precise machine readable format, use --humanReadable=false (default:
                                                  true)
      --noheaders                                 don't output column names
  -n, --rowcount=<count>                          number of stats lines to print (0 for indefinite)
      --discover                                  discover nodes and display stats for all
      --http                                      use HTTP instead of raw db connection
      --all                                       all optional fields
      --json                                      output as JSON rather than a formatted table
      --useDeprecatedJsonKeys                     use old key names; only valid with the json output option.
  -i, --interactive                               display stats in a non-scrolling interface

可以实时监控
·inserts/s 每秒插入次数,如果是slave，则数值前有*,则表示复制集操作
·query/s 每秒查询次数
·update/s 每秒更新次数
·delete/s 每秒删除次数
·getmore/s 每秒执行getmore次数,每秒查询cursor(游标)时的getmore操作数
·command/s 每秒的命令数，比以上插入、查找、更新、删除的综合还多，还统计了别的命令(每秒执行的命令数，在主从系统中会显示两个值(例如 3|0),分表代表 本地|复制 命令)
dirty: 仅仅针对WiredTiger引擎，官网解释是脏数据字节的缓存百分比
used:仅仅针对WiredTiger引擎，官网解释是正在使用中的缓存百分比
·flushs/s 每秒执行fsync将数据写入硬盘的次数。
(For WiredTiger引擎：指checkpoint的触发次数在一个轮询间隔期间 For MMAPv1 引擎：每秒执行fsync将数据写入硬盘的次数)
一般都是0，间断性会是1， 通过计算两个1之间的间隔时间，可以大致了解多长时间flush一次。flush开销是很大的，如果频繁的flush，可能就要找找原因了

·mapped/s 所有的被mmap的数据量，单位是MB，
·vsize 虚拟内存使用量，单位MB(最后一次调用的总数据)
·res 物理内存使用量，单位MB(最后一次调用的总数据)
这个和你用top看到的一样, vsize一般不会有大的变动， res会慢慢的上升，如果res经常突然下降，去查查是否有别的程序狂吃内存。

·faults/s 每秒访问失败数（只有Linux有），数据被交换出物理内存，放到swap。不要超过100，否则就是机器内存太小，造成频繁swap写入。此时要升级内存或者扩展
·locked % 被锁的时间百分比，尽量控制在50%以下吧
·idx miss % 索引不命中所占百分比。如果太高的话就要考虑索引是不是少了


·time 时间戳
·q t|r|w Mongodb接收到太多的命令而数据库被锁住无法执行完成，它会将命令加入队列。这一栏显示了总共、读、写3个队列的长度，都为0的话表示mongo毫无压力。高并发时，一般队列值会升高。
qr: 客户端等待从MongoDB实例读数据的队列长度
qw：客户端等待从MongoDB实例写入数据的队列长度
qrw: 客户端等待从MongoDB实例读数据和写数据的队列长度

ar: 执行读操作的活跃客户端数量
aw: 执行写操作的活客户端数量
arw: 执行读操作和写操作的活跃客户端数量
如果这两个数值很大，那么就是DB被堵住了，DB的处理速度不及请求速度。看看是否有开销很大的慢查询。如果查询一切正常，确实是负载很大，就需要加机器了

netIn:MongoDB实例的网络进流量
netOut：MongoDB实例的网络出流量
此两项字段表名网络带宽压力，一般情况下，不会成为瓶颈

·conn 当前连接数
conn: 打开连接的总数，是qr,qw,ar,aw的总和
MongoDB为每一个连接创建一个线程，线程的创建与释放也会有开销，所以尽量要适当配置连接数的启动参数，maxIncomingConnections，阿里工程师建议在5000以下，基本满足多数场景

这些状态我们基本上可以不看conn，一般都不会变，因为是连接池过来的连接数都是固定的。基本上看看qr|qw ，ar|aw如果一直0说明很健康，如果几十的话那就说明mongo处理起来很慢了，有可能有慢查询，锁表排队等现象。


查看mongodb最大连接数
db.serverStatus().connections

```

### mongotop
```
mongotop --host 192.168.1.169:27017
mongotop --host 192.168.1.169 --port 27017

Usage:
  mongotop <options> <polling interval in seconds>

Monitor basic usage statistics for each collection.

See http://docs.mongodb.org/manual/reference/program/mongotop/ for more information.

general options:
      --help                                      print usage
      --version                                   print the tool version and exit

verbosity options:
  -v, --verbose=<level>                           more detailed log output (include multiple times for more verbosity, e.g.
                                                  -vvvvv, or specify a numeric value, e.g. --verbose=N)
      --quiet                                     hide all log output

connection options:
  -h, --host=<hostname>                           mongodb host(s) to connect to (use commas to delimit hosts)
      --port=<port>                               server port (can also use --host hostname:port)

authentication options:
  -u, --username=<username>                       username for authentication
  -p, --password=<password>                       password for authentication
      --authenticationDatabase=<database-name>    database that holds the user's credentials
      --authenticationMechanism=<mechanism>       authentication mechanism to use

uri options:
      --uri=mongodb-uri                           mongodb uri connection string

output options:
      --locks                                     report on use of per-database locks
  -n, --rowcount=<count>                          number of stats lines to print (0 for indefinite)
      --json                                      format output as JSON


ns：包含数据库命名空间，后者结合了数据库名称和集合。
db：包含数据库的名称。名为 . 的数据库针对全局锁定，而非特定数据库。
total：mongod在这个命令空间上花费的总时间。
read：在这个命令空间上mongod执行读操作花费的时间。
write：在这个命名空间上mongod进行写操作花费的时间。
时间: 当前状态的db时间

```

