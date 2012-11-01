---
layout: post
title: "为Octopress修改主题和自定义样式"
date: 2012-01-07 21:16
comments: true
categories: octopress
---

<p class="info">
本文翻译自Octopress的帮助文档<a href="http://octopress.org/docs/theme" target="_blank">Theming & Customization</a>。
本人水平有限，不当之处请指正，欢迎留言给出修改意见。
</p>

Octopress在 `.themes` 目录提供了一个默认主题。当你安装Octopress时，HTML和Javascripts被复制到 `/source`，Sass样式表被复制到 `/sass`。
你可以随意修改上述文件，不过我还是设计了一些模式，来让自定制变得更简单，更新Octopress更方便。

本文分成两部分：

1. [自定义模板]({{page.url}}#theme) - *学习如何修改HEAD，sidebar，header，navigation 以及footer*
2. [修改样式]({{page.url}}#styles) - *学习如何修改颜色和布局，控制样式*

<!--more-->

<h2 id="theme" style="font-size:32px;color:red;">1. 主题</h2>

不久前发布的 Octopress 2.0版增加了 `source/_includes/custom`目录。 如果你没有这个目录， 建议 [升级](http://octopress.org/docs/updating){:target="_blank"} Octopress，因为它真的很棒。

    source/
      _includes/    # Main layout partials
        custom/     # <- Customize head, header, navigation, footer, and sidebar here
        asides/     # Theme sidebar partials
        post/       # post metadata, sharing & comment partials
      _layouts/     # layouts for pages, posts & category archives

<h2 id="landing_page">登录页 vs. 博客主页</h2>

Octopress默认地把博客主页生成在网站的根目录下。
如果你想把你的博客主页发布在别的位置，比如 `blog/index.html`，那么请在终端里进行下面的操作：

``` sh
    mv source/index.html source/blog/index.html
    rake new_page[index.html]
```

当你 [更新Octopress](http://octopress.org/docs/updating){:target="_blank"}，下一步你要更新`Rakefile` ，以保证博客主页不被修改。

``` ruby
    blog_index_dir = 'source/blog'
```

记住修改网站的导航栏（navigation），因为现在博客链接指向`/`。跳到下面[修改navigation](#changing_navigation)这节，添加“主页”链接，更新“博客”链接指向`/blog/`。

最后，`source/index.html` 可以成为你网站的登录页（landing page）。
## 修改 &lt;HEAD&gt;

如果你想修改`<HEAD>`，请看一下 `/source/_includes/custom/head.html`。

{% codeblock &lt;HEAD&gt; (source/_includes/custom/head.html) %}
{% render_partial ../source/_includes/custom/head.html raw%}
{% endcodeblock %}

在这里你可以轻易地修改或移除[Google Webfonts](http://google.com/webfonts){:target="_blank"}，插入javascripts等等。

### 修改侧边栏
Octopress整合了一些[第三方服务](http://www.octopress.org/docs/configuring/#third_party){:target="_blank"}，诸如出现在侧边栏的Twitter，Pinboard和Delicious。
在`_config.yml`你可以重新安排它们的位置，为每种layout创建自定制的侧边栏，添加你自己的侧边栏section。

{% codeblock Sidebar configuration (_config.yml) %}
default_asides:   [asides/recent_posts.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html]
# blog_index_asides:
# post_asides:
# page_asides:
{% endcodeblock %}

如果你想在侧边栏添加新的section，就在 `source/_includes/custom/asides/`中创建新的文件。
许多都会想在侧边栏加一个“关于我”的section，上面提到的这个目录下已经有个`about.html` 文件以供修改。内容如下：

{% codeblock About Me (source/_includes/custom/asides/about.html) %}
<section>
  <h1>About Me</h1>
  <p>A little something about me.</p>
</section>
{% endcodeblock %}

如果你要添加section到侧边栏, 必须遵循这样的模式，要有一个`<section>` 代码块，并以`<h1>`为标题。如果想把这个section加到侧边栏里，就要编辑 `_config.yml` 把它加到asides列表里。

{% codeblock Sidebar configuration (_config.yml) %}
default_asides:     [asides/recent_posts.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html]
blog_index_asides:  [custom/asides/about.html, asides/recent_posts.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html]
post_asides:        [custom/asides/about.html, asides/recent_posts.html, asides/twitter.html, asides/delicious.html, asides/pinboard.html]
# page_asides:
{% endcodeblock %}

在上面的配置文件中，我向博客主页和文章页面添加了about页。 由于`page_asides` 没有被设置, 它会从默认列表（default_asides）中继承内容。

## 修改Header, Navigation和Footer

网站的这几个部分是经常被自定制的。你可以编辑 `/source/_includes/custom/`里的每个文件，即使更新Octopress,你的修改还会保留。

### 修改Header

header的标题和子标题必须在 `_config.yml`中设置。如果你想对header做其他设置，就要编辑`/source/_includes/custom/header.html`：

{% codeblock Header (source/_includes/custom/header.html) %}
{% render_partial ../source/_includes/custom/header.html raw%}
{% endcodeblock %}

<h3 id="changing_navigation">修改Navigation</h3>

编辑`/source/_includes/custom/navigation.html`来修改或添加链接到主导航栏，代码如下：

{% codeblock Navigation (source/_includes/custom/navigation.html) %}
{% render_partial ../source/_includes/custom/navigation.html raw%}
{% endcodeblock %}

每个链接的`href`都以 `{% raw %}{{ root_url }}{% endraw %}`开始 (如果网站部署到子目录里，这可以帮助Octopress采用不同的链接).
如果你想把你的网站部署到像 `yoursite.com/octopress` 这样的子目录，你必须把它加到你添加的任何链接里。

### 修改Footer

你可以在`source/_includes/custom/footer.html`中修改footer，像这样：

{% codeblock Footer (source/_includes/custom/footer.html) %}
{% render_partial ../source/_includes/custom/footer.html raw%}
{% endcodeblock %}

你可以做任意修改，只要够酷并保留Octopress的链接就可以。

<h2 id="styles" style="font-size:32px;color:red;">2. 样式</h2>

<h2 id="overriding_styles">控制样式</h2>
如果想添加或控制样式，编辑`sass/custom/_styles.scss`。样式表最后才引入， so you can override styles with the cascade.

<h2 id="customizing_styles">修改配色</h2>
请查看[HSL Color Picker](http://hslpicker.com){:target="_blank"}，它可以帮助你选择颜色，是一种易用的基于网页的选色工具。

    # In /sass/base/
    _theme.scss      # All colors are defined here

    # In /sass/custom/ - Change these files for easy customization
    _colors.scss     # Override colors in base/_theme.scss to change color schemes
    _styles.scss     # Easly Override any style (last in the cascade)


Octopress的所有颜色都是以Sass变量的形式在 `/sass/base/_theme.scss`文件中定义。
想自定制你的配色，就要编辑`sass/custom/_colors.scss` 并在`sass/base/_theme.scss`中控制颜色。

Octopress官方网站用的是默认的'classic'主题，颜色在自定制颜色文件中稍微做了调整。仔细看这个文件，你会看到sass代码的某些行被取消注释。

{% codeblock Custom Colors (sass/custom/_colors.scss) https://github.com/imathis/octopress/tree/master/.themes/classic/sass/custom/_colors.scss View on Github %}
	$header-bg: #263347;
	$subtitle-color: lighten($header-bg, 58);
	$nav-bg: desaturate(lighten(#8fc17a, 18), 5);
	$sidebar-bg: desaturate(#eceff5, 8);
	$sidebar-link-color: saturate(#526f9a, 10);
	$sidebar-link-color-hover: darken(#7ab662, 9);
{% endcodeblock %}

自定制颜色文件有几项被取消注释的颜色可以用。主题文件被分成几个部分以使文件更容易阅读。请看`sass/base/_theme.scss`中关于navigation的部分。

{% codeblock Navigation (sass/base/_theme.scss) https://github.com/imathis/octopress/tree/master/.themes/classic/sass/base/_theme.scss View on Github %}
	/* Navigation */
	$nav-bg: #ccc !default;
	$nav-color: darken($nav-bg, 38) !default;
	$nav-color-hover: darken($nav-color, 25) !default;
	...
{% endcodeblock %}

The `!default` rule lets the variable be overridden if it is defined beforehand.
is imported before the `_theme.scss` it can predefine these colors easily. There are comments to help out with this in the
[source](https://github.com/imathis/octopress/tree/master/.themes/classic/sass/custom/_colors.scss).

主题里的许多颜色是用 [Sass's color functions](http://sass-lang.com/docs/yardoc/Sass/Script/Functions.html){:target="_blank"}来设置的。
你可以通过设置`$nav-bg`变量为navigation选择新的背景颜色，并且其它颜色会做相应的改变。虽然这不是很完美，但是它对大多数颜色都是合适的。


<h2 id="changing_layout">修改布局</h2>

    # In /sass/base
    _layout.scss     # Responsive layouts are defined here

    # In /sass/custom - Change these files for easy customization
    _layout.scss     # Override settings for base/_layout.scss to change the layout

和颜色一样， `/sass/base/_layout.scss`里的宽度像`$max-width: 1200px !default;`定义，在`sass/custom/_layout.scss`中定义它们可以很容易地自定制。下面是布局的一些默认值：

{% codeblock Layout Defaults (_layout.scss) https://github.com/imathis/octopress/tree/master/.themes/classic/sass/base/_layout.scss view on Github %}
	$max-width: 1200px !default;

	// Padding used for layout margins
	$pad-min: 18px !default;
	$pad-narrow: 25px !default;
	$pad-medium: 35px !default;
	$pad-wide: 55px !default;

	// Sidebar widths used in media queries
	$sidebar-width-medium: 240px !default;
	$sidebar-pad-medium: 15px !default;
	$sidebar-pad-wide: 20px !default;
	$sidebar-width-wide: 300px !default;

	$indented-lists: false !default;
{% endcodeblock %}

这些变量是用来计算相应布局的宽度和padding的。`$indented-lists` 变量允许你选择列表的样式是使用缩进还是正常的。

## 推荐文章 ##
关于sass和scss，请看<http://blog.visioncan.com/2011/sass-scss-your-css/>{:target="_blank"}

