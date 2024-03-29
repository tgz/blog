---
title: HTTP keywords you should know
date: 2018-12-05 22:13:58
tags: [http]
---
# HTTP
状态码
从输入网址，到显示出网页，发生了什么

## HTTP 1.1
一个网站，能使用的 tcp 连接数量有限，不够用
 > N 个小图标放在一张大图内，使用 css 的手段截取需要显示的部分
 
keep-alive 只是能保持连接，无法「并发」
难以榨干 tcp 的性能
http 请求中的冗余内容
基于文本的协议，不够安全？容易出错？

## HTTP 2
二进制
多路复用
header 压缩
server-push
优先级

## HTTP 3
HTTP/3基于QUIC设计，QUIC是一个自己管理流的传输层协议
HTTP/2基于TCP设计，所以HTTP/2在HTTP层管理流

基于 UDP 协议, 更低的延迟
安全，要求 TLS 1.3+
HTTP/2 在差网络情况下的性能，比 Http/1 要差。
    单 TCP 连接出现丢包，这个链路上的内容需要重传。
    因为 HTTP/1 会有多个 TCP 连接，一个出现丢包，不影响其它
    
提供了重传、拥塞控制等其它 TCP 特性，以实现数据可靠传输
多 stream 的机制，每个 stream 内做重传等其它操作，并且数据有序
缓存连接参数的情况下，可以 0-RTT 建立连接
    