---
layout: post
title: "用jekyll生成包含json变量的js脚本"
date: 2012-04-20 23:58
comments: true
categories: [jekyll, github, octopress, javascript]
description: 本文主要讨论如何用jekyll模板生成json，并以此整合在github上托管的不同网站的数据
keywords: jekyll, octopress, javascript, json
---

{:.info}
本文主要讨论如何用jekyll模板生成含有json数据的javascript脚本，并以此解决跨域读取json数据的问题。

[前一篇文章](http://yanping.me/cn/blog/2012/04/19/jekyll-with-json/)提到用getJSON读取json文件，并以此动态更新页面，但只能读取同域的json文件，据说是出于安全性的考虑。

现在问题出来了，我除了前文提到的三个网站以外，还有个[主页的镜像网站](http://inwake.com/ypchen)，它存放在美国的一位师兄的服务器上，和那三个网站肯定不同域，如果我要让它和github上的[主页](http://yanping.me)始终保持一致，又不想每次手动修改博客文章列表，也不能再使用feedsky了。因为feedsky除了慢之外，生成的列表样式也和网站风格不一致。

<!--more-->

别看表面上只有一行代码：

```html
<script src="http://feed.feedsky.com/yanping/jsout&n=5&e=utf8" type="text/javascript"></script>	
```

实际上经过了向feedsky服务器发送请求、返回数据、浏览器渲染之后的代码很臃肿，用firefox的插件firebug查看上面那行代码渲染之后的代码是如下行形式（只是个例子，等这篇文章发布以后feedsky提供的内容会改变）：

```html
<!-- Feedsky FEED JS发布代码开始 -->
    <script src="http://feed.feedsky.com/yanping/jsout&amp;n=5&amp;e=utf8">
    </script>
    <div class="reader-publisher-module" id="readerpublishermodule0" style="border: 1px solid rgb(188, 204, 235); margin: 0.5em; padding: 0pt; background: rgb(255, 255, 255) none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; font-family: arial,sans-serif; font-size: 10pt; -moz-border-radius-topleft: 8px; -moz-border-radius-topright: 8px; -moz-border-radius-bottomright: 8px; -moz-border-radius-bottomleft: 8px;">
        <h3 style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(188, 204, 235); border-width: medium medium 1px; margin: 0pt 0.5em; padding: 0.2em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; -moz-border-radius-topleft: 8px; -moz-border-radius-topright: 8px; -moz-border-radius-bottomright: 0pt; -moz-border-radius-bottomleft: 0pt; color: rgb(9, 9, 146);">
            <a href="http://chen.yanping.me/cn/">
                雁起平沙的网络日志
            </a>
        </h3>
        <ul style="border: medium none ; margin: 0pt 0.5em; padding: 0.2em; background: transparent none repeat scroll 0%; overflow: hidden; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal;">
            <li style="border: medium none ; margin: 0pt; padding: 0.4em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; list-style-type: none;">
                <a href="http://item.feedsky.com/~feedsky/yanping/~8847833/629496870/6966477/1/item.html"
                title="Thu, 19 Apr 2012 22:30:00 +0800:用jekyll生成json" class="i" style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(122, 126, 224); border-width: medium medium 1px; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; color: rgb(16, 16, 200);">
                    用jekyll生成json
                </a>
            </li>
            <li style="border: medium none ; margin: 0pt; padding: 0.4em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; list-style-type: none;">
                <a href="http://item.feedsky.com/~feedsky/yanping/~8847833/629496871/6966477/1/item.html"
                title="Fri, 30 Mar 2012 19:50:00 +0800:指数方法论入门" class="i" style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(122, 126, 224); border-width: medium medium 1px; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; color: rgb(16, 16, 200);">
                    指数方法论入门
                </a>
            </li>
            <li style="border: medium none ; margin: 0pt; padding: 0.4em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; list-style-type: none;">
                <a href="http://item.feedsky.com/~feedsky/yanping/~8847833/629496872/6966477/1/item.html"
                title="Sun, 18 Mar 2012 00:30:00 +0800:Github Pages极简教程" class="i" style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(122, 126, 224); border-width: medium medium 1px; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; color: rgb(16, 16, 200);">
                    Github Pages极简教程
                </a>
            </li>
            <li style="border: medium none ; margin: 0pt; padding: 0.4em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; list-style-type: none;">
                <a href="http://item.feedsky.com/~feedsky/yanping/~8847833/629496873/6966477/1/item.html"
                title="Tue, 13 Mar 2012 00:30:00 +0800:黑魔法利器pandoc" class="i" style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(122, 126, 224); border-width: medium medium 1px; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; color: rgb(16, 16, 200);">
                    黑魔法利器pandoc
                </a>
            </li>
            <li style="border: medium none ; margin: 0pt; padding: 0.4em 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; list-style-type: none;">
                <a href="http://item.feedsky.com/~feedsky/yanping/~8847833/629496874/6966477/1/item.html"
                title="Mon, 12 Mar 2012 22:16:00 +0800:我的Octopress样式表" class="i" style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(122, 126, 224); border-width: medium medium 1px; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: none; font-weight: normal; color: rgb(16, 16, 200);">
                    我的Octopress样式表
                </a>
            </li>
        </ul>
        <div class="f" style="border-style: solid none none; border-color: rgb(188, 204, 235) -moz-use-text-color -moz-use-text-color; border-width: 1px medium medium; margin: 0pt; padding: 0.2em 8px; background: rgb(229, 236, 249) none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: right; text-indent: 0pt; text-decoration: none; font-weight: normal; -moz-border-radius-topleft: 0pt; -moz-border-radius-topright: 0pt; -moz-border-radius-bottomright: 4px; -moz-border-radius-bottomleft: 4px; font-size: small; white-space: nowrap;">
            <a style="border: medium none ; margin: 0pt; padding: 0pt; background: transparent none repeat scroll 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; text-align: left; text-indent: 0pt; text-decoration: underline; font-weight: normal; color: rgb(137, 141, 233);"
            href="http://feed.yanping.me">
                Read in Feedsky
            </a>
        </div>
    </div>
    <!-- Feedsky FEED JS发布代码结束 -->
```

虽然不好跨域读取json数据文件，但是浏览器可以加载外部js脚本，js脚本里又可以包含json变量。

我们称提供json数据的一端为服务端，调用json数据的一端为客户端。在服务端创建下面的js脚本模板：

{%include_code recent.json lang:javascript ../../posts.js %}

经过jekyll的处理后得到：

{%include_code recent.json lang:javascript ../../../public/cn/posts.js %}

客户端页面里是这样调用的：

```html
	<div class="section" id="blog1-posts-list">
		<h1 id="id165">博客</h1>
		<p>我现在主要更新的是托管在github上的<a href="http://chen.yanping.me/cn" target="_blank">Octopress博客</a>，主要记录自己在学习过程中的心得体会。近期内容：</p>
	</div>

	<script src="http://chen.yanping.me/cn/posts.js" type="text/javascript"></script>
```

读者可以自行比较<http://inwake.com/ypchen>和<http://inwake.com/ypchen/json-demo>的差别。

## 第二种方法 ##

上面讲的这种调用方式还是不够灵活，客户端不但提供数据，还限定了使用数据的方法，如果两端你都能操作那一点问题没有，但经常两端分属不同的人维护，你也没权力指挥别人做什么。有没有更好的办法呢？答案是肯定的。只要把数据格式的定义和调用数据的函数定义分开就行。

服务端只定义json数据的形式，例如在博客<https://github.com/yanping/art>新建posts2.js的模板：

{% codeblock %}
{% raw %}
---
layout: nil
---

	var post = {
	"list":[{% for post in site.posts limit:5 %}{
	    "title":"{{post.title}}",
        "url":"{{site.url}}{{post.url}}",
        "date":"{{post.date|date_to_string}}"
    }{% if forloop.last == false %},{% endif %}
	{% endfor %}

	]};	

{% endraw %}
{% endcodeblock %}

在客户端页面这样调用：

```html
	<div class="section" id="blog2-posts-list">
	<p>我还有个文艺点儿的<a href="http://art.yanping.me" target="_blank">博客</a>，写写跟技术无关的东西。近期内容：</p>
	</div>
		
	<script src="http://art.yanping.me/posts2.js" type="text/javascript"></script>

	<!-- 下面定义数据调用方法 -->
	<script type="text/javascript">
		$(document).ready(function() {
			var content ="<ul class=\"compact recent\">";
			$.each(post.list,function(i,item){

			content += "<li><span class=\"date\">"+ item.date + "</span><a href=\""+item.url+"\">"+ item.title +"</a></li>";

			});

			content +="</ul>";
			$("#blog2-posts-list").append(content);
		
		});		
	</script>
```

我尝试了几种json数据的定义形式，[示例1][]、[示例2][]、[示例3][]和[示例4][]，只有最后一种没有办法完成调用，这是因为数据的读取和使用分别在两个`<script>`标签里，数据必须定义成全局变量才能在后面被引用。

[示例1]: http://inwake.com/ypchen/json-demo/2.html
[示例2]: http://inwake.com/ypchen/json-demo/3.html
[示例3]: http://inwake.com/ypchen/json-demo/4.html
[示例4]: http://inwake.com/ypchen/json-demo/5.html


## 进一步思考 ##

在同域的情况下，服务端生成json数据，在客户端用getJSON读取json文件，我们称之为**方法一**，这是[前一篇文章](http://yanping.me/cn/blog/2012/04/19/jekyll-with-json/)讲的方法;在跨域的情况下，服务端生成包含json变量的js脚本，然后再在客户端链接这个外部的js脚本，这种方法我们称之为**方法二**。

本文在使用**方法二**时，如果服务端和客户端分别由两个人维护的话，客户端的维护者只能被动接受。幸好我们有github，github的口号是social coding，有人翻译成社会化编程，我偏向于翻译成社交编程。想想我们在facebook、人人网这样的社交网络都干些什么，我们在那上面上发布状态、上传图片，告诉朋友以及路过的陌生人我们都做了什么、心情如何、拍了什么照片，上班时大家很喜欢挂人人，刷新鲜事；而在github上，coder们晒出自己的代码，可以关注别的coder和感兴趣的项目，登录github可以看到大家的“新鲜事”：某某创建了个什么代码库、做了什么修改，你可以亲眼看到别人的项目从最初的雏形发展成一个完美的项目，可以给别人的代码留言，报告bug，也可以fork别人的代码，根据自己的喜好做修改，如果有好的主意，可以给原作者发个pull request，作者要是也同样喜欢，就会加到自己的代码里。

在github上，跨域的问题不是那么难解决，我们完全可以针对自己的需求写个js脚本的模板，给博客的作者发个pull request，或者留言，没准儿哪天包含json变量的js脚本模板也会像rss.xml、atom.xml或者sitemap.xml一样变得成github博客的标配。






