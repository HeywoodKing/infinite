select * from Savedruginfo

select * from Savedrugrecord

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,r.TimePoint from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID and r.ExecuteTime = to_date('2012-5-10','yyyy-mm-dd')

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,
case r.TimePoint as am
  when '上午' then '1'
  else 'no'
end from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID 
and to_date(to_char(r.executetime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')

--when cast('下午' as nvarchar2(10)) then '下午'
--when cast('上夜' as nvarchar2(10)) then '上夜'
--when cast('下夜' as nvarchar2(10)) then '下夜'

/*
when trim(r.timepoint)='上午' then '上午'
  when trim(r.timepoint)='午班' then '午班'
  when trim(r.timepoint)='下午' then '下午'
  when trim(r.timepoint)='上夜' then '上夜'
  when trim(r.timepoint)='下夜' then '下夜'
*/

select i.id,i.DrugCode,i.DrugName,i.Dosage,i.Radix,r.ExecuteTime,--r.TimePoint
--select id,savedrugID,
(case
       when trim(r.timepoint)='上午' then '上午'
       else ' ' 
end) am,
(case
     when trim(r.timepoint)='午班' then '午班'
     else ' '
end) noon,
(case
       when trim(r.timepoint)='下午' then '下午'
       else ' '
end) pm,
(case
     when trim(r.timepoint)='上夜' then '上夜'
     else ' '
end) amnight,
(case
     when trim(r.timepoint)='下夜' then '下夜'
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
(case when trim(r.timepoint) = '上午' then '上午' else '' end) am,
(case when trim(r.timepoint) = '午班' then '午班' else '' end) noon,
(case when trim(r.timepoint) = '下午' then '下午' else '' end) pm,
(case when trim(r.timepoint) = '上夜' then '上夜' else '' end) amnight,
(case when trim(r.timepoint) = '下夜' then '下夜' else '' end) pmnight 
from SaveDrugRecord r,SaveDrugInfo i where i.id = r.SaveDrugID 
and to_date(to_char(r.ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')



select hls_f_IsSaveDrugChecked('上午',sdi.id,'2012-5-10',0) as am,hls_f_IsSaveDrugChecked('午班',sdi.id,'2012-5-10',0) as noon,
hls_f_IsSaveDrugChecked('下午',sdi.id,'2012-5-10',0) as pm,hls_f_IsSaveDrugChecked('上夜',sdi.id,'2012-5-10',0) as amnight,
hls_f_IsSaveDrugChecked('下夜',sdi.id,'2012-5-10',0) as amnight,
sdi.id,sdi.drugcode,sdi.drugname,sdi.dosage,sdi.radix from SaveDrugInfo sdi
--,SaveDrugRecord r where r.savedrugid = sdi.id

select * from savedrugrecord
where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')

/*
select * from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='上午' and savedrugid=25 

select count(*) from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='午班' and savedrugid=25 

select * from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='下午' and savedrugid=25 
*/

select id,status from SaveDrugRecord where to_date(to_char(ExecuteTime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('2012-5-10','yyyy-mm-dd')
and timepoint='上午'





