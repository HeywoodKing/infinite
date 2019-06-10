--create database Store
--drop database Store
--create table store_information
--drop table Store_Information
use Store
create table Store_Information
(
store_id int primary key not null,
store_name nvarchar(100),
store_sales numeric(18,2),
store_date  datetime,
)

/*insert into Store_Information (store_id,store_name,store_sales,store_date,nickname,email) 
  values(6,'White Chen','2000',1988-8-8,'云中飞','123456@126.com')*/

--delete store_information 
--where store_id = 5
select * from Store_Information

--若要选出所有的店名 (store_Name)：
select store_name as 商店名 from Store_Information

--选择部分列并指定它们的显示次序查询结果集合中数据的排列顺序与选择列表中所指定的列名排列顺序相同
--asc 升序，desc 降序
select store_name,store_sales from Store_Information
where store_sales > 100 
order by store_sales desc

alter table store_information add nickname varchar(50)
alter table store_information add email varchar(50)

--显示的时候看到的"昵称"和"电子邮件"是中文的
select 昵称=nickname,电子邮件=email from Store_Information  

--返回前两行PERCENT 
select top 2 * from Store_Information
--返回前 总行数的50%(PERCENT) 
select top 50 PERCENT * from Store_Information
--每条数据只显示一条,重复的也显示一条
select distinct store_name,nickname from Store_Information

/*
例：返回96年1月的定单 
SELECT orderID, CustomerID, orderDate 
FROM orders 
WHERE orderDate 〉#1/1/96# AND orderDate〈#1/30/96# 
*/

--找出营业额大于1000
select store_name,store_sales from Store_Information
where store_sales > 1000

--{}+ 代表{}之内的情况会发生一或多次

--举例来说，我们若要在 Store_Information 表格中选出所有 Sales 高于 $1,000 或是 Sales 在 $500 及 $275 之间的资料的话
select store_name,store_sales from Store_Information
where store_sales > 1000
or (store_sales > 275 and store_sales < 500)
--举例来说，若我们要在 Store_Information 表格中找出所有含盖 Los Angeles 或 San Diego 的资料
select * from Store_Information
where store_name in ('Los Angeles','San Diego')
--更新
update Store_Information set store_name = 'Log Angeles'
where store_id = 3
update Store_Information set store_date = '1999-1-7'
where store_id = 3
--更新时间
update Store_Information set store_date = '1999-06-13'
where store_id = 3 
--举例来说，若我们要由 Store_Information 表格中找出所有介于 1905-6-15及 1999-6-13 中的资料
select * from Store_Information
where store_date between '1905-6-15' and '1999-6-13'
--在运用 IN 的时候，我们完全地知道我们需要的条件；在运用 BETWEEN 的时候，我们则是列出一个范围
select * from Store_Information
where store_name like '%e%' 

/*
LIKE运算符里使用的通配符 
通配符含义 
1)？ 任何一个单一的字符 
2)* 任意长度的字符 
3)# 0~9之间的单一数字 
4)[字符列表] 在字符列表里的任一值 
5)[！字符列表] 不在字符列表里的任一值 
6)_ 指定字符范围，两边的值分别为其上下限 
	{模式} 经常包括野卡 (wildcard). 以下是几个例子： 
	'A_Z': 所有以 'A' 起头，另一个任何值的字原，且以 'Z' 为结尾的字符串。 'ABZ' 和 'A2Z' 都符合这一个模式，
	而 'AKKZ' 并不符合 (因为在 A 和 Z 之间有两个字原，而不是一个字原)。 
	'ABC%': 所有以 'ABC' 起头的字符串。举例来说，'ABCD' 和 'ABCABC' 都符合这个模式。 
	'%XYZ': 所有以 'XYZ' 结尾的字符串。举例来说，'WXYZ' 和 'ZZXYZ' 都符合这个模式。 
	'%AN%': 所有含有 'AN'这个模式的字符串
*/
--排序 asc 升序(由小到大)，desc 降序(由大到小)
select store_name,store_sales,store_date from Store_Information
order by 2 desc
/*AVG (平均) 
COUNT (计数) 
MAX (最大值) 
MIN (最小值) 
SUM (总合) 
VAR (方差) 
STDEV (标准误差) 
FIRST (第一个值) 
LAST (最后一个值) 
*/
--查找到营业额最大的商店的名,id,日期
select store_id,store_name,store_date from Store_Information
where store_sales like
(
select MAX(Store_sales) from Store_Information
)
--查找到日期最小的商店的名,营业额
select Store_name,store_sales,store_date from Store_Information
where store_date = 
(
select MIN(store_date) from Store_Information
)
--求营业额的平均值
select avg(store_sales) from Store_Information
--求出营业总额
select SUM(Store_sales) from Store_Information
--计算总共有多少条记录
select COUNT(*) from Store_Information
--计算营业额的方差
select var(store_sales) from Store_Information
--计算营业额的标准差
select STDEV(Store_sales) from Store_Information
select store_name,store_date from Store_Information
group by store_name,store_date
--计算店名不是空的总共有多少条记录
select COUNT(Store_name) from Store_Information
where store_name is not null
--举例来说，如果我们要找出我们的表格中有多少个不同的 store_name
select COUNT(distinct Store_name) from Store_Information
--分组求和用group by
select store_name,SUM(Store_sales) from Store_Information
group by store_name
--找出营业额大于700的
select Store_name,SUM(Store_sales) from Store_Information
group by store_name
having SUM(store_sales) > 700
--运用别名,有聚合函数时,要用group by 分组
select a1.store_name 商店名,sum(a1.store_sales) 营业额 from Store_Information a1
group by a1.store_name

