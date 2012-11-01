---
layout: post
title: "Windows下安装Octopress"
date: 2011-12-26 15:36
comments: true
categories: octopress
---

首先，我要感慨一下，有心栽花花不开，无心插柳柳成荫。

最初我发现在windows下不能部署octopress，安装rvm不成功，跟<a href="http://yangzhiping.com" target="_blank">阳志平</a>交流后，他也说在windows不可以，到网上搜寻了一下，也没有人说在windows下安装成功。

去上海参加[R语言会议](http://cos.name/2011/11/4th-china-r-shanghai-summary/)时，见到怡轩和思喆的ubuntu，甚是羡慕，当初哥也玩过很长一段时间的，没玩明白呢就荒废了，现在决定捡起来。重新给硬盘分区太麻烦了，好在现在的电脑性能比3、4年前要强太多了，办公室的电脑随便哪台都是双核4G内存256G硬盘，用来打字上网淘宝人人开心微博就太浪费了<sup>[<a id="back_2_1" href="#fn_2_1">1</a>]</sup>，于是我决定在办公室的电脑上安装虚拟机virtualBox，在虚拟机里装ubuntu 10.04。这中间也遇到了些问题，我到ruby-taiwan上也发帖问过（请看<a href="http://ruby-taiwan.org/topics/37" target="_blank">当时的帖子</a>）。后来用wubi的方式在自己笔记本上安装了ubuntu11.10，用得挺爽，我的octopress博客也开张了，地址是<a href="http://chen.yanping.me/cn" target="_blank">http://chen.yanping.me/cn</a>。原来的wordpress博客暂停更新。

因为大部分工作还是要在windows里完成，所以我还是想能在windows下使用Octopress。

<!--more-->

想起阳志平推荐的RailsInstaller<sup>[<a id="back_2_2" href="#fn_2_2">2</a>]</sup>，其中ruby的版本就是1.9.2，而Octopress就要求Ruby1.9.2的环境。于是打开Git Bash，按照<a href="http://octopress.org/docs/" target="_blank">官方指南</a>安装，

```sh
git clone git://github.com/imathis/octopress.git octopress
cd octopress    # If you use RVM, You'll be asked if you trust the .rvmrc file (say yes).
ruby --version  # Should report Ruby 1.9.2
gem install bundler
bundle install
```

`bundle install`不成功的话可以换成`bundle update`。下一步应该运行`rake install`了，结果返回信息：

```sh
You have already activated rake 0.9.2.2, but your Gemfile requires rake 0.9.2. Using bundle exec may solve this.
```

换成`bundle exec rake install`就行了，于是后面所有要用到rake的命令，通过都用bundle exec rake代替。嫌麻烦的话也可以在bash的配置文件里添加命令的别名。如果你windows的用户名为user，bash的配置文件在C:\Documents and Settings\user下，也可以直接在git bash下输入`cd ~`，文件名为`.bash_profile`，在文件里添加一行

```sh
alias rake='bundle exec rake'

```
后面都和官方指南一样。但真正用起来的时候，发现不能使用中文（请看<a href="http://ruby-taiwan.org/topics/46" target="_blank">帖子</a>）。经论坛上laoyang945点拨，字符集不兼容的问题终于解决了，只要在`.bash_profile`再加两行

```sh
export   LC_ALL=zh_CN.UTF-8
export   LANG=zh_CN.UTF-8 
```

另外，淘宝给我们送了一份圣诞大礼（请猛戳<a href="http://www.oschina.net/news/24321/rubygems-taobao-mirror?from=rss" target="_blank">淘宝提供RubyGems的国内镜像站点</a>），这样我可以修改下载的Octopress目录下的Gemfile文件，把第一行改成

```ruby
source "http://ruby.taobao.org/"
```
做这样的修改后，安装速度会大大提高。

### 脚注 ###
1. 我所在的并不是技术公司，相反，那是个文人聚集的地方  [<a id="fn_2_1" href="#back_2_1">↩</a>] 
2. 关于在windows下搭建ruby环境，请看他的[文章](http://www.yangzhiping.com/tech/happy-ruby-ps1-windows.html) [<a id="fn_2_2" href="#back_2_2">↩</a>] 

<p class="warning">
有人反映在win7下找不到<code>.bash_profile</code>文件，新建这个也没用。我暂时也没有win7的测试环境，论坛上有人提出了解决方法，更多的讨论请看<a href="http://ruby-taiwan.org/topics/46">http://ruby-taiwan.org/topics/46</a> 。
</p>

