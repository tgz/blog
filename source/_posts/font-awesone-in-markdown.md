---
title: Markdown 文档中使用 font awesome
date: 2018-07-01 17:15:40
tags: markdown
---

# Font Awesome 是什么

官网：[Font Awesome](https://fontawesome.com/)

> Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit.

Font Awesome 是一个图标库，包含了常见 & 流行的各式 Logo ，它帮助你快速在网页中添加各类图标。它的应用实在是太广泛了, 在 web 项目中几乎随处可见。

# 如何使用

我们在 markdown 头部或尾部插入这么一段

> hexo 渲染时，`head` `link` 虽然不会显示内容，但是位置还是会占用，这几行代码如果放在头部会有一小段空白，所以我放在了文件最下面。

```
<head> 
    <script defer src="https://use.fontawesome.com/releases/v5.1.0/js/all.js"></script> 
    <script defer src="https://use.fontawesome.com/releases/v5.1.0/js/v4-shims.js"></script> 
</head> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css">
```

这里包含三个引用：支持最新 `5.1.0` 版本和`4.x` 版本的图标

引入这个文件中，我们就可以添加我们需要的图标了。如：

```html
<i class="fab fa-weixin"></i> someone
```

效果为：
<i class="fab fa-weixin"></i> someone

# 如何导找图标：

[官网搜索](https://fontawesome.com/icons)
可以直接粘贴官网的代码

# 修改图标尺寸：

### 图标 size 会跟随文字：<i class="fab fa-weixin"></i>

```
### 图标 size 会跟随文字：<i class="fab fa-weixin"></i>
```


如果需要比当前文字更大的图标：添加样式 `fa-lg` 或其它即可 (33%递增)。如：

```
<i class="fab fa-weixin fa-lg"></i> someone
```
<i class="fab fa-weixin fa-lg"></i> someone

继续变大：

<i class="fab fa-weixin fa-2x"></i>  `fa-2x` 

<i class="fab fa-weixin fa-3x"></i>   `fa-3x` 

<i class="fab fa-weixin fa-4x"></i>   `fa-4x` 

<i class="fab fa-weixin fa-5x"></i>   `fa-5x` 

# 动画

使用样式：`fa-spin`

```
 <i class="fa fa-refresh fa-spin"></i>
```
 <i class="fa fa-refresh fa-spin"></i>
 
 除了这种连续旋转，还有每次旋转45度的样式：
 `fa-pulse` <i class="fas fa-spinner fa-pulse"></i>
 
# 旋转与翻转

<i class="fa fa-shield"></i> normal<br>
<i class="fa fa-shield fa-rotate-90"></i> fa-rotate-90<br>
<i class="fa fa-shield fa-rotate-180"></i> fa-rotate-180<br>
<i class="fa fa-shield fa-rotate-270"></i> fa-rotate-270<br>
<i class="fa fa-shield fa-flip-horizontal"></i> fa-flip-horizontal<br>
<i class="fa fa-shield fa-flip-vertical"></i> icon-flip-vertical
 
# 其它
除了以上的一些基本操作，还有一些更细致的用法，如图标组合，蒙板，角标等等，可以参考官网的 [文档说明](https://fontawesome.com/how-to-use/on-the-web/styling/stacking-icons)




<head> 
    <script defer src="https://use.fontawesome.com/releases/v5.1.0/js/all.js"></script> 
    <script defer src="https://use.fontawesome.com/releases/v5.1.0/js/v4-shims.js"></script> 
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css">
</head> 