create table Geography
(
G_id int primary key not null,
store_name nvarchar(100),
region_name varchar(50),
memo nvarchar(1000),
)
--插入数据
/*insert into Geography values(1,'Boston','East','')
insert into Geography values(2,'New York','East','') 
insert into Geography values(3,'Los Angeles','East','') 
insert into Geography values(4,'San Diego','West','') 
insert into Geography values(5,'BeiJing','East','') 
*/
select * from Geography
--两个表的连接，找到两个表格的共同点
select a.region_name 区域,SUM(b.store_sales) 营业额 from Geography a,Store_Information b
where a.store_name = b.store_name
group by a.region_name
--两个表的store_name名称对比
select a.store_name a表中的店名,b.store_name b表中的店名 from Geography a,Store_Information b
where a.G_id = b.store_id
--两个表的内连接：是指两个表格中有相同的数据才会被选出
--外连接
--左连接
select a.store_name,SUM(b.store_sales) from Geography a,Store_Information b
where a.store_name *= b.store_name
group by a.store_name

/*
此查询使用的不是 ANSI 外部联接运算符("*=" 或 "=*")。若要不进行修改即运行此查询，
请使用 ALTER DATABASE 的 SET COMPATIBILITY_LEVEL 选项将当前数据库的兼容级别设置为 80。
极力建议使用 ANSI 外部联接运算符(LEFT OUTER JOIN、RIGHT OUTER JOIN)重写此查询。
在将来的 SQL Server 版本中，即使在向后兼容模式下，也不支持非 ANSI 联接运算符。
*/
--设置当前数据库的兼容级别为80，级别分别为80,90,100
ALTER DATABASE store SET COMPATIBILITY_LEVEL = 80
/*MySQL/Oracle的字符串连接语法，Oracle的CONCAT()只允许两个参数；
换言之，一次只能将两个字符串串连起来。不过，在Oracle中，我们可以用'||'来一次串连多个字符串

select concat(Store_name,region_name) from Store_Information
where store_name = 'Boston'

Oracle: 
SELECT region_name || ' ' || store_name FROM Geography 
WHERE store_name = 'Boston'; 

*/
--SQL 的两个或者多个字符串连接用"+"
select Store_name + ' ' + nickname as 标题字符串连接 from Store_Information
where store_name = 'White Chen'
select * from Store_Information
SELECT region_name + ' ' + store_name + ' ' + memo FROM Geography 
WHERE store_name = 'Boston';
--SQL 中的 substring 函数是用来抓出一个栏位资料中的其中一部分,
/*MySQL: SUBSTR(), SUBSTRING() 
Oracle: SUBSTR() 
SQL Server: SUBSTRING()*/
--截取字符串的一部分substring(str,2,5),从str中的第二个位置开始，截取5个字符
select SUBSTRING(Store_name,2,5) from Store_Information
where store_name = 'Los Angeles'

create table Internet_Sales
(
store_date datetime,
sales numeric(18,2),
memo varchar(500),
)
/*
insert into Internet_Sales values('1999-1-7','250','')
insert into Internet_Sales values('1999-1-10','535','')
insert into Internet_Sales values('1999-1-11','320','')
insert into Internet_Sales values('1999-1-12','750','')
insert into Internet_Sales values('1999-1-13','1000','')*/
--查询
select * from Internet_Sales
--使用 UNION、INTERSECT 或 EXCEPT 运算符合并的所有查询必须在其目标列表中有相同数目的表达式。
--我们要找出来所有有营业额 (sales) 的日子,union目的是要将两个 SQL 语句的结果合并在一起
select Store_date from Store_Information
union
select Store_date from Internet_Sales
--笛卡尔积连接
select (a.store_date) a_date,(b.store_date) b_date from Store_Information a,Internet_Sales b
--找出来所有有营业额 (sales) 的日子,不管数据有没有重复,
--union all目的也是要将两个 SQL 语句的结果合并在一起
select Store_date from Store_Information
union
select Store_date from Internet_Sales
/*
 INTERSECT和 UNION 指令类似， INTERSECT 也是对两个 SQL 语句所产生的结果做处理的。不同的地方是，
 UNION 基本上是一个 OR (如果这个值存在于第一句或是第二句，它就会被选出)，
 而 INTERSECT 则比较像 AND (这个值要存在于第一句和第二句才会被选出)。intersect 是指两个表中都有时才选出 
 UNION 是联集，而 INTERSECT 是交集
*/
--我们要找出哪几天有店面交易和网络交易
--使用 UNION、INTERSECT 或 EXCEPT 运算符合并的所有查询必须在其目标列表中有相同数目的表达式。
select Store_date from Store_Information
intersect
select Store_date from Internet_Sales
/*
MINUS 指令是运用在两个 SQL 语句上。它先找出第一个 SQL 语句所产生的结果，
然后看这些结果有没有在第二个 SQL 语句的结果中。如果有的话，那这一笔资料就被去除，而不会在最后的结果中出现。
如果第二个 SQL 语句所产生的结果并没有存在于第一个 SQL 语句所产生的结果内，那这笔资料就被抛弃。 
*/
--我们要知道有哪几天是有店面营业额而没有网络营业额的
select store_date from Store_Information
MINUS
select Store_date from Internet_Sales
--minus的作用简单来说是去同留异

