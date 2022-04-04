---
title: setup_webrtc_tun_server
date: 2021-05-18 12:30:54
tags: [webrtc]
---

# WebRTC

[webrtc 介绍](https://www.cnblogs.com/vipzhou/p/7994927.html)

[webrtc samples](https://webrtc.github.io/samples/)

[淘宝 webrtc 直播介绍](https://www.zhihu.com/question/25497090)

[WebRTC TURN 协议初识及 turnserver 实践](https://zhuanlan.zhihu.com/p/71025431)

[实际中的 WebRTC：STUN，TURN 以及信令（一）](https://webrtc.org.cn/real-world-webrtc-1/)

# STUN/TURN Server 开源项目：

[github/coturn](https://github.com/coturn/coturn)

> Free open source implementation of TURN and STUN Server

> The TURN Server is a VoIP media traffic NAT traversal server and gateway. It can be used as a general-purpose network traffic TURN server and gateway, too.

> On-line management interface (over telnet or over HTTPS) for the TURN server is available.

> The implementation also includes some extra experimental features.

# coturn server 搭建：使用 docker


*   turn/stun server 验证:  
    [Trickle ICE](https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/)
    
*   tunserver.conf
    

```
listening-port=3478
tls-listening-port=3480
relay-threads=3
min-port=49152
max-port=49999
fingerprint
lt-cred-mech
#no-auth
user=test:test1234
realm=your.domain.com
max-bps=3000000
syslog
pidfile="/var/tmp/turnserver.pid"
mobility
prometheus
relay-ip=111.22.33.44
listening-ip=111.22.33.44
external-ip=111.22.33.44
```

*   docker-compose.yml

```
version: '2'
services:
  coturn:
    image: woahbase/alpine-coturn
    volumes:
      - "./turnserver.conf:/var/lib/coturn/turnserver.conf"
    network_mode: host
```

> 参考：[jam-systems](https://gitlab.com/jam-systems/jam/-/blob/master/deployment/turnserver.conf)