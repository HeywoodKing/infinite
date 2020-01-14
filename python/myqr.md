


1. 安装myqr
在安装之前，你需要保证电脑里已经安装python 3.x，这是基本环境。并且本文是在windows中实验的，其它系统大同小异，问题处请自研解决喽

安装myqr和安装普通的python一样，很简单，使用pip安装即可

在命令行键入：
```
pip install myqr 
```

2. 使用方式
该库在命令行中运行，你只需要传递网址链接、图片地址等参数，就可以生成相应的二维码，二维码图片默认保存在当前目录下面。命令行输入格式：
```
myqr  网址链接
```
比如：
```
myqr https://zhuanlan.zhihu.com/pydatalysis 
```
再按enter键执行，就能生成对应链接的二维码了。


3. 制作普通二维码
普通二维码就是常见的的二维码
普通二维码只需在命令行输入：myqr + 链接参数
```
myqr https://zhuanlan.zhihu.com/pydatalysis 
```
改变二维码边长
你可以通过输入边长参数 '-v'，改变二维码的尺寸
```
myqr https://zhuanlan.zhihu.com/pydatalysis -v 10
```
-v 控制边长，范围是1至40，数字越大边长越大

对二维码图片命名
参数 '-n'可以对生成的二维码图片重命名
```
myqr https://zhuanlan.zhihu.com/pydatalysis -v 10 -n pydatas.jpg 
```
设置二维码图片保存地址
参数'-d'可以定义二维码图片的保存位置，比如我要保存在c:\picture\
```
myqr https://zhuanlan.zhihu.com/pydatalysis -v 10 -n pydatas.jpg -d c:\picture\
```

4. 制作艺术二维码
艺术二维码是融合了静态图片的二维码

怎么融合图片呢？很简单，传入图片地址参数'-p'

比如说我d盘有一张海绵宝宝的图片，地址是：d:\hmbb.jpg即传入参数'-pd:\hmbb.jpg'在命令行键入：
```
myqr https://zhuanlan.zhihu.com/pydatalysis -p d:\hmbb.jpg
```
执行就能生成上图的海绵宝宝主题二维码了

你会发现怎么是黑白的呢？如何变成漂亮的彩色？

也很简单，在图片地址参数'-d'后面加上色彩参数'-c'，就能使黑白变彩色了
```
myqr https://zhuanlan.zhihu.com/pydatalysis -p d:\hmbb.jpg -c
```
你还可以添加对比度参数和亮度参数，来调节艺术二维码图片的视觉效果：

参数 -con 用以调节图片的对比度，1.0 表示原始图片，更小的值表示更低对比度，更大反之。默认为1.0。
参数 -bri 用来调节图片的亮度，其余用法和取值与 -con 相同。
尺寸调节、图片位置设置等参数和普通二维码一样哦！

5. 制作动态二维码
动态二维码是艺术二维码的一种，不过它是可动的

动态二维码的制作和艺术二维码一样，这里不做赘述，只需要传入的图片是gif格式，输出二维码图片也是gif格式


eg:
```
myqr https://heywoodking.github.io/ -n me_blog.gif -p bg.gif -v 7 -c
```
