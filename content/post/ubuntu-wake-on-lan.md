---
title: "Ubuntu Wake on Lan"
date: 2022-12-25T23:55:05+08:00
draft: false
tags: [ubuntu]
---

## 0x00

```bash
# install ethtool
sudo apt install ethtool

# get mac address
ip a

2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 3c:97:0e:ff:ff:ff brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.46/24 brd 192.168.1.255 scope global dynamic noprefixroute enp2s0
       valid_lft 42036sec preferred_lft 42036sec
    inet6 fe80::1322:52e3:324f:d295/64 scope link noprefixroute
       valid_lft forever preferred_lft forever


# check your hardware support wol

sudo ethtool enp2s0

#Supports Wake-on: pumbg
#Wake-on: d

# Test
sudo ethtool --change enp4s0 wol g

# power off, and use wol tools send magic pack to mac address
```

## 0x1 always enable wol

```bash
which ethtool

/usr/sbin/ethtool


```

### config systemd
```bash
sudo vim /etc/systemd/system/wol.service

```
paste content:
```
[Unit]
Description=Enable Wake On Lan

[Service]
Type=oneshot
ExecStart = /sbin/ethtool --change enp2s0 wol g

[Install]
WantedBy=basic.target
```

### enable wol service
```bash
sudo systemctl daemon-reload
sudo systemctl enable wol.service
```

check service status:
```bash
sudo systemctl status wol
```

shutdown your device and test it


## reference
[enabling-wake-on-lan](https://necromuralist.github.io/posts/enabling-wake-on-lan/)