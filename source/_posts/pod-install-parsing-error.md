---
title: gRPC Pod install/update 时 parsing error 的处理
date: 2018-03-28 16:44:41
tags: 
    - CocoaPods
    - iOS
---

 **Update: 这个问题已经在 CodoaPods v1.5.0 中修复，见[这个 PR](https://github.com/CocoaPods/Core/pull/438)。**
 
 要想让自己的库排在前面，放心添加特殊符号

---------

最近在使用 [gRPC](https://grpc.io) 时，在 iOS 项目下，多次 `pod install` 或 `update` 时，会出现 `Podfile.lock` 解析错误的问题：

console 输出：

```
[!] ERROR: Parsing unable to continue due to parsing error:

...

```

这个问题在 [github](https://github.com/grpc/grpc/issues/12172) 上也有人反馈。

研究了一番，发现是这么个事情：

gRPC 的 proto 文件编译时，为了方便开发者，将 `ProtoCompiler` 项目用 pod 的形式引入。

为了让 `ProtoCompiler` 以及所需要的插件 `ProtoCompiler-gRPCPlugin` 在编译自己 proto 文件前下载好，需要保证 cocoapods 处理完依赖关系时，让这两个库排在前面。grpc 的做法是在这俩库名字前添加一个感叹号，所以我拉看到的就是 `!ProtoCompiler` 和 `!ProtoCompiler-gRPCPlugin`.

万万没想到，这导致了 YAML 无法解析这个字符串，YAML 解析可以在[这里测试](http://www.yamllint.com)

经过一番测试，不影响 YAML 解析，且能使排序到最前的特殊符号是 `=` 和 `+`

所以我们只需要使用一个私有的 Pod Spec , 将 `ProtoCompiler` 和 `ProtoCompiler-gRPCPlugin` 添加前缀 `=` 上传到私有库即可（`+ 我并未完整测试`）。