--select * from Store_Information where rownum < 10
--MINUS 
--select * from Internet_Sales where rownum < 5
--我们要运用 subquery 来找出所有在西部的店的营业额,简单子查询
select SUM(Store_sales) from Store_Information
where store_name in
(
select store_name from Geography
where region_name = 'west'
)
--查询两表中共同有的商店的总共的营业额,相关子查询
select SUM(a1.store_sales) from Store_Information a1
where a1 .store_name in
(
select a2.store_name from Geography a2
where a2.store_name = a1.store_name
)
--EXISTS 是用来测试内查询有没有产生任何结果。如果有的话，系统就会执行外查询中的 SQL。若是没有的话，
--那整个 SQL 语句就不会产生任何结果
select SUM(Store_sales) from Store_Information
where exists
(select * from Geography
where region_name = 'west'
)
--CASE 是 SQL 用来做为 IF-THEN-ELSE 之类逻辑的关键字
/*
SELECT CASE ("列名")
  WHEN "条件1" THEN "结果1"
  WHEN "条件2" THEN "结果2"
  ...
  [ELSE "结果N"]
  END
FROM "表名"
*/
--若我们要将 'Los Angeles' 的 Sales 数值乘以2，以及将 'San Diego' 的 Sales 数值乘以1.5
--这里要用到case
select Store_name ,case Store_name
	when 'Los Angeles' then Store_sales * 2
	when 'San Diego' then Store_sales *1.5
	else store_sales
	end "new sales",store_date
from Store_Information

--简单Case函数
select customerNO,userName,
case sex
	when '1' then '男'
	when '0' then '女'
else '其他' 
end "sex",fullname,parentID,adddate,nickname,birthday,createman,createtime
from customer
--select * from customer

--Case搜索函数
select customerNo,userName,
case when sex = '1' then '男'
	 when sex = '2' then '女'
else '其他' end "sex",fullname,parentID,adddate,nickname,birthday,createman,createtime
from customer

create table Nation
(
id int,
N_code bigint,
N_country varchar(100) primary key not null,
N_population int,
memo nvarchar(1000)
)
--insert into Nation values(1,86,'中国',600,'')
--insert into Nation values(2,80,'美国',100,'')
--insert into Nation values(3,89,'加拿大',100,'')
--insert into Nation values(4,16,'英国',200,'')
--insert into Nation values(5,102,'法国',300,'')
--insert into Nation values(6,95,'日本',250,'')
--insert into Nation values(7,82,'德国',200,'')
--insert into Nation values(8,61,'墨西哥',50,'')
--insert into Nation values(9,32,'印度',250,'')
select * from Nation
--计算出某一地区（洲）的人口数
select SUM(N_population) 人口,
		   case N_country
				when '中国' then '亚洲'
				when '印度' then '亚洲'
				when '日本' then '亚洲'
				when '美国' then '北美洲'
				when '加拿大' then '北美洲'
				when '墨西哥' then '北美洲'
				when '英国' then '欧洲'
				when '法国' then '欧洲'
				when '德国' then '欧洲'						
else '其他' end "洲"
from Nation
group by case N_country
				when '中国' then '亚洲'
				when '印度' then '亚洲'
				when '日本' then '亚洲'
				when '美国' then '北美洲'
				when '加拿大' then '北美洲'
				when '墨西哥' then '北美洲'
				when '英国' then '欧洲'
				when '法国' then '欧洲'
				when '德国' then '欧洲'
		 else '其他' end
	
--drop table total_sales

create table Teacher_Salary
(
id int primary key not null,
T_name varchar(100),
T_salary numeric(18,2),
memo nvarchar(1000),
)
--insert into Teacher_Salary values(1,'李老师',500,'')
--insert into Teacher_Salary values(2,'王老师',600,'')
--insert into Teacher_Salary values(3,'陈老师',800,'')
--insert into Teacher_Salary values(4,'张老师',1000,'')
--insert into Teacher_Salary values(5,'刘老师',500,'')
--insert into Teacher_Salary values(6,'赵老师',600,'')
--insert into Teacher_Salary values(7,'马老师',1200,'')
--insert into Teacher_Salary values(8,'白老师',800,'')
select * from Teacher_Salary
select /*T_name,*/
	case when T_salary <= 500 then '1'
		 when T_salary > 500 and T_salary <= 600 then '2'
		 when T_salary > 600 and T_salary <= 800 then '3'
		 when T_salary > 800 and T_salary <= 1000 then '4'
		 when T_salary > 1000 then '5'
	else null end salary_class,COUNT(*) count
from Teacher_Salary
group by /*T_name,*/
	case when T_salary <= 500 then '1'
		 when T_salary > 500 and T_salary <= 600 then '2'
		 when T_salary > 600 and T_salary <= 800 then '3'
		 when T_salary > 800 and T_salary <= 1000 then '4'
		 when T_salary > 1000 then '5'
	else null end ;
