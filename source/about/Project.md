
---
title: Project List
date: 2020-02-02 22:22:22
---

### Tech

#### bash
路由器自动更新防火墙脚本

#### Python
中国人民银行网站公告爬虫，及时获取相关公告。

#### C++

#### Swift， Ojbective-C

#### JavaScript， TypeScript

#### Vue

#### Electron, Node.js

#### OpenGL


### ZeroZero Robotics
* 视频主要为视频自动剪辑 & 手动剪辑 & 配乐，基于 AVFoundation 框架完成。  
* 图片后期处理包含裁剪、旋转等操作，前端交互生成相关参数于 OpenGL 中处理并输出图片。  
* 供图片、视频处理使用的滤镜模块，基于 OpenGL ES 完成。  
* 制作了供设计师使用的滤镜「设计」工具，设计师可以使用类似于 Photoshop 的操作，调配出合适的滤镜，输出 shader 供 iOS & Android 的滤镜模块调用。逆向了部分 Photoshop 的图像处理功能。

### 项目经历

#### 硬件测试管理系统

#### 硬件测试上位机软件

#### 无人机平台智能跟踪框架

#### Siamese-FC 目标跟踪网络的性能优化

依据 [论文](http://www.robots.ox.ac.uk/~luca/siamese-fc.html) 尝试优化此网络，使得网络可以在高通 8096 平台以 30 帧运行。  
主要方案为使用 [MobileNet](https://arxiv.org/abs/1704.04861) 替换原有网络结构。

该项目主要工作为模型修改、训练、调参。最后完成的版本平均覆盖率为 57.3%.(原本 68%)

#### 照片智能滤镜

依据公开的 [论文](http://people.ee.ethz.ch/~ihnatova/) 及相关实现，学习了机器学习相关知识，将训练好的 model 转换为 CoreML model，在手机上成功运行智能滤镜算法。   
之后拍摄一系列照片，使用 openCV 进行预处理，构建数据集，训练出适用于 HoverCamera 的 model。

由于该算法输出的照片质量并不好，最终放弃。该项目基本上入门机器学习，主要使用 tensorflow 进行训练、优化，并了解了 CoreML 及相关工具链。

#### HoverCamera 图片视频后期功能

视频处理为基于 AVFoundation 完成的视频裁剪、拼接、合成模块。包含视频模板、简单转场、音乐结尾渐弱等功能。分为自动剪辑和手动剪辑两种模式。  
通过该项目了解了 AVFoundation 框架的使用。

图片处理的操作类似于 iPhone 相册的裁剪功能，用户操作后使用相关参数交由滤镜模块输出处理后的图像。  

#### HoverCamera 滤镜模块
供视频剪辑模块、图片处理模块调用的滤镜库。基于 OpenGL ES 2.0。滤镜来源部分参考 GPUImage 的实现，并针对性的做调整，使其效果尽量与 photoshop 接近。部分滤镜为逆向 photoshop 的效果，使用函数拟合，并使用 shader 实现。  

通过该项目了解到 shader 的一些基础知识，可以写一些简单的 shader 代码。针对 OpenGL 部分的实现，主要参考了 GPUImage。

#### HoverCamera 滤镜设计工具   
macOS 软件，包含一些 photoshop 中常用的操作，如：曲线、色相饱和度、可选颜色等操作，设计师甚至可以在 photoshop 中调整这些参数，在工具中使用用相同参数验证效果，并可直接生成 shader 文件，iOS 与 Android 可部署上线，无需再做其它调整。  

通过该项目了解到 macOS 软件的开发，OpenGL 部分主要借助 GPUImage 完成。

#### HoverCamera 直播模块
为飞机实时传回手机的图像加入 Facebook Live 功能，可以一键打开 Facebook 直播的功能，将飞机上的视频和手机麦克风收到的声音推至 facebook。  
RTMP 推流基于 HaishinKit.swift 修改而来。  

通过该项目了解到一些直播时的技术手段。

#### bong iOS app & bong SDK
负责 bong app 的新产品、新功能的适配、开发工作。主要为蓝牙通讯模块兼容，通常的业务功能开发，迭代等。项目以 MVVM 为基础架构，并引入 RxSwift。自己实现大量定制化 UI 界面及动画效果并力求尽量减少第三方库依赖。主要使用 Swift 进行开发。  

封装 bong SDK 主要方便第三方厂商接入 bong 手环，无需蓝牙知识，即可实现将 bong 手环通信，数据处理等功能接入 app 。

负责 bong Classic 的维护，主要使用 Objective-C 进行开发。

主要技术点：

 * MVVM、RxSwift、Protocol、Extension、函数式等。
 * 网络，多线程编程, UI 控件定制，动画，地图，蓝牙，iHealth，数据持久化，国际化等
 * 持续集成 Jenkins + Fastlane
 * 内测分发，Crash 统计分析等
 * 熟练使用 Reveal、Charles 等调试工具，熟悉 Instruments 的使用

---
### 教育经历

#### 2009 - 2013 南京工业大学  
无机非金属材料科学与工程
