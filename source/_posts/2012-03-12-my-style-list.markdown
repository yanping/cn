---
layout: post
title: "我的Octopress样式表"
date: 2012-03-12 22:16
comments: true
categories: octopress
description: 本文是我octopress博客的样式表，作为备忘
keywords: octopress
---

`/sass/custom/_styles.scss`里是用户自己定义的样式，我在博客里添加了表格、脚注、提示框等样式，本文作为备忘，博客每次更新本文会自动更新，这也是用octopress博客的好处，我不过是在博客里插入下面两段代码：

{% codeblock %}
{% raw %}
{% codeblock (/sass/custom/_styles.scss) %}
	{% render_partial ../sass/custom/_styles.scss raw%}
{% endcodeblock %}
{% endraw %}
{% endcodeblock %}

{% codeblock %}
{% raw %}
{% codeblock (/sass/custom/_fonts.scss) %}
	{% render_partial ../sass/custom/_fonts.scss raw%}
{% endcodeblock %}
{% endraw %}
{% endcodeblock %}

由于本人刚刚学习CSS，所以写的东西难免幼稚，也可能有错的地方，请各位看官多提宝贵意见。

关于sass和scss，请参考[《使用scss來加速寫css吧!》](http://blog.visioncan.com/2011/sass-scss-your-css/){:target="_blank"}和[《用強大的compass+sass寫css》](http://blog.visioncan.com/2011/compass-sass-your-css/){:target="_blank"}

<!--more-->

## 自定义样式 ##


{% codeblock (/sass/custom/_styles.scss) %}
{% render_partial ../sass/custom/_styles.scss raw%}
{% endcodeblock %}

## 自定义字体样式 ##


{% codeblock (/sass/custom/_styles.scss) %}
{% render_partial ../sass/custom/_fonts.scss raw%}
{% endcodeblock %}