--***
create table Population_sex
(
id int not null,
N_code bigint,
N_sex char(4),
S_population int,
)
--insert into Population_sex values(1,86,'男',340)
--insert into Population_sex values(2,86,'女',260)
--insert into Population_sex values(3,80,'男',45)
--insert into Population_sex values(4,80,'女',55)
--insert into Population_sex values(5,89,'男',51)
--insert into Population_sex values(6,89,'女',49)
--insert into Population_sex values(7,16,'男',105)
--insert into Population_sex values(8,16,'女',95)
select * from Nation
select * from Population_sex
--***
--case语句查询不同国家男女人数
select a.N_country,SUM(case b.N_sex when '男' then b.S_population else 0 end) 男性,
				   SUM(case b.N_sex when '女' then b.S_population else 0 end) 女性
from Nation a,population_sex b
where a.N_code = b.N_code
group by N_country
--运用子查询

{{{{{{{
select a.N_country,b.S_population
from Nation a,Population_sex b
where a.N_code = b.N_code
group by a.N_country,b.S_population
}}}}}}}

(select a.N_country,b.S_population 男性 from Nation a ,Population_sex b where a.N_code = b.N_code and b.N_sex = '男')

(select a.N_country,b.S_population 女性 from Nation a ,Population_sex b where a.N_code = b.N_code and b.N_sex = '女')


