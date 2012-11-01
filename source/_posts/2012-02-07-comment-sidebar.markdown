---
layout: post
title: "给博客侧边栏添加近期评论"
date: 2012-02-07 14:56
comments: true
categories: octopress
---

<p class="info">
在我翻译的<a href="http://chen.yanping.me/cn/blog/2012/01/07/theming-and-customization/" target="_blank">为Octopress修改主题和自定义样式</a>一文后面，Eric Lau问我如何在博客侧边栏显示近期评论。本文就是针对这一问题的简短教程。
</p>

## 第一步：在disqus.com获取代码 ##
登录到disqus.com，选择评论所在的网站，进入Admin，选择Tools，在code中，是**Extra Widgets**的代码，提供了几种Widgets插件，分别是Combination（组合式）、Recent Comments（近期评论）、 Popular Threads（热门话题）、Top Commenters（最近评论人）。该工具可以根据用户设置的参数生成代码。

{% img /images/blog/12-02-07/tools-setting.png %} 

<!-- more -->

## 第二步：把代码添加到octopress
按照<a href="http://chen.yanping.me/cn/blog/2012/01/07/theming-and-customization/" target="_blank">为Octopress修改主题和自定义样式</a>一文的描述，在sidebar里添加一个section，比如叫做recent_comments.html，代码如下：

{% codeblock recent_comments.html (../source/_includes/custom/asides/recent_comments.html) %}
{% render_partial ../source/_includes/custom/asides/recent_comments.html raw%}
{% endcodeblock %}


## 第三步：修改_config.yml ##
按照<a href="http://chen.yanping.me/cn/blog/2012/01/07/theming-and-customization/" target="_blank">为Octopress修改主题和自定义样式</a>一文的描述，修改_config.yml，以决定评论插件出现的位置。

{% codeblock Sidebar configuration (_config.yml) %}
# list each of the sidebar modules you want to include, in the order you want them to appear.
# To add custom asides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
default_asides:     [asides/recent_posts.html, custom/asides/recent_comments.html, custom/asides/blogroll.html,custom/asides/weibo.html, custom/asides/copyleft.html,custom/asides/feed.html]

# Each layout uses the default asides, but they can have their own asides instead. Simply uncomment the lines below
# and add an array with the asides you want to use.

blog_index_asides:  [custom/asides/about.html, asides/recent_posts.html, custom/asides/recent_comments.html, custom/asides/blogroll.html, custom/asides/weibo.html, custom/asides/copyleft.html, custom/asides/feed.html]
post_asides:        [asides/recent_posts.html, custom/asides/recent_comments.html, custom/asides/blogroll.html, custom/asides/weibo.html, custom/asides/copyleft.html, custom/asides/feed.html]
# page_asides:
{% endcodeblock %}




