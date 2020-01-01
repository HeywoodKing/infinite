# Python 打包发布pypi流程


### 构建源码包
```
python setup.py sdist build
这样在当前目录的dist文件夹下，就会多出一个以tar.gz结尾的包
```

### 构建预览发行包
```
python setup.py bdist
```

### 构建whl包
```
python setup.py bdist_wheel --universal

这样会在dist文件夹下生成一个whl文件
```


### 发布到pypi
```
python setup.py sdist upload
python setup.py bdist_wheel upload
```
以上方法不推荐，因为使用setuptools上传时，你的用户名和密码是明文或者未加密传输，安全起见还是使用twine吧


### 发布到pypi(twine)
```
pip3 install twine -i https://pypi.douban.com/simple
或
pipenv install twine

twine upload dist/* --repository pypi
twine upload dist/* --repository pypitest

twine upload dist/* --repository-url https://upload.pypi.org/legacy
twine upload dist/* --repository-url https://test.pypi.org/legacy
```