create table total_sales
(
id int primary key not null,
name nvarchar(100),
sales numeric(18,2),
)
/*
insert into total_sales values(1,'John',10)
insert into total_sales values(2,'Jennifer',15)
insert into total_sales values(3,'Stella',20)
insert into total_sales values(4,'Sophia',40)
insert into total_sales values(5,'Greg',50)
insert into total_sales values(6,'Jeff',20)
*/
--insert into total_sales values(7,'John',10)
--insert into total_sales values(8,'John',10)
--insert into total_sales values(9,'John',10)
select * from total_sales
--要找出每一行的排名,先判断，再分组，最后排序
use store
select a1.name,a1.sales,count(a2.sales) rank from total_sales a1,total_sales a2
where a1.sales < a2.sales or (a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc

/*
select a1.store_date,a1.sales,COUNT(a2.sales) from information_sales a1,information_sales a2
where a1.sales <= a2.sales or (a1.sales = a2.sales and a1.store_date = a2.store_date)
group by a1.sales,a1.store_date
order by a1.sales desc,a1.store_date desc
*/
--反复查找a1.sales小于等于a2.sales的条数，显示一次，然后继续查找下一跳满足条件的数目，这样就能出现排序
--最后要分组，升序或者降序排序即可很清晰的看到排名了
--要找出中位数,
--除非另外还指定了 TOP 或 FOR XML，否则，ORDER BY 子句在视图、内联函数、派生表、子查询和公用表表达式中无效。
select sales median中位数 from 
(select a1.name,a1.sales,COUNT(a1.sales) rank from total_sales a1,total_sales a2
where a1.sales < a2.sales or (a1.sales = a2.sales and a1.name >= a2.name)
group by a1.sales,a1.name
/*order by a1.sales desc*/) a3
where rank = (select (COUNT(*)+1)/2 from total_sales)

select top 2 * from total_sales
/*
算累积总计
算出累积总计是一个常见的需求，可惜以 SQL 并没有一个很直接的方式达到这个需求。
要以 SQL 算出累积总计，基本上的概念与列出排名类似：第一是先做个表格自我连结 (self join)，
然后将结果依序列出。在做列出排名时，我们算出每一行之前 (包含那一行本身) 有多少行数；
而在做累积总计时，我们则是算出每一行之前 (包含那一行本身) 的总合
*/

select a1.name,a1.sales,count(a2.sales) rank,sum(a2.sales) running_sales 
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or (a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--算总合百分比*******排序: asc 升序(由小到大)，desc 降序(由大到小)*******
select a1.name,a1.sales,a1.sales/(select SUM(sales) from total_sales) Pct_to_total
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or(a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--算累积总合百分比
select a1.name,a1.sales,SUM(a2.sales)/(select SUM(sales) from total_sales)
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or(a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--日期的格式可以设定。设置日期格式的命令如下Set DateFormat {}
--MDY、DMY、YMD、YDM、MYD 和 DYM。在默认情况下，日期格式为MDY
--例如:Set DateFormat YMD
--创建自定义数据类型
--创建一个用户定义的数据类型 ssn，其基于的系统数据类型是变长为11 的字符，不允许空
use Store
exec sp_addtype name,'varchar(20)','not null'
--创建一个用户定义的数据类型 birthday，其基于的系统数据类型是 DateTime，允许空。
use Store
exec sp_addtype birthday,datetime,'null'
--创建两个数据类型，即 telephone 和 fax,对于日期型的可以不加''单引号，字符型的要加上单引号''
exec sp_addtype telephone,'varchar(24)',"not null"
exec sp_addtype fax,'varchar(24)',"null"
--删除用户自定义的数据类型
exec sp_droptype 'name'
exec sp_droptype 'birthday'
exec sp_droptype 'telephone'
exec sp_droptype 'fax'

--create table aa
--(
--s_name name,
--y_year birthday,
--)

--备份数据库第一种方法
use Store
exec sp_addumpdevice 'disk','testback','H:\backup\backup_store.bak'
BACKUP DATABASE store TO testBack
--备份数据库第二种方法
backup database store to disk='H:\backup\backup_store.bak'
--恢复数据库
restore database data from disk='H:\backup\backup_store.bak'
--分离数据库
exec sp_detach_db 数据库名,'','',
--附加数据库
exec sp_attach_db 数据库名,'','',

--create table store_all like store_information
--create table store_all as select Store_id,Store_name,store_sales from Store_Information definition 
--添加主键给某个列
--Alter table 表名 add primary key(列名)
--删除某列的主键
--Alter table 表名 drop primary key(列名)
--创建索引
/*
建立索引的目的是： 
l       提高对表的查询速度； 
2       对表有关列的取值进行检查。
*/
create unique index store_index on store_information
(store_id ,
store_name,
store_sales
)
--删除索引
use Store
if exists (select Store_id from Store_Information
		   where store_id = -1)
	drop index store_index on store_infomation
else
	print '这里的值是不存在的'
GO
/*下例删除 authors 表内名为 au_id_ind 的索引。
USE Store
IF EXISTS (SELECT name FROM 表名
         WHERE name = 'au_id_ind')
   DROP INDEX authors.au_id_ind
GO
*/
--下面是if-exists-else判断
/*
if object_id('emp.idxemp') is  null 
print 'emp.idxemp not exist'

if exists (select Store_id from Store_Information where store_id = 1)
	print '你好'
else
	print '不好'
go
*/
--创建视图
create view store_view(id,name,sales,nickname) 
as 
select Store_id,Store_name,Store_sales,nickname from Store_Information
go
--exec sp_helptext store_view
--go
--查询视图
select * from store_view
--删除视图
drop view store_view
/*
选择：select * from table1 where 范围
插入：insert into table1(field1,field2) values(value1,value2)
删除：delete from table1 where 范围
更新：update table1 set field1=value1 where 范围
查找：select * from table1 where field1 like ’%value1%’ ---like的语法很精妙，查资料!
排序：select * from table1 order by field1,field2 [desc]
总数：select count as totalcount from table1
求和：select sum(field1) as sumvalue from table1
平均：select avg(field1) as avgvalue from table1
最大：select max(field1) as maxvalue from table1
最小：select min(field1) as minvalue from table1
*/
--修改数据库名称{exec sp_renamedb '旧数据库名','新数据库名'}
exec sp_renamedb 'store_1','store'
exec sp_renamedb 'StuMag','StuMagSys'
--修改数据库的表名（exec sp_rename '旧表名','新表名'）
exec sp_rename 'stu_info','stu_info_2'
exec sp_rename '[store].[dbo].[dbo.Customer]','Customer'
exec sp_rename 'information_sales','Information_sales'
exec sp_rename 'internet','Internet'
exec sp_rename 'score','Score'
exec sp_rename 'total_sales','Total_sales'
exec sp_rename 'shop','Shop'
--复制表(只复制了表结构,没有复制内容){select * into 新表名 from 源表名 where 1 <> 1}
select * into information_sales from internet_sales
where 1 <> 1
--复制表结构没有复制内容
--select top 0 * into 新表名 from 源表名
select top 0 * into internet from internet_sales
--drop table internet
--拷贝表数据到另一个表里,同一个数据库之间的数据拷贝
insert into internet(store_date,sales,memo) select store_date,sales,memo from Internet_Sales;
select * from internet
--跨数据库之间表的拷贝(具体数据使用绝对路径)
--insert into student(student_id,student_name,sex,birth) select * 
--from student in '"&server.mappath(".")&"\stumagsys.mdf "&"'
--where 1 = 1
/*同一个服务器，不同数据库之间的操作（跨数据库之间表的拷贝）
select * into 目标数据库.dbo（拥有者）.stu_info_1（表名，原来已有的表不能出现） 
from 源数据库名.dbo（拥有者）.student（表名）*/
select * into student.dbo.stu_info_1 from StuMagSys.dbo.student

/*不同服务器数据库之间的数据操作*/ 
--创建链接服务器 exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 ' 
--exec sp_addlinkedsrvlogin 'ITSV ', 'false ',null, '用户名 ', '密码 ' 
--查询示例 select * from ITSV.数据库名.dbo.表名 
--导入示例 select * into 表 from ITSV.数据库名.dbo.表名 
--以后不再使用时删除链接服务器 exec sp_dropserver 'ITSV ', 'droplogins ' 
--连接远程/局域网数据(openrowset/openquery/opendatasource) 
--1、openrowset 
--查询示例 select * from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) 
--生成本地表 select * into 表 from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) 
--把本地表导入远程表 insert openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) select *from 本地表 
--更新本地表 update b set b.列A=a.列A from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名)as a inner join 本地表 b on a.column1=b.column1 
--openquery用法需要创建一个连接 
--2、首先创建一个连接创建链接服务器 exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 ' 
--查询 select * FROM openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ') 
--把本地表导入远程表 insert openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ') select * from 本地表 
--更新本地表 update b set b.列B=a.列B FROM openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ') as a inner join 本地表 b on a.列A=b.列A 
--3、opendatasource/openrowset SELECT * FROM opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ' ).test.dbo.roy_ta 
--把本地表导入远程表
/*
SQL Server 阻止了对组件 'Ad Hoc Distributed Queries' 的 STATEMENT 'OpenRowset/OpenDatasource' 的访问，
因为此组件已作为此服务器安全配置的一部分而被关闭。系统管理员可以通过使用 sp_configure 启用 'Ad Hoc Distributed Queries'。
有关启用 'Ad Hoc Distributed Queries' 的详细信息，请参阅 SQL Server 联机丛书中的 "外围应用配置器"。
*/
exec sp_configure
--insert into aa select * from opendatasource('SQLOLEDB','data source = 192.168.1.5;userid = sa;password=zkbr').xzx.dbo.customer
--配置"外围应用配置器"
--show advanced option的值默认为0
use Store
go
exec sp_configure 'show advanced option','1';

