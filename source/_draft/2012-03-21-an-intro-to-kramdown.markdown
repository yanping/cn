---
layout: post
title: "kramdown简介"
date: 2012-03-21 9:30
comments: true
categories: [markdown, octopress]
description: 本文简要介绍kramdown
keywords: Octopress, kramdown
---

原文来自 <http://kramdown.rubyforge.org/syntax.html>{:.target="_blank"}，本文仅选择几条有意思的特性做介绍。

## 段落 ##
段落分行的问题。其中每个`⋅`代表一个空格。

	This⋅para⋅line⋅starts⋅at⋅the⋅first⋅column.⋅However,
	⋅⋅⋅⋅⋅⋅the⋅following⋅lines⋅can⋅be⋅indented⋅any⋅number⋅of⋅spaces/tabs.
	⋅⋅⋅The⋅para⋅continues⋅here.

	⋅⋅This⋅is⋅another⋅paragraph,⋅not⋅connected⋅to⋅the⋅above⋅one.⋅But⋅⋅
	with⋅a⋅hard⋅line⋅break.⋅\\
	And⋅another⋅one.

得到下面的效果：

<div markdown="1" class="showbox">
This para line starts at the first column. However,
      the following lines can be indented any number of spaces/tabs.
   The para continues here.

  This is another paragraph, not connected to the above one. But  
with a hard line break. \\
And another one.
</div>

## 缩略 ##
	This is some text not written in HTML but in another language! 用中文可以吗？

	*[another language]: It's called Markdown
	*[HTML]: Hyper Text Markup Language
	*[中文]: 东方的一种文字

对应的效果是：

<div markdown="1" class="showbox">
This is some text not written in HTML but in another language! 用中文可以吗？

*[another language]: It's called Markdown
*[HTML]: Hyper Text Markup Language
*[中文]: 东方的一种文字
</div>



<!--more-->

## 属性列表 ##
This is an implementation of [Maruku]{:target="_blank"}’s feature for adding attributes to block and span-level elements (the naming is also taken from [Maruku]{:target="_blank"}). This block-level element is used to define attributes which can be referenced later. The Block Inline Attribute List is used to attach attributes to a block-level element and the Span Inline Attribute List is used to attach attributes to a span-level element.

[Maruku]: http://maruku.rubyforge.org/ 

