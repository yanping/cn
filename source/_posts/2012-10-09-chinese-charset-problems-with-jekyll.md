---
layout: post
title: "在Windows下使用jekyll如何避免出现中文字符集错误"
date: 2012-10-09 21:30
comments: true
categories: jekyll
description: 在windows下使用jekyll时经常会遇到字符集错误，本文重点讲解解决办法。
keywords: jekyll, notepad++, 字符集
---

{:.info}
在windows下使用jekyll时经常会遇到字符集错误，比如遇到提示<span style="font-family: Menlo,Monaco,'Andale Mono','lucida console','Courier New',monospace;">Liquid error: incompatible character encodings: UTF-8 and GBK</span>。本文将介绍几种解决方案。

1\. **修改bash的字符集：**在`C:\Documents and Settings\用户名`下，找到文件`.bash_profile`，后面加两行

```sh
set LC_ALL=en_US.UTF-8
set LANG=en_US.UTF-8
```

<!--more-->

2\. **所有文档使用utf-8无BOM格式**

在Windows下新建的文本文件默认是ANSI格式的，而jekyll只认utf-8。如果遇到ANSI格式编码的文件，可以在notepad++中转换，如下图：

<img src="http://f-1.tuzhan.com/31767262cd80/p-1/l/2012/10/09/16/bc35a142ea064af69246d43d794d11bd.png" alt="转换为utf-8编码">

3\. **使用Unix换行符**

可以在notepad++中转换，如下图：

<img src="http://t-1.tuzhan.com/c6de0d29ca03/p-1/l/2012/10/09/16/73050c832188493ba1d6cbbb4757211c.png" alt="转换为Unix换行符">

这里有个技巧，在notepad++中，可以开启“显示所有字符”选项，这样就可以看出文档用的是Windows的换行符还是Unix的换行符。

<img src="http://f-1.tuzhan.com/63479110599f/p-1/l/2012/10/09/16/6a12be56f7374c608d732f090a1a49bd.png" alt="显示所有字符">

在这种模式下，Windows的换行符显示的是`CR`，Unix的换行符显示的是`LF`

4\. **新建文档的时候就注意到前两条**

在**设置-->首选项**里，如下设置
<img src="http://f-1.tuzhan.com/fb1e112d285c/p-1/l/2012/10/09/21/6c80da6e228343998fa184a3983c403a.png" alt="新建文档设置">

5\. **注意YAML头部的格式**

模板文件的元数据以YAML的格式展现，YAML头部经常会出现三个问题：（1）三短线前面不能有空格；（2）“名: 值”对里冒号后面要有空格；（3）回车后不要有Tab符；（4）表示数组成员开始的`-`号后面要有空格

在notepad++中开启“显示所有字符”选项后，就可以看清空格和Tab符了，下图是很规范的例子
<img src="http://f-1.tuzhan.com/5a62f0e1e6c7/p-1/l/2012/10/09/16/1395a21769e24594a7783da6a8310d17.png" alt="yaml头部">

尤其是Tab符，不借助工具很难跟空格区分，下图那个向右箭头的符号就是Tab符，这是个错误的例子，应该把Tab符删除，改为用空格缩进

<img src="http://f-1.tuzhan.com/104be2300ea4/p-1/l/2012/10/09/16/5a42fd3a016741388044954d4e9c0925.png" alt="带Tab符的YAML头部">

正确的应该是这样，`-`号后面都有空格

<img src="http://f-1.tuzhan.com/8df6d607c9f0/p-1/l/2012/10/09/16/4769b025fb8b4d129d3755cf84746ad1.png" alt="不带Tab符的YAML头部">