reconfigure;
exec sp_configure
--修改"外围应用配置器"Ad Hoc Distributed Queries的值,默认为0
exec sp_configure 'ad hoc distributed queries','1'
--select * from Store
--where DATEDIFF('5','14:05',GETDATE()) > 5
--下例将使用名为 @find 的局部变量检索所有姓氏以 Man 开头的联系人信息
/*
USE AdventureWorks2008R2;
GO
DECLARE @find varchar(30);
/* Also allowed: 
DECLARE @find varchar(30) = 'Man%';
*/
SET @find = 'Man%';
SELECT p.LastName, p.FirstName, ph.PhoneNumber
FROM Person.Person p 
JOIN Person.PersonPhone ph
ON p.BusinessEntityID = ph.BusinessEntityID
WHERE LastName LIKE 'Man%';
*/
--下例将检索北美销售区中年销售额至少为 $2,000,000 的 Adventure Works Cycles 销售代表的名字。
/*
USE AdventureWorks2008R2;
GO
SET NOCOUNT ON;
GO
DECLARE @Group nvarchar(50), @Sales money;
SET @Group = N'North America';
SET @Sales = 2000000;
SET NOCOUNT OFF;
SELECT FirstName, LastName, SalesYTD
FROM Sales.vSalesPerson
WHERE TerritoryGroup = @Group and SalesYTD >= @Sales;
*/
--显示前三条数据
select top 3 * from Store_Information
--随机取出10条数据
select top 2 * from Store_Information
order by NEWID();

select * from Store_Information

--添加一个自增列(自增值为1)
alter table 表名
add  列名 int identity(1,1)
--增加一列
alter table Nation add sex char(4)

--{下面的这两句SQL是一样的
	--列出数据库里所有的表名(U代表用户的,S代表系统的)
	select name from sysobjects where type = 'U'
	--获取当前数据库中的所有用户表
	select name from sysobjects where xtype = 'U' and status >= 0
--}
--列出表里的所有的列名
--{
select name from syscolumns where id = OBJECT_ID('Store_Information')
select name from syscolumns where id =OBJECT_ID('total_sales')
select name from syscolumns where id  in(select id from sysobjects where type = 'U' and name = 'score')
--这三种效果一样
--}
create table shop
(
id int not null primary key,
type varchar(100),
vender varchar(50),
pcs bigint,
memo nvarchar(1000),
)
insert into shop values(1,'电脑','A',1,'')
insert into shop values(2,'电脑','A',2,'')
insert into shop values(3,'电脑','B',1,'')
insert into shop values(4,'光盘','A',2,'')
insert into shop values(5,'光盘','B',2,'')
insert into shop values(6,'手机','C',3,'')
insert into shop values(7,'手机','A',3,'')
insert into shop values(8,'手机','B',3,'')
insert into shop values(9,'手机','C',3,'')
select * from shop
--列出type、vender、pcs字段，以type字段排列，case可以方便地实现多重选择，类似select 中的case
--列出各种产品各种类型的数量
select TYPE,SUM(case vender 
				when 'A' then pcs 
				else 0 end) A类,
			SUM(case vender 
				when 'B' then pcs 
				else 0 end) B类,
			SUM(case vender 
				when 'C' then pcs 
				else 0 end) C类
from shop 
group by type

--初始化表table1
--truncate table shop
--选择从2到7的记录(select * from shop)
select top 5 * from (select top 7 * from shop order by id asc) sp
order by id desc

--在SQL中，"where 1 = 1" 是表示选择全部    "where 1 = 2 "全部不选

declare @strWhere int,@strSQL varchar(1000),@tblName varchar(100)
if @strWhere !='' 
begin
set @strSQL = 'select count(*) as Total from [' + @tblName + '] where ' + @strWhere 
end
else 
begin
set @strSQL = 'select count(*) as Total from [' + @tblName + ']' 
end
/*
dbcc reindex
dbcc indexdefrag
dbcc shrinkdb
dbcc shrinkfile
*/
--压缩数据库
dbcc shrinkdatabase (store)
--转移数据库给新用户以已存在用户权限
--(exec sp_change_users_login 'update_one','newname','oldname'
--go)
exec sp_change_users_login 'update_one','chw','guest'
go
--检查备份集
restore verifyonly from disk = 'H:\backup\store.bak'
--修复数据库
--首先修改数据库使用者为自己单个用户
--第二步修复数据库
--第三步将数据库使用者改为多用户
alter database store set single_user
go

dbcc checkdb('store',repair_allow_data_loss) with tablock

alter database store set multi_user
go
--日志清除
SET NOCOUNT ON
DECLARE @LogicalFileName sysname,
	    @MaxMinutes INT,
		@NewSize INT

USE store -- 要操作的数据库名
SELECT  @LogicalFileName = 'tablename_log', -- 日志文件名
@MaxMinutes = 10, -- Limit on time allowed to wrap log.限定时间
@NewSize = 1  -- 你想设定的日志文件的大小(M)
Setup / initialize
DECLARE @OriginalSize int
SELECT @OriginalSize = size 
 FROM sysfiles
 WHERE name = @LogicalFileName
