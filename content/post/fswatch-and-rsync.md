---
title: fswatch_and_rsync
date: 2018-10-16 13:54:50
tags: [fswatch, rsync]
---


最近觉得 mac 编译项目越来越慢，由于是 c++ 项目，可以用 linux 编译，于是整了一个性能稍好的 ubuntu，但是开发还是在 mac 上

怎么方便 & 快捷地把文件同步到编译机上，是个问题

之前 rsync 也用过很多次了，这里就使用 fswatch + rsync 的方案

### 1. mac 上安装 `fswatch`

```bash
brew install fswatch
```

### 2. 编写脚本，监控文件夹内容的变化

```bash
#!/bin/zsh

# fswatch 可同时监控多个文件夹，这里我有两个项目，写了两个文件夹
# -e 排除掉 git 目录
fswatch /Users/xx/Git/repo1 /Users/xx/Git/repo2 -e ".git"| while read file
do

# 将本地的 ~/Git/repo 同步到 远端的 /home/xx/workspace/ 下，需要修改目标路径
target_path='/home/xx/workspace/'${file#/Users/xx/Git/}

# rsync 参数可以参考我正面的
# zz 是我 ssh config 的编译机
rsync -trl --delete ${file} zz:${target_path}

echo "${file} sync to: ${target_path}"

done

```

enjoy!
