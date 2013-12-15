<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增博客</title>
<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/2.2.2/css/bootstrap.min.css">
<style>
	.main{     
		border-radius : 3px 3px 3px 3px;
		color : black;
	}
	.menu_ul{      
		padding-left : 0px;
	}
	.title_div{
		padding-bottom : 15px;
	}
	.menu_ul .addBlog{
		background-color : grey;
	}
	.btnCode {
		background:transparent url(${base}/image/code.gif) no-repeat 16px 16px;
		background-position:2px 2px;
	}
</style>
</head>
<body>
	       
	<div class="main">
		
			<div class="row-fluid" style="padding-top:20px;">
				<div class="span1"></div>
				<div class="span10">
				
				<div>
					<select id="article_type" style="width:70px;">
						<option value="0">原创</option>
						<option value="1">转载</option>
						<option value="2">翻译</option>
					</select>
					<input type="text" id="title" class="input_class">
				</div>
				<div class="title_div">
					<textarea id="content" name="content" rows="22" cols="80" style="width: 100%"></textarea>
				</div>
				<div>关键字： <input type="text" class="input_class" name="keyword" id="keyword"></div>
				<div><input type="button" id="blog_post" style="margin-top:10px;" class="btn" value="发布" ></div>
				</div>
			</div>
	</div>
	
	<%@include file="../../static/endNew.jsp" %>

</body>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor-1.2.1.min.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor_lang/zh-cn.js"></script>
<script type="text/javascript" src="${base}/js/xheditor-1.2.1/xheditor.js"></script>
<script>
    $(document).ready(function() {
      $("#blog_post").click(function(){
    	  var title = $("#title").val();
    	  var content = editor.getSource();
    	  var article_type = $("#article_type").html();
    	  var keyword = $("#keyword").val();
    	  if(title == "" || $.trim(content) == "<br>"){
    		  alert("请输入标题或者内容");
    	  }else{
    		  $.post('${base}/blog/my-addblog-post',{ title: title,keyword : keyword, content: content,article_type : article_type }, function(data) {
    			  location.href = "${base}/blog/${user.bgUserId}";
    		  });
    	  }
      });
  });
    function addBlog(){
    	var title = $("#title").val();
	  	var content = editor.getSource();
	  	var article_type = $("#article_type").html();
	  	var keyword = $("#keyword").val();
	  	if(title == "" || $.trim(content) == "<br>"){
	  	    alert("请输入标题或者内容");
	  	    return false;
	  	}else{
	  	    $.post('${base}/blog/my-addblog-post',{ title: title,keyword : keyword, content: content,article_type : article_type }, function(data) {
		  	    top.closeDialog();
		  	    top.returnBlogList();
		  	});
	  	}
    }
  
</script>
</html>