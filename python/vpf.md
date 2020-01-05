# VPF


## Python 中的硬件加速视频处理框架 VPF
VPF 是基于 CMake 的开源跨平台框架，它依赖于 FFmpeg 库来进行（de）muxing 和 pybind11 项目从而构建 Python 绑定。它包含了一组开源的 C ++库和 Python 绑定，可与其封闭源代码 Codec SDK 进行交互。

该框架的主要功能是简化从 Python 开发 GPU 加速视频编码/解码的过程，可为视频处理任务（例如解码，编码，代码转换以及 GPU 加速的色彩空间和像素格式转换）提供完整的硬件加速。

尽管 Python 不是性能最高的语言，但它易于使用；在 NVIDIA 发布此视频处理框架之后，它相当于在现有 Video Codec SDK C ++ 堆栈周围的 Python wrapper，将用于在 Kepler 及更高版本上基于 GPU 的视频编码/解码。这使得 VPF 在利用基于 GPU 的高性能视频加速的同时，也获得了易于阅读/编写的代码



[Github](https://github.com/NVIDIA/VideoProcessingFramework "GitHub")

VPF 使用类说明

VPF 中包含了多个类，其核心部分是 PyNvDecoder 和 PyNvEncoder 类，它们是与 NVIDIA Video Codec SDK 的 Python 绑定。

PyNvDecoder 和 PyNvEncoder 类支持 NV12 像素格式，所有转换均通过 GPU 加速，并在 VRAM 内存中完成，以提高性能。其中——

PyNvDecoder 类有五个主要方法：

DecodeSingleSurface 从输入视频解码单帧，返回带有解码像素的 Surface。下次用户调用此方法时，先前返回的 Surface 可能会被重用。如果未解码帧，则解码后的 Surface 的 GetCudaDevicePtr 方法将返回零；
DecodeSingleFram 从输入视频解码单帧，返回带有解码像素的 NumPy 数组。下次用户调用此方法时，将返回另一个 NumPy 数组实例。如果未解码帧，它将返回空的 NumPy 数组。此操作将设备复制到主机内存；
Width 返回解码的帧宽度；
Height 返回解码的帧高度；
PixelFormat 返回解码的帧像素格式。
用户使用 DecodeSingleSurface 和 DecodeSingleFrame 时，不会破坏解码器的内部状态。解码器类支持 H.264 和 H.265 编解码器。

PyNvEncoder 类有六个方法：

EncodeSingleSurface 以原始像素获取 NV12 Surface，对其进行编码，然后将基本视频比特流作为 NumPy 数组返回。编码器是异步的，因此此方法可能会在前几次调用时返回空数组（取决于编码器设置），这不是编码错误；
EncodeSingleFrame 以原始像素获取 NumPy 数组，对其进行编码，然后将基本视频比特流作为 NumPy 数组返回。编码器是异步的，因此此方法可能在前几次调用时返回空数组（取决于编码器设置）；
Flush 冲洗编码器。除非编码器队列中的所有原始帧都已编码，否则它不会返回，并返回带有基本流字节的 NumPy 数组的列表；
Width 返回编码的帧宽度；
Height 返回编码的帧高度；
PixelFormat 返回编码的帧像素格式。
如果用户使用 EncodeSingleSurface 和 EncodeSingleFrame，则不会破坏编码器的内部状态。此外，PyNvEncoder 可以获取任意分辨率的输入帧，并在实际编码之前即时在 GPU 上调整其大小。

编码器类支持 H.264 和 H.265 编解码器，并且具有较低的延迟，因此在编码会话结束时，应调用 Flush 刷新编码器帧队列。

HardwareSurface 类包含一个包装器 CUdeviceptr：

GetCudaDevicePtr 将 CUdeviceptr 返回到 CUDA 内存对象。
对于主机和设备之间的内存传输，有两个名为 PyFrameUploader 和 PySurfaceDownloader 的类：

PyFrameUploader 用于将 NumPy 数组上传到 GPU；
UploadSingleFrame 将一个 numpy 数组上传到 GPU，再将句柄返回到上传的 Surface。下次用户调用此方法时，先前返回的 Surface 可能会被重用。
PySurfaceDownloader 类用于从 GPU 下载 Surface，它只包含一种方法：

DownloadSingleSurface 将 GPU 端 Surface 下载到 CPU 端 numpy 数组中。下次用户调用此方法时，将返回另一个 numpy 数组实例。
PySurfaceConverter 类用于 GPU 加速的色彩空间和像素格式转换。以下是受支持的转化列表：

YUV420 至 NV12
NV12 到 YUV420
NV12 转 RGB
PySurfaceConverter 类包含一种方法：

Execute 在 GPU 上执行转换，将句柄以输出格式返回给 Surface。下次用户调用此方法时，先前返回的 Surface 可能会被重用。
而 VPF 运行的主要数据类型有两种：

用于 CPU 端数据的 NumPy 数组；
用户透明 Surface 类，表示 GPU 端数据；
由于 GPU 端内存对象分配很复杂，并且会严重影响性能，因此所有归还 Surface，并在下次调用时重用先前返回的 VPF 类方法。

与此不同的是，VPF 类方法每次被调用时都会返回新的 NumPy 数组实例。移动构造函数可避免内存复制的运行成本。

其它开源视频处理框架

一、RxFFmpeg

RxFFmpeg 是基于 ( FFmpeg 4.0 + X264 + mp3lame + fdk-aac ) 编译的适用于 Android 平台的音视频编辑、视频剪辑的快速处理框架。

包含：视频拼接，转码，压缩，裁剪，片头片尾，分离音视频，变速，添加静态贴纸和 gif 动态贴纸，添加字幕，添加滤镜，添加背景音乐，加速减速视频，倒放音视频，音频裁剪，变声，混音，图片合成视频，视频解码图片等主流特色功能。

RxFFmpeg 开源地址：https://github.com/microshow/RxFFmpeg
![RxFFmpeg](https://pics2.baidu.com/feed/960a304e251f95ca92e291bd8959803b6709527d.png?token=b6a368dde41eed03bdf81ffa9a6df552&s=511ACC33C66266AA0C6541D00300D0E2 "RxFFmpeg")


二、VidGear

VidGear 是一个围绕 OpenCV 视频 I/O 模块的轻量级 python 包装器，它使用多线程 Gears（又名 API）构建，每个都有独特的开拓性功能。

这些 API 提供了易于使用，高度可扩展的多线程包装器，这些包装器围绕着许多底层的最新 python 库，例如 OpenCV，FFmpeg，picamera，pafy，pyzmq 和 python-mss ，可以在各种设备和平台上实现高速视频帧读取功能 。它也是 imutils 库视频模块的重新实现，修复了所有主要错误，并附带了直接网络流支持。

VidGear 开源地址：https://pypi.org/project/vidgear/
![VidGear](https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4270143090,639572889&fm=173&app=25&f=JPG?w=504&h=281&s=6BA438627FB04FA124DC7C5C03001032 "VidGear")


VPF 博客地址：https://devblogs.nvidia.com/vpf-hardware-accelerated-video-processing-framework-in-python/
