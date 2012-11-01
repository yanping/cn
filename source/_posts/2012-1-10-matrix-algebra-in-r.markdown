---
layout: post
title: "R的矩阵代数"
date: 2012-01-10 14:00
comments: true
categories: R语言
description: 介绍R语言的矩阵运算
keywords: R语言, 矩阵
---
<p class="info">
本文翻译自<a target="_blank" href="http://www.manning.com/kabacoff/">R in Action</a>的附录E，如果对该书感兴趣，请自行购买或去图书馆阅读。<br />
更多的例子请看<a href="http://yishuo.org/2011/08/matrix-operations/">http://yishuo.org/2011/08/matrix-operations/</a>
</p>

书中描述的很多函数都是在矩阵上的操作。矩阵的处理根植于R语言底层。下表描述了求解线性代数问题中重要的操作符和函数。下表中，A和B是矩阵，x和b是向量，k是标量。

<table class="datalist" markdown="0">
<caption>矩阵代数的R函数和操作符</caption>
<tr>
	<th>操作符或函数</th><th>描述</th>
</tr>
<tr>
	<td>+ -<code> *</code> / ^</td><td>对应元素相加、相减、相乘、相除、求幂</td>
</tr>
<tr>
	<td>A <code>%*%</code> B</td><td>矩阵相乘</td>
</tr>
<tr>
	<td>A <code>%o%</code> B</td><td>矩阵的外积。<code>AB'</code></td>
</tr>
<tr>
	<td>cbind(A, B, ...)</td><td>横向组合矩阵或向量</td>
</tr>
<tr>
	<td>col(A)</td><td>求A的Choleski因子。如果<code>R <- chol(A)</code>，则<code>chol(A)</code>包含上三角因子，并有<code>R'R=A</code></td>
</tr>
<tr>
	<td>colMeans(A)</td><td>返回一个向量，包含A每列的均值</td>
</tr>
<tr>
	<td>crossprod(A)</td><td><code>A'A</code></td>
</tr>
<tr>
	<td>crossprod(A,B)&nbsp;&nbsp;&nbsp;&nbsp;</td><td><code>A'B</code></td>
</tr>
<tr>
	<td>colSums(A)</td><td>返回一个向量，包含A每列的和</td>
</tr>
<tr>
	<td>diag(A)</td><td>返回一个向量，包含主对角线元素</td>
</tr>
<tr>
	<td>diag(x)</td><td>以x为主对角线元素创建对角矩阵</td>
</tr>
<tr>
	<td>diag(k)</td><td>如果k是标量，则创建一个k &times; k的单位矩阵</td>
</tr>
<tr>
	<td>eigen(A)</td><td>A的特征值和特征向量。如果<code>y <- eigen(A)</code>，则<br />
	<code>y$val</code>是A的特征值，<code>y$vec</code>是A的特征向量
	</td>
</tr>
<tr>
	<td>ginv(A)</td><td>A的Moore-Penrose广义逆。（需要MASS包）</td>
</tr>
<tr>
	<td>qr(A)</td><td>A的QR分解。如果<code>y <- qr(A)</code>，则<br />
	<code>y$qr</code>有一个包含分解值的上三角矩阵和一个包含分解值信息的下三角矩阵，<code>y$rank</code>是A的秩，<code>y$qraux</code>是包含Q其他信息的向量，<code>y$pivot</code>包含旋转策略的信息。
	</td>
</tr>
<tr>
	<td>rbind(A, B, ...)</td><td>纵向组合矩阵或向量</td>
</tr>
<tr>
	<td>rowMeans(A)</td><td>返回一个向量，包含A每行的均值</td>
</tr>
<tr>
	<td>rowSums(A)</td><td>返回一个向量，包含A每行的和</td>
</tr>
<tr>
	<td>solve(A)</td><td>求A的逆，其中A是方阵</td>
</tr>
<tr>
	<td>solve(A, b)</td><td>解出方程b=Ax里的向量x</td>
</tr>

<tr>
	<td>svd(A)</td><td>A的奇异值分解。如果<code>y <- svd(A)</code>，则	<code>y$d</code>是包含A的奇异值的向量，矩阵<code>y$u</code>的列向量包含A的左奇异值向量，矩阵<code>y$v</code>的列向量包含A的右奇异值向量。</td></tr>

<tr>
	<td>t(A)</td><td>求A的转置</td>
</tr>
</table>



还有一些用户贡献的包专门用于矩阵代数。_matlab_ 包封装了类似MATLAB语言的矩阵操作函数和变量。这些函数可以帮助用户将MATLAB程序移植到R语言代码。<http://mathesaurus.sourceforge.net/octave-r.html>上有一份很有用的清单可以帮助你将MATLAB语句转化为R语句。

_Matrix_ 包提供的函数使R可以处理高密度矩阵或稀疏矩阵。它提供了对BLAS（Basic Linear Algebra Subroutines）、Lapack（dense matrix）、TAUCS（sparse matrix）和UMFPACK（sparse matrix）的高效调用。

最后，_matrixStats_ 包提供了对矩阵的行和列的操作方法，例如计数、求和、中心趋势、离差（dispersion）等。每一个函数都进过了优化，使得可以高速高效地运行。


