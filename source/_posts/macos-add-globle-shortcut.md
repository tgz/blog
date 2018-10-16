---
title: 给 Xcode run 添加全局快捷键
date: 2018-09-09 21:22:52
tags: Xcode
---

开发 ReactNative 程序时，使用 VSCode 为主，但是真机调试时，又需要使用 Xcode, 每次两个软件之间切换比较麻烦，这里提供一种方式，可以直接按一个快捷键，自动唤起 Xcode 并执行 「RUN」

这里需要借助苹果自带的 Automator 来做到这件事情。

首先：打开 Automator ,新建服务：

![automator_new_service](http://cdn.imqsc.xyz/automator_new_service.jpg)

找到 「运行 AppleScript」拖动到右侧编辑区，添加以下内容：

```AppleScript
on run {input, parameters}
	
	tell application "Xcode"
		activate
		tell application "System Events"
			keystroke "r" using command down
		end tell
	end tell
end run
```

> AppleScript 的语法不再解释，比较简单明了，我这里使用发送键盘事件的方式达到目的，你也可以操作菜单栏，如有其它需求，自己 google 一下即可。

如图所示：
![](http://cdn.imqsc.xyz/automator-run-script.jpg)

注意这里服务的输入要选择「没有输入」，位于，我选择的是所有程序，你也可以按需选择。

完成后，可以点击右侧运行，验证效果。

验证无误后，保存文件即可。然后到 [系统设置---键盘---快捷键] 内，添加这个服务的全局快捷键即可。

如下图所示：
![](http://cdn.imqsc.xyz/service-shortcut.jpg)

如上图所示，我保存服务的名称为 [Xcode-Run], 这里就能看到同名的服务，添加自己想设置的快捷键。

Enjoy!