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
  values(6,'White Chen','2000',1988-8-8,'���з�','123456@126.com')*/

--delete store_information 
--where store_id = 5
select * from Store_Information

--��Ҫѡ�����еĵ��� (store_Name)��
select store_name as �̵��� from Store_Information

--ѡ�񲿷��в�ָ�����ǵ���ʾ�����ѯ������������ݵ�����˳����ѡ���б�����ָ������������˳����ͬ
--asc ����desc ����
select store_name,store_sales from Store_Information
where store_sales > 100 
order by store_sales desc

alter table store_information add nickname varchar(50)
alter table store_information add email varchar(50)

--��ʾ��ʱ�򿴵���"�ǳ�"��"�����ʼ�"�����ĵ�
select �ǳ�=nickname,�����ʼ�=email from Store_Information  

--����ǰ����PERCENT 
select top 2 * from Store_Information
--����ǰ ��������50%(PERCENT) 
select top 50 PERCENT * from Store_Information
--ÿ������ֻ��ʾһ��,�ظ���Ҳ��ʾһ��
select distinct store_name,nickname from Store_Information

/*
��������96��1�µĶ��� 
SELECT orderID, CustomerID, orderDate 
FROM orders 
WHERE orderDate ��#1/1/96# AND orderDate��#1/30/96# 
*/

--�ҳ�Ӫҵ�����1000
select store_name,store_sales from Store_Information
where store_sales > 1000

--{}+ ����{}֮�ڵ�����ᷢ��һ����

--������˵��������Ҫ�� Store_Information �����ѡ������ Sales ���� $1,000 ���� Sales �� $500 �� $275 ֮������ϵĻ�
select store_name,store_sales from Store_Information
where store_sales > 1000
or (store_sales > 275 and store_sales < 500)
--������˵��������Ҫ�� Store_Information ������ҳ����к��� Los Angeles �� San Diego ������
select * from Store_Information
where store_name in ('Los Angeles','San Diego')
--����
update Store_Information set store_name = 'Log Angeles'
where store_id = 3
update Store_Information set store_date = '1999-1-7'
where store_id = 3
--����ʱ��
update Store_Information set store_date = '1999-06-13'
where store_id = 3 
--������˵��������Ҫ�� Store_Information ������ҳ����н��� 1905-6-15�� 1999-6-13 �е�����
select * from Store_Information
where store_date between '1905-6-15' and '1999-6-13'
--������ IN ��ʱ��������ȫ��֪��������Ҫ�������������� BETWEEN ��ʱ�����������г�һ����Χ
select * from Store_Information
where store_name like '%e%' 

/*
LIKE�������ʹ�õ�ͨ��� 
ͨ������� 
1)�� �κ�һ����һ���ַ� 
2)* ���ⳤ�ȵ��ַ� 
3)# 0~9֮��ĵ�һ���� 
4)[�ַ��б�] ���ַ��б������һֵ 
5)[���ַ��б�] �����ַ��б������һֵ 
6)_ ָ���ַ���Χ�����ߵ�ֵ�ֱ�Ϊ�������� 
	{ģʽ} ��������Ұ�� (wildcard). �����Ǽ������ӣ� 
	'A_Z': ������ 'A' ��ͷ����һ���κ�ֵ����ԭ������ 'Z' Ϊ��β���ַ����� 'ABZ' �� 'A2Z' ��������һ��ģʽ��
	�� 'AKKZ' �������� (��Ϊ�� A �� Z ֮����������ԭ��������һ����ԭ)�� 
	'ABC%': ������ 'ABC' ��ͷ���ַ�����������˵��'ABCD' �� 'ABCABC' ���������ģʽ�� 
	'%XYZ': ������ 'XYZ' ��β���ַ�����������˵��'WXYZ' �� 'ZZXYZ' ���������ģʽ�� 
	'%AN%': ���к��� 'AN'���ģʽ���ַ���
*/
--���� asc ����(��С����)��desc ����(�ɴ�С)
select store_name,store_sales,store_date from Store_Information
order by 2 desc
/*AVG (ƽ��) 
COUNT (����) 
MAX (���ֵ) 
MIN (��Сֵ) 
SUM (�ܺ�) 
VAR (����) 
STDEV (��׼���) 
FIRST (��һ��ֵ) 
LAST (���һ��ֵ) 
*/
--���ҵ�Ӫҵ�������̵����,id,����
select store_id,store_name,store_date from Store_Information
where store_sales like
(
select MAX(Store_sales) from Store_Information
)
--���ҵ�������С���̵����,Ӫҵ��
select Store_name,store_sales,store_date from Store_Information
where store_date = 
(
select MIN(store_date) from Store_Information
)
--��Ӫҵ���ƽ��ֵ
select avg(store_sales) from Store_Information
--���Ӫҵ�ܶ�
select SUM(Store_sales) from Store_Information
--�����ܹ��ж�������¼
select COUNT(*) from Store_Information
--����Ӫҵ��ķ���
select var(store_sales) from Store_Information
--����Ӫҵ��ı�׼��
select STDEV(Store_sales) from Store_Information
select store_name,store_date from Store_Information
group by store_name,store_date
--����������ǿյ��ܹ��ж�������¼
select COUNT(Store_name) from Store_Information
where store_name is not null
--������˵���������Ҫ�ҳ����ǵı�����ж��ٸ���ͬ�� store_name
select COUNT(distinct Store_name) from Store_Information
--���������group by
select store_name,SUM(Store_sales) from Store_Information
group by store_name
--�ҳ�Ӫҵ�����700��
select Store_name,SUM(Store_sales) from Store_Information
group by store_name
having SUM(store_sales) > 700
--���ñ���,�оۺϺ���ʱ,Ҫ��group by ����
select a1.store_name �̵���,sum(a1.store_sales) Ӫҵ�� from Store_Information a1
group by a1.store_name