SELECT 'Original Size of ' + db_name() + ' LOG is ' + 
 CONVERT(VARCHAR(30),@OriginalSize) + ' 8K pages or ' + 
 CONVERT(VARCHAR(30),(@OriginalSize*8/1024)) + 'MB'
 FROM sysfiles
 WHERE name = @LogicalFileName
CREATE TABLE DummyTrans
 (DummyColumn char (8000) not null)

DECLARE @Counter    INT,
 @StartTime DATETIME,
 @TruncLog   VARCHAR(255)
SELECT @StartTime = GETDATE(),
 @TruncLog = 'BACKUP LOG ' + db_name() + ' WITH TRUNCATE_ONLY'
DBCC SHRINKFILE (@LogicalFileName, @NewSize)
EXEC (@TruncLog)
-- Wrap the log if necessary.
WHILE @MaxMinutes > DATEDIFF (mi, @StartTime, GETDATE()) -- time has not expired
 AND @OriginalSize = (SELECT size FROM sysfiles WHERE name = @LogicalFileName)  
 AND (@OriginalSize * 8 /1024) > @NewSize  
 BEGIN -- Outer loop.
SELECT @Counter = 0
 WHILE   ((@Counter < @OriginalSize / 16) AND (@Counter < 50000))
 BEGIN -- update
 INSERT DummyTrans VALUES ('Fill Log') DELETE DummyTrans
 SELECT @Counter = @Counter + 1
 END
 EXEC (@TruncLog)  
 END
SELECT 'Final Size of ' + db_name() + ' LOG is ' +
 CONVERT(VARCHAR(30),size) + ' 8K pages or ' + 
 CONVERT(VARCHAR(30),(size*8/1024)) + 'MB'
 FROM sysfiles 
 WHERE name = @LogicalFileName
DROP TABLE DummyTrans
SET NOCOUNT OFF
--更改某个表的拥有者
exec sp_changeobjectowner 'store_information','dbo'
--存储过程更改全部表

CREATE PROCEDURE dbo.User_ChangeObjectOwnerBatch
@OldOwner as NVARCHAR(128),
@NewOwner as NVARCHAR(128)
AS
DECLARE @Name    as NVARCHAR(128)
DECLARE @Owner   as NVARCHAR(128)
DECLARE @OwnerName   as NVARCHAR(128)
DECLARE curObject CURSOR FOR 
select 'Name'   = name,
	   'Owner'  = user_name(uid)
from sysobjects
where user_name(uid)=@OldOwner
order by name
OPEN   curObject
FETCH NEXT FROM curObject INTO @Name, @Owner
WHILE(@@FETCH_STATUS=0)
BEGIN     
if @Owner=@OldOwner 
begin
   set @OwnerName = @OldOwner + '.' + rtrim(@Name)
   exec sp_changeobjectowner @OwnerName, @NewOwner
end
-- select @name,@NewOwner,@OldOwner
FETCH NEXT FROM curObject INTO @Name, @Owner
END
close curObject
deallocate curObject
GO
/*
create table score
(
id int primary key not null,
name varchar(100),
g_score int,
memo nvarchar(1000),
)*/
use store
select * from score
--delete from score where 1 = 1
--SQL SERVER中直接循环写入数据
declare @i int
set @i = 1
while @i < 5
begin
    insert into dbo.score(id,name,g_score) values(@i,'zhangsan + @i',57 + @i)
    set @i = @i + 1
end
--要求就上表中所有沒有及格的成績，在每次增長0.1的基礎上，使他們剛好及格

set nocount on
while((select MIN(g_score) from score) < 60)
begin
	update score set g_score = g_score * 1.01
	where score.g_score < 60
	if((select MIN(g_score) from score) > 60)
		break
	else
		continue
	set nocount off
end
--显示数据库对象的特征信息,
exec sp_help store_information
--可以显示数据库对象所依赖的对象
exec sp_helptext store_view

create table tb_family_name
(
id int not null primary key,
family_name varchar(50),
content nvarchar(1000),
memo nvarchar(1000),
)

--insert into tb_family_name values(1,'赵','相传编百家姓的时候，国王姓赵，故以赵开头','')
--insert into tb_family_name values(2,'钱','这个就不得而知了','')
--insert into tb_family_name values(3,'孙','这个就不得而知了','')
--insert into tb_family_name values(4,'李','这个就不得而知了','')
--insert into tb_family_name values(5,'周','这个就不得而知了','')
--insert into tb_family_name values(6,'武','这个就不得而知了','')
--insert into tb_family_name values(7,'郑','这个就不得而知了','')
--insert into tb_family_name values(8,'王','这个就不得而知了','')
--insert into tb_family_name values(9,'陈','这个就不得而知了','')
--insert into tb_family_name values(10,'齐','这个就不得而知了','')
select * from tb_family_name
--按姓氏笔画排序
select * from tb_family_name
order by family_name collate chinese_prc_stroke_ci_as

--按照汉字拼音的首字母排名的降序
select a1.family_name,COUNT(a2.family_name) rank from tb_family_name a1,tb_family_name a2
where a1.family_name <= a2.family_name
group by a1.family_name
order by /*rank asc,*/a1.family_name desc
--数据库加密
--create database teacher
--select ENCRYPT('')
select PWDENCRYPT('原始密码') as 原始密码
select PWDCOMPARE('','') 
--取回表中字段
declare @list varchar(1000),
		@sql nvarchar(1000)
