# pandas






#### 疑难杂症

#### 1. pandas 读取csv Error tokenizing data. C error: EOF inside string starting
解决方法：
csv文件默认的是以逗号为分隔符，但是中文中逗号的使用率很高，爬取中文数据时就容易造成混淆，所以使用pandas写入csv时可以设置参数 sep=’\t’ ，即以tab为分隔符写入。毕竟tab在中文习惯里用的很少嘛。
那这样在后面读取csv进行数据处理时，一定记得加上一个参数delimiter

df = pd.read_csv(csvfile, header = None, delimiter="\t", quoting=csv.QUOTE_NONE, encoding='utf-8');
df = pd.read_csv('path',delimiter="\t")


#### 2.pandas tuple indices must be integers or slices, not str
```
df = pd.read_sql("select ...", con=conn)

for row in df.itertuples(index=True, name='pandas'):
	getattr(row, 'category_id')
	getattr(row, 'id')  # 正确用法
	row['id']  # tuple indices must be integers or slices, not str
```


#### 3.ValueError: The truth value of a DataFrame is ambiguous. Use a.empty, a.bool(), a.item(), a.any() or a.all()
```

```


#### 4.TypeError: 'int' object does not support item assignment
```

```

#### 5.'gbk' codec can't decode byte 0x80 in position 4: illegal multibyte sequence 或者 'gbk' codec can't encode character '\xae'
```

```


#### 6.'pandas' object has no attribute '供应商器件封装'
```
检测列是否存在
if 'A' in df:

但为了清楚起见，我可能会将它写为：
if 'A' in df.columns:

要检查是否存在一列或多列，可以使用set.issubset，如下所示：
if set(['A','C']).issubset(df.columns):
   df['sum'] = df['A'] + df['C']

set([])也可以用大括号来构造：
if {'A', 'C'}.issubset(df.columns):
```

#### 7.ParserError：Error tokenizing data.C error:Expected 2 fields in line 407,saw 3
```
pandas.read_csv(filePath) 方法来读取csv文件时，可能会出现这种错误：
ParserError：Error tokenizing data.C error:Expected 2 fields in line 407,saw 3
是指在csv文件的第407行数据，期待2个字段，但在第407行实际发现了3个字段。

原因：header只有两个字段名，但数据的第407行却出现了3个字段（可能是该行数据包含了逗号，或者确实有三个部分），导致pandas不知道该如何处理。

解决办法:把第407行多出的字段删除，或者通过在read_csv方法中设置error_bad_lines=False来忽略这种错误：
改为pandas.read_csv(filePath,error_bad_lines=False)
来忽略掉其中出现错乱(例如，由于逗号导致多出一列)的行。
```