create table Geography
(
G_id int primary key not null,
store_name nvarchar(100),
region_name varchar(50),
memo nvarchar(1000),
)
--��������
/*insert into Geography values(1,'Boston','East','')
insert into Geography values(2,'New York','East','') 
insert into Geography values(3,'Los Angeles','East','') 
insert into Geography values(4,'San Diego','West','') 
insert into Geography values(5,'BeiJing','East','') 
*/
select * from Geography
--����������ӣ��ҵ��������Ĺ�ͬ��
select a.region_name ����,SUM(b.store_sales) Ӫҵ�� from Geography a,Store_Information b
where a.store_name = b.store_name
group by a.region_name
--�������store_name���ƶԱ�
select a.store_name a���еĵ���,b.store_name b���еĵ��� from Geography a,Store_Information b
where a.G_id = b.store_id
--������������ӣ���ָ�������������ͬ�����ݲŻᱻѡ��
--������
--������
select a.store_name,SUM(b.store_sales) from Geography a,Store_Information b
where a.store_name *= b.store_name
group by a.store_name

/*
�˲�ѯʹ�õĲ��� ANSI �ⲿ���������("*=" �� "=*")����Ҫ�������޸ļ����д˲�ѯ��
��ʹ�� ALTER DATABASE �� SET COMPATIBILITY_LEVEL ѡ���ǰ���ݿ�ļ��ݼ�������Ϊ 80��
��������ʹ�� ANSI �ⲿ���������(LEFT OUTER JOIN��RIGHT OUTER JOIN)��д�˲�ѯ��
�ڽ����� SQL Server �汾�У���ʹ��������ģʽ�£�Ҳ��֧�ַ� ANSI �����������
*/
--���õ�ǰ���ݿ�ļ��ݼ���Ϊ80������ֱ�Ϊ80,90,100
ALTER DATABASE store SET COMPATIBILITY_LEVEL = 80
/*MySQL/Oracle���ַ��������﷨��Oracle��CONCAT()ֻ��������������
����֮��һ��ֻ�ܽ������ַ���������������������Oracle�У����ǿ�����'||'��һ�δ�������ַ���

select concat(Store_name,region_name) from Store_Information
where store_name = 'Boston'

Oracle: 
SELECT region_name || ' ' || store_name FROM Geography 
WHERE store_name = 'Boston'; 

*/
--SQL ���������߶���ַ���������"+"
select Store_name + ' ' + nickname as �����ַ������� from Store_Information
where store_name = 'White Chen'
select * from Store_Information
SELECT region_name + ' ' + store_name + ' ' + memo FROM Geography 
WHERE store_name = 'Boston';
--SQL �е� substring ����������ץ��һ����λ�����е�����һ����,
/*MySQL: SUBSTR(), SUBSTRING() 
Oracle: SUBSTR() 
SQL Server: SUBSTRING()*/
--��ȡ�ַ�����һ����substring(str,2,5),��str�еĵڶ���λ�ÿ�ʼ����ȡ5���ַ�
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
--��ѯ
select * from Internet_Sales
--ʹ�� UNION��INTERSECT �� EXCEPT ������ϲ������в�ѯ��������Ŀ���б�������ͬ��Ŀ�ı��ʽ��
--����Ҫ�ҳ���������Ӫҵ�� (sales) ������,unionĿ����Ҫ������ SQL ���Ľ���ϲ���һ��
select Store_date from Store_Information
union
select Store_date from Internet_Sales
--�ѿ���������
select (a.store_date) a_date,(b.store_date) b_date from Store_Information a,Internet_Sales b
--�ҳ���������Ӫҵ�� (sales) ������,����������û���ظ�,
--union allĿ��Ҳ��Ҫ������ SQL ���Ľ���ϲ���һ��
select Store_date from Store_Information
union
select Store_date from Internet_Sales
/*
 INTERSECT�� UNION ָ�����ƣ� INTERSECT Ҳ�Ƕ����� SQL ����������Ľ��������ġ���ͬ�ĵط��ǣ�
 UNION ��������һ�� OR (������ֵ�����ڵ�һ����ǵڶ��䣬���ͻᱻѡ��)��
 �� INTERSECT ��Ƚ��� AND (���ֵҪ�����ڵ�һ��͵ڶ���Żᱻѡ��)��intersect ��ָ�������ж���ʱ��ѡ�� 
 UNION ���������� INTERSECT �ǽ���
*/
--����Ҫ�ҳ��ļ����е��潻�׺����罻��
--ʹ�� UNION��INTERSECT �� EXCEPT ������ϲ������в�ѯ��������Ŀ���б�������ͬ��Ŀ�ı��ʽ��
select Store_date from Store_Information
intersect
select Store_date from Internet_Sales
/*
MINUS ָ�������������� SQL ����ϡ������ҳ���һ�� SQL ����������Ľ����
Ȼ����Щ�����û���ڵڶ��� SQL ���Ľ���С�����еĻ�������һ�����Ͼͱ�ȥ���������������Ľ���г��֡�
����ڶ��� SQL ����������Ľ����û�д����ڵ�һ�� SQL ����������Ľ���ڣ���������Ͼͱ������� 
*/
--����Ҫ֪�����ļ������е���Ӫҵ���û������Ӫҵ���
select store_date from Store_Information
MINUS
select Store_date from Internet_Sales
--minus�����ü���˵��ȥͬ����

--select * from Store_Information where rownum < 10
--MINUS 
--select * from Internet_Sales where rownum < 5
--����Ҫ���� subquery ���ҳ������������ĵ��Ӫҵ��,���Ӳ�ѯ
select SUM(Store_sales) from Store_Information
where store_name in
(
select store_name from Geography
where region_name = 'west'
)
--��ѯ�����й�ͬ�е��̵���ܹ���Ӫҵ��,����Ӳ�ѯ
select SUM(a1.store_sales) from Store_Information a1
where a1 .store_name in
(
select a2.store_name from Geography a2
where a2.store_name = a1.store_name
)
--EXISTS �����������ڲ�ѯ��û�в����κν��������еĻ���ϵͳ�ͻ�ִ�����ѯ�е� SQL������û�еĻ���
--������ SQL ���Ͳ�������κν��
select SUM(Store_sales) from Store_Information
where exists
(select * from Geography
where region_name = 'west'
)
--CASE �� SQL ������Ϊ IF-THEN-ELSE ֮���߼��Ĺؼ���
/*
SELECT CASE ("����")
  WHEN "����1" THEN "���1"
  WHEN "����2" THEN "���2"
  ...
  [ELSE "���N"]
  END
FROM "����"
*/
--������Ҫ�� 'Los Angeles' �� Sales ��ֵ����2���Լ��� 'San Diego' �� Sales ��ֵ����1.5
--����Ҫ�õ�case
select Store_name ,case Store_name
	when 'Los Angeles' then Store_sales * 2
	when 'San Diego' then Store_sales *1.5
	else store_sales
	end "new sales",store_date
from Store_Information

--��Case����
select customerNO,userName,
case sex
	when '1' then '��'
	when '0' then 'Ů'
else '����' 
end "sex",fullname,parentID,adddate,nickname,birthday,createman,createtime
from customer
--select * from customer

--Case��������
select customerNo,userName,
case when sex = '1' then '��'
	 when sex = '2' then 'Ů'
else '����' end "sex",fullname,parentID,adddate,nickname,birthday,createman,createtime
from customer

create table Nation
(
id int,
N_code bigint,
N_country varchar(100) primary key not null,
N_population int,
memo nvarchar(1000)
)
--insert into Nation values(1,86,'�й�',600,'')
--insert into Nation values(2,80,'����',100,'')
--insert into Nation values(3,89,'���ô�',100,'')
--insert into Nation values(4,16,'Ӣ��',200,'')
--insert into Nation values(5,102,'����',300,'')
--insert into Nation values(6,95,'�ձ�',250,'')
--insert into Nation values(7,82,'�¹�',200,'')
--insert into Nation values(8,61,'ī����',50,'')
--insert into Nation values(9,32,'ӡ��',250,'')
select * from Nation
--�����ĳһ�������ޣ����˿���
select SUM(N_population) �˿�,
		   case N_country
				when '�й�' then '����'
				when 'ӡ��' then '����'
				when '�ձ�' then '����'
				when '����' then '������'
				when '���ô�' then '������'
				when 'ī����' then '������'
				when 'Ӣ��' then 'ŷ��'
				when '����' then 'ŷ��'
				when '�¹�' then 'ŷ��'						
else '����' end "��"
from Nation
group by case N_country
				when '�й�' then '����'
				when 'ӡ��' then '����'
				when '�ձ�' then '����'
				when '����' then '������'
				when '���ô�' then '������'
				when 'ī����' then '������'
				when 'Ӣ��' then 'ŷ��'
				when '����' then 'ŷ��'
				when '�¹�' then 'ŷ��'
		 else '����' end
	
