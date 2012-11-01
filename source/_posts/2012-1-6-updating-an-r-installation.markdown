---
layout: post
title: "如何升级R"
date: 2012-1-6 17:12
comments: true
categories: R语言
description: 本文主要介绍如何升级R
keywords: R语言
---

<p><span class="info">
本文翻译自<a href="http://www.manning.com/kabacoff/" target="_blank">R in Action</a>的附录H，如果对该书感兴趣，请自行购买或去图书馆阅读。
</span>
</p>
R的函数`update.packages()`可以下载和升级安装的包，但是没有相应的函数升级R本身。如果你想把R从4.1.0版升级到5.1.1版，那你必须有点创造性。（实际上作者写书的时候R的版本还只是2.13.0，但是他说想这本书在若干年后仍然不显得过时）

从CRAN（<http://cran.r-project.org/bin>）下载并安装最新版的R相当简单。但是想在新安装时保留之前的个性化设置（比如之前安装的包）就复杂了。在我现在的安装中，安装了248个包。我实在是不想把这些包的名字写下来，然后在下次升级R的时候手动重装它们。

关于如何方便简洁高效地升级R，网上有很多这方面的讨论。下面描述的方法既不简洁，也不高效，但是我发现它可以用在任何平台（Windows，Mac以及Linux）。

<!--more-->

`installed.packages()`函数用来保存一份已安装包的列表到R目录之外。然后利用这个列表和`install.packges()`函数来下载和安装最新的包到新安装的R中。下面是步骤：

1. 如果有自定义的配置文件**Rprofile.site**，就把它保存到R之外。
2. 启动当前版本的R，运行下面的命令
	{% codeblock lang:r %}
	oldip <- installed.packages()[ ,1]
	save(oldip, file="path/installedPackages.Rdata")
{% endcodeblock %}	
其中*path*是R的安装目录。

<ol start="3">
	<li> 下载并安装最新版的R。</li>
	<li> 如果你保存了原来的<strong>Rprofile.site</strong>文件，把它复制到新的安装目录中。</li>
	<li>启动新版的R，然后运行下面的命令	
	{% codeblock lang:r %}
	load("path/installedPackages.Rdata")
	newip <- installed.packages()[,1]
	for(i in setdiff(oldip, newip))
		install.packages(i)
{% endcodeblock %}
	</li>
</ol>
<ol start="6">
 	<li>删除旧的安装（可选）</li>
</ol>

<p><span class="warning">
这种方法只能安装从CRAN能获取到的包。其他途径获取的包要单独安装。
</span>
</p>









