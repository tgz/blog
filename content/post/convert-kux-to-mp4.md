---
title: 优酷 kux 文件转码
date: 2018-06-23 17:14:28
tags: []
---

kux 是优酷的加密视频文件，对于独播资源客户端是不允许转码的。网上也有一些小工具，有的已经失效了。

在知乎的[这个回答](https://www.zhihu.com/question/51792949/answer/298412575)中，答主提到使用优酷自带 ffmpeg 来转码，简直不能再完美了。

由于需求不太相同，我这里重新写了一个脚本，将内容保存为 `.bat` 后，将需要转码的 kux 文件拖动至 bat 文件上，即可在源文件位置生成一份 `.mp4` 文件

> 注意：ffmpeg 位置 及使用的线程数按需修改

```bat
@echo off

set orig=%1
set after=%orig:~0,-5%.mp4"

set ffmpeg="C:\Program Files (x86)\YouKu\YoukuClient\nplayer\ffmpeg.exe"

%ffmpeg% -y -i %orig% -c:a copy -c:v copy -threads 8 %after%
```


