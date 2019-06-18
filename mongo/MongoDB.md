����Աģʽ����cmd
C:\Windows\system32>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install -serviceName "MongoDB"
2019-04-24T13:06:38.318+0800 I CONTROL  [main] Automatically disabling TLS 1.0,
to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'

D:\MongoDB\bin>mongod --dbpath "D:\MongoDB\db" --logpath "D:\MongoDB\log\MongoDB.log" --install --serviceName "MongoDB"
���ʱ����������Ѿ���װ����

���������еĲ���˵��

���� ��������������������������
--bind_ip���� �������������󶨷���IP������127.0.0.1����ֻ�ܱ������ʣ���ָ��Ĭ�ϱ�������IP
--logpath	������������������MongoDB��־�ļ���ע����ָ���ļ�����Ŀ¼
--logappend	���� �������� ʹ��׷�ӵķ�ʽд��־
--dbpath	���������������� ָ�����ݿ�·��
--port	���������� �������� ָ������˿ںţ�Ĭ�϶˿�27017
--serviceName    ��������  ָ����������
--serviceDisplayName	����ָ���������ƣ��ж��mongodb����ʱִ�С�
--install	����������������   ָ����Ϊһ��Windows����װ��

�鿴�������ݿ��б�
show dbs

�л��������û�
use Admn

ʹ�����ݿ⡢�������ݿ�
use douban

�������ݿ�
db.douban

�����û�
db.addUser("flack", "123456")
db.createUser(
        {
	user: "flack",
	pwd: "123456",
	roles: [{role: "userAdmin", db: "test"}]
        }
)

�����û�Ϊ�������ӵ��û�
db.auth("flack", "123456")

������
db.createCollection("userinfo")
�鿴���Ƿ񴴽��ɹ�
show collections

�������
db.userinfo.save({age: 1})

��ѯ���м�¼
db.userinfo.find()


��ʾ��ǰ�����ݼ���
show collections

ɾ�����ݿ�
db.dropDatabase()

ɾ�����ϣ�ɾ��ָ���ļ��� ɾ����
db.userinfo.drop()


����һ������
�������ݣ��������ݵĲ��룬���ݿⴴ���ɹ��ˣ�����Ҳ�����ɹ��ˡ�
db.userinfo.insert({"name":"xiaoming"})
db.userinfo.insert(
{
	"_id": ObjectId("57172b0f657f8bbb34d70144"),
	"name": "����"
}
)

��������
��ѯ���м�¼
db.userinfo.find()
�൱�ڣ�select* from userInfo; 

��ѯȥ����ĵ�ǰ�ۼ������е�ĳ�е��ظ�����
db.userinfo.distinct("name")
����˵� name �е���ͬ���� �൱�ڣ�select distict name from userinfo;

��ѯ age = 22 �ļ�¼
db.userinfo.find({"age": 22})
�൱�ڣ� select * from userInfo where age = 22; 

��ѯ age > 22 �ļ�¼
db.userinfo.find({age:{$gt: 22}})
�൱�ڣ�select * from userInfo where age >22;

��ѯ age < 22 �ļ�¼
db.userinfo.find({age: {$lt: 22}})
�൱�ڣ�select * from userInfo where age <22; 

��ѯ age >= 25 �ļ�¼
db.userinfo.find({age: {$gte: 25}})
�൱�ڣ�select * from userInfo where age >= 25; 

��ѯ age <= 25 �ļ�¼
db.userinfo.find({age: {$lte: 25}})
�൱�ڣ�select * from userInfo where age <= 25; 

��ѯ age >= 23 ���� age <= 26
db.userinfo.find({age: {$gte: 23, $lte: 26}})
�൱�ڣ�select * from userInfo where age >= 23 and age <= 26; 

��ѯ name �а��� mongo ������
ģ����ѯ��������
db.userinfo.find({name: /mongo/})
//�൱��%% select * from userInfo where name like '%mongo%'; 

��ѯ name ���� mongo ��ͷ��
db.userinfo.find({name: /^mongo/})
�൱�ڣ�select * from userInfo where name like 'mongo%'; 