--drop table total_sales

create table Teacher_Salary
(
id int primary key not null,
T_name varchar(100),
T_salary numeric(18,2),
memo nvarchar(1000),
)
--insert into Teacher_Salary values(1,'����ʦ',500,'')
--insert into Teacher_Salary values(2,'����ʦ',600,'')
--insert into Teacher_Salary values(3,'����ʦ',800,'')
--insert into Teacher_Salary values(4,'����ʦ',1000,'')
--insert into Teacher_Salary values(5,'����ʦ',500,'')
--insert into Teacher_Salary values(6,'����ʦ',600,'')
--insert into Teacher_Salary values(7,'����ʦ',1200,'')
--insert into Teacher_Salary values(8,'����ʦ',800,'')
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
--insert into Population_sex values(1,86,'��',340)
--insert into Population_sex values(2,86,'Ů',260)
--insert into Population_sex values(3,80,'��',45)
--insert into Population_sex values(4,80,'Ů',55)
--insert into Population_sex values(5,89,'��',51)
--insert into Population_sex values(6,89,'Ů',49)
--insert into Population_sex values(7,16,'��',105)
--insert into Population_sex values(8,16,'Ů',95)
select * from Nation
select * from Population_sex
--***
--case����ѯ��ͬ������Ů����
select a.N_country,SUM(case b.N_sex when '��' then b.S_population else 0 end) ����,
				   SUM(case b.N_sex when 'Ů' then b.S_population else 0 end) Ů��
from Nation a,population_sex b
where a.N_code = b.N_code
group by N_country
--�����Ӳ�ѯ

{{{{{{{
select a.N_country,b.S_population
from Nation a,Population_sex b
where a.N_code = b.N_code
group by a.N_country,b.S_population
}}}}}}}

(select a.N_country,b.S_population ���� from Nation a ,Population_sex b where a.N_code = b.N_code and b.N_sex = '��')

(select a.N_country,b.S_population Ů�� from Nation a ,Population_sex b where a.N_code = b.N_code and b.N_sex = 'Ů')


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
--Ҫ�ҳ�ÿһ�е�����,���жϣ��ٷ��飬�������
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
--��������a1.salesС�ڵ���a2.sales����������ʾһ�Σ�Ȼ�����������һ��������������Ŀ���������ܳ�������
--���Ҫ���飬������߽������򼴿ɺ������Ŀ���������
--Ҫ�ҳ���λ��,
--�������⻹ָ���� TOP �� FOR XML������ORDER BY �Ӿ�����ͼ�������������������Ӳ�ѯ�͹��ñ���ʽ����Ч��
select sales median��λ�� from 
(select a1.name,a1.sales,COUNT(a1.sales) rank from total_sales a1,total_sales a2
where a1.sales < a2.sales or (a1.sales = a2.sales and a1.name >= a2.name)
group by a1.sales,a1.name
/*order by a1.sales desc*/) a3
where rank = (select (COUNT(*)+1)/2 from total_sales)

select top 2 * from total_sales
/*
���ۻ��ܼ�
����ۻ��ܼ���һ�����������󣬿�ϧ�� SQL ��û��һ����ֱ�ӵķ�ʽ�ﵽ�������
Ҫ�� SQL ����ۻ��ܼƣ������ϵĸ������г��������ƣ���һ������������������� (self join)��
Ȼ�󽫽�������г��������г�����ʱ���������ÿһ��֮ǰ (������һ�б���) �ж���������
�������ۻ��ܼ�ʱ�������������ÿһ��֮ǰ (������һ�б���) ���ܺ�
*/

