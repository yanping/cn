---
layout: post
title: "在Octopress中使用LaTeX"
date: 2012-03-10 10:30
comments: true
categories: [octopress, LaTeX]
description: 本文主要介绍如何在Octopress博客中插入LaTeX代码
keywords: Octopress, LaTeX, jekyll, kramdown
---

这个博客的主题定位为数量金融、统计与R语言，但一直以来我都没写什么金融和统计的文章，估计很多看官都误以为我是程序猿。最初我列了个书单，计划有哪些书要读要翻译的，包括*Implementing Models in Quantitative Finance*、*Statistics and Data Analysis for Financial Engineering*和*Option Pricing and Estimation of Financial Models with R*。除了没时间开始以外，还有个原因是折腾完octopress之后也没去折腾如何在octopress中插入公式。估计ruby的程序猿很少会用到数学公式吧，对*LaTeX*的支持很有限，但是我等数学文艺青年的博客里怎能没有数学公式呢？

热心网友Sinosmond推荐使用kramdown以尽量减少往markdown中插入html代码，接着我发现此物非常强大，连*LaTeX*都支持。昨晚使用了一下，现在把心得记录于此。

先安装kramdown包

```sh
gem install kramdown
```

再把下面的代码插入`<head>`和`</head>`标签中间，如果你使用octopress，那就是添加到`/source/_includes/custom/head.html`文件里：


{% codeblock lang:html %}
<!-- mathjax config similar to math.stackexchange -->

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      processEscapes: true
    }
  });
</script>

<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    });
</script>

<script type="text/x-mathjax-config">
    MathJax.Hub.Queue(function() {
        var all = MathJax.Hub.getAllJax(), i;
        for(i=0; i < all.length; i += 1) {
            all[i].SourceElement().parentNode.className += ' has-jax';
        }
    });
</script>

<script type="text/javascript"
   src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
{% endcodeblock %}


<!--more-->

在markdown里插入下面的代码

{% codeblock lang:tex %}
$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$
{% endcodeblock %}

就会得到：

$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$

```tex
段内插入LaTeX代码是这样的：$\exp(-\frac{x^2}{2})$，试试看看吧
```
可以得到：

<div markdown="1" class="showbox">
段内插入LaTeX代码是这样的：$\exp(-\frac{x^2}{2})$，试试看看吧
</div>

详细介绍请见 <http://kramdown.rubyforge.org/syntax.html#math-blocks>

## 需要注意的问题 ##
使用kramdown时，对markdown的语法要求似乎比用rdiscount时要严格，一些在rdiscount中支持的写法，在使用kramdown不能的得到预期的效果。

例如下面的代码，在<code>```html</code>之前必须留一行的空行。

{% include_code url-jump.html %}

再比如`_italic_`，前后必须留空格，否则不能得到斜体的效果。

以`##`这样的形式标记的标题之后不能有空行... 这意味着我之前写过的文章还必须检查一遍。

## 其他功能 ##
用kramdown可以生成脚注、表格，设置标题的id...大大弥补了markdown不足，详细信息请见<http://kramdown.rubyforge.org/syntax.html>

## 参考资料 ##
<http://steshaw.org/blog/2012/02/09/hello-mathjax/> 解决了右键点击公式网页消失的问题。


