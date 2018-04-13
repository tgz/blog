---
title: 使用 FFmpeg 给视频添加水印
date: 2018-03-28 18:08:55
tags: ffmpeg
---

接到一条求助：在视频的前 2 秒添加水印，想了下最方便的应该是使用 FFMPEG 了。简单捣鼓了一下：

使用的 FFmpeg 版本：`3.4.2`

#### 图片水印：

``` bash
ffmpeg -i source.mp4 -i 011.jpg -filter_complex "overlay=x='if(gte(t,2),NAN,10)':y=0[out]" -map '[out]' out.mp4
```

#### 文字水印    

```bash
ffmpeg -i source.mp4 -vf "drawtext=fontfile=/Library/Fonts/AdobeHeitiStd-Regular.otf:text='watermark测试':x=30:y=h-30:enable='if(gte(t,3),0,1)':fontsize=24:fontcolor=red@0.7" output.mp4
```

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


或者 [一个比较全的例子](https://gist.github.com/clayton/6196167)