select a1.name,a1.sales,count(a2.sales) rank,sum(a2.sales) running_sales 
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or (a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--���ܺϰٷֱ�*******����: asc ����(��С����)��desc ����(�ɴ�С)*******
select a1.name,a1.sales,a1.sales/(select SUM(sales) from total_sales) Pct_to_total
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or(a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--���ۻ��ܺϰٷֱ�
select a1.name,a1.sales,SUM(a2.sales)/(select SUM(sales) from total_sales)
from total_sales a1,total_sales a2
where a1.sales <= a2.sales or(a1.sales = a2.sales and a1.name = a2.name)
group by a1.name,a1.sales
order by a1.sales desc,a1.name desc
--���ڵĸ�ʽ�����趨���������ڸ�ʽ����������Set DateFormat {}
--MDY��DMY��YMD��YDM��MYD �� DYM����Ĭ������£����ڸ�ʽΪMDY
--����:Set DateFormat YMD
--�����Զ�����������
--����һ���û�������������� ssn������ڵ�ϵͳ���������Ǳ䳤Ϊ11 ���ַ����������
use Store
exec sp_addtype name,'varchar(20)','not null'
--����һ���û�������������� birthday������ڵ�ϵͳ���������� DateTime������ա�
use Store
exec sp_addtype birthday,datetime,'null'
--���������������ͣ��� telephone �� fax,���������͵Ŀ��Բ���''�����ţ��ַ��͵�Ҫ���ϵ�����''
exec sp_addtype telephone,'varchar(24)',"not null"
exec sp_addtype fax,'varchar(24)',"null"
--ɾ���û��Զ������������
exec sp_droptype 'name'
exec sp_droptype 'birthday'
exec sp_droptype 'telephone'
exec sp_droptype 'fax'

--create table aa
--(
--s_name name,
--y_year birthday,
--)

--�������ݿ��һ�ַ���
use Store
exec sp_addumpdevice 'disk','testback','H:\backup\backup_store.bak'
BACKUP DATABASE store TO testBack
--�������ݿ�ڶ��ַ���
backup database store to disk='H:\backup\backup_store.bak'
--�ָ����ݿ�
restore database data from disk='H:\backup\backup_store.bak'
--�������ݿ�
exec sp_detach_db ���ݿ���,'','',
--�������ݿ�
exec sp_attach_db ���ݿ���,'','',

--create table store_all like store_information
--create table store_all as select Store_id,Store_name,store_sales from Store_Information definition 
--���������ĳ����
--Alter table ���� add primary key(����)
--ɾ��ĳ�е�����
--Alter table ���� drop primary key(����)
--��������
/*
����������Ŀ���ǣ� 
l       ��߶Ա�Ĳ�ѯ�ٶȣ� 
2       �Ա��й��е�ȡֵ���м�顣
*/
create unique index store_index on store_information
(store_id ,
store_name,
store_sales
)
--ɾ������
use Store
if exists (select Store_id from Store_Information
		   where store_id = -1)
	drop index store_index on store_infomation
else
	print '�����ֵ�ǲ����ڵ�'
GO
/*����ɾ�� authors ������Ϊ au_id_ind ��������
USE Store
IF EXISTS (SELECT name FROM ����
         WHERE name = 'au_id_ind')
   DROP INDEX authors.au_id_ind
GO
*/
--������if-exists-else�ж�
/*
if object_id('emp.idxemp') is  null 
print 'emp.idxemp not exist'

if exists (select Store_id from Store_Information where store_id = 1)
	print '���'
else
	print '����'
go
*/
--������ͼ
create view store_view(id,name,sales,nickname) 
as 
select Store_id,Store_name,Store_sales,nickname from Store_Information
go
--exec sp_helptext store_view
--go
--��ѯ��ͼ
select * from store_view
--ɾ����ͼ
drop view store_view
/*
ѡ��select * from table1 where ��Χ
���룺insert into table1(field1,field2) values(value1,value2)
ɾ����delete from table1 where ��Χ
���£�update table1 set field1=value1 where ��Χ
���ң�select * from table1 where field1 like ��%value1%�� ---like���﷨�ܾ��������!
����select * from table1 order by field1,field2 [desc]
������select count as totalcount from table1
��ͣ�select sum(field1) as sumvalue from table1
ƽ����select avg(field1) as avgvalue from table1
���select max(field1) as maxvalue from table1
��С��select min(field1) as minvalue from table1
*/
--�޸����ݿ�����{exec sp_renamedb '�����ݿ���','�����ݿ���'}
exec sp_renamedb 'store_1','store'
exec sp_renamedb 'StuMag','StuMagSys'
--�޸����ݿ�ı�����exec sp_rename '�ɱ���','�±���'��
exec sp_rename 'stu_info','stu_info_2'
exec sp_rename '[store].[dbo].[dbo.Customer]','Customer'
exec sp_rename 'information_sales','Information_sales'
exec sp_rename 'internet','Internet'
exec sp_rename 'score','Score'
exec sp_rename 'total_sales','Total_sales'
exec sp_rename 'shop','Shop'
--���Ʊ�(ֻ�����˱�ṹ,û�и�������){select * into �±��� from Դ���� where 1 <> 1}
select * into information_sales from internet_sales
where 1 <> 1
--���Ʊ�ṹû�и�������
--select top 0 * into �±��� from Դ����
select top 0 * into internet from internet_sales
--drop table internet
--���������ݵ���һ������,ͬһ�����ݿ�֮������ݿ���
insert into internet(store_date,sales,memo) select store_date,sales,memo from Internet_Sales;
select * from internet
--�����ݿ�֮���Ŀ���(��������ʹ�þ���·��)
--insert into student(student_id,student_name,sex,birth) select * 
--from student in '"&server.mappath(".")&"\stumagsys.mdf "&"'
--where 1 = 1
/*ͬһ������������ͬ���ݿ�֮��Ĳ����������ݿ�֮���Ŀ�����
select * into Ŀ�����ݿ�.dbo��ӵ���ߣ�.stu_info_1��������ԭ�����еı��ܳ��֣� 
from Դ���ݿ���.dbo��ӵ���ߣ�.student��������*/
select * into student.dbo.stu_info_1 from StuMagSys.dbo.student

/*��ͬ���������ݿ�֮������ݲ���*/ 
--�������ӷ����� exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', 'Զ�̷���������ip��ַ ' 
--exec sp_addlinkedsrvlogin 'ITSV ', 'false ',null, '�û��� ', '���� ' 
--��ѯʾ�� select * from ITSV.���ݿ���.dbo.���� 
--����ʾ�� select * into �� from ITSV.���ݿ���.dbo.���� 
--�Ժ���ʹ��ʱɾ�����ӷ����� exec sp_dropserver 'ITSV ', 'droplogins ' 
--����Զ��/����������(openrowset/openquery/opendatasource) 
--1��openrowset 
--��ѯʾ�� select * from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����) 
--���ɱ��ر� select * into �� from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����) 
--�ѱ��ر���Զ�̱� insert openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����) select *from ���ر� 
--���±��ر� update b set b.��A=a.��A from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����)as a inner join ���ر� b on a.column1=b.column1 
--openquery�÷���Ҫ����һ������ 
--2�����ȴ���һ�����Ӵ������ӷ����� exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', 'Զ�̷���������ip��ַ ' 
--��ѯ select * FROM openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ') 
--�ѱ��ر���Զ�̱� insert openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ') select * from ���ر� 
--���±��ر� update b set b.��B=a.��B FROM openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ') as a inner join ���ر� b on a.��A=b.��A 
--3��opendatasource/openrowset SELECT * FROM opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=��½��;Password=���� ' ).test.dbo.roy_ta 
--�ѱ��ر���Զ�̱�
/*
SQL Server ��ֹ�˶���� 'Ad Hoc Distributed Queries' �� STATEMENT 'OpenRowset/OpenDatasource' �ķ��ʣ�
��Ϊ���������Ϊ�˷�������ȫ���õ�һ���ֶ����رա�ϵͳ����Ա����ͨ��ʹ�� sp_configure ���� 'Ad Hoc Distributed Queries'��
�й����� 'Ad Hoc Distributed Queries' ����ϸ��Ϣ������� SQL Server ���������е� "��ΧӦ��������"��
*/
exec sp_configure
--insert into aa select * from opendatasource('SQLOLEDB','data source = 192.168.1.5;userid = sa;password=zkbr').xzx.dbo.customer
--����"��ΧӦ��������"
--show advanced option��ֵĬ��Ϊ0
use Store
go
exec sp_configure 'show advanced option','1';

