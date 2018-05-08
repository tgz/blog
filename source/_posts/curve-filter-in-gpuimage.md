---
title: GPUImage 中的曲线滤镜
date: 2018-04-24 08:35:34
tags: GPUImage
---

前段时间在做滤镜的开发，参考了 GPUImage 中的多种滤镜。在使用过程中，发现 GPUImage 中的 曲线 滤镜和 PS 中略有不同。记录如下。

PS 中曲线调整时，如果起始结束点不在 `(0,0),(255,255)` ，则按照一定的规则进行补齐两侧的点

PS 中生成的图如下图
![PS 补点](http://cctgz.u.qiniudn.com/curve-ps.jpg)

GPUImage 补齐规则：
![GPUImage](http://cctgz.u.qiniudn.com/curve-old.jpg)

从图上可以很容易的看出来，PS 的规则为：  
    1. 在起始点前的点，y 值按第一个点的值进行填充。
    2. 在结束点后的点，y 值按最后一个点的值进行填充。

而 GPUImage 则使用了简单粗暴的补 0 和补 255。

从 GPUImage 的代码上看也是这么一回事

[GPUImageToneCurveFilter](https://github.com/BradLarson/GPUImage/blob/master/framework/Source/GPUImageToneCurveFilter.m#L284~L323)

```objc
        
        // If we have a first point like (0.3, 0) we'll be missing some points at the beginning
        // that should be 0.
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
        CGPoint firstSplinePoint = [[splinePoints objectAtIndex:0] CGPointValue];
#else
        NSPoint firstSplinePoint = [[splinePoints objectAtIndex:0] pointValue];
#endif
        
        if (firstSplinePoint.x > 0) {
            for (int i=firstSplinePoint.x; i >= 0; i--) {
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
                CGPoint newCGPoint = CGPointMake(i, 0);
                [splinePoints insertObject:[NSValue valueWithCGPoint:newCGPoint] atIndex:0];
#else
                NSPoint newNSPoint = NSMakePoint(i, 0);
                [splinePoints insertObject:[NSValue valueWithPoint:newNSPoint] atIndex:0];
#endif
            }
        }

        // Insert points similarly at the end, if necessary.
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
        CGPoint lastSplinePoint = [[splinePoints lastObject] CGPointValue];

        if (lastSplinePoint.x < 255) {
            for (int i = lastSplinePoint.x + 1; i <= 255; i++) {
                CGPoint newCGPoint = CGPointMake(i, 255);
                [splinePoints addObject:[NSValue valueWithCGPoint:newCGPoint]];
            }
        }
#else
        NSPoint lastSplinePoint = [[splinePoints lastObject] pointValue];
        
        if (lastSplinePoint.x < 255) {
            for (int i = lastSplinePoint.x + 1; i <= 255; i++) {
                NSPoint newNSPoint = NSMakePoint(i, 255);
                [splinePoints addObject:[NSValue valueWithPoint:newNSPoint]];
            }
        }
#endif
        
```

重点就在于两种情况下构造的 `newPoint`.
我们简单调整，即可将 GPUImage 生成的曲线与 PS 保持一致

``` objc

if (firstSplinePoint.x > 0) {
    for (int i=firstSplinePoint.x; i >= 0; i--) {
        CGPoint newCGPoint = CGPointMake(i, firstSplinePoint.y);
        [splinePoints insertObject:[NSValue valueWithCGPoint:newCGPoint] atIndex:0];
    }
}

```

```objc
if (lastSplinePoint.x < 255) {
    for (int i = lastSplinePoint.x + 1; i <= 255; i++) {
        CGPoint newCGPoint = CGPointMake(i, lastSplinePoint.y);
        [splinePoints addObject:[NSValue valueWithCGPoint:newCGPoint]];
    }
}
```

调整后，GPUImage 生成的曲线就和 PS 中保持一致了。
![new-curve](http://cctgz.u.qiniudn.com/curve-new.jpg)


