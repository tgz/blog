---
title: xcrun error SDK "xx" cannot be locateed 解决
date: 2018-05-08 17:21:46
tags: [iOS]
---

升级至 Xcode9 后，有人在使用 ffmpeg 时遇到编译错误，关键报错为：

```
xcrun: error: SDK "iphoneos" cannot be located
```

很显然，xcrun 找不到 sdk 了。
验证一下：
  
```
xcrun -k --sdk iphoneos --show-sdk-path

#输出：
xcrun: error: SDK "iphoneos" cannot be located
xcrun: error: SDK "iphoneos" cannot be located
xcrun: error: unable to lookup item 'Path' in SDK 'iphoneos'
```

解决起来很简单,执行以下命令即可修复：

```
sudo xcode-select --switch /Applications/Xcode.app
```