reconfigure;
exec sp_configure
--�޸�"��ΧӦ��������"Ad Hoc Distributed Queries��ֵ,Ĭ��Ϊ0
exec sp_configure 'ad hoc distributed queries','1'
--select * from Store
--where DATEDIFF('5','14:05',GETDATE()) > 5
--������ʹ����Ϊ @find �ľֲ������������������� Man ��ͷ����ϵ����Ϣ
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
--���������������������������۶�����Ϊ $2,000,000 �� Adventure Works Cycles ���۴�������֡�
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
--��ʾǰ��������
select top 3 * from Store_Information
--���ȡ��10������
select top 2 * from Store_Information
order by NEWID();

select * from Store_Information

--���һ��������(����ֵΪ1)
alter table ����
add  ���� int identity(1,1)
--����һ��
alter table Nation add sex char(4)

--{�����������SQL��һ����
	--�г����ݿ������еı���(U�����û���,S����ϵͳ��)
	select name from sysobjects where type = 'U'
	--��ȡ��ǰ���ݿ��е������û���
	select name from sysobjects where xtype = 'U' and status >= 0
--}
--�г���������е�����
--{
select name from syscolumns where id = OBJECT_ID('Store_Information')
select name from syscolumns where id =OBJECT_ID('total_sales')
select name from syscolumns where id  in(select id from sysobjects where type = 'U' and name = 'score')
--������Ч��һ��
--}
create table shop
(
id int not null primary key,
type varchar(100),
vender varchar(50),
pcs bigint,
memo nvarchar(1000),
)
insert into shop values(1,'����','A',1,'')
insert into shop values(2,'����','A',2,'')
insert into shop values(3,'����','B',1,'')
insert into shop values(4,'����','A',2,'')
insert into shop values(5,'����','B',2,'')
insert into shop values(6,'�ֻ�','C',3,'')
insert into shop values(7,'�ֻ�','A',3,'')
insert into shop values(8,'�ֻ�','B',3,'')
insert into shop values(9,'�ֻ�','C',3,'')
select * from shop
--�г�type��vender��pcs�ֶΣ���type�ֶ����У�case���Է����ʵ�ֶ���ѡ������select �е�case
--�г����ֲ�Ʒ�������͵�����
select TYPE,SUM(case vender 
				when 'A' then pcs 
				else 0 end) A��,
			SUM(case vender 
				when 'B' then pcs 
				else 0 end) B��,
			SUM(case vender 
				when 'C' then pcs 
				else 0 end) C��
from shop 
group by type

--��ʼ����table1
--truncate table shop
--ѡ���2��7�ļ�¼(select * from shop)
select top 5 * from (select top 7 * from shop order by id asc) sp
order by id desc

--��SQL�У�"where 1 = 1" �Ǳ�ʾѡ��ȫ��    "where 1 = 2 "ȫ����ѡ

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
--ѹ�����ݿ�
dbcc shrinkdatabase (store)
--ת�����ݿ�����û����Ѵ����û�Ȩ��
--(exec sp_change_users_login 'update_one','newname','oldname'
--go)
exec sp_change_users_login 'update_one','chw','guest'
go
--��鱸�ݼ�
restore verifyonly from disk = 'H:\backup\store.bak'
--�޸����ݿ�
--�����޸����ݿ�ʹ����Ϊ�Լ������û�
--�ڶ����޸����ݿ�
--�����������ݿ�ʹ���߸�Ϊ���û�
alter database store set single_user
go

dbcc checkdb('store',repair_allow_data_loss) with tablock

alter database store set multi_user
go
--��־���
SET NOCOUNT ON
DECLARE @LogicalFileName sysname,
	    @MaxMinutes INT,
		@NewSize INT

USE store -- Ҫ���������ݿ���
SELECT  @LogicalFileName = 'tablename_log', -- ��־�ļ���
@MaxMinutes = 10, -- Limit on time allowed to wrap log.�޶�ʱ��
@NewSize = 1  -- �����趨����־�ļ��Ĵ�С(M)
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
--����ĳ�����ӵ����
exec sp_changeobjectowner 'store_information','dbo'
--�洢���̸���ȫ����

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
--SQL SERVER��ֱ��ѭ��д������
declare @i int
set @i = 1
while @i < 5
begin
    insert into dbo.score(id,name,g_score) values(@i,'zhangsan + @i',57 + @i)
    set @i = @i + 1
end
--Ҫ����ϱ������Л]�м���ĳɿ�����ÿ�����L0.1�Ļ��A�ϣ�ʹ�������ü���

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
--��ʾ���ݿ�����������Ϣ,
exec sp_help store_information
--������ʾ���ݿ�����������Ķ���
exec sp_helptext store_view

create table tb_family_name
(
id int not null primary key,
family_name varchar(50),
content nvarchar(1000),
memo nvarchar(1000),
)