��ѯָ���� name��age ����
db.userinfo.find({}, {name: 1, age: 1})
����
db.userinfo.find({}, {name: true, age: true})
��Ȼ name Ҳ������ true �� false,���� ture ������º� name:1 Ч��һ��������� false �� ���ų� name����ʾ name ���������Ϣ

��ѯָ���� name��age ����, age > 25
db.userinfo.find({age:{$gt: 25}}, {name:1, age: 1})
�൱�ڣ�select name, age from userInfo where age >25; 

������������ 1 ���� -1 ����
����db.userinfo.find().sort({age: 1})
����db.userinfo.find().sort({age: -1})


��ѯ name = zhangsan, age = 22 ������
db.userinfo.find({name: "zhangsan", age: 22})
�൱�ڣ�select * from userInfo where name = 'zhangsan' and age = '22'; 


��ѯǰ 5 ������
db.userinfo.find().limit(5)
�൱�ڣ�select top 5 * from userInfo; 


��ѯ 10 ���Ժ������
db.userinfo.find().skip(10)
�൱�ڣ�select * from userInfo where id not in (  
selecttop 10 * from userInfo  
); 

��ѯ�� 5-10 ֮�������
db.userinfo.find().limit(10).skip(5)
�����ڷ�ҳ��limit �� pageSize��skip �ǵڼ�ҳ*pageSize 

or �� ��ѯ
db.userinfo.find({$or: [{age: 22}, {age: 25}]})
�൱�ڣ�select * from userInfo where age = 22 or age = 25; 

findOne ��ѯ��һ������
db.userinfo.findOne()
�൱�ڣ�select top 1 * from userInfo;  
db.userInfo.find().limit(1);  

��ѯĳ��������ļ�¼���� ͳ������
db.userinfo.find({age: {$gte: 20}}).count()
�൱�ڣ�select count(*) from userInfo where age >= 20;  
���Ҫ��������֮��ļ�¼������Ҫʹ�� count(true)���� count(�� 0)  db.users.find().skip(10).limit(5).count(true);   


�޸�����
update() �������ڸ����Ѵ��ڵ��ĵ�
update() �������ڸ����Ѵ��ڵ��ĵ����﷨��ʽ���£�
update.collection.update(
<query>,
<update>,
{
	upsert:<boolean>,
	multi:<boolean>,
	writeConcern:<document>
}
)
query : update�Ĳ�ѯ����������sql update��ѯ��where����ġ�
update : update�Ķ����һЩ���µĲ���������,inc�����ȣ�Ҳ�������Ϊsql update��ѯ��set�����
upsert : ��ѡ�������������˼�ǣ����������update�ļ�¼���Ƿ����objNew,trueΪ���룬Ĭ����false�������롣
multi : ��ѡ��mongodb Ĭ����false,ֻ�����ҵ��ĵ�һ����¼������������Ϊtrue,�ͰѰ����������������¼ȫ�����¡�
writeConcern :��ѡ���׳��쳣�ļ���

�޸����滹�в�ѯ��������Ҫ�޸�˭��Ҫ���� mongo�� �������ֽ���С���ģ����������Ϊ 16 �꣺
db.userinfo.update({"name":"xiaoming"}, {$set: {"age": 16}})

������ѧ�ɼ��� 70�����������Ϊ 33 �꣺
db.userinfo.update({"score.shuxue": 70}, {$set: {"age": 33}})


��������ƥ����Ŀ�� 
�������ֻ���޸ĵ�һ�����ֵ��ĵ��������Ҫ�޸Ķ�����ͬ���ĵ�������Ҫ���� multi ����Ϊ true�� 
multi : ��ѡ��mongodb Ĭ����false,ֻ�����ҵ��ĵ�һ����¼������������Ϊtrue,�ͰѰ����������������¼ȫ�����¡�
db.userinfo.update({"sex": "��"}, {$set: {"age": 33}}, {multi: true})


�����滻��������$set �ؼ����ˣ� ע��
db.userinfo.update({"name": "xiaoming"}, {"name": "daming", "age": 16})

