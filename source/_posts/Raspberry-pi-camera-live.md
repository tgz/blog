---
title: 使用树梅派 ffmpeg 进行 USB 摄像头画面直播
date: 2020-07-09 23:45:10
tags:
    - RaspberryPi
    - ffmpeg
    - RTMP
---

## 0x00 系统安装、软件安装

这里选择使用官方提供的 [Raspberry Pi OS](https://www.raspberrypi.org/downloads/raspberry-pi-os/) 
下载桌面版即可 `Raspberry Pi OS (32-bit) with desktop Image with desktop based on Debian Buster`, 笔者下载的版本为 `May 2020`

> 注意，桌面版系统，烧录后，默认 SSH Server 未打开，无法直接 ssh 连接进行配置，需要使用屏幕 + 键盘 + 鼠标做最基本的 Setup 

烧录工具推荐 [Etcher](https://www.balena.io/etcher/) 跨平台，简单好用

SD 卡烧录成功后，正常开机即可。

打开 SSH 参见 [官方文档](https://www.raspberrypi.org/documentation/remote-access/ssh/)

## 0x01 摄像头检查
检查摄像头可以使用 lsusb + v4l2-ctl 命令

```
#列出所有的 USB 设备 
lsusb

#列出视频设备
v4l2-ctl --list-devices
```

笔者在使用一款红外摄像头，机芯控制指令采用 UVC 协议中的 Zoom (Absolute) 通道，可以通过发送 v4l2 控制命令，向摄像头发送指令：

```
v4l2-ctl -c zoom_absolute=0x8802
```

能够看到摄像头硬件的情况下，可以打开系统自带的 VLC，打开设备，可以直接看到摄像头画面，说明摄像头硬件、驱动正常

## 0x02 直播测试

推流使用 FFMPEG, 树梅派系统自带

先在用其它服务器上测试一下推流：

```
ffmpeg -f v4l2 -i /dev/video0 -vcodec libx264 \
-preset:v ultrafast -tune:v zerolatency \
-r 25 -s 640x480 \
-f flv  rtmp://192.168.2.18:1935/live/out
```


> 由于不想再额外跑一个直播服务器，期望的效果为 移动电源 + 树梅派 + 摄像头 , 手机连接树梅派 WiFi，可以用第三方软件直接查看摄像头直播流  
故需要在树梅派上跑一个 RTMP Server

RTMP Server 推荐：[SRS](https://github.com/ossrs/srs/)

clone 源码后，直接编译即可，一次成功，未遇到环境相关的配置问题

由于是实时摄像头直播，可以配置 SRS 低延迟，参见文档：[RTMP低延时配置](https://github.com/ossrs/srs/wiki/v3_CN_SampleRealtime)

将 SRS 跑起来后，树梅派推本地测试：

```
ffmpeg -f v4l2 -i /dev/video0\
  -vcodec libx264 -preset:v ultrafast -tune:v zerolatency \
  -r 25 -s 256x196 -pix_fmt yuv420p \
  -f flv rtmp://127.0.0.1:1935/live/out
  
  #这里做了额外的操作：将数据转换为 yuv420 ,某些播放器没兼容 YUV422 会导致画面异常
```

## 0x04 WiFi 配置

先来个官方文档，按照这个步骤，可以设置 2.4G WiFi
[Setting up a Raspberry Pi as a routed wireless access point](https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md)

如果想获得更好的传输带宽，可以选择配置 5G 模式
需要在 `/etc/hostapd/hostapd.conf` 文件内容

```
country_code=US
interface=wlan0

ssid=NameOfNetwork
wpa_passphrase=AardvarkBadgerHedgehog

hw_mode=a
channel=149

ieee80211n=1
ieee80211ac=1
ieee80211d=1
ieee80211h=1
require_ht=1
require_vht=1
wmm_enabled=1

vht_oper_chwidth=1
vht_oper_centr_freq_seg0_idx=155
ht_capab=[HT40-][HT40+][SHORT-GI-40][DSSS_CCK-40]


wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

## 0x05 配置开机启动

1. 先写个脚本，一键启动 SRS+ RTMP 推流
2. 执行 `crontab -e`

添加一行即可实现开机延迟 30s 执行一键运行脚本：

```
@reboot sleep 30 && script_file.sh
```

这么完成以后，移动电源 + 树梅派， 手机连上树梅派 WiFi，即可查看摄像头实时画面。