--insert into tb_family_name values(1,'��','�ഫ��ټ��յ�ʱ�򣬹������ԣ������Կ�ͷ','')
--insert into tb_family_name values(2,'Ǯ','����Ͳ��ö�֪��','')
--insert into tb_family_name values(3,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(4,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(5,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(6,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(7,'֣','����Ͳ��ö�֪��','')
--insert into tb_family_name values(8,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(9,'��','����Ͳ��ö�֪��','')
--insert into tb_family_name values(10,'��','����Ͳ��ö�֪��','')
select * from tb_family_name
--�����ϱʻ�����
select * from tb_family_name
order by family_name collate chinese_prc_stroke_ci_as

--���պ���ƴ��������ĸ�����Ľ���
select a1.family_name,COUNT(a2.family_name) rank from tb_family_name a1,tb_family_name a2
where a1.family_name <= a2.family_name
group by a1.family_name
order by /*rank asc,*/a1.family_name desc
--���ݿ����
--create database teacher
--select ENCRYPT('')
select PWDENCRYPT('ԭʼ����') as ԭʼ����
select PWDCOMPARE('','') 
--ȡ�ر����ֶ�
declare @list varchar(1000),
		@sql nvarchar(1000)
select @list = @list + ',' + b.name from sysobjects a,syscolumns b
where a.id = b.id and a.name = '��A'
set @sql = 'select' + RIGHT(@list,LEN(@list)-1) + 'from ��A'
--exec (@sql)
select @list,@sql,b.name from sysobjects a,syscolumns b
where a.id = b.id
--�鿴Ӳ�̷���(exec ���ݿ���..xp_fixeddrives����{exec ..xp_fixeddrives})
exec master..xp_fixeddrives
--�Ƚ�A,B���Ƿ����
if (select CHECKSUM_AGG(BINARY_CHECKSUM(*)) from score)
	=
   (select CHECKSUM_AGG(BINARY_CHECKSUM(*)) from shop)
	print '���'
else
	print '�����'

--ɱ�����е��¼�̽��������
declare hcforeach cursor global for select 'kill' + rtrim(spid) from master.dbo.sysprocesses
where program_name in ('SQL profiler',N'SQL�¼�̽����')
exec sp_MSforeach_worker '?'
--��¼����
--��ѯ���е����������¼������֪��������ж�������,�Լ���ṹ
declare @sql_1 varchar(500),
		@count int
set @sql_1 = 'select top 1 * from store_information where pid not in(select top ' + STR(@count - 1) + 'pid from store_information)'
print @sql_1
exec sp_executesql @sql_1

--�鿴��ĳһ������ص���ͼ���洢���̡�����
select a.* from sysobjects a,syscomments b
where a.id = b.id and b.text like '%store_information%'

select a.* from sysobjects a,syscomments b
where a.id = b.id and b.text like '%total_sales%'
--�鿴��ĳһ������ص���ͼ���洢���̡�����
select name as�洢�������� from sysobjects 
where xtype = 'P'
--��ѯ�û��������������ݿ�(����������䶼����)
select * from master ..sysdatabases D where sid not in(select sid from master ..syslogins where name = 'sa')
select dbid,name as DB_name from master ..sysdatabases where sid <> 0x01 
--��ѯĳһ������ֶκ���������
select column_name,data_type from information_schema.COLUMNS
where TABLE_NAME = 'shop'

�����
--��ͬ���������ݿ�֮������ݲ���
exec sp_addlinkedserver 'ITSV','','SQLOLEDB','192.168.1.5'
exec sp_addlinkedsrvlogin 'ITSV','false',null,'sa','zkbr'
--��ѯʾ��
select * from ITSV.xzx.dbo.tb_customer
--����ʾ��
select * into from ITSV.xzx.dbo.customer
--�Ժ���ʹ��ʱɾ�����ӷ�����
exec sp_dropserver 'itsv','droplogins'
--����Զ��/����������(openrowset/openquery/opendatasource)
--�����ϸ����������ĸ�ʽ����,�����ǡ�,������;�����ǡ�;��

--1��openrowset���÷�
--��ѯʾ�� 
select * from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
--���ɱ��ر�
--(select * into ���ر����ڵı��� from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer))
select * into customer from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
--�ѱ��ر���Զ�̱�
insert openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer)
select * from Store_Information
--���±��ر�
update ���ر�b
set b.��A = a.��A
from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer) as a inner join ���ر�b
on a.column1 = b.column1

--2��openquery�÷�����Ҫ����һ�����ӣ�
--���ȴ���һ�����Ӵ������ӷ�����
exec sp_addlinkedserver 'ITSV','','SQLOLEDB','192.168.1.5'
exec sp_addlinkedsrvlogin 'ITSV','false',null,'sa','zkbr'
--�Ժ���ʹ��ʱɾ�����ӷ�����
exec sp_dropserver 'ITSV','droplogins'
--��ѯ
select * from openquery(ITSV,'select * from xzx.dbo.tb_customer')
--���ɱ��ر�
--(select * into ����(���ز����ڵı�) from openrowset('SQLOLEDB','192.168.1.5';'sa';'zkbr',xzx.dbo.tb_customer))
select * into customer from openquery(ITSV,'select * from xzx.dbo.tb_customer')
--�ѱ��ر���Զ�̱�
insert openquery(ITSV,'select * from xzx.dbo.tb_customer')
select * from ���ر�
--���±��ر�
update ���ر�b
set b.��B = a.��B
from openquery(ITSV,'select * from xzx.dbo.tb_customer') as a inner join  ���ر�b on a.��A = b.��A

--3��opendatasource/openrowset ��ʹ�÷���
/*
SELECT   * 
FROM   opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=��½��;Password=���� ' ).���ݿ���.dbo.����
*/
select * from 
opendatasource('SQLOLEDB','data source = 192.168.1.5;user ID = sa;password = zkbr').xzx.dbo.tb_customer
--�ѱ��ر���Զ�̱�
/*
insert opendatasource( 'SQLOLEDB ',  'Data Source=ip/ServerName;User ID=��½��;Password=���� ').���ݿ�.dbo.���� 
select * from ���ر�
*/
insert opendatasource('SQLOLEDB','data source = 192.168.1.5,user ID = sa;password = zkbr').xzx.dbo.tb_customer
select * from ���ر�
�����
--�ַ�������
--�ַ���ռ�õĿռ�
select store_name,DATALENGTH(store_name) ��ռ�ÿռ� from Store_Information
select family_name,DATALENGTH(family_name) ��ռ�ÿռ� from tb_family_name
--�ַ��ĳ���
select family_name,LEN(family_name) �ַ����� from tb_family_name
--��customerNO�ַ���һλ��ʼȡ3λ
select customerNo,SUBSTRING(customerNO,1,3) from customer
--ȫ��ȡ���ַ���
select customerNo,SUBSTRING(customerNO,1,LEN(customerNO)) ȫ���ַ��� from customer
--use store
--select * from Customer
--ȡ���ַ������ұߵĵ�һλ�ַ�
select customerNO,RIGHT(customerNo,2) �ұ߿�ʼȡ��λ�ַ� from customer
select customerNO,LEFT(customerNO,3) ��߿�ʼȡ��λ�ַ� from customer
--isnull( check_expression , replacement_value )���check_expression��գ��t����replacement_value��ֵ��
--����գ��ͷ���check_expression�ַ�
select ISNULL(customerNO,0) from customer






