---
title: appcenter.ms 初体验
date: 2019-01-12 12:37:21
tags: CI
---

最近发现微软的一个服务： [AppCenter](https://appcenter.ms) ，是微软收购 HockeyApp 后的「新形态」。

![](http://cdn.imqsc.xyz/appcenter.ms.jpg)

它集成了 app 开发人员常用服务的解决方案，包含常用的 CI/CD， 错误收集， 用户统计，测试等，具体可以看 [官网介绍](https://docs.microsoft.com/zh-cn/appcenter/)

做 iOS 的同学，每次发布版本，要编译，上传 AppStore， 这个过程比较漫长，使用工具自动化这个过程，解决生产力是必须的。AppCenter 免费账户每月有 240 min 的编译时间，对更新不是很频繁的项目应该也是够用的。

> 这里有个坑，免费账户，每次编译限制为 30 min, 付费后也只有 60 min，对于每次 archive 时间很长的项目不适用，需要注意。

![appcenter-build-time-limit](http://cdn.imqsc.xyz/appcenter-build-time-limit.jpg)
## Level1
AppCenter 使用起来非常简单，关联一下 GitHub 帐号，选择项目即可，它会加载所有的分支
![appcenter-project](http://cdn.imqsc.xyz/appcenter-project.jpg)
点击相应分支右侧的齿轮打开配置，简单明了：
选择项目文件，再选择相应的 Scheme 
![appcenter-build-config1](http://cdn.imqsc.xyz/appcenter-build-config1.jpg)

接着配置一下签名使用的证书、pp文件
![appcenter-build-sign](http://cdn.imqsc.xyz/appcenter-build-sign.jpg)

可以配置发布到 iTunesConnect。
![appcenter-connect-Store](http://cdn.imqsc.xyz/appcenter-connect-Store.jpg)

![appcenter-select-tea](http://cdn.imqsc.xyz/appcenter-select-team.jpg)

![appcenter-connect-app2](http://cdn.imqsc.xyz/appcenter-connect-app2.jpg)

不得不说，微软真是太贴心了，用起来非常傻瓜。

AppCenter 会自动检测 podfile.lock 以及 Carthfile.resolved 
如果你只用了 Cocoapods、Carthage，并且直接配置上传 iTunesConnect 的话，项目上什么都不需要修改，这个自动构建并上传 iTunesConnect 配置就做完了。

而且得益于服务器位置的原因，上传 iTunesConnect 也非常快
![appcenter-build-success](http://cdn.imqsc.xyz/appcenter-build-success.jpg)


## Leve2 使用脚本，预处理&上传内测
如果有其它脚本，或者需要有 fastlane 命令等情况，以及编译后需要上传内测的情况，可以有三处 build-script 配置：
* appcenter-post-clone.sh
* appcenter-pre-build.sh
* appcenter-post-build.sh

顾明思义，此处不在缀述，用法也非常简单，就是三个 shell 脚本。
比如我的 post-clone：

```shell
#!/usr/bin/env bash
#since carthage build time too long, download the pre build files
echo "" > Cartfile
echo "" > Cartfile.resolved
ls -al
curl -L -o Carthage.zip https://api.onedrive.com/v1.0/shares/s\!AhJsHmAuYQjqgP9Wfu-cwJxkm9ALUQ/root/content
unzip Carthage.zip
```

以及编译后进行上传 pgyer.com 的操作：

```shell post-build.sh
#!/usr/bin/env bash

FILE_PATH=$APPCENTER_OUTPUT_DIRECTORY/$APPCENTER_XCODE_SCHEME.ipa
echo "upload file: $FILE_PATH"
curl \
    -F "file=@$FILE_PATH" \
    -F "uKey=$PGYER_USER_KEY" \
    -F "_api_key=$PGYER_API_KEY" \
    https://www.pgyer.com/apiv1/app/upload

```

这里可以用一些环境变量，关于 build-script 更多的说明, [见文档](https://docs.microsoft.com/zh-cn/appcenter/build/custom/scripts/)

## Level3 使用编译好的 Carthage build
刚才有说到，免费项目有 30 min 的限制，主要是因为我这里使用了大量的 swift 第三方库，如果全部是 cocoapods，一次全量编译需要大概 1 小时左右，后来几乎把所有的库都换成了 Carthage 方案，这样本地只要一次 `carthage bootstrap` ，后面编译基本在 15 分钟左右可以完成。

现在在 AppCenter 上也遇到了这个问题。
于是怎么办？让它去下载 Carthage 编译出来的 framework 呗。

说干就干：

打包 Carthage 目录：
```shell
zip -9 -r --exclude=*Checkouts* Carthage.zip Carthage
```
将 Carthage.zip 上传至网盘。
考虑到 AppCenter 是微软的服务，这里也用微软的网盘吧！

把 Carthage.zip 上传至 OneDrive 后，点击分享，得到分享链接，形如：
`https://1drv.ms/u/s!AhJsHmAuYQjqgP9Wfu-cwJxkm9AAAA`

怎么在使用 wget/curl 下载 OneDrive 分享呢？

经过一翻 google， 得到下面的方案：
将分享链接最后的 s!xxx
填进 `https://api.onedrive.com/v1.0/share/s\!{xxx}/root/content`

```bash 
wget https://api.onedrive.com/v1.0/shares/s\!AhJsHmAuYQjqgP9Wfu-cwJxkm9ALUQ/root/content
```

于是，appcenter-pose-clone.sh 脚本变成之前那个样子

> 注意，appcenter 在开始的时候会检测 Cartfile.resolved 文件，如果存在，就会有 carthage 的流程，所以我把 carthage 的两个文件内容置空。「删除文件无效，会报找不到文件的错」

还有一些注意点：我这个项目使用了 [SwiftGen](https://github.com/SwiftGen/SwiftGen) 自动生成一些代码，需要将自动生成的代码添加到项目内
>「appcenter 的机器还不支持 swiftgen ，当然，给它的构建节点装个 swfitgen 也是条路子」

## Other Resources
[AppCenter 构建节点系统软件环境](https://docs.microsoft.com/en-us/appcenter/build/software)

[和 Azure DevOps Pipeline 对比](https://docs.microsoft.com/en-us/appcenter/build/choose-between-services)

[Visual Studio App Center Blog](https://blogs.msdn.microsoft.com/vsappcenter/)

## 总结
1. 使用很方便，傻瓜式
2. 单次 build 30min限制，付费后 60min
3. 免费每月 240min build 时间，付费后无限
4. 价格好贵……不如买台 mini
5. 由于服务器在海外，`git clone`, `pod install` 等，非常快
6. 内测如果使用了 pyger.com ，上传非常慢，不可用。用来上传 iTunesConnect 发布/ TestFlight 还是不错的。