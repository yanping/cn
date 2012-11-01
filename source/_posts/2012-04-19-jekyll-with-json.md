---
layout: post
title: "用jekyll生成json"
date: 2012-04-19 22:30
comments: true
categories: [jekyll, github, octopress, javascript]
description: 本文主要讨论如何用jekyll模板生成json，并以此整合在github上托管的不同网站的数据
keywords: jekyll, octopress, javascript
---

{:.info}
本文主要讨论如何用jekyll模板生成json，并以此整合在github上托管的不同网站的数据。

从去年年底接触github和jekyll到现在已经折腾五个月了，从最初用github托管纯静态网站，到现在依照别人的网站构架修改成自己喜欢的样子，这个过程也是个不断学习的过程。

我在github上有三个网站，一个是[主页][]，一个[技术博客][]，最后一个是[文艺博客][]。现在有个问题是，这三个网站对应的是github上三个不同的代码库，如果我要在[主页][]上列出另两个网站的文章列表，不能用jekyll提供的函数来做到，jekyll只能操作一个代码库的文本，不能跨代码库。我之前用的一个方法是用feedsky提供的发布脚本，效果请看<http://inwake.com/ypchen/json-demo>。这样的缺点是很显然的，一是加载速度慢，二是我们没办法控制列表的格式和样式。有没有更直接的解决方法呢？

<!--more-->

我看到在很多jekyll的博客里，都能自动生成rss.xml和atom.xml，其实说白了，只要是本文文件，jekyll都能用模板操作。后来我听说了json，听说可以用jquery调用json，既然jekyll可以操作本文，那么可不可以用jekyll来生成我们规定格式的json文件呢？例如在[技术博客][]和[文艺博客][]各生成一个包含文章信息的json文件，再用jquery或ajax来调用。这里面涉及到一个是否跨域的问题，一开始我只能确定[主页][]和[技术博客][]是同域的，可我忘了[文艺博客][]的真正地址是<http://yanping.github.com/art>，或者说是<http://chen.yanping.me/art>，<http://artn.yanping.me/>只不过是我后来给它绑定的域名，还特定用了javascript来限定了只能用这个域名访问，因为用前两个地址访问都显示不正常（关于这点，请看[这里](http://chen.yanping.me/cn/blog/2012/02/06/github-pages-domain-3/)）。所以说，只要是在同一个github账户下建立的网站，它们就是同域的。



[主页]: http://yanping.me
[技术博客]: http://yanping.me/cn
[文艺博客]: http://art.yanping.me

## 生成json ##

例如我在网站代码库里建立这样的json文件模板：

{%include_code recent.json lang:javascript ../../recent.json %}

在使用原生的jekyll时没有问题，但是在使用octopress时就出现了[问题](http://ruby-taiwan.org/topics/230)：octopress自动把英文的双引号\"变成了`&#8220;`和`&#8221;`，经过浏览器的解释对应的是&#8220;和&#8221;。有人提出在双引号前加`\`，在网页里的确是显示的原来的引号，但是一看代码，还是字符引用。

昨晚想了很久，网上找资料也没找到，没办法，只好去看octopress里的代码。我可是ruby小白啊，一点都不懂，连猜带蒙终于搞定了。其实最简单粗暴的办法就是把octopress目录下`/plugins/octopress_filters.rb`里的第19行行首加`#`注释掉：

```ruby
	#		RubyPants.new(input).to_html
```

RubyPants这个插件就是替换引号的元凶，你可以打开它卡看看里面的注释。

经过上面的处理后，octopress也可以正常输出json文件了，请看

{%include_code recent.json lang:javascript ../../../public/cn/recent.json %}

## 调用json ## 

可以用ajax或jquery来调用json文件，后者更容易一些，这里给出一个例子，效果见我的[主页][]

```html
<div class="section" id="blog1-posts-list">
		<h1 id="id165">博客</h1>
		<p>我现在主要更新的是托管在github上的<a href="http://chen.yanping.me/cn" target="_blank">Octopress博客</a>，主要记录自己在学习过程中的心得体会。近期内容：</p>

	</div>
	
		<script type="text/javascript">
		$(document).ready(function() {
			$.getJSON("/cn/recent.json",function(data){
				var content ="<ul class=\"compact recent\">";
				$.each(data,function(i,item){
				
				content += "<li><span class=\"date\">"+ item.date + "</span><a href=\""+item.url+"\">"+ item.title +"</a></li>";
				
				});
				
				content +="</ul>";
				$("#blog1-posts-list").append(content);
			});
		});	
	</script>
```

别忘了加载jquery脚本，在我主页里是这句：

```html
<script src="/files/js/jquery-1.7.1.min.js" type="text/javascript"></script> 
```



