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


