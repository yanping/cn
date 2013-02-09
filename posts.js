$(document).ready(function() {
	var post = {
	"list":[{
		"title":"用R获取flash中的数据",
		    "url":"http://yanping.me/cn/blog/2013/02/10/get-data-from-flash/",
		    "date":"10 Feb 2013"
		},
	{
		"title":"R语言版的cntrade程序",
		    "url":"http://yanping.me/cn/blog/2013/02/10/cntrade-r-version/",
		    "date":"10 Feb 2013"
		},
	{
		"title":"用R获取郑州商品交易所历史数据",
		    "url":"http://yanping.me/cn/blog/2013/02/09/get-zce-data/",
		    "date":"09 Feb 2013"
		},
	{
		"title":"用R获取大连商品交易所历史数据",
		    "url":"http://yanping.me/cn/blog/2012/12/09/get-dce-data/",
		    "date":"09 Dec 2012"
		},
	{
		"title":"用jekyll和jQuery实现异步加载文章列表",
		    "url":"http://yanping.me/cn/blog/2012/10/10/asynchronous-loading-post-list-with-jekyll-and-jQuery/",
		    "date":"10 Oct 2012"
		}
	
	]};

	var content ="<ul class=\"compact recent\">";
	$.each(post.list,function(i,item){

	content += "<li><span class=\"date\">"+ item.date + "</span><a href=\""+item.url+"\">"+ item.title +"</a></li>";

	});
	
	content +="</ul>";
	$("#blog1-posts-list .loading").remove();
	$("#blog1-posts-list").append(content);
}); 