Following are some examples of attribute list definitions (ALDs) and afterwards comes the syntax explanation:

	{:ref-name: #myid .my-class}
	{:other: ref-name #id-of-other title="hallo you"}
	{:test: key="value \" with quote" and other='quote brace \}'}


An ALD line has the following structure:

* a left brace, optionally preceded by up to three spaces,
* followed by a colon, the reference name and another colon,
* followed by attribute definitions (allowed characters are backslash-escaped closing braces or any character except a not escaped closing brace),
* followed by a closing brace and optional spaces until the end of the line.

The reference name needs to start with a word character or a digit, optionally followed by other word characters, digits or dashes.

There are four different types of attribute definitions which have to be separated by one or more spaces:

### 1. references ###
This must be a valid reference name. It is used to reference an other ALD so that the attributes of the other ALD are also included in this one. The reference name is ignored when collecting the attributes if no attribute definition list with this reference name exists. For example, a simple reference looks like id.

### 2. key-value pairs ###
A key-value pair is defined by a key name, which must follow the rules for reference names, then an equal sign and then the value in single or double quotes. If you need to use the value delimiter (a single or a double quote) inside the value, you need to escape it with a backslash. Key-value pairs can be used to specify arbitrary attributes for block or span-level elements. For example, a key-value pair looks like key1="bef \"quoted\" aft" or title='This is a title'.

### 3. ID name ###
An ID name is defined by using a hash and then the identifier name which needs to start with a word character or a digit, optionally followed by other word characters, digits, dashes or colons. This is a short hand for the key-value pair id="IDNAME" since this is often used. The ID name specifies the unique ID of a block or span-level element. For example, an ID name looks like #myid.

### 4. class names ###
A class name is defined by using a dot and then the class name. This is (almost, but not quite) a short hand for the key-value pair class="class-name". Almost because it actually means that the class name should be appended to the current value of the class attribute. The following ALDs are all equivalent:

    {:id: .cls1 .cls2}
    {:id: class="cls1" .cls2}
    {:id: class="something" class="cls1" .cls2}
    {:id: class="cls1 cls2}

As can be seen from the example of the class names, attributes that are defined earlier are overwritten by ones with the same name defined later.

### block 属性 ###
	A simple paragraph with an ID attribute.
	{: #para-one}

	> A blockquote with a title
	{:title="The blockquote title"}
	{: #myid}

	{:.ruby}
		Some code here

渲染以后的代码是：

```html
<p id="para-one">A simple paragraph with an ID attribute.</p>

<blockquote title="The blockquote title" id="myid">
	<p>A blockquote with a title</p>
</blockquote>

<pre class="ruby">
	<code>
	Some code here
	</code>
</pre>
```

### 行内属性表 ###


## 链接 ##
	[链接](http://chen.yanping.me){:target="blank"}

<div markdown="1" class="showbox">
[链接](http://chen.yanping.me){:target="blank"}
</div>



## 表格 ##
	{:.datalist}
	|-----------------+------------+-----------------+----------------|
	| Default aligned |Left aligned| Center aligned  | Right aligned  |
	|-----------------|:-----------|:---------------:|---------------:|
	| First body part |Second cell | Third cell      | fourth cell    |
	| Second line     |foo         | **strong**      | baz            |
	| Third line      |quux        | baz             | bar            |
	|-----------------+------------+-----------------+----------------|
	| Second body     |            |                 |                |
	| 2 line          |            |                 |                |
	|=================+============+=================+================|
	| Footer row      |            |                 |                |
	|-----------------+------------+-----------------+----------------|

{:.datalist}
|-----------------+------------+-----------------+----------------|
| Default aligned |Left aligned| Center aligned  | Right aligned  |
|-----------------|:-----------|:---------------:|---------------:|
| First body part |Second cell | Third cell      | fourth cell    |
| Second line     |foo         | **strong**      | baz            |
| Third line      |quux        | baz             | bar            |
|-----------------+------------+-----------------+----------------|
| Second body     |            |                 |                |
| 2 line          |            |                 |                |
|=================+============+=================+================|
| Footer row      |            |                 |                |
|-----------------+------------+-----------------+----------------|

上面的写法太费时间，可以简写成这样

	|---
	| Default aligned | Left aligned | Center aligned | Right aligned
	|-|:-|:-:|-:
	| First body part | Second cell | Third cell | fourth cell
	| Second line |foo | **strong** | baz
	| Third line |quux | baz | bar
	|---
	| Second body
	| 2 line
	|===
	| Footer row


## 印刷符号 ##
+ `---` will become an em-dash (like this ---)
+ `--` will become an en-dash (like this --)
+ `...` will become an ellipsis (like this ...)
+ `<<` will become a left guillemet (like this <<) – an optional following space will become a non-breakable space
+ `>>` will become a right guillemet (like this >>) – an optional leading space will become a non-breakable space


## 脚注 ##
This is some text [^1]. Other text.[^footnote].也可以继续插入[^3ft]，后面可以再插入[^other-note]。

	[^1]: Some *crazy* footnote definition.

	[^footnote]:
		> Blockquotes can be in a footnote.


			as well as code blocks


		or, naturally, simple paragraphs.

	[^other-note]: no code block here (spaces are stripped away)

	[^3ft]: 这样呢

我修改了`/sass/custom/_styles.scss`

{% codeblock lang:css %}
div.footnotes{
	border-top: 1px dashed grey;
	font-size: 0.8em;
	
}

div.footnotes > ol:before{
	margin-left: -20px;
	content: "脚注： ";
}
{% endcodeblock %}

[^1]: Some *crazy* footnote definition.

[^footnote]:
    > Blockquotes can be in a footnote.


		as well as code blocks


	or, naturally, simple paragraphs.

[^other-note]: no code block here (spaces are stripped away)

[^3ft]: 这样呢  








