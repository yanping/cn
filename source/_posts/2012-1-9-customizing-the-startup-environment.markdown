---
layout: post
title: "定制R启动环境"
date: 2012-01-09 22:16
comments: true
categories: R语言
---

<p class="info">
本文翻译自<a href="http://www.manning.com/kabacoff/" target="_blank">R in Action</a>的附录B，如果对该书感兴趣，请自行购买或去图书馆阅读。<br />
R导论的10.8也是讲定制环境的。
</p>

程序员最喜欢做的事之一是定制启动环境，好让程序按照他们喜欢方式工作。定制启动环境可以让你设置R的选项、指定工作目录、加载常用的包、加载用户自己写的函数、设置CRAN下载网址以及其它操作。

你可以通过编辑位置位置初始化文件（Rprofile.site）或者目录初始化文件（.Rprofile）来定制R环境。这两个是纯文本文件，包含启动时要执行的R代码。

<!--more-->

在启动的时候，R会从*R_HOME*/etc这个目录寻找Rprofile.site来调用，其中 *R_HOME* 是环境变量。然后R会在当前工作目录寻找.Rprofile文件来调用。如果R没有找到这个文件，就会在用户的主目录寻找。你可以用`Sys.getenv("R_HOME")`、`Sys.getenv("HOME")`和`getwd()`分别查看*R_HOME* 、*HOME*以及当前工作目录。

你可以在这些文件里放两个特殊的函数，`.First()`函数在启动R会话的时候执行，`.Last()`函数在结束会话的时候执行。Rprofile.site文件的例子如下：

{% codeblock Sample Rprofile.site file  lang:r %}
# 设置常用选项
options(papersize="a4")
options(editor="notepad")
options(pager="internal")
options(tab.width = 2)
options(width = 130)
options(graphics.record=TRUE)
options(show.signif.stars=FALSE)

# 设置R交互提示信息
options(prompt="> ")
options(continue="+ ")

.libPaths("C:/my_R_library") # 设置包的本地库（library）路径

# 设置CRAN镜像默认地址
local({r <- getOption("repos")
     r["CRAN"] <- "http://cran.case.edu/"
     options(repos=r)})

# 启动函数
.First <- function(){
 library(lattice)
 library(Hmisc)
 source("C:/mydir/myfunctions.R")
 cat("\nWelcome at", date(), "\n")
}

# 会话结束函数
.Last <- function(){
 cat("\nGoodbye at ", date(), "\n")
}

{% endcodeblock %}

关于这个文件，你需要注意以下几点：

* 设置.libPaths值允许你在R的安装目录之外创建包的本地库。这再升级时很有用，可以保留之前安装的包。
* 设置CRAN镜像网站可以让你在使用`install.packages()`命令时不用每次都选择。
* `.First()`函数是一个很好的地方，来加载你常用的包，运行常用的用户编写的函数。
* `.Last()`函数一个很好的地方做清理活动，包括保存命令历史、程序输出和数据文件。

还有其他定制启动环境的方式，包括使用命令行选项和环境变量。查看`help(Startup)`以及R导论的附录B（<http://cran.r-project.org/doc/manuals/R-intro.pdf>，中文版地址<http://cran.r-project.org/doc/contrib/Ding-R-intro_cn.pdf>）获取更多细节。






