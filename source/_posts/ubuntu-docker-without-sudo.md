---
title: Ubuntu 下免 root 权限执行 docker 命令
date: 2018-06-22 23:01:34
tags: 
    - Ubuntu
    - Docker
---

将当前用户加入 docker 组后，重启 docker 并刷新 group 缓存。

```bash
sudo groupadd docker #正常情况下，装完 Docker 此组已经自动创建
sudo gpasswd -a ${USER} docker
sudo service docker restart
newgrp - docker
```