db.userinfo.update({"name": "Lisi"}, {$inc: {age: 50}}, false, true)
�൱�ڣ�update users set age = age + 50 where name = 'Lisi'; 

db.userinfo.update({"name": "Lisi"}, {$inc: {age: 50}, $set: {name: "hihi"}}, false, true)
�൱�ڣ�update userinfo set age = age + 50,name = "hihi"
where name = "Lisi"

ֻ���µ�һ����¼��
db.userinfo.update({"count": {$gt: 1}}, {$set: {"test2": "OK"}})

ȫ�����£�
db.userinfo.update({"count": {$gt: 3}}, {$set: {"test2": "OK"}}, false, true)

ֻ��ӵ�һ����
db.userinfo.update({"count": {$gt: 4}}, {$set: {"test5": "OK"}}, true, false)

ȫ����ӽ�ȥ:
db.userinfo.update({"count": {$gt: 5}}, {$set: {"test5": "OK"}}, true, true)

ȫ�����£�
db.userinfo.update({"count": {$gt: 15}}, {$inc: {"count": 1}}, false, true)

ֻ���µ�һ����¼��
db.userinfo.update({"count": {$gt: 10}}, {$inc: {"count": 1}}, false, false)

��3.2�汾��ʼ��MongoDB�ṩ���¸��¼����ĵ��ķ�����
db.collection.updateOne() ��ָ�����ϸ��µ����ĵ�
db.collection.updateMany() ��ָ�����ϸ��¶���ĵ�

���µ����ĵ�
db.userinfo.updateOne({"name": "abc"}, {$set: {"age": "28"}})

���¶���ĵ�
db.userinfo.updateMany({"age": {$gt: "10"}}, {$set: {"status": "xyz"}})


ɾ������
3.2�汾֮ǰ
db.collection.remove() //

3.2�汾֮��
db.collection.deleteMany() //ɾ��ƥ�������Ķ�����¼
db.collection.deleteOne() //ɾ��ƥ�������ĵ�����¼
��������Ĳ����ǲ�ѯ������
{
  <field1>: <value1>,
  <field2>: { <operator>: <value> },
  ...
}

remove() �����Ļ����﷨��ʽ������ʾ��
db.collection.remove(
   <query>,
   <justOne>
)
������ MongoDB �� 2.6 �汾�Ժ�ģ��﷨��ʽ���£�
db.collection.remove(
   <query>,
   {
     justOne: <boolean>,
     writeConcern: <document>
   }
)
����˵����

query :����ѡ��ɾ�����ĵ���������
justOne : ����ѡ�������Ϊ true �� 1����ֻɾ��һ���ĵ���
writeConcern :����ѡ���׳��쳣�ļ���

db.userinfo.remove({"name": "manhattan"})

db.userinfo.remove({"age": 123})

db.userinfo.remove({"name": "newyork"}, {justOne: true})


ɾ��test���ݿ������м�¼
db.test.deleteMany({})
{}��ʾû��Լ��������

ɾ��test���ݿ���_idΪ5abb3b5bce69c048be080199�ļ�¼��
db.test.deleteMany({_id: ObjectId("5abb3b5bce69c048be080199")})




����mongodb���ݿ�
mongodump -h IP --port �˿� -u �û��� -p ���� -d ���ݿ� -o �ļ��洢·��
���û���û�������ȥ�� -u��-p
����������������ݿ⣬����ȥ�� -h
�����Ĭ�϶˿ڣ�����ȥ�� --port
����뵼���������ݿ⣬����ȥ�� -d
eg:
mongodump -h IP --port 27017 -u flack -p 123456 -d test -o D:/MongoDB/Backups/  ���ز��ü�:-h IP

����ָ�����ݿ�
mongodump -h IP -d test -o D:/MongoDB/Backups/ 

����MongoDB���ݿ�
mongorestore -h IP --port �˿� -u �û��� -p ���� -d ���ݿ� --drop �ļ�����·��
eg:
mongorestore -h IP --port 27017 -u flack -p 123456 -d test --drop D:/MongoDB/Backups/2019-04-27/test  ���ز��ü� -h IP




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