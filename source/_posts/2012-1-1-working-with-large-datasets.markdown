---
layout: post
title: "用R处理大数据集"
date: 2012-1-1 15:36
comments: true
categories: R语言
description: 本文主要介绍用R语言如何实现大数据的处理
keywords: R语言, 大数据
---


<p><span class="info">
本文翻译自<a href="http://www.manning.com/kabacoff/" target="_blank">R in Action</a>的附录G，如果对该书感兴趣，请自行购买或去图书馆阅读。
</span>
</p>

R会把所有的对象读存入虚拟内存中。对我们大多数用户来说，这种设计可以提高与R相互的速度，但是当分析大数据集时，这种设计会降低程序运行速度有时还会产生跟内存相关的错误。

内存限制主要取决于R的build版（32位还是64位），而在32位的windows下，取决于操作系统的版本。以cannot allocate vectoe of size开头的出错信息表示无法分配充足的连续内存，而以cannot allocate vector of length开头的出错信息表示超越了地址限制（address limit）。在处理大数据集时，应尽量使用64位版的R。对于各种build版，向量中的元素个数最大为2147483647（请自行?Memory）。

在处理大数据集时有三方面应该考虑：（a）提高程序的效率，保证执行速度；（b）把数据储存在外部，以解决内存限制问题；（c）使用专门的统计方法来有效处理大数据量的问题。

下面将分别讨论。

<!--more-->

### 高效编程 ###
下面几条编程技巧来可以提高处理大数据集时的效率

* 尽量向量化运算。使用R内置的函数来处理向量、矩阵和list（例如函数`sapply`，`lapply`和`mapply`），尽量避免使用循环（for和while）;
* 使用矩阵，必要时才使用数据框，因为矩阵的开销更少；
* 使用`read.table()`函数族把外部数据导入数据框时，尽量显式设定`colClasses`和`nrows`选项，设定`comment.char = ""`，把不需要的列设置成NULL。这样可以减少占用的内存，同时加快处理速度。将外部数据导入矩阵时，使用`scan()`函数；
* 在处理全部数据前，用数据的子集测试程序，来优化程序，去掉bug；
* 删除临时对象和不再用的对象。调用`rm(list=ls())`可以删除内存中的所有对象。删除指定的对象可以用`rm(object)`；
* 在Jeromy Anglim的博客文章“R的内存管理：一些小窍门和技巧”(原文[Memory Management in R: A Few Tips and Tricks ](http://jeromyanglim.blogspot.com/2009/11/memory-management-in-r-few-tips-and.html)，被墙)中提到，使用函数`.ls.objects()`列出工作区内的对象占用的内存大小。这个函数会帮助你找到吃内存的大家伙。
* profile你的程序，看看在每个函数中花的时间。你可以用`Rprof()`和`summaryRprof()`函数完成这项工作。`system.time()`函数也可以帮助你。_profr_ 和 _prooftools_ 包提供了若干函数来帮助分析profile的输出。
* Rcpp包可以把R对象转成C++函数（原文是The Rcpp package can be used to transfer R objects to C++ functions and back when more optimized subroutines are needed. 后半句不知怎么翻译）

处理大数据集，提高代码效率只能解决一部分问题。你也可以把数据存在外部存储并使用专门的统计分析方法。

### 把数据存储在内存之外 ###
有几种包可以实现在内存之外存储数据。解决之道是把数据保存在外部数据库或者硬盘里的二进制文件中，然后在需要的时候部分地读取。下表描述了几种有用的包：

<table class="datalist">
<tr>
	<th><strong>包</strong></th>
	<th><strong>描述</strong></th>
</tr>
<tr>
	<td>ff</td>
	<td>提供了一种数据结构，保存在硬盘中，但是操作起来就如同在内存中一样</td>
</tr>
<tr>
	<td>bigmemory</td>
	<td>支持大规模矩阵的创建、储存、读取和操作。矩阵被分配到共享内存或内存映射的文件中（memory-mapped files）</td>
</tr>
<tr>
	<td>filehash</td>
	<td>实现了简单的key-value数据库，在其中特征字符串key与存储在硬盘中的数据value相关联。</td>
</tr>
<tr>
	<td>ncdf, ncdf4</td>
	<td>Provides an interface to Unidata netCDF data files.
</td>
</tr>
<tr>
	<td>RODBC, RMySQL,<br /> 
	ROracle, <br />
	RPostgreSQL, <br />
	RSQLite 
	</td>
	<td>可以用这些包读取外部关系数据库管理系统的数据</td>
</tr>
</table>
上面的包可以帮助客服R的内存限制。除此以外，当需要在有限时间内分析大数据集时，使用专门方法也是必须的。一些有用的方法将在下面介绍。

### 分析大数据集的包 ###
R提供了几种分析大数据集的包：

* _biglm_ 和 _speedglm_ 包可以针对大数据集有效地拟合线性和广义线性模型。在处理大规模数据集时，这两个包提供了类似`lm()`和`glm()`的功能。
* 由 _bigmemory_ 包可产生大规模矩阵，一些包可以提供分析这些大规模矩阵的函数。_bigannalytics_ 包提供了k-means聚类、行统计量（column statistics）和一个对`biglm()`的封装。_bigtabulate_ 包提供了`table()`、`split()`和`tapply()`的功能，_bigalgebra_ 包提供了高等线性代数的函数。
* _biglars_ 包提供了最小角回归（least-angle regression）、lasso以及针对大数据集的逐步回归，数据集因太大而不能读入到内存中，这时候要配合 _ff_ 包使用。
* _Brobdingnag_ 包可以用来处理大数字（大于2&#94;1024）

处理从GB到TB级的数据对于任何数据都是极大的挑战。如果想查看R的更多方法，请看CRAN task View: _High-Performance and Parallel Computing with R_ （<http://cran.r-project.org/web/view>）。

### 译者注 ###
[李舰](http://jliblog.com/)曾经在第四届R语言会议（北京会场）上做了题为《 _R与高性能运算_ 》的报告，报告slides及代码请见[会议纪要](http://cos.name/2011/05/4th-china-r-beijing-summary/)

