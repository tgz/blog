---
title: Ubuntu L2TP 配置
date: 2018-04-13 16:19:58
tags: ubuntu
---


1. 让「系统设置」「网络」「添加VPN」时出现 L2TP 选项

    ```
    sudo add-apt-repository ppa:nm-l2tp/network-manager-l2tp
    sudo apt-get update
    sudo apt-get install network-manager-l2tp
    sudo apt-get install network-manager-l2tp-gnome
    ```

2. 一些问题的处理（Ubuntu 16.04）：
 
   *  VPN service failed to start
     
     > i. VPN Ipsec 设置里，加密算法两行，第一行：`3des-sha1-modp1024` 第二行 `3des-sha1`.  (ike-scan)
      *这个算法可能通过 ike-scan youer-server 获取*
     
     > ii. 检查下是不是安装了 `libreswan` 库。`apt-get remove libreswan` 会自动切换到 `strongswan`
      *`libreswan` 和 `strongswan` 不同内核可能需求不一样，我这边有台电脑是这样*
     

     
  * 实时输出 L2TP 连接日志。无需到 /var/log/syslog 中筛查：
  
      > sudo /usr/lib/NetworkManager/nm-l2tp-service --debug
     
3. 资源：
   [network-manager-l2tp](https://github.com/nm-l2tp/network-manager-l2tp)


