create or replace procedure write2blob(p_id        in number, --id
                                       p_blob_data in blob,
                                       p_msg       out varchar2) --数据
 is
  v_lobloc     blob; --目标blob字段
  v_blob_data  blob; --作为接受参数的字段，参数变量不能直接拿来赋值
  v_amount     binary_integer; --总长度
  v_sub_length binary_integer; --一次读取的最大长度，不超过32766
  v_sub_blob   blob; --一次读取的子串
  v_offset     binary_integer; --游标
  v_err_msg    varchar2(1000); --测试用
  v_id         binary_integer; --要修改或新增的记录ID
  v_temp       binary_integer; --临时变量用于判断是否有v_id对应的记录
begin
  v_amount     := length(p_blob_data);
  v_blob_data  := p_blob_data;
  v_sub_length := 32767;
  v_offset     := 1;
  v_id         := p_id;
  v_temp       := 0;
  --execute immediate v_query_string into v_lobloc;
  select count(1) into v_temp from a where id = v_id;  --查询是否有v_id对应的记录，并且赋值给v_temp
  /*注意：无论是修改还是新增，blob字段都需要用empty_blob()进行初始化，否则后边的blob内容，不能写进表里*/
  /***************************这里为了演示异常信息，把if else判断给注释掉了********************/
  /*if v_temp = 0 then
    insert into a (id, img) values (v_id, empty_blob()); --如果v_temp为0新增
  else
    update a set img = empty_blob() where id = v_id; --如果v_temp为1修改
  end if;
  */
  commit;
  select img into v_lobloc from a where id = v_id for update;
  if v_amount > v_sub_length then
    --dbms_lob.open(v_lobloc, dbms_lob.lob_readwrite);
    while v_offset < v_amount loop
      dbms_lob.read(v_blob_data, v_sub_length, v_offset, v_sub_blob); --把读到的内容放到v_sub_blob中
      dbms_lob.writeappend(v_lobloc,
                           --DBMS_LOB.GETLENGTH(v_sub_blob),
                           length(v_sub_blob),
                           v_sub_blob); --写入v_lobloc,该变量已经在之前和sql语句绑定
      v_offset  := length(v_sub_blob) + v_offset; --游标移动
      v_err_msg := length(v_lobloc);
    end loop;
  else
    dbms_lob.writeappend(v_lobloc, v_amount, v_blob_data); --若是小鱼32766直接写入
  end if;
  commit;
  dbms_lob.close(v_lobloc);
exception
  when others then
    p_msg := sqlcode || sqlerrm;
    --p_msg := v_err_msg;
    rollback;
end;