select @list = @list + ',' + b.name from sysobjects a,syscolumns b
where a.id = b.id and a.name = '表A'
set @sql = 'select' + RIGHT(@list,LEN(@list)-1) + 'from 表A'
--exec (@sql)
select @list,@sql,b.name from sysobjects a,syscolumns b
where a.id = b.id
--查看硬盘分区(exec 数据库名..xp_fixeddrives或者{exec ..xp_fixeddrives})
exec master..xp_fixeddrives
--比较A,B表是否相等
if (select CHECKSUM_AGG(BINARY_CHECKSUM(*)) from score)
	=
   (select CHECKSUM_AGG(BINARY_CHECKSUM(*)) from shop)
	print '相等'
else
	print '不相等'

--杀掉所有的事件探察器进程
declare hcforeach cursor global for select 'kill' + rtrim(spid) from master.dbo.sysprocesses
where program_name in ('SQL profiler',N'SQL事件探查器')
exec sp_MSforeach_worker '?'
--记录搜索
--查询表中的最后以条记录，并不知道这个表共有多少数据,以及表结构
declare @sql_1 varchar(500),
		@count int
set @sql_1 = 'select top 1 * from store_information where pid not in(select top ' + STR(@count - 1) + 'pid from store_information)'
print @sql_1
exec sp_executesql @sql_1

--查看与某一个表相关的视图、存储过程、函数
select a.* from sysobjects a,syscomments b
where a.id = b.id and b.text like '%store_information%'

select a.* from sysobjects a,syscomments b
where a.id = b.id and b.text like '%total_sales%'
--查看与某一个表相关的视图、存储过程、函数
select name as存储过程名称 from sysobjects 
where xtype = 'P'
--查询用户创建的所有数据库(下面两条语句都可以)
select * from master ..sysdatabases D where sid not in(select sid from master ..syslogins where name = 'sa')
select dbid,name as DB_name from master ..sysdatabases where sid <> 0x01 
--查询某一个表的字段和数据类型
select column_name,data_type from information_schema.COLUMNS
where TABLE_NAME = 'shop'

●■★
--不同服务器数据库之间的数据操作
exec sp_addlinkedserver 'ITSV','','SQLOLEDB','192.168.1.5'
exec sp_addlinkedsrvlogin 'ITSV','false',null,'sa','zkbr'
--查询示例
select * from ITSV.xzx.dbo.tb_customer
--导入示例
select * into from ITSV.xzx.dbo.customer
--以后不再使用时删除链接服务器
exec sp_dropserver 'itsv','droplogins'
--连接远程/局域网数据(openrowset/openquery/opendatasource)
--必须严格按照下面语句的格式，“,”就是“,”，“;”就是“;”

--1、openrowset的用法
--查询示例 
select * from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
--生成本地表
--(select * into 本地表不存在的表名 from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer))
select * into customer from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
--把本地表导入远程表
insert openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
select * from Store_Information
--更新本地表
update 本地表b
set b.列A = a.列A
from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer) as a inner join 本地表b
on a.column1 = b.column1

--2、openquery用法（需要创建一个连接）
--首先创建一个连接创建链接服务器
exec sp_addlinkedserver 'ITSV','','SQLOLEDB','192.168.1.5'
exec sp_addlinkedsrvlogin 'ITSV','false',null,'sa','zkbr'
--以后不再使用时删除链接服务器
exec sp_dropserver 'ITSV','droplogins'
--查询
select * from openquery(ITSV,'select * from xzx.dbo.tb_customer')
--生成本地表
--(select * into 表名(本地不存在的表) from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer))
select * into customer from openquery(ITSV,'select * from xzx.dbo.tb_customer')
--把本地表导入远程表
insert openquery(ITSV,'select * from xzx.dbo.tb_customer')
select * from 本地表
--更新本地表
update 本地表b
set b.列B = a.列B
from openquery(ITSV,'select * from xzx.dbo.tb_customer') as a inner join  本地表b on a.列A = b.列A

--3、opendatasource/openrowset 的使用方法
/*
SELECT   * 
FROM   opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ' ).数据库名.dbo.表名
*/
select * from 
opendatasource('SQLOLEDB','data source = 192.168.1.5;user ID = sa;password = zkbr').xzx.dbo.tb_customer
--把本地表导入远程表
/*
insert opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ').数据库.dbo.表名 
select * from 本地表
*/
insert opendatasource('SQLOLEDB','data source = 192.168.1.5,user ID = sa;password = zkbr').xzx.dbo.tb_customer
select * from 本地表
●■★
--字符串函数
--字符所占用的空间
select store_name,DATALENGTH(store_name) 所占用空间 from Store_Information
select family_name,DATALENGTH(family_name) 所占用空间 from tb_family_name
--字符的长度
select family_name,LEN(family_name) 字符长度 from tb_family_name
--从customerNO字符第一位开始取3位
select customerNo,SUBSTRING(customerNO,1,3) from customer
--全部取出字符串
select customerNo,SUBSTRING(customerNO,1,LEN(customerNO)) 全部字符串 from customer
--use store
--select * from Customer
--取出字符串的右边的第一位字符
select customerNO,RIGHT(customerNo,2) 右边开始取两位字符 from customer
select customerNO,LEFT(customerNO,3) 左边开始取三位字符 from customer
--isnull( check_expression , replacement_value )如果check_expression為空，則返回replacement_value的值，
--不為空，就返回check_expression字符
select ISNULL(customerNO,0) from customer






