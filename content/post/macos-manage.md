---
title: mac 管理
date: 2018-04-13 16:12:42
tags: [macos]
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
 
#### 如果开启了 FileVault 的处理
开机 cmd + r => 实用工具 => 终端
diskutil cs list

应会显示类似以下内容的列表：
``` bash
-bash-3.2# diskutil cs list
CoreStorage logical volume groups (1 found)
|
+-- Logical Volume Group 9BDE693D-8B2A-4BB5-B2F2-AB836127C4FA      
【UUID 号】
    =========================================================       
    Name:         Macintosh HD
    Sequence:     1
    Free Space:   0 B (0 B)
    |
    +-< Physical Volume AA2E2185-84C9-4D41-95DB-13235D3BBC8F
    |   ----------------------------------------------------
    |   Index:    0
    |   Disk:     disk0s6
    |   Status:   Online
    |   Size:     29743423488 B (29.7 GB)
    |
    +-> Logical Volume Family 00C419B1-BA2B-4234-8480-6955349B2AF3
        ----------------------------------------------------------
        Sequence:               8
        Encryption Status:      Locked
        Encryption Type:        AES-XTS
        Encryption Context:     Present
        Conversion Status:      Complete
        Has Encrypted Extents:  Yes
        Conversion Direction:   -none-
        |
        +-> Logical Volume 081502ED-C76D-4F4B-8641-6B0B3AD1512B
            ---------------------------------------------------
            Disk:               -none-
            Status:             Locked
            Sequence:           4
            Size (Total):       29424652288 B (29.4 GB)
            Size (Converted):   -none-
            Revertible:         Yes (unlock and decryption required)
            LV Name:            Macintosh HD                    
            Content Hint:       Apple_HFS
```

记下第一行中的逻辑宗卷组 UUID 号。

```
diskutil cs delete UUID

```
然后便可重装系统 

#### 制作U盘安装盘：

为方便查看拆成多行显示： 

```
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia 
--volume /Volumes/Sierra
--applicationpath /Applications/Install\ macOS\ High\ Sierra.app 
--nointeraction
```





