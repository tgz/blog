---
title: 斐讯 N1 折腾手记
date: 2020-01-01 21:18:20
tags: 
    - N1
    - phicomm
    - openwrt
---

## 0. why?

最近想提高一下家里的网络体验，本想搞个软路由，后来发现，斐讯 N1 是一个性价比极其高的方案，家用环境完全 ok, 性能比目前服役的古董 WNDR3400 强了不知道多少倍了，拼多多上矿渣只要 80 块包邮。嗯，真香！

## 1. 正常的步骤

按照以下步骤来：  
1. 降级
2. 刷个安桌电视系统（我选了 YYF 的，主要是下载到最新版方便），这一步应该可以忽略
3. 搞个 Armbian 启动 U 盘
4. 启动 U 盘内的 armbian 系统, 并将 armbian 安装到 emmc 中
5. 持载 openwrt 镜像文件，把 openwrt 第二个分区的内容，覆盖到 emmc 中
6. Enjoy! 🎉

## 3. 主要重点问题

### 1. 降级、刷安桌系统
没什么好说的，用网上的脚本一键就行了，不会存在什么问题
如果要刷系统，下载系统可以到 [YYF 官网](http://www.yyfrom.com/cms/yyfrom/product/2019-11-29/164.html) 很方便.

### 2. Armbian 系统的选择

#### 为什么需要 Armbian?

找了网上 [Tony](https://www.youtube.com/channel/UCA3gvWwB9OvQEHuX8BOIazg) 的固件 `可以去 tony 的 TG 群下载，下载体验要好很多` ，主要是集成了比较多的功能吧，但是 Tony 提供的镜像，写入 U 盘并不能正常引导启动，会卡在 recovery 界面。折腾了 4 个 U 盘，反复尝试了不下 20 次，最后发现 armbian 可以正常启动。就换了思路，直接在 emmc 内写入 armbian 的系统，再替换 openwrt 的系统文件。

#### 用哪个版本的 Armbian？

目前(2020 年 1 月 1 日)，armbian 的系统已经是 5.x 的内核了，而我们能比较容易找到的 openwrt 系统，基本上是 4.8.7 内核版本的。
起初走了很多弯路，5.x 内核的 armbain 系统写入 emmc 后替换 openwrt 内容后，启动后遇到了没有驱动网卡的问题。

为了简便,我直接找了应该是当初比较火的 [xq7 armbian](https://www.right.com.cn/forum/thread-394823-1-1.html) 镜像, 猜测大部分 openwrt 应该都是基于这个版本做的？

#### 写入后无法启动？

这个把我折腾了很惨，经过一番折腾，有一个要点：做完镜像后，不能在安卓系统的情况下把 U 盘插入。必须在 `adb reboot update` 命令后，系统黑屏后，快速插入 U 盘。

U 盘的选择也很重要，最好是 Sandisk 的。两方面原因：网友反馈 & 个人经验。

如果想确认 U 盘是否支持，可以先 [挑个 armbian 的系统](https://disk.yandex.ru/d/pHxaRAs-tZiei) 写入验证一下能否 U 盘启动。

## 4. Reference
[https://disk.longe.xyz/N1/OpenWrt/](https://disk.longe.xyz/N1/OpenWrt/)
[https://yuerblog.cc/2019/10/23/斐讯n1-完美刷机armbian教程/](https://yuerblog.cc/2019/10/23/斐讯n1-完美刷机armbian教程/)
[https://www.right.com.cn/forum/thread-737893-1-1.html](https://www.right.com.cn/forum/thread-737893-1-1.html)






