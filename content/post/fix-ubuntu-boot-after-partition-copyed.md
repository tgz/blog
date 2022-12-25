---
title: "Ubuntu 使用 dd 迁移磁盘后的启动修复"
date: 2022-12-26T00:05:42+08:00
draft: false
tags: [ubuntu]
---

## 0x00 dd 迁移磁盘
使用 usb-live-cd 启动电脑后，使用 dd 命令迁移磁盘到 ssd 内：
```bash
sudo dd if=/dev/sda2 of=/dev/sdb2 bs=4M status=progress

# sda 为原机械硬盘，sdb 为固态硬盘
# 固态硬盘和机械硬盘系统安装方式相同，使用 ubuntu 的默认一键安装
## 其实 ssd 可以自行分区后直接用 dd 拷贝整盘/多个分区，无需安装系统 
```

## 0x01 别着急重启
由于 ubuntu 安装时使用了默认安装安装方式，用户数据和系统数据在同一分区，切换磁盘后，由于磁盘 uuid 发生了变化，会出现 grub 无法引导的情况

解决方式：
在 live-cd 环境内，挂载 ssd 新系统 分区
```bash
sudo mount /dev/sdb2 /mnt
sudo mount /dev/sdb1 /mnt/boot/efi

# 第二句极为关键，因为 EFI 拥有独立分区，需要挂载进系统分区再重新安装 grub

# 重新安装 grub
sudo grub-install --boot-directory=/mnt/boot /dev/sda

```

**还有一步** 修复 `/etc/fstab` 中的分区 UUID

```bash
# 当前分区 uuid ：
sudo blkid

## 记住两个分区的 uuid

sudo vim /etc/fstab
# 调整分区 uuid 的值

```

## 0x02 Enjoy
此时可以放心切换引导至 SSD