---
layout: post
title: "再谈github页面域名绑定"
date: 2011-12-26 14:56
comments: true
categories: [jekyll, github]
description: 本文主要介绍如何设定github博客的域名
keywords: jekyll, github, 博客, 域名
---

之前我写过一篇<a href="http://chen.yanping.me/cn/blog/2011/12/04/github-pages-domain/" target="_blank">浅谈github页面域名绑定</a>，现在一直困扰我的问题终于解决了。

假设你的用户名是`username`，要绑定一个二级域名的话，那么不管是user page还是project page，除了在github的版本库里添加CNAME文件，还要在DNS record里增加相应的CNAME记录指向`username.github.com`。注意这里的表述，指向的地址在两种情况下都是一样的。

如果要绑定顶级域名，就建立A记录，指向`207.97.227.245`。

经过这样的操作，你想绑定几个域名都可以了。

## 域名跳转的问题 ##
<del>当你访问`username.github.com`这个地址时，Github会自动转到绑定的域名，但是当你访问`http://username.github.com/repo-name`这样的网址，虽然可以显示网页，但是地址不会自动转。</del>

<del>可以用.htaccess文件来实现跳转，在repo代码库根目录下创建.htaccess文件</del>

<p><span class="warning">
本文域名跳转部分有误，请看<a href="http://chen.yanping.me/cn/blog/2012/02/06/github-pages-domain-3/" target="_blank">三谈github页面域名绑定</a>
</span>
</p>


