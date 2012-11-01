---
layout: post
title: "【译文】用Jekyll构建静态网站"
date: 2011-12-15 17:36
comments: true
categories: jekyll
---

{:.info}
原文地址 <a href="http://net.tutsplus.com/tutorials/other/building-static-sites-with-jekyll/"> http://net.tutsplus.com/tutorials/other/building-static-sites-with-jekyll/</a>


功能五花八门的CMS（内容管理系统）有时候并不是必需的，你只需要创建一个轻量级的静态网站...  当你有足够多的页面就会使复制模板文件和跨网站标记的过程变成繁琐的事。今天，我将介绍一种简单的解决方案——[Jekyll](http://jekyllrb.com/)——使你可以轻而易举地创建小型网站。

## Step 0: 遭遇Jekyll ##
{% blockquote %}
Jekyll is a simple, blog aware, static site generator.
{% endblockquote %}
Jekyll是一种简单的、适用于博客（blog aware）的、静态网站生成引擎。Jekyll网站的宣传语这么说。但，这究竟是什么意思呢？静态网站生成引擎是利用一整套文件生成网站的程序。正如你看到的，我们可以利用一套模板，单独生成内容文件，然后用Jekyll生成网站。“blog aware”意思是我们可以用它来创建博客，或者其他有系列文章（例如合集，英文称portfolio）发布的网站。让我们来尝试一下吧！

<!--more-->

## Step 1: 安装Jekyll ##

<blockquote>
 <a href="http://rubygems.org/" target="_blank">查看这里</a>来获取更多关于Ruby Gems的信息.
</blockquote>

我们从安装Jekyll开始；它是一种Ruby Gem，所以可以直接用下面的命令安装：

```sh
gem install jekyll #  use 'sudo' if your setup requires it
```

很简单吧！如果想做更多复杂的事，就需要安装其他的包了。

## Step 2: 创建第一个模板 ##
<blockquote>
任何不以下划线开头的文件和目录都会被复制到生成的网站。
</blockquote>
下一步，我们新建一个目录，命名为example-app作为演示用；我们打算建一个合集网站，比如，发布影集。这是个很好的例子，用来说明Jekyll的优势之处：这是个小网站，不会更新地太频繁，但是当你想改变其中一处小细节时如果一页页打开页面修改又很麻烦。

在example-app中，建一个名为`_layouts`的目录。注意这个下划线，任何以下划线开头的文件和目录都不会成为网站的一部分。如果它们的名字Jekyll能够识别的话（比如`_config.yml`或者`_layouts`），它们的内容会被用于生成网站，但是它们的文件不会出现在网站目录下。记住这一点：任何不以下划线开头的文件和目录都会被复制到生成的网站（默认为`_site`子目录）。

我们来创建一个layout文件。我们以包含所有元素的全局layout文件开始。在`_layouts`目录下创建名为default.html的新文件（叫什么名字无所谓），加入下面的代码：


{% gist 1481001 %}

下面是要注意的：

首先，Jekyll默认的是用[Liquid模板系统](https://github.com/shopify/liquid/wiki/liquid-for-designers)。这意味着，你用Liquid能做的事，在Jekyll模板里也能做。例如，在`<title>`标签，我们可以用两种Liquid标记语言：*输出标记*（output markup）和*标签标记* (tag markup)。输出标记会输出文本（如果被引用的变量存在），而标签标记不会。输出标记是用双花括号分隔，而标签标记是用花括号-百分号对分隔。

其次，Liquid标签中诸如`page.title`和`content`等都是Jekyll提供的变量；你可以查看文档中的[可用的模板数据](https://github.com/mojombo/jekyll/wiki/Template-Data)。我们也可以创建自定义的模板数据。

最后，注意到我们链接的CSS文件：在你的项目根目录下创建一个CSS目录，然后把下面的代码写进styles.css文件：

```css
body {
  font: 16px/1.5 verdana, helvetica-neue, helvetica, arial, san-serif;
  background: black;
  color: #ececec;
  padding: 0;
  margin: 0;
}
ul {
  margin: 0;
  padding: 0;
}
a {
  color: #ccc;
  rubyt-decoration: none;
}
 
a:hover {
  color: #ececec;
  rubyt-decoration: underline;
}
 
#main {
  width: 960px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.4);
}
header {
  padding: 0 10px;
  overflow: hidden;
}
h1 {
  margin: 0;
}
 
nav ul, ul.entries {
  list-style-type: none;
}
nav li a {
  float: left;
  margin: 5px;
}
.content {
  padding: 10px;
}
 
ul.entries li {
  position: relative;
  margin: 20px auto;
  padding: 20px;
  background: #ececec;
  width: 600px;
}
 
ul.entries img {
  width: 600px;
}
 
ul.entries li h3 {
  position: absolute;
  bottom: -18px;
  left: 17px;
  font-size: 2em;
}
ul.entries a {
  color: #ececec;
}
ul.entries a:hover {
  color: #fff;
}
 
footer {
  font-size: 0.65em;
  rubyt-align: center;
}
```

接着，创建一个img目录，并把图片加进去，比如banner.jpg，我们一会儿要用到它。任何图片都行，只要把它的大小调整为 960px &times; 300px。

你可能会觉得奇怪，在上面为什么我们用if语句？如果page.title变量存在的话它也不会显示啊！如果它存在，我想让它后面跟着竖线(｜)，另一种写法是这样：

{% codeblock %}
{% raw %}

 {{ page.title }}{% if page.title %} | {% endif %}

{% endraw %}
{% endcodeblock %}

那么我们怎样使用模板？我们需要用模板创建页面。在项目的根目录，创建名为index.html的文件。内容如下：

{% codeblock index.html lang:html %}
---
layout: default
---
<section role="banner">
  <img src="/img/banner.jpg" />
</section>
 
<section class="content">
  <p>
  Welcome to John Doe Photography! Please, check out my <a href="/portfolio/">Portfolio</a> to see my work.
  </p>
</section>
{% endcodeblock %}

这是index.html的内容。注意到文件的顶部，Jekyll称之为YAML front matter。有YAML front matter的任何文件（不以下划线开头的）将会先被Jekyll处理然后才被放进`_site`目录中，如果不以YFM开头，将会被直接放进`_site`目录。在上面这个例子中，YAML front matter告诉Jekyll要用什么模板。

然后打开终端命令行，cd进项目目录，运行jekyll。你会看到类似下面的提示：

```sh
WARNING: Could not read configuration. Using defaults (and options).
   No such file or directory - /Users/andrew/Desktop/example-app/_config.yml
Building site: /Users/andrew/Desktop/example-app -> /Users/andrew/Desktop/example-app/_site
Successfully generated site: /Users/andrew/Desktop/example-app -> /Users/andrew/Desktop/example-app/_site

```
忽略警告，我们一会儿处理。你可以看出网站在新建的`_site`目录中被构建出来。如果你用浏览器打开 `_site/index.html`文件，你可以看到网页有错误。这是因为我们的路径（url和样式表）是以斜杠`/`开头的。这意味着我们只能以文件的形式查看。当然，你可以开启W/MAMP，但是为什么要那么麻烦呢？jekyll内置有服务器。只要运行`jekyll --server`，然后浏览localhost:4000就可以看到下面的图片：

![pic1](http://d2o0t5hpnwv4c1.cloudfront.net/1064_jekyll/index.png)

如果上面的图还不够，可以看看`_site/index.html`的代码。你可以看出我们指定的模板和我们提供的内容混合在一起。哇呜！——页面就生成了。

我要提醒一点的是，是YAML front matter使得这一神奇的事发生。如果一个文件不以三个短线开头，后接一行或多行属性，再以三个短线结尾，那这个文件只会被复制到`_site`中。


## Step 3: 创建一个合集模板 ##
现在我们对基础很熟悉了，那我们来创建几幅图的合集。还记得我们前面说的jekyll是“适用于博客的”吗？我们来使用blog-awareness特性：我们来做一整套的条目(portfolio entries)，而不是零散的帖子(posts)。

帖子位于名为`_posts`目录中，创建该目录。帖子的文件名模式必须设定：year-month-day-title.ext。帖子，jekyll网站的任何文件，可以是markdown或者HTML格式。

我们来创建几个帖子：这些实际上是我们整套的条目。


{% codeblock _posts/2010-03-04-bikes.md lang:html %}
---
layout: portfolio_entry
image: /img/bikes.jpg
title: Bikes, Black and White
---
Bikes are used by almost everyone in downtown Amsterdam. These ones are chained to a bike rack.

{% endcodeblock %}


{% codeblock _posts/2010-10-01-wing.md lang:html %}
---
layout: portfolio_entry
title: Wing and a Prayer
image: /img/wing.jpg
---
The wing of the AirBus I rode to England.

{% endcodeblock %}

{% codeblock _posts/2011-06-05-bridge.md lang:html %}
---
layout: portfolio_entry
title: Stone Bridge
image: /img/bridge.jpg
---
An old stone bridge in London.
{% endcodeblock %}

{% codeblock _posts/2011-07-09-road.md lang:html %}
---
layout: portfolio_entry
title: Road and Curb
image: /img/road.jpg
---
Bike lanes here are terribly thin.

{% endcodeblock %}

相当简单，是吧？注意到，我们创建了一个自定义的YAML front matter域：image。这是该条目（entry）的图片地址。这样我们就可以在这个文件里构建整个条目的HTML。但是如果我们想修改怎么办？那我们必须返回到每个条目里进行修改。我们可以不用这样做，而使用portfolio_entry模板来表示它们。这个模板长什么样呢？也是相当简单：

{% include_code portfolio_entry.html %}

如果你看[template data page](https://github.com/mojombo/jekyll/wiki/Template-Data)，你就会发现我们添加的任何自定义front matter在page里都是可用的；在这里，我们可以访问 `page.image`。我们也可以用`page.title`和`content`（后一个三短线之后的所有东西）。

我必须提一点的是，虽然帖子（post）的 `title`被认为在post对象中是可用的，我只在page对象中也可以用。

帖子（文章）页面建立起来了，但是合集（portfolio）主页怎么办呢？当我写我们的默认layout里的导航栏时，我注意到我们要的是 `/portfolio/`。那么我们在根目录创建名为`portfolio`的目录，打开里面的index.html文件。

{% gist 1481016 %}

这是我们最复杂的一块了。记住，这不是模板：这是一个“正常的”文件，但是同样可以包含Liquid标签。我们把layout设置成default，把title设定成“Portfolio”。

注意到，在HTML文件中，我们用了Liquid的`for-in`循环。我们用`site.posts`遍历出所有帖子，然后用`for post in site.posts / endfor`遍历所有的帖子。如果你用过Wordpress，或者其他博客系统，相信你对循环的概念很熟悉。这样就完成了！正如你看到的，我们可以得到标准属性，以及我们定义的front matter（例如`image`）。

现在运行`jekyll --server`来生成网站，然后浏览localhost:4000就可以看到


![pic2](http://d2o0t5hpnwv4c1.cloudfront.net/1064_jekyll/portfolio.png)

下面是条目页面:

![pic3](http://d2o0t5hpnwv4c1.cloudfront.net/1064_jekyll/entry.png)

现在你创建了合集，你也能看出它怎么用来创建博客。 我们来看看如何设置Jekyll的配置选项.

## Step 4: 写配置文件 ##
Jekyll有大量的选项，还好很多都有默认选项。但是如果你想改变选项，也不是很难。

有两种方式改变选项：

* 第一种方式，当你在命令行运行程序，你可以传递参数。我们已经看到`--server`参数，这会在生成网站后开启服务器。
* 另一种方式，也就是我们在这里用的方法，就是在`_config.yml`文件中，每一行用`a key: value`对来设置参数，如同YAML front matter那样。Jekyll会在生成网站前寻找这个文件。

<blockquote>
查看<a href="https://github.com/mojombo/jekyll/wiki/Configuration" target="_blank">配置文档</a>，获取完整的选项列表。
</blockquote>
我们来看看常用的选项有哪些：

* auto： 添加`auto: true`到你的配置文件来保持Jekyll运行，查看你的项目目录的改变并随时生成网站。
* source: 如果源文件目录不是运行Jekyll的目录，你就要用`source`选项来设置源文件目录。
* destination: Jekyll默认会把网站生成在`./_site`，如果你想把网站生成在别的目标，就可以永这个选项设定。
* permalink：permalink是你文章的路径。默认是`/year/month/day/title.html`。你也可以自定义路径。你可以用的变量有`:year`，`:month`，`:day`，`:title` 以及`:categories`。`:categories`来自front matter；其他的变量都来自文章的文件名。你可以用`/:year/:month/:title`或者`/:categories/:title.html`的形式来设置permalink。需要注意的是，如果你文章的front matter中有permalink选项，它会覆盖掉全局的默认值。
* exclude: 像上面所言，Jekyll会忽略以下划线开头的文件，但是，如果你有需要忽略的目录，但是又不是以下划线开头，你可以在`exclude`中设定。


## Step 5: 部署网站 ##
假设你已经创建的网站，希望能在网上自由浏览，该怎么做呢？

有几种方式可以做到。当然，如果它是一个小网站你不会经常更新它，那么简单地用ftp把它上传到服务器就可以了。如果你使用共享的主机服务，这可能是你唯一的选择了。

如果你有VPS或者专用的主机，你可以更自动化地运行。查看[部署的文档](https://github.com/mojombo/jekyll/wiki/Deployment)。如果你不确定怎么做，试试使用git post-receive hook；我曾经试过，非常cool。

**译者注：**也可以把网站部署在github或者heroku上。

## Step 6: 更进一步 ##
下面是Jekyll的一些tip:

* [Jekyll插件](https://github.com/mojombo/jekyll/wiki/Plugins)允许你修改网站内容生成方式。
* 你可以用[Liquid](https://github.com/Shopify/liquid/wiki)做更多的事，Jekyll增加了很多[扩展](https://github.com/mojombo/jekyll/wiki/Liquid-Extensions) 。
* 还有很多[模板数据](https://github.com/mojombo/jekyll/wiki/Template-Data)我们没有提及，请自行查看。

## 结论 ##
本文介绍了Jekyll——一种简单的、适用于做博客的、静态网站生成引擎。下次如果你想建一个宣传册风格的、小型展示页面，可以试试用Jekyll，如果你成功了，请在留言中告诉我。感谢您的阅读！


## 译者言 ##

我也是一边翻译，一边练习使用Octopress，在翻译过程中遇到了三个问题。

第一个问题是在markdown里直接写html标签的话可能会出错。例如在step2中，我写了个&lt;title&gt;，一开始的时候没有做任何处理，结果出来的网页有错，后来我才想起来，markdown里的html语句会被直接放到最终网页里，那么我直接这么写的话，就会出现两个&lt;title&gt;，所以正确的做法是用&#96;把&lt;title&gt;括起来，或者就写`&lt;title&gt;`。就在我刚才编辑这段话时，又接连出现问题，这个&#96;会自动寻找最近的另一半来匹配，所以我不得不用数字实体引用来表示它。

第二个问题是当文章中引用了含有Liquid标签的代码片段时，这些代码会被jekyll渲染。一般代码是用<a href="http://octopress.org/docs/plugins/codeblock/" target="_blank">codeblock标签</a>或者用 <code>```</code>括起来（也就是Backtick Code Blocks的方式），能保持原样，还能显示语法高亮，但是当引用的代码里含有Liquid标签时就出现了混乱。为此，我也试了很久，也到[ruby-taiwan.org](http://ruby-taiwan.org/topics/74)上发帖问了，总结起来有几种方法：

1\. **用gist插件**

{% codeblock %}
{% raw %}
	{% gist gist_id [filename] %}
{% endraw %}
{% endcodeblock %}

这种方式比较强大，但是需要连接gist，加载页面的时候有点卡。

2\. **用include_code插件**

{% codeblock %}
{% raw %}
	{% include_code [title] [lang:language] path/to/file  %}
{% endraw %}
{% endcodeblock %}
上面两种方法在Octoprss的官方网站都有介绍，请看<http://octopress.org/docs/blogging/code/>

3\. **用codeblock标签里嵌套raw标签**，详情请看<http://jimpravetz.com/blog/2011/12/inserting-liquid-syntax-into-octopress-codeblock/>。这种方式只能帖代码，不能语法高亮。

仔细研究一下Octopress官方网站的代码（比如[codeblock这节](https://raw.github.com/imathis/octopress/site/source/docs/plugins/codeblock/index.markdown)），还能学到另一个技巧。在我翻译这篇文章时，几种方法都用到了，有兴趣的可以查看本文的markdown代码。

第三个问题是CSS代码不能被着色，找到了一篇文章<a href="http://hack.sslab.co/blog/2011/11/13/octopress-upgrade-pygments/" target="_blank">《讓 Octopress 支援更多語言的程式碼區塊（更新 Pygments）》</a>，用里面的方法更新pygment就行了。需要注意的是pygments.rb的目录和那篇文章的不同，我的ubuntu11.10下为

```sh
~/.rvm/gems/ruby-1.9.2-p290/gems/pygments.rb-0.2.4/vendor
```
后面的类似。


