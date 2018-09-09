---
title: markdown 中使用可展开的区域 details
date: 2018-07-01 17:46:51
tags: markdown
---

在 github 中，经常能看到一些人写的 markdown 中包含一个可展开的区域，一般会长这个样子：
<details>
    some thing
</details>


比如 [这个 issue](https://github.com/fastlane/fastlane/issues/12757)

这个是怎么写的？有没有兼容性问题？

通过查看网页源代码，可以看到这个区域是一个 html 标签：`details`

查看 [MDN 的文档](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/details) 可以获得更加详细的说明

所以用法也就很清晰了：

```
<details open>
    <summary>show more</summary>
    This section was in a detail block
</details>

```
这么一段代码，使得 details 区域默认展开，前修改了标题为：`show more`

<details open>
    <summary>show more</summary>
    This section was in a detail block
    
</details>

由于是 html 内容，所以不存在兼容性问题  
但是 details 里面的内容是否支持 markdown 语法，不同的渲染器表现会不同, 需要各位自己去验证了。`github 支持`






