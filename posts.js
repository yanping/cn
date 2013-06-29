$(document).ready(function() {
  var post = {
    "list": [ {
      "title": "【广告】上海R语言培训",
      "url": "http://yanping.me/cn/blog/2013/06/30/xccds-r-training/",
      "date": "30 Jun 2013"
    } ,  {
      "title": "【译文】软件工程师如何修炼数据科学",
      "url": "http://yanping.me/cn/blog/2013/05/25/software-engineers-guide-to-getting/",
      "date": "25 May 2013"
    } ,  {
      "title": "《R语言编程艺术》即将上市",
      "url": "http://yanping.me/cn/blog/2013/05/15/the-art-of-r-programming-published/",
      "date": "15 May 2013"
    } ,  {
      "title": "用js在jekyll博客中实现标签云和标签页",
      "url": "http://yanping.me/cn/blog/2013/02/13/generate-tags-with-js-in-jekyll-blog/",
      "date": "13 Feb 2013"
    } ,  {
      "title": "用R获取flash中的数据",
      "url": "http://yanping.me/cn/blog/2013/02/10/get-data-from-flash/",
      "date": "10 Feb 2013"
    }  ]
  };

  var content = "<ul class=\"compact recent\">";
  $.each(post.list,
  function(i, item) {

    content += "<li><span class=\"date\">" + item.date + "</span><a href=\"" + item.url + "\">" + item.title + "</a></li>";

  });

  content += "</ul>";
  $("#blog1-posts-list .loading").remove();
  $("#blog1-posts-list").append(content);
});
