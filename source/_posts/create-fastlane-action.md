---
title: 给 fastlane 添加自定义 action
date: 2018-05-14 14:33:19
tags: fastlane
---

最近公司在做新项目，iOS 这边，因为企业证书配置了 Wildcard App ID,无法使用推送等功能。  
之前的做法一直是配置另外一个 Target，使用不同的配置来实现 fastlane 自动打包。

这种做法存在的问题是，每次新加入文件，都需选中多个 target ，如果忘记了，会导致打包失败。

## First Step
一开始想的是，写个脚本改 xcodeproj 的内容。  

由于 xcodeproj 的结构看起来很混乱，各种 uuid 互相关联。  
这里就想到使用 CocoaPods 提供的 [Xcodeproj](https://github.com/CocoaPods/Xcodeproj) 库来做。

经过一番尝试和努力，写出了一个脚本

```ruby
require 'xcodeproj'

project = Xcodeproj::Project.open(project_path)
specificed_target = params[:target]
target = project.targets.first

attributes = project.root_object.attributes['TargetAttributes']
target_attributes = attributes[target.uuid]
system_capabilities = target_attributes['SystemCapabilities']

if system_capabilities.class == Hash
    system_capabilities.delete('com.apple.Push')
end

target.build_configurations.each do |item|
    # just remove the entitlements config from code sign
    item.build_settings['CODE_SIGN_ENTITLEMENTS'] = ""
        end

project.save()

```

这个脚本可以完成任务。但是总感觉不够好。翻了下 fastlane 的文档，看到了[local-action](https://docs.fastlane.tools/plugins/create-plugin/#local-actions)

## 一. Local Action

fastlane 官方提供了 local-action 的简要说明, 参照 github 中的[示例](https://github.com/fastlane/fastlane/blob/master/fastlane/actions/test_sample_code.rb)，

给脚本加了 module, class 并放到项目 `fastlane/actions` 目录下,  
命名为 `disable_push_notifications.rb`. 

Well Done! 

我们只要在想关闭推送的 lane 中，加入一行 `disable_push_notifications` 即可。

更进一步，如果我有多个 xcodeproj 或 target 呢？

那就加几个可选参数吧~ 最终完成的文件见[这里](https://github.com/tgz/fastlane-plugin-disable_push_nogifications/blob/master/lib/fastlane/plugin/disable_push_notifications/actions/disable_push_notifications_action.rb)

在使用时，也可以 `disable_push_notifications(xcodeproj: your.xcodeproj, target: enterprise)` 设定相应的 project 文件和 target.

## 二. 写一个插件

在看 local action 的文档时，看到了 fastlane 有说明如何自己实现一个[插件](https://docs.fastlane.tools/plugins/create-plugin/#create-your-own-plugin)。

那就来试一把吧！

执行 `fastlane new_plugin disable_push_notifications`, fastlane 自动帮我们生成了一个插件的目录结构。  
观察一番，只要把我们刚才实现的 action 的内容放到插件自动生成的 ruby 文件中即可。


最后实现的插件，见[这个仓库](https://github.com/tgz/fastlane-plugin-disable_push_nogifications)

我这个需求由于很小众，就没有发布到 [rubygems.org](https://rubygems.org/).

如果有需求，建议还是使用 local action 的形式来做。毕竟只要加一个文件在项目中，简单又方便。