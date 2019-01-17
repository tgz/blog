---
title: FFmpeg 水印、图片转视频
date: 2018-03-28 18:08:55
tags: ffmpeg
keywords: ffmpeg 水印 时间段 图片转视频
---

接到一条求助：在视频的**前 2 秒**添加水印，想了下最方便的应该是使用 FFMPEG 了。简单捣鼓了一下：

使用的 FFmpeg 版本：`3.4.2`

#### 图片水印：

``` bash
ffmpeg -i source.mp4 \
    -i 011.jpg \
    -filter_complex "overlay=x='if(gte(t,2),NAN,10)':y=0[out]" \
    -map '[out]' out.mp4
```

#### 文字水印    

```bash
ffmpeg -i source.mp4 \
   -vf "drawtext=fontfile=/Library/Fonts/AdobeHeitiStd-Regular.otf:text='watermark测试':x=30:y=h-30:enable='if(gte(t,3),0,1)':fontsize=24:fontcolor=red@0.7" output.mp4
```

### FFmpeg 将图片序列转视频
```bash
ffmpeg -r 30 -i v_%d.jpg -b:v 3m -vcodec libx264 video2.mp4
```

`-r 30 : 30fps`
`-i v_%d.jpg: input images: v_1.jpg v_2.jpg ... [v_%03d.jpg]`
`-b:v 3m : video bitrate: 3m/s`
`-vcodec libx264: video codec is h264`

---

附： mac 下 [安装 FFmpeg](https://trac.ffmpeg.org/wiki/CompilationGuide/macOS)，其中文字水印需要 --with-freetype

 
``` 
brew install ffmpeg \    
    --with-tools \    
    --with-fdk-aac \  
    --with-freetype \   
    --with-fontconfig \   
    --with-libass \   
    --with-libvorbis \  
    --with-libvpx \  
    --with-opus \  
    --with-x265   
```


或者参考 [一个比较全的安装命令](https://gist.github.com/clayton/6196167)

