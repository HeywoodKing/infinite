select * from Savedruginfo

select * from Savedrugrecord

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,r.TimePoint from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID and r.ExecuteTime = to_date('2012-5-10','yyyy-mm-dd')

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,
case r.TimePoint as am
  when '����' then '1'
  else 'no'
end from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID 
and to_date(to_char(r.executetime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')

--when cast('����' as nvarchar2(10)) then '����'
--when cast('��ҹ' as nvarchar2(10)) then '��ҹ'
--when cast('��ҹ' as nvarchar2(10)) then '��ҹ'

/*
when trim(r.timepoint)='����' then '����'
  when trim(r.timepoint)='���' then '���'
  when trim(r.timepoint)='����' then '����'
  when trim(r.timepoint)='��ҹ' then '��ҹ'
  when trim(r.timepoint)='��ҹ' then '��ҹ'
*/

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,--r.TimePoint
--select id,savedrugID,
(case
       when trim(r.timepoint)='����' then '����'
       else ' ' 
end) am,
(case
     when trim(r.timepoint)='���' then '���'
     else ' '
end) noon,
(case
       when trim(r.timepoint)='����' then '����'
       else ' '
end) pm,
(case
     when trim(r.timepoint)='��ҹ' then '��ҹ'
     else ' '
end) amnight,
(case
     when trim(r.timepoint)='��ҹ' then '��ҹ'
     else ' '
end) pmnight
from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID

--from SaveDrugRecord r 
/*
select * from SaveDrugRecord for update

select * from savedrugrecord for update 
*/

select * from 
select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,
(case when trim(r.timepoint) = '����' then '����' else '' end) am,
(case when trim(r.timepoint) = '���' then '���' else '' end) noon,
(case when trim(r.timepoint) = '����' then '����' else '' end) pm,
(case when trim(r.timepoint) = '��ҹ' then '��ҹ' else '' end) amnight,
(case when trim(r.timepoint) = '��ҹ' then '��ҹ' else '' end) pmnight 
from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID 
and to_date(to_char(r.ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')



select hls_f_IsSaveDrugChecked('����',sdi.id,'2012-5-10',0) as am,hls_f_IsSaveDrugChecked('���',sdi.id,'2012-5-10',0) as noon,
hls_f_IsSaveDrugChecked('����',sdi.id,'2012-5-10',0) as pm,hls_f_IsSaveDrugChecked('��ҹ',sdi.id,'2012-5-10',0) as amnight,
hls_f_IsSaveDrugChecked('��ҹ',sdi.id,'2012-5-10',0) as amnight,
sdi.id,sdi.drugcode,sdi.drugname,sdi.dosage,sdi.radix from SaveDrugInfo sdi
--,SaveDrugRecord r where r.savedrugid = sdi.id

select * from savedrugrecord
where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')

/*
select * from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='����' and savedrugid=25 

select count(*) from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='���' and savedrugid=25 

select * from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='����' and savedrugid=25 
*/

select id,status from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='����'





