---
layout: post
title: "使用现有的jekyll模板"
date: 2011-11-12 15:36
comments: true
categories: github
---


jekyll可以生成静态页面，可以用来写博客。假设你建立的repo地址是 `https://github.com/username/reponame` :

下面的命令用于克隆和初始化别人的模板

```sh
git clone https://github.com/krisb/jekyll-template.git mysite
cd mysite
rm -rf .git
git init
git add -A
git commit -m 'initial template based on https://github.com/krisb/jekyll-template'
git remote add origin git@github.com:username/reponame.git
git push -u origin master
```

原文地址 <a target="_blank" href="https://github.com/krisb/jekyll-template">https://github.com/krisb/jekyll-template</a>

###延伸阅读：###

* <a target="_blank" href="http://kyle.xlau.org/2009/08/13/blogging-like-a-hacker.html">像黑客一样写博客</a>
* <a target="_blank" href="http://blog.leezhong.com/tech/2010/08/25/make-github-as-blog-engine.html">使用github作为博客引擎</a>
* <a target="_blank" href="http://www.yangzhiping.com/tech/wordpress-to-jekyll.html">告别wordpress，拥抱jekyll</a>
* <a target="_blank" href="http://roylez.heroku.com/2010/02/04/jekyll-on-heroku.html">在heroku上用jekyll做博客</a>
* <a target="_blank" href="http://www.shaoshing.com/2010/04/03/blog-engine-jekyll-vs-toto/">轻量级博客工具: Jekyll vs ToTo</a>
* <a target="_blank" href="http://blog.miaout17.net/2011/05/08/convert-wordpress-to-jekyll-and-disqus/">將Wordpress轉移到Jekyll及Disqus</a>
