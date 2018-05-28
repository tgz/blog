---
title: mac 管理
date: 2018-04-13 16:12:42
tags: macos
---

### 忘记密码的处理
##### 方案1:

 1. cmd + s 开启，进入 single-user 模式
 2. 在`:/ root#`下 执行　`mount -uaw /`
 3. 执行 `rm /var/db/.AppleSetupDone`
 4. `reboot` 重启，设置一个新用户
 5. 设置---用户和群组---重设老用户的密码

 
##### 方案2 👍:
 
开机按 cmd + r，进入Recovery（恢复）=> 实用工具-终端-输入 `resetpassword`
 
 随后会弹出密码修改工具，选择对应的用户，直接设置新密码即可。
 
 

#### 制作U盘安装盘：

为方便查看拆成多行显示： 

```
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia 
--volume /Volumes/Sierra
--applicationpath /Applications/Install\ macOS\ High\ Sierra.app 
--nointeraction
```





