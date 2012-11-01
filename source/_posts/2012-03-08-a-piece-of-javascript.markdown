---
layout: post
title: "一段有用的javascript代码"
date: 2012-03-08 14:30
comments: true
categories: javascript
---


有没有发现网速不给力的时候disqus评论框加载很慢？菜鸟安装不上pygments，要实现语法高亮肿么办？用markdown写的文章链接都是原页面打开的有木有啊？我在<a href="http://beiyuu.com" target="_blank">BeiYuu</a>的博客里发现了一段js代码，正好可以解决上面的三个问题。代码如下：


{% codeblock lang:html %}
<div id="disqus_container">
    <a href="#" class="comment" onclick="return false;">点击查看评论</a>
    <div id="disqus_thread"></div>
</div>
{% endcodeblock %}

上面这段html用来代替你原来的disqus评论框的代码，页面加载的时候只看到一个“点击查看评论”的链接。

{% codeblock lang:javascript %}
<script type="text/javascript">
    BYB.readyFunction = function(){
        $(document).ready(function(){
            $('pre').addClass('prettyprint linenums') //添加Google code Hight需要的class
			
			// 加载评论框
            $('#disqus_container .comment').on('click',function(){
                $(this).html('加载中...');
                var disqus_shortname = 'disqus_name';   // 注意把disqus_name修改成自己网站的disqus名
                var that = this;
                BYB.includeScript('http://' + disqus_shortname + '.disqus.com/embed.js',function(){$(that).remove()});
            });
                            
			// 这段代码是用来提取文章中链接到其他网站的链接
			// 然后给这写链接加上外链的样式，并且修改为在新窗口打开(target=_blank)
            $('.entry a').each(function(index,element){
                var href = $(this).attr('href');
                if(href.indexOf('#') == 0){
                }else if ( href.indexOf('/') == 0 || href.toLowerCase().indexOf('beiyuu.com')>-1 ){
                }else{
                    $(this).attr('target','_blank');
                    $(this).addClass('external');
                }
            });     
			
			// 导入Prettify的javascript
            BYB.includeScript('/js/prettify/prettify.js',function(){prettyPrint()});
        });
    };
</script>
{% endcodeblock %}


他是用Google Code Prettify来实现语法高亮，使用也比较方便，只需要在`<pre>`的标签上加入prettyprint即可。当初我在windows下安装pygments也是折腾了很久也没成功，如果你跟我一样是菜鸟，还是尽量别往这坑里跳了，用Prettify或者gist吧，没必要再去学怎么使用python。

以上代码都是BeiYuu针对自己网站的样式写的，看官如果要用的话，请修改相应的样式名称。

### 参考资料 ###
BeiYuu写的建github博客的教程 <http://beiyuu.com/github-pages/>